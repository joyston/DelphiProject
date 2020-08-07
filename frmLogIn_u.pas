unit frmLogIn_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, frmDiary_u, frmDbModule_u;

type
  TfrmLogIn = class(TForm)
    edtUsername: TEdit;
    edtPassword: TEdit;
    btnLogin: TButton;
    lblUsername: TLabel;
    lblPassword: TLabel;
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    //puserID : ^Integer;
    userID : Integer;
    userInstance : TDbFunctions;
  end;

var
  frmLogIn: TfrmLogIn;


implementation
//puserID := @userID;

{$R *.dfm}

procedure TfrmLogIn.btnLoginClick(Sender: TObject);
//var DB : Tdbmodule;
//var userInstance : TDbFunctions;
begin
  try
    try
      if (edtUsername.Text <> '') AND (edtPassword.Text <> '') then
      begin
         //puserID := @userID;
         //Code to check credentials
         //dbmodule.FDConnection1.Connected := true;
         //dbmodule.FDQuery1.Active := true;

         if not dbmodule.mainConnection.Connected then
          Exit;

         userInstance := TDbFunctions.Create;
         userID := userInstance.GetUserId(edtUsername.Text, edtPassword.Text);

         if userID <> 0 then
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
    FreeAndNil(userInstance);
  end;
end;

end.
