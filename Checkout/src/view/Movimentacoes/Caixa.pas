unit Caixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFrmCaixa = class(TForm)
    Label2: TLabel;
    Label4: TLabel;
    btnAbrir: TSpeedButton;
    BtnFechar: TSpeedButton;
    Label3: TLabel;
    EdtUsuario: TEdit;
    edtSenha: TEdit;
    edtValor: TEdit;
    edtCaixa: TEdit;
    Label1: TLabel;
    btnPDV: TButton;
    P_CONTAINER: TPanel;
    P_RODAPE: TPanel;
    SB_CANCELAR: TSpeedButton;
    procedure FormShow(Sender: TObject);

    procedure btnAbrirClick(Sender: TObject);
    procedure btnPDVClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SB_CANCELARClick(Sender: TObject);
  private
    { Private declarations }

    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;

    procedure associarCampos;
    procedure listar;

  public
    { Public declarations }
  end;

var
  FrmCaixa: TFrmCaixa;
  gerente: string;
  cargoGerente: string;
  valorVendido: double;
  valorQuebra: double;
  valorAbertura: double;

  // DECLARAÇÃO DAS VARIAVEIS GLOBAIS
   idFunc: string;
  nomeFunc: string;
  cargoFunc: string;

  chamada: string;

  nomeUsuario: string;
  cargoUsuario: string;

  codigoProduto: string;

  idFornecedor: string;
  nomeFornecedor: string;

  nomeProduto: string;
  estoqueProduto: double;
  idProduto: string;

  totalProdutos: double;

  certificadoDig: string;

  statusCaixa: string;
  numeroCaixa: string;

  rel: string;
  excluir: string;

implementation

{$R *.dfm}

uses DM.Model, Vendas;

procedure TFrmCaixa.associarCampos;
begin
  Model.tb_caixa.FieldByName('data_abertura').Value := DateToStr(Date);
  Model.tb_caixa.FieldByName('hora_abertura').Value := TimeToStr(Time);
  Model.tb_caixa.FieldByName('valor_abertura').Value := strToFloat(edtValor.Text);
  Model.tb_caixa.FieldByName('funcionario_abertura').Value := gerente;
  Model.tb_caixa.FieldByName('num_caixa').Value := edtCaixa.Text;
  Model.tb_caixa.FieldByName('operador').Value := nomeUsuario;
  Model.tb_caixa.FieldByName('status').Value := 'Aberto';

end;

procedure TFrmCaixa.btnAbrirClick(Sender: TObject);
begin
  if Trim(edtValor.Text) = '' then
  begin
    MessageDlg('Preencha o Valor!', mtInformation, mbOKCancel, 0);
    edtValor.SetFocus;
    exit;
  end;

  if Trim(edtCaixa.Text) = '' then
  begin
    MessageDlg('Preencha o Caixa!', mtInformation, mbOKCancel, 0);
    edtCaixa.SetFocus;
    exit;
  end;

  // VERIFICAR SE O CAIXA JÁ ESTÁ ABERTO
  Model.query_caixa.Close;
  Model.query_caixa.SQL.Clear;
  Model.query_caixa.SQL.Add
    ('SELECT * from caixa where status = :status and num_caixa = :num and data_abertura = curDate()');
  Model.query_caixa.ParamByName('status').Value := 'Aberto';
  Model.query_caixa.ParamByName('num').Value := edtCaixa.Text;
  Model.query_caixa.Open;

  if not Model.query_caixa.isEmpty then
  begin
    MessageDlg('Este caixa já está aberto!', mtInformation, mbOKCancel, 0);
    exit;
  end;

  // VERIFICAR PERMISSAO DO GERENTE
  Model.query_usuarios.Close;
  Model.query_usuarios.SQL.Clear;
  Model.query_usuarios.SQL.Add
    ('SELECT * from usuarios where usuario = :usuario and senha = :senha');
  Model.query_usuarios.ParamByName('usuario').Value := EdtUsuario.Text;
  Model.query_usuarios.ParamByName('senha').Value := edtSenha.Text;
  Model.query_usuarios.Open;

  if not Model.query_usuarios.isEmpty then
  begin
    gerente := Model.query_usuarios['nome'];
    cargoGerente := Model.query_usuarios['cargo'];

    // VERIFICAR SE QUEM LOGOU FOI UM OPERADOR DE CAIXA
    if cargoGerente <> 'Gerente' then
    begin

      edtSenha.Text := '';
      MessageDlg('Você não tem permissão de Gerente!', mtInformation,
        mbOKCancel, 0);
      exit;
    end;

  end
  else
  begin
    MessageDlg('Dados de Login Incorretos!!', mtInformation, mbOKCancel, 0);
    EdtUsuario.Text := '';
    edtSenha.Text := '';
    EdtUsuario.SetFocus;
    exit;
  end;

  associarCampos;
  Model.tb_caixa.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);

  FrmVendas := TFrmVendas.Create(self);
  numeroCaixa := edtCaixa.Text;
  limpar;

  btnAbrir.Enabled := false;

  BtnFechar.Enabled := true;

  FrmVendas.ShowModal;

