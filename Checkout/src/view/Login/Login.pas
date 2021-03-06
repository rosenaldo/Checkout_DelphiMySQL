unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.StdCtrls, Vcl.Buttons;

type
  TFrmLogin = class(TForm)
    btnLogin: TSpeedButton;
    EdtUsuario: TEdit;
    EdtSenha: TEdit;
    P_CONTAINER: TPanel;
    P_LOGO: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    P_USUARIO: TPanel;
    Label4: TLabel;
    P_SENHA: TPanel;
    Label5: TLabel;
    P_LOGIN: TPanel;
    Image1: TImage;
    Label7: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    SB_SAIR: TSpeedButton;
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure btnLoginClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SB_SAIRClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure centralizarPainel;
    procedure Login;
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;



implementation

{$R *.dfm}

uses Menu,
 DM.Model,
 Caixa;

procedure TFrmLogin.btnLoginClick(Sender: TObject);
begin
  if Trim(EdtUsuario.Text) = '' then
  begin
    MessageDlg('Preencha o Usu?rio!', mtInformation, mbOKCancel, 0);
    EdtUsuario.SetFocus;
    exit;
  end;

  if Trim(EdtSenha.Text) = '' then
  begin
    MessageDlg('Preencha a Senha!', mtInformation, mbOKCancel, 0);
    EdtSenha.SetFocus;
    exit;
  end;

  Login;
end;

procedure TFrmLogin.centralizarPainel;
begin
  // pnlLogin.Top := (self.Height div 2) - (pnlLogin.Height div 2);
  // pnlLogin.Left := (self.Width div 2) - (pnlLogin.Width div 2);
end;

procedure TFrmLogin.FormCanResize(Sender: TObject;
  var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  centralizarPainel;
end;

procedure TFrmLogin.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    Login;

end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  EdtUsuario.SetFocus;
end;

procedure TFrmLogin.Login;
begin
  // AQUI VIRA O C?DIGO DE LOGIN

  Model.query_usuarios.Close;
  Model.query_usuarios.SQL.Clear;
  Model.query_usuarios.SQL.Add
    ('SELECT * from usuarios where usuario = :usuario and senha = :senha');
  Model.query_usuarios.ParamByName('usuario').Value := EdtUsuario.Text;
  Model.query_usuarios.ParamByName('senha').Value := EdtSenha.Text;
  Model.query_usuarios.Open;

  if not Model.query_usuarios.isEmpty then
  begin
    nomeUsuario := Model.query_usuarios['nome'];
    cargoUsuario := Model.query_usuarios['cargo'];

    // VERIFICAR SE QUEM LOGOU FOI UM OPERADOR DE CAIXA
    if ((cargoUsuario = 'operador de caixa') or (cargoUsuario = 'caixa')) then
    begin
      FrmCaixa := TFrmCaixa.Create(self);
      EdtSenha.Text := '';
      statusCaixa := 'Abertura';
      FrmLogin.Hide;
      FrmCaixa.ShowModal;
      FrmLogin.Close;
      exit;
    end;

    FrmMenu := TFrmMenu.Create(FrmLogin);
    EdtSenha.Text := '';
    FrmLogin.Hide;
    FrmMenu.ShowModal;
    FrmLogin.Close;

  end
  else
  begin
    ShowMessage('Usu?rio e/ou Senha Inv?lido');
    EdtUsuario.Text := '';
    EdtSenha.Text := '';
    EdtUsuario.SetFocus;
  end;
end;

procedure TFrmLogin.SB_SAIRClick(Sender: TObject);
begin
  Close;
end;

end.
