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

var
  dbmodule: Tdbmodule;

implementation

uses frmLogIn_u;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
