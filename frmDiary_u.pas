unit frmDiary_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCGrids, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls;

type
  TfrmDiary = class(TForm)
    tabDiary: TPageControl;
    tabAddEdit: TTabSheet;
    tabView: TTabSheet;
    btnAdd: TButton;
    edtHour: TEdit;
    lblDate: TLabel;
    lblHour: TLabel;
    memLog: TMemo;
    DBGrid1: TDBGrid;
    Button1: TButton;
    btnLogout: TButton;
    dtLog: TDateTimePicker;
    procedure btnAddClick(Sender: TObject);
    procedure tabDiaryChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDiary: TfrmDiary;
  fmt: TFormatSettings;

implementation

uses frmLogIn_u, frmDbModule_u;

{$R *.dfm}

procedure TfrmDiary.btnAddClick(Sender: TObject);
var
  frmlogID : integer;
begin
  if not dbmodule.mainConnection.Connected then
    Exit;

  fmt := TFormatSettings.Create;
  fmt.ShortDateFormat := 'yyyy-mm-dd';

  //Check if Date already present in Db
  //frmlogID := frmLogIn.userInstance.GetLogId(frmLogIn.userInstance.UserId, DateToStr(dtLog.Date, fmt));
  frmLogIn.userInstance.LogId := frmLogIn.userInstance.GetLogId(frmLogIn.userInstance.UserId, DateToStr(dtLog.Date, fmt));
   if frmLogIn.userInstance.LogId <> 0 then
   begin
     frmLogIn.userInstance.UpdateDiary(frmLogIn.userInstance.LogId, frmLogIn.userInstance.UserId,
         DateToStr(dtLog.Date, fmt), memLog.Text, edtHour.Text);
   end
   else
   begin
    frmLogIn.userInstance.InsertInDiary(frmLogIn.userInstance.UserId, DateToStr(dtLog.Date, fmt)
        , memLog.Text, edtHour.Text);
   end;

  dbmodule.qryDiary.Refresh;
  tabView.Show;
end;

procedure TfrmDiary.btnLogoutClick(Sender: TObject);
var
  buttonSelected : Integer;
begin
  buttonSelected := messagedlg('Are you sure you want to LogOut?',mtCustom, mbOKCancel, 0);
  if buttonSelected = mrCancel then
  Exit;

  frmLogIn.edtUsername.Text := '';
  frmLogIn.edtPassword.Text := '';
  //frmLogIn.frmuserID := 0;
  frmLogIn.userInstance.Free;
  frmDiary.Close;
end;

procedure TfrmDiary.Button1Click(Sender: TObject);
var
  logDate, logText, logTime : string;
begin
  //dtLog.Date := StrToDate(DBGrid1.Fields[0].AsString);
  //memLog.Text := DBGrid1.Fields[1].AsString;
  //edtHour.Text := DBGrid1.Fields[2].AsString;
  dtLog.Date := dbmodule.qryDiary.FieldByName('logdate').AsDateTime;
  memLog.Text := dbmodule.qryDiary.FieldByName('log').AsString;
  edtHour.Text := dbmodule.qryDiary.FieldByName('logtime').AsString;
  //dtLog.Enabled := false;
  tabAddEdit.Show;
end;

procedure TfrmDiary.FormCreate(Sender: TObject);
begin
  tabAddEdit.Show;
  dtLog.Date := now;
  dtLog.MaxDate := Trunc(Date) + 0.99999999999;;
end;

procedure TfrmDiary.FormShow(Sender: TObject);
begin
  //dtLog.Date := Date;
  //dtLog.MaxDate := now;
end;

procedure TfrmDiary.tabDiaryChange(Sender: TObject);
begin
    frmLogIn.userInstance.GetUserLogs(frmLogIn.userInstance.UserId);
end;

end.
