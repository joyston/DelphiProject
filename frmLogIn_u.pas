unit frmLogIn_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, frmDiary_u, frmDbModule_u,
  Vcl.Mask;

type
  TfrmLogIn = class(TForm)
    edtUsername: TEdit;
    btnLogin: TButton;
    lblUsername: TLabel;
    lblPassword: TLabel;
    edtPassword: TMaskEdit;
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    frmuserID : Integer;
    userInstance : TDbFunctions;
  end;

var
  frmLogIn: TfrmLogIn;

implementation

{$R *.dfm}

procedure TfrmLogIn.btnLoginClick(Sender: TObject);
//var userInstance : TDbFunctions;
begin
  userInstance := TDbFunctions.Create;
  try
    try
      if (edtUsername.Text <> '') AND (edtPassword.Text <> '') then
      begin
         //Code to check credentials
         if not userInstance.ConnectToDb() then
          Exit;

         userInstance.UserId := userInstance.GetUserId(edtUsername.Text, edtPassword.Text);
         //userInstance.SetUserId(userInstance.GetUserId(edtUsername.Text, edtPassword.Text));

         if userInstance.UserId <> 0 then
         begin
           frmDiary.Show;
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
      on E : Exception do
      begin
        ShowMessage(E.Message);
      end;
    end;
  finally
    userInstance.Free;
  end;
end;

end.