end;

procedure TFrmCaixa.BtnFecharClick(Sender: TObject);
begin
  if Trim(edtValor.Text) = '' then
  begin
    MessageDlg('Preencha o Valor!', mtInformation, mbOKCancel, 0);
    edtValor.SetFocus;
    exit;
  end;

  if Trim(edtCaixa.Text) = '' then
  begin
    MessageDlg('Preencha o Caixa!', mtInformation, mbOKCancel, 0);
    edtCaixa.SetFocus;
    exit;
  end;

  // VERIFICAR SE O CAIXA JÁ ESTÁ FECHADO
  Model.query_caixa.Close;
  Model.query_caixa.SQL.Clear;
  Model.query_caixa.SQL.Add
    ('SELECT * from caixa where status = :status and num_caixa = :num and operador = :operador and data_fechamento = curDate()');
  Model.query_caixa.ParamByName('status').Value := 'Fechado';
  Model.query_caixa.ParamByName('num').Value := edtCaixa.Text;
  Model.query_caixa.ParamByName('operador').Value := nomeUsuario;
  Model.query_caixa.Open;

  if not Model.query_caixa.isEmpty then
  begin
    MessageDlg('Este caixa já está fechado!', mtInformation, mbOKCancel, 0);
    exit;
  end;

  // VERIFICAR PERMISSAO DO GERENTE
  Model.query_usuarios.Close;
  Model.query_usuarios.SQL.Clear;
  Model.query_usuarios.SQL.Add
    ('SELECT * from usuarios where usuario = :usuario and senha = :senha');
  Model.query_usuarios.ParamByName('usuario').Value := EdtUsuario.Text;
  Model.query_usuarios.ParamByName('senha').Value := edtSenha.Text;
  Model.query_usuarios.Open;

  if not Model.query_usuarios.isEmpty then
  begin
    gerente := Model.query_usuarios['nome'];
    cargoGerente := Model.query_usuarios['cargo'];

    // VERIFICAR SE QUEM LOGOU FOI UM OPERADOR DE CAIXA
    if cargoGerente <> 'Gerente' then
    begin

      edtSenha.Text := '';
      MessageDlg('Você não tem permissão de Gerente!', mtInformation,
        mbOKCancel, 0);
      exit;
    end;

  end
  else
  begin
    MessageDlg('Dados de Login Incorretos!!', mtInformation, mbOKCancel, 0);
    EdtUsuario.Text := '';
    edtSenha.Text := '';
    EdtUsuario.SetFocus;
    exit;
  end;

  // RECUPERAR O TOTAL VENDIDO NO DIA PELO FUNCIONÁRIO
  Model.query_coringa.Close;
  Model.query_coringa.SQL.Clear;
  Model.query_coringa.SQL.Add
    ('select sum(valor) as total from vendas where data = curDate() and funcionario = :func and status = :status');
  Model.query_coringa.ParamByName('func').Value := nomeUsuario;
  Model.query_coringa.ParamByName('status').Value := 'Concluída';
  Model.query_coringa.Prepare;
  Model.query_coringa.Open;
  valorVendido := Model.query_coringa.FieldByName('total').AsFloat;

  // RECUPERAR O VALOR DA ABERTURA
  Model.query_caixa.Close;
  Model.query_caixa.SQL.Clear;
  Model.query_caixa.SQL.Add
    ('SELECT * from caixa where status = :status and num_caixa = :num and data_abertura = curDate()');
  Model.query_caixa.ParamByName('status').Value := 'Aberto';
  Model.query_caixa.ParamByName('num').Value := edtCaixa.Text;
  Model.query_caixa.Open;

  if not Model.query_caixa.isEmpty then
  begin
    valorAbertura := Model.query_caixa['valor_abertura'];
  end;

  valorQuebra := strToFloat(edtValor.Text) - valorVendido - valorAbertura;

  Model.query_caixa.Close;
  Model.query_caixa.SQL.Clear;
  Model.query_caixa.SQL.Add
    ('UPDATE caixa set data_fechamento = curDate(), hora_fechamento = curTime(), valor_fechamento = :valor, valor_vendido = :valorV, valor_quebra = :valor_quebra, funcionario_fechamento = :func_fec, status = :stat where num_caixa = :num and status = :status');
  Model.query_caixa.ParamByName('valor').Value := edtValor.Text;
  Model.query_caixa.ParamByName('valorV').Value := valorVendido;
  Model.query_caixa.ParamByName('valor_quebra').Value := valorQuebra;
  Model.query_caixa.ParamByName('func_fec').Value := gerente;
  Model.query_caixa.ParamByName('num').Value := edtCaixa.Text;
  Model.query_caixa.ParamByName('stat').Value := 'Fechado';
  Model.query_caixa.ParamByName('status').Value := 'Aberto';
  Model.query_caixa.ExecSQL;
  MessageDlg('Caixa Fechado!!', mtInformation, mbOKCancel, 0);

  numeroCaixa := '';
  limpar;

  btnAbrir.Enabled := true;

  BtnFechar.Enabled := false;
  edtCaixa.Enabled := true;

