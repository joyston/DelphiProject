//Diary Add/Edit and view
unit frmDiary_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCGrids, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls,
  Vcl.ExtCtrls, System.UITypes, Vcl.WinXPickers;

type
  TfrmDiary = class(TForm)
    tabDiary: TPageControl;
    tabAddEdit: TTabSheet;
    tabView: TTabSheet;
    btnAdd: TButton;
    lblDate: TLabel;
    lblHour: TLabel;
    memLog: TMemo;
    grdDiaryLogs: TDBGrid;
    btnEdit: TButton;
    btnLogout: TButton;
    dtLog: TDateTimePicker;
    lblHHMM: TLabel;
    tplogtime: TTimePicker;
    lblLog: TLabel;
    btnSave: TButton;
    btnRefresh: TBitBtn;
    procedure btnAddClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure tabDiaryChange(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RefreshDiaryForm();
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDiary: TfrmDiary;
  fmt: TFormatSettings;

implementation

uses frmLogIn_u, FrmDbModule_u;

{$R *.dfm}

procedure TfrmDiary.btnAddClick(Sender: TObject);
//var  lLogID : Integer;
begin
  if not dbmodule.mainConnection.Connected then
    Exit;

  //fmt := TFormatSettings.Create;
  //fmt.ShortDateFormat := 'yyyy-mm-dd';

   //Check if Date already present in Db
//   lLogID := dbmodule.GetLogId(dbmodule.UserId, dtLog.Date); //DateToStr(dtLog.Date, fmt));
//   if lLogID <> 0 then
//   begin
//     dbmodule.UpdateDiary(lLogID, dbmodule.UserId,
//         dtLog.Date, memLog.Text, tplogtime.Time); //edtHour.Text);
//   end
   if memLog.Text <> '' then
   begin
      dbmodule.InsertInDiary(dbmodule.UserId, dtLog.Date //DateToStr(dtLog.Date, fmt)
        , memLog.Text, tplogtime.Time); //edtHour.Text);
   end
   else
   begin
      ShowMessage('Please add some logs.');
      Exit
   end;

  //lLogID := 0;
  //dbmodule.qryDiary.Refresh;
  RefreshDiaryForm();
  tabView.Show;
end;

procedure TfrmDiary.btnSaveClick(Sender: TObject);
begin
  //Code to edit
  if memLog.Text <> '' then
  begin
    dbmodule.UpdateDiary(memLog.Text);
    tabView.Show;
    RefreshDiaryForm();
  end
  else
  begin
    ShowMessage('Please add some logs.');
  end;
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

  frmLogIn.Show;
  frmDiary.Hide;
  tabAddEdit.Show;

  //dbmodule.tblDiary.Close;
end;

procedure TfrmDiary.btnRefreshClick(Sender: TObject);
var
  buttonSelected : Integer;
begin
  if btnSave.Enabled then
  begin
    buttonSelected := messagedlg('Are you sure you want to abort the changes?',mtCustom, mbOKCancel, 0);
    if buttonSelected = mrCancel then
      Exit
    else
  end
  else
  begin
    if memLog.Text <> '' then
    begin
      buttonSelected := messagedlg('Are you sure you want to abort the changes?',mtCustom, mbOKCancel, 0);
      if buttonSelected = mrCancel then
        Exit
      else
    end;
  end;
  RefreshDiaryForm();
end;

procedure TfrmDiary.btnEditClick(Sender: TObject);
begin
  //dtLog.Date := StrToDate(DBGrid1.Fields[0].AsString);
  //memLog.Text := DBGrid1.Fields[1].AsString;
  //edtHour.Text := DBGrid1.Fields[2].AsString;

  //dtLog.Date := dbmodule.qryDiary.FieldByName('logdate').AsDateTime;
  //memLog.Text := dbmodule.qryDiary.FieldByName('log').AsString;
  //edtHour.Text := dbmodule.qryDiary.FieldByName('logtime').AsString;
  btnAdd.Enabled := false;
  btnSave.Enabled := true;
  dtLog.Date := dbmodule.tblDiary.FieldByName('logdate').AsDateTime;
  dtLog.Enabled := false;
  memLog.Text := dbmodule.tblDiary.FieldByName('log').AsString;
  tplogtime.Time := dbmodule.tblDiary.FieldByName('logtime').AsDateTime;
  tplogtime.Enabled := false;

  btnRefresh.Kind := bkAbort;
  tabAddEdit.Show;
end;

procedure TfrmDiary.RefreshDiaryForm();
begin
  dtLog.Date := now;
  tplogtime.Time := now;
  memLog.Text := '';
  btnSave.Enabled := false;
  btnAdd.Enabled := true;
  dtLog.Enabled := true;
  tplogtime.Enabled := true;
  btnRefresh.Kind := bkRetry;
  btnRefresh.Caption := '&Refresh';
end;

procedure TfrmDiary.tabDiaryChange(Sender: TObject);
begin
    dbmodule.GetUserLogs(dbmodule.UserId);
end;

procedure TfrmDiary.FormCreate(Sender: TObject);
begin
  tabAddEdit.Show;
  dtLog.MaxDate := Trunc(Date) + 0.99999999999;
  RefreshDiaryForm();
end;

end.
