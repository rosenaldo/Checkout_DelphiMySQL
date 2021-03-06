unit Login.Wiew;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TFRM_LOGIN = class(TForm)
    P_CONTAINER: TPanel;
    P_LOGO: TPanel;
    Image1: TImage;
    P_LOGIN: TPanel;
    Label3: TLabel;
    btnLogin: TSpeedButton;
    SB_SAIR: TSpeedButton;
    P_SENHA: TPanel;
    Label5: TLabel;
    EDT_SENHA: TEdit;
    Panel2: TPanel;
    P_USUARIO: TPanel;
    Label4: TLabel;
    EDT_USUARIO: TEdit;
    Panel1: TPanel;
    P_CONFIRMAR: TPanel;
    procedure SB_SAIRClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
  private
    procedure Login;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRM_LOGIN: TFRM_LOGIN;

implementation

{$R *.dfm}

uses Menu.View;

procedure TFRM_LOGIN.btnLoginClick(Sender: TObject);
begin
  if EDT_USUARIO.Text = '' then
  begin
     ShowMessage('preencha o usuario');
  end;
  Login  ;

end;

procedure TFRM_LOGIN.SB_SAIRClick(Sender: TObject);
begin
  Close;
end;

 procedure TFRM_LOGIN.Login;
 begin
   FRM_MENU:= TFRM_MENU.Create(nil);
   try
     FRM_MENU.ShowModal;
   finally
                       FRM_MENU.Free;
   end;
 end;

end.