end;

procedure TFrmCaixa.btnPDVClick(Sender: TObject);
begin

  // VERIFICAR SE O CAIXA JÁ ESTÁ ABERTO
  Model.query_caixa.Close;
  Model.query_caixa.SQL.Clear;
  Model.query_caixa.SQL.Add
    ('SELECT * from caixa where status = :status and num_caixa = :num and data_abertura = curDate()');
  Model.query_caixa.ParamByName('status').Value := 'Aberto';
  Model.query_caixa.ParamByName('num').Value := edtCaixa.Text;
  Model.query_caixa.Open;

  if not Model.query_caixa.isEmpty then
  begin
    FrmVendas := TFrmVendas.Create(self);
    limpar;

    btnAbrir.Enabled := false;

    BtnFechar.Enabled := true;
    edtCaixa.Enabled := false;
    FrmVendas.ShowModal;

  end
  else
  begin
    MessageDlg('Abra Primeiro o Caixa!!', mtInformation, mbOKCancel, 0);
  end;
end;

procedure TFrmCaixa.desabilitarCampos;
begin
  EdtUsuario.Enabled := false;
  edtSenha.Enabled := false;
  edtValor.Enabled := false;
  edtCaixa.Enabled := false;
end;

procedure TFrmCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // VERIFICAR SE O CAIXA JÁ ESTÁ ABERTO
  Model.query_caixa.Close;
  Model.query_caixa.SQL.Clear;
  Model.query_caixa.SQL.Add
    ('SELECT * from caixa where status = :status and num_caixa = :num');
  Model.query_caixa.ParamByName('status').Value := 'Aberto';
  Model.query_caixa.ParamByName('num').Value := edtCaixa.Text;
  Model.query_caixa.Open;

  if not Model.query_caixa.isEmpty then
  begin

    MessageDlg('Você não pode sair com o caixa aberto!!', mtInformation,
      mbOKCancel, 0);
    Action := caNone;
  end;
end;

procedure TFrmCaixa.FormShow(Sender: TObject);
begin

  habilitarCampos;
  Model.tb_caixa.Active := true;
  listar;
  edtCaixa.Text := numeroCaixa;
  EdtUsuario.SetFocus;

  if statusCaixa = 'Abertura' then
  begin
    habilitarCampos;
    Model.tb_caixa.Insert;
    btnAbrir.Enabled := true;
  end;

end;

procedure TFrmCaixa.habilitarCampos;
begin
  EdtUsuario.Enabled := true;
  edtSenha.Enabled := true;
  edtValor.Enabled := true;
  edtCaixa.Enabled := true;
end;

procedure TFrmCaixa.limpar;
begin
  EdtUsuario.Text := '';
  edtSenha.Text := '';
  edtValor.Text := '';

end;

procedure TFrmCaixa.listar;
begin
  Model.query_caixa.Close;
  Model.query_caixa.SQL.Clear;
  Model.query_caixa.SQL.Add
    ('SELECT * from caixa where data_abertura = curDate() ');
  // Model.query_caixa.ParamByName('data').Value := FormatDateTime('yyyy/mm/dd' ,dataBuscar.Date);
  Model.query_caixa.Open;
end;

procedure TFrmCaixa.SB_CANCELARClick(Sender: TObject);
begin
  Close;
end;

end.
