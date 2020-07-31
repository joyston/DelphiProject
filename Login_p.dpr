program Login_p;

uses
  Vcl.Forms,
  frmLogIn_u in 'frmLogIn_u.pas' {frmLogIn},
  frmDbModule_u in 'frmDbModule_u.pas' {dbmodule: TDataModule},
  frmDiary_u in 'frmDiary_u.pas' {frmDiary};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmLogIn, frmLogIn);
  Application.CreateForm(Tdbmodule, dbmodule);
  Application.CreateForm(TfrmDiary, frmDiary);
  Application.Run;
end.
