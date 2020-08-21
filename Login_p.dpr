program Login_p;

uses
  Vcl.Forms,
  frmLogIn_u in 'frmLogIn_u.pas' {frmLogIn},
  FrmDbModule_u in 'FrmDbModule_u.pas' {dbmodule: TDataModule},
  frmDiary_u in 'frmDiary_u.pas' {frmDiary},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Diary Application';
  TStyleManager.TrySetStyle('Glow');
  Application.CreateForm(TfrmLogIn, frmLogIn);
  Application.Run;
end.
