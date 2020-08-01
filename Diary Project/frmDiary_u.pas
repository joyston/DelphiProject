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
    dtLog: TDateTimePicker;
    edtHour: TEdit;
    lblDate: TLabel;
    lblHour: TLabel;
    memLog: TMemo;
    DBGrid1: TDBGrid;
    Button1: TButton;
    btnLogout: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure tabDiaryChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
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
  logID : integer;
begin
  if not dbmodule.mainConnection.Connected then
    Exit;

  fmt := TFormatSettings.Create;
  fmt.ShortDateFormat := 'yyyy-mm-dd';

  //Check if Date already present in Db
  logID := dbmodule.mainConnection.ExecSQLScalar('select _id from diary where' +
        ' user_fkid=:UId and logdate=:LD and active=1', [frmLogIn.userID, DateToStr(dtLog.Date, fmt)]);
   if logID <> 0 then
   begin
     dbmodule.mainConnection.ExecSQL('Update diary set active=0 WHERE _id=:LID' +
        ' and active=1 and user_fkid=:UId', [logID, frmLogIn.userID]);
   end;


  dbmodule.mainConnection.ExecSQL('Insert into diary(user_fkid, logdate, log,'
          + ' logtime, active) values(:Id, :LD, :Lg, :Lt, :A)',
          [frmLogIn.userID, DateToStr(dtLog.Date, fmt), memLog.Text,
          edtHour.Text, 1]);

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
  frmLogIn.userID := 0;
  frmDiary.Close;
end;

procedure TfrmDiary.Button1Click(Sender: TObject);
var
  logDate, logText, logTime : string;
begin
  dtLog.Date := StrToDate(DBGrid1.Fields[0].AsString);
  memLog.Text := DBGrid1.Fields[1].AsString;
  edtHour.Text := DBGrid1.Fields[2].AsString;
  //dtLog.Enabled := false;
  tabAddEdit.Show;
end;

procedure TfrmDiary.tabDiaryChange(Sender: TObject);
begin
  dbmodule.qryDiary.SQL.Text := 'Select * from diary where user_fkid='
        + IntToStr(frmLogIn.userID) + ' AND active=1;';
  dbmodule.qryDiary.Open;

  //dbmodule.qryDiary.Refresh;
end;

end.