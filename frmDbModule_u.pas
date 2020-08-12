unit frmDbModule_u;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Dialogs, Vcl.Forms;

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
    private
      fUserId : Integer;
      fLogId : Integer;
    public
      function ConnectToDb() : Boolean;
      function GetUserId(userName, passWord : string) : Integer;
      function GetLogId(userId : Integer; logDate : string) : Integer;
      procedure UpdateDiary(logId, userId : Integer; logDate, log, logTime : string);
      procedure InsertInDiary(userId : Integer; logDate, log, logTime : string);
      procedure GetUserLogs(userId : Integer);

      Property UserId : Integer read fUserId write fUserId;
      Property LogId : Integer read fLogId write fLogId;

      constructor Create;
  end;

var
  dbmodule: Tdbmodule;

implementation

  uses frmLogIn_u, inifiles;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

  constructor TDbFunctions.Create;
  begin
    fUserId := 0;
    fLogId := 0;
  end;
  function TDbFunctions.ConnectToDb() : Boolean;
  var appINI : TIniFile;
  begin
    appINI := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'dbconfig.ini');
    try
       try
          //Read Db info from INF file
          with  dbmodule.mainConnection do
          begin
            Connected := false;
            Params.Clear;
            DriverName := appINI.ReadString('DB-INFO', 'DriverID', '');
            Params.values['Database'] := appINI.ReadString('DB-INFO', 'Database', '');
            Params.values['Server'] := appINI.ReadString('DB-INFO', 'Server', '');
            Params.values['User_name'] := appINI.ReadString('DB-INFO', 'User_Name', '');
            Params.values['Password'] := appINI.ReadString('DB-INFO', 'Password', '');
            Params.values['Port'] := appINI.ReadString('DB-INFO', 'Port', '');
            Connected := true;
          end;

          if not dbmodule.mainConnection.Connected then
             Result := False
          else
            Result := True;
       Except on E : Exception do
          begin
            ShowMessage(E.Message);
            Result := False;
          end;
       end;
    finally
      FreeAndNil(appINI);
    end;
  end;

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
    try
      dbmodule.qryDiary.SQL.Text := 'Select * from diary where user_fkid='
          + IntToStr(userId) + ';';
      dbmodule.qryDiary.Open;
    Except on E : Exception do
      begin
        ShowMessage(E.Message);
      end;
    end;
  end;

end.
