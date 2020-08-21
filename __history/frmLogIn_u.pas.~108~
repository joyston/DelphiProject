// Login Page
unit frmLogIn_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, frmDiary_u, FrmDbModule_u,
  Vcl.Mask, Vcl.Menus, Vcl.ExtCtrls;

type
  TfrmLogIn = class(TForm)
    edtUsername: TEdit;
    btnLogin: TButton;
    lblUsername: TLabel;
    lblPassword: TLabel;
    edtPassword: TMaskEdit;
    btnClose: TButton;
    pnlLogin: TPanel;
    procedure btnLoginClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    frmuserID: Integer;
    // userInstance : TDbFunctions;
  end;

var
  frmLogIn: TfrmLogIn;

implementation

{$R *.dfm}

procedure TfrmLogIn.btnCloseClick(Sender: TObject);
begin
  if Assigned(frmDiary) then
  begin
    frmDiary.DisposeOf;
  end;

  if Assigned(dbmodule) then
  begin
    dbmodule.DisposeOf;
  end;

  close;
end;

  procedure TfrmLogIn.btnLoginClick(Sender: TObject);
  begin
    try
      if (edtUsername.Text <> '') AND (edtPassword.Text <> '') then
      begin
        dbmodule := Tdbmodule.Create(Self);

        // Set UserId on log in
        dbmodule.SetUserId(edtUsername.Text, edtPassword.Text);

        if dbmodule.UserId <> 0 then
        begin
          if not Assigned(frmDiary) then
          begin
            frmDiary := TfrmDiary.Create(self);
          end else begin
//           dbmodule.GetUserLogs(dbmodule.UserId);
          end;

          frmDiary.Show;
          frmLogIn.Hide;
        end
        else
        begin
          ShowMessage('Please enter valid Username and Password');
        end;
      end
      else
      begin
        if (edtUsername.Text = '') then
          ShowMessage('Please enter your Username')
        else
          ShowMessage('Please enter your Password');
      end;
    Except
      on E: Exception do
      begin
        ShowMessage(E.Message);
      end;
    end;
  end;

end.
