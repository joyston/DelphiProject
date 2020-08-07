unit frmDbModule_u;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  Tdbmodule = class(TDataModule)
    mainConnection: TFDConnection;
    qryUsers: TFDQuery;
    dsUsers: TDataSource;
    qryDiary: TFDQuery;
    dsDiary: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

  TDbFunctions = class
    public
      function GetUserId(userName, passWord : string) : Integer;
      function GetLogId(userId : Integer; logDate : string) : Integer;
      procedure UpdateDiary(logId, userId : Integer; logDate, log, logTime : string);
      procedure InsertInDiary(userId : Integer; logDate, log, logTime : string);
      procedure GetUserLogs(userId : Integer);
  end;

var
  dbmodule: Tdbmodule;

implementation

uses frmLogIn_u;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

// Get a scalar value from DB
function TDbFunctions.GetUserId(userName, passWord : string) : Integer;
begin
 Result := dbmodule.mainConnection.ExecSQLScalar('select _id from users where' +
        ' username=:username and password=:password', [userName, passWord]);
end;

function TDbFunctions.GetLogId(userId : Integer; logDate : string) : Integer;
begin
  Result := dbmodule.mainConnection.ExecSQLScalar('select _id from diary where' +
        ' user_fkid=:UId and logdate=:LD', [userId, logDate]);
end;

procedure TDbFunctions.UpdateDiary(logId, userId : Integer; logDate, log, logTime : string);
begin
  dbmodule.mainConnection.ExecSQL('Update diary set log=:LG, logtime=:LT WHERE _id=:LID' +
        ' and user_fkid=:UId and logdate=:LD', [log, logTime, logID, userId, logDate]);
end;

procedure TDbFunctions.InsertInDiary(userId : Integer; logDate, log, logTime : string);
begin
  dbmodule.mainConnection.ExecSQL('Insert into diary(user_fkid, logdate, log,'
          + ' logtime) values(:Id, :LD, :Lg, :Lt)', [userId, logDate, log, logTime]);
end;

procedure TDbFunctions.GetUserLogs(userId : Integer);
begin
  dbmodule.qryDiary.SQL.Text := 'Select * from diary where user_fkid='
        + IntToStr(userId) + ';';
  dbmodule.qryDiary.Open;
end;

end.
