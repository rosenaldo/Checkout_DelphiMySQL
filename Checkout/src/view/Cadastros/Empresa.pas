unit Empresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Imaging.pngimage;

type
  TFRM_EMPRESA = class(TForm)
    P_CONTAINER: TPanel;
    P_TOPO: TPanel;
    P_INFORMACAO: TPanel;
    IMG_EMPRESA: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    SB_CANCELAR: TSpeedButton;
    BtnEditar: TSpeedButton;
    btnSalvar: TSpeedButton;
    btnNovo: TSpeedButton;
    EDT_NOME: TDBEdit;
    EDT_FANTASIA: TDBEdit;
    EDT_CNPJ: TDBEdit;
    EDT_IE: TDBEdit;
    EDT_ENDERECO: TDBEdit;
    EDT_BAIRRO: TDBEdit;
    EDT_CIDADE: TDBEdit;
    EDT_EMAIL: TDBEdit;
    EDT_UF: TDBEdit;
    EDT_TELEFONE: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure SB_CANCELARClick(Sender: TObject);
    procedure P_INFORMACAOClick(Sender: TObject);
  private
    procedure LimparCampos;
    procedure AssociarCampos;
    procedure AtualizarDados;
    procedure HabilitarCampos;
    procedure DesabilitarCampos;

    { Private declarations }

  public
    { Public declarations }
  end;

var
  FRM_EMPRESA: TFRM_EMPRESA;
  id: string;

implementation

{$R *.dfm}

uses DM.Model;


procedure TFRM_EMPRESA.LimparCampos;
begin
  EDT_NOME.Text := '';
  EDT_CNPJ.Text := '';
  EDT_BAIRRO.Text := '';
  EDT_CIDADE.Text := '';
  EDT_ENDERECO.Text := '';
  EDT_IE.Text := '';
  EDT_FANTASIA.Text := '';
  EDT_UF.Text := '';
  EDT_TELEFONE.Text := '';
  EDT_EMAIL.Text := '';
end;

procedure TFRM_EMPRESA.P_INFORMACAOClick(Sender: TObject);
begin
//  HabilitarCampos;
//  Model.tb_produtos.Edit;
//  Model.query_produtos.Edit;
end;

procedure TFRM_EMPRESA.SB_CANCELARClick(Sender: TObject);
begin
  Close;
end;

procedure TFRM_EMPRESA.AssociarCampos;
begin
  Model.Q_EMPRESArazao_social.Value := EDT_NOME.Text;
  Model.Q_EMPRESAcnpj.Value := EDT_CNPJ.Text;
  Model.Q_EMPRESAbairro.Value := EDT_BAIRRO.Text;
  Model.Q_EMPRESAcidade.Value := EDT_CIDADE.Text;
  Model.Q_EMPRESAendereco.Value := EDT_ENDERECO.Text;
  Model.Q_EMPRESAie.Value := EDT_IE.Text;
  Model.Q_EMPRESAnome_fantasia.Value := EDT_FANTASIA.Text;
  Model.Q_EMPRESAuf.Value := EDT_UF.Text;
  Model.Q_EMPRESAtelefone.Value := EDT_TELEFONE.Text;
  Model.Q_EMPRESAemail.Value := EDT_EMAIL.Text;
end;

procedure TFRM_EMPRESA.AtualizarDados;
begin
  Model.Q_EMPRESA.Close;
  Model.Q_EMPRESA.SQL.Clear;
  Model.Q_EMPRESA.SQL.Add
    ('UPDATE EMPRESA set RAZAO_SOCIAL = :RAZAO_SOCIAL, CNPJ = :CNPJ, BAIRRO = :BAIRRO, CIDADE = :CIDADE, ENDERECO = :ENDERECO, IE = :IE, NOME_FANTASIA = :NOME_FANTASIA, UF =:UF,TELEFONE =:TELEFONE  where id = :id');
  Model.Q_EMPRESA.ParamByName('RAZAO_SOCIAL').Value := EDT_NOME.Text;
  Model.Q_EMPRESA.ParamByName('CNPJ').Value := EDT_CNPJ.Text;
  Model.Q_EMPRESA.ParamByName('BAIRRO').Value := EDT_BAIRRO.Text;
  Model.Q_EMPRESA.ParamByName('CIDADE').Value := EDT_CIDADE.Text;
  Model.Q_EMPRESA.ParamByName('ENDERECO').Value := EDT_ENDERECO.Text;
  Model.Q_EMPRESA.ParamByName('IE').Value := EDT_IE.Text;
  Model.Q_EMPRESA.ParamByName('NOME_FANTASIA').Value := EDT_FANTASIA.Text;
  Model.Q_EMPRESA.ParamByName('UF').Value := EDT_UF.Text;
  Model.Q_EMPRESA.ParamByName('TELEFONE').Value := EDT_TELEFONE.Text;

  Model.Q_EMPRESA.ParamByName('id').Value := id;
  Model.Q_EMPRESA.ExecSQL;

end;

procedure TFRM_EMPRESA.BtnEditarClick(Sender: TObject);
begin
  AssociarCampos;
  AtualizarDados;
  DesabilitarCampos;
end;

procedure TFRM_EMPRESA.btnNovoClick(Sender: TObject);
begin
  HabilitarCampos;
  Model.Q_EMPRESA.Insert;
  Model.TB_EMPRESA.Insert;
end;

procedure TFRM_EMPRESA.btnSalvarClick(Sender: TObject);
begin
  AssociarCampos;
  Model.Q_EMPRESA.Post;
  DesabilitarCampos;
end;

procedure TFRM_EMPRESA.FormCreate(Sender: TObject);
begin
  Model.TB_EMPRESA.active := true;

end;

procedure TFRM_EMPRESA.HabilitarCampos;
begin
  EDT_NOME.Enabled := true;
  EDT_CNPJ.Enabled := true;
  EDT_BAIRRO.Enabled := true;
  EDT_CIDADE.Enabled := true;
  EDT_ENDERECO.Enabled := true;
  EDT_IE.Enabled := true;
  EDT_FANTASIA.Enabled := true;
  EDT_UF.Enabled := true;
  EDT_TELEFONE.Enabled := true;
  EDT_EMAIL.Enabled := true;
end;

procedure TFRM_EMPRESA.DesabilitarCampos;
begin
  EDT_NOME.Enabled := False;
  EDT_CNPJ.Enabled := False;
  EDT_BAIRRO.Enabled := False;
  EDT_CIDADE.Enabled := False;
  EDT_ENDERECO.Enabled := False;
  EDT_IE.Enabled := False;
  EDT_FANTASIA.Enabled := False;
  EDT_UF.Enabled := False;
  EDT_TELEFONE.Enabled := False;
  EDT_EMAIL.Enabled := False;
end;

end.
