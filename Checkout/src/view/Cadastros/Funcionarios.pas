unit Funcionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls;

type
  TFrmFuncionarios = class(TForm)
    EdtBuscarNome: TEdit;
    rbNome: TRadioButton;
    rbCPF: TRadioButton;
    EdtBuscarCPF: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    EdtNome: TEdit;
    Label3: TLabel;
    EdtCPF: TMaskEdit;
    Label4: TLabel;
    EdtTel: TMaskEdit;
    Label5: TLabel;
    EdtEndereco: TEdit;
    Label6: TLabel;
    cbCargo: TComboBox;
    DBGrid1: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    P_CONTAINER: TPanel;
    P_RODAPE: TPanel;
    P_TOPO: TPanel;
    P_GRID: TPanel;
    SB_CANCELAR: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure EdtBuscarNomeChange(Sender: TObject);
    procedure EdtBuscarCPFChange(Sender: TObject);
    procedure rbNomeClick(Sender: TObject);
    procedure rbCPFClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure SB_CANCELARClick(Sender: TObject);
  private
    { Private declarations }

    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;

    procedure associarCampos;
    procedure listar;

    procedure carregarCombobox;
    procedure buscarNome;
    procedure buscarCpf;

  public
    { Public declarations }
  end;

var
  FrmFuncionarios: TFrmFuncionarios;
  id: string;
  cpfAntigo: string;


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

uses DM.Model;



{ TFrmFuncionarios }

procedure TFrmFuncionarios.associarCampos;
begin
  Model.tb_func.FieldByName('nome').Value := EdtNome.Text;
  Model.tb_func.FieldByName('cpf').Value := EdtCPF.Text;
  Model.tb_func.FieldByName('telefone').Value := EdtTel.Text;
  Model.tb_func.FieldByName('endereco').Value := EdtEndereco.Text;
  Model.tb_func.FieldByName('cargo').Value := cbCargo.Text;
  Model.tb_func.FieldByName('data').Value := DateToStr(Date);
end;

procedure TFrmFuncionarios.BtnEditarClick(Sender: TObject);
var
  cpf: string;
begin

  if Trim(EdtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
    EdtNome.SetFocus;
    exit;
  end;

  if Trim(EdtCPF.Text) = '' then
  begin
    MessageDlg('Preencha o CPF!', mtInformation, mbOKCancel, 0);
    EdtCPF.SetFocus;
    exit;
  end;

  if cpfAntigo <> EdtCPF.Text then
  begin
    // VERIFICAR SE O cpf JÁ ESTÁ CADASTRADO
    Model.query_func.Close;
    Model.query_func.SQL.Clear;
    Model.query_func.SQL.Add('SELECT * from funcionarios where cpf = ' +
      QuotedStr(Trim(EdtCPF.Text)));
    Model.query_func.Open;

    if not Model.query_func.isEmpty then
    begin
      cpf := Model.query_func['cpf'];
      MessageDlg('O CPF ' + cpf + ' já está cadastrado!', mtInformation,
        mbOKCancel, 0);
      EdtCPF.Text := '';
      EdtCPF.SetFocus;
      exit;
    end;

  end;

  associarCampos;
  Model.query_func.Close;
  Model.query_func.SQL.Clear;
  Model.query_func.SQL.Add
    ('UPDATE funcionarios set nome = :nome, cpf = :cpf, endereco = :endereco, telefone = :telefone, cargo = :cargo where id = :id');
  Model.query_func.ParamByName('nome').Value := EdtNome.Text;
  Model.query_func.ParamByName('cpf').Value := EdtCPF.Text;
  Model.query_func.ParamByName('endereco').Value := EdtEndereco.Text;
  Model.query_func.ParamByName('telefone').Value := EdtTel.Text;
  Model.query_func.ParamByName('cargo').Value := cbCargo.Text;
  Model.query_func.ParamByName('id').Value := id;
  Model.query_func.ExecSQL;

  // EDITAR O CARGO DO USUÁRIO
  Model.query_usuarios.Close;
  Model.query_usuarios.SQL.Clear;
  Model.query_usuarios.SQL.Add
    ('UPDATE usuarios set cargo = :cargo where id_funcionario = :id');
  Model.query_usuarios.ParamByName('cargo').Value := cbCargo.Text;
  Model.query_usuarios.ParamByName('id').Value := id;
  Model.query_usuarios.ExecSQL;

  listar;
  MessageDlg('Editado com Sucesso!!', mtInformation, mbOKCancel, 0);
  BtnEditar.Enabled := false;
  BtnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;

end;

procedure TFrmFuncionarios.BtnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes then
  begin
    Model.tb_func.Delete;
    MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

    BtnEditar.Enabled := false;
    BtnExcluir.Enabled := false;
    limpar;

  end;


  // DELETAR TAMBÉM O USUÁRIO ASSOCIADO A ELE

  Model.query_usuarios.Close;
  Model.query_usuarios.SQL.Clear;
  Model.query_usuarios.SQL.Add('DELETE from usuarios where id_funcionario = :id');
  Model.query_usuarios.ParamByName('id').Value := id;
  Model.query_usuarios.Execute;

  listar;
end;

procedure TFrmFuncionarios.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  Model.tb_func.Insert;
  btnSalvar.Enabled := true;
end;

procedure TFrmFuncionarios.btnSalvarClick(Sender: TObject);
var
  cpf: string;
begin

  if Trim(EdtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
    EdtNome.SetFocus;
    exit;
  end;

  if Trim(EdtCPF.Text) = '' then
  begin
    MessageDlg('Preencha o CPF!', mtInformation, mbOKCancel, 0);
    EdtCPF.SetFocus;
    exit;
  end;

  // VERIFICAR SE O cpf JÁ ESTÁ CADASTRADO
  Model.query_func.Close;
  Model.query_func.SQL.Clear;
  Model.query_func.SQL.Add('SELECT * from funcionarios where cpf = ' +
    QuotedStr(Trim(EdtCPF.Text)));
  Model.query_func.Open;

  if not Model.query_func.isEmpty then
  begin
    cpf := Model.query_func['cpf'];
    MessageDlg('O CPF ' + cpf + ' já está cadastrado!', mtInformation,
      mbOKCancel, 0);
    EdtCPF.Text := '';
    EdtCPF.SetFocus;
    exit;
  end;

  associarCampos;
  Model.tb_func.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;

end;

procedure TFrmFuncionarios.buscarCpf;
begin
  Model.query_func.Close;
  Model.query_func.SQL.Clear;
  Model.query_func.SQL.Add
    ('SELECT * from funcionarios where cpf = :cpf order by nome asc');
  Model.query_func.ParamByName('cpf').Value := EdtBuscarCPF.Text;
  Model.query_func.Open;
end;

procedure TFrmFuncionarios.buscarNome;
begin
  Model.query_func.Close;
  Model.query_func.SQL.Clear;
  Model.query_func.SQL.Add
    ('SELECT * from funcionarios where nome LIKE :nome order by nome asc');
  Model.query_func.ParamByName('nome').Value := EdtBuscarNome.Text + '%';
  Model.query_func.Open;
end;

procedure TFrmFuncionarios.carregarCombobox;
begin

  Model.query_cargos.Close;
  Model.query_cargos.Open;

  if not Model.query_cargos.isEmpty then
  begin
    while not Model.query_cargos.Eof do
    begin
      cbCargo.Items.Add(Model.query_cargos.FieldByName('cargo').AsString);
      Model.query_cargos.Next;
    end;

  end;

end;

procedure TFrmFuncionarios.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;
  BtnEditar.Enabled := true;
  BtnExcluir.Enabled := true;

  Model.tb_func.Edit;

  if Model.query_func.FieldByName('nome').Value <> null then
    EdtNome.Text := Model.query_func.FieldByName('nome').Value;

  EdtCPF.Text := Model.query_func.FieldByName('cpf').Value;

  cbCargo.Text := Model.query_func.FieldByName('cargo').Value;

  if Model.query_func.FieldByName('telefone').Value <> null then
    EdtTel.Text := Model.query_func.FieldByName('telefone').Value;

  if Model.query_func.FieldByName('endereco').Value <> null then
    EdtEndereco.Text := Model.query_func.FieldByName('endereco').Value;

  id := Model.query_func.FieldByName('id').Value;

  cpfAntigo := Model.query_func.FieldByName('cpf').Value;

end;

procedure TFrmFuncionarios.DBGrid1DblClick(Sender: TObject);
begin
  if chamada = 'Func' then
  begin
    idFunc := Model.query_func.FieldByName('id').Value;
    nomeFunc := Model.query_func.FieldByName('nome').Value;
    cargoFunc := Model.query_func.FieldByName('cargo').Value;
    Close;
    chamada := '';
  end;
end;

procedure TFrmFuncionarios.desabilitarCampos;
begin
  EdtNome.Enabled := false;
  EdtCPF.Enabled := false;
  EdtEndereco.Enabled := false;
  EdtTel.Enabled := false;
  cbCargo.Enabled := false;
end;

procedure TFrmFuncionarios.EdtBuscarCPFChange(Sender: TObject);
begin

  buscarCpf;

end;

procedure TFrmFuncionarios.EdtBuscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

procedure TFrmFuncionarios.FormShow(Sender: TObject);
begin
  desabilitarCampos;
  Model.tb_func.Active := true;
  listar;
  carregarCombobox;
  cbCargo.ItemIndex := 0;
  EdtBuscarCPF.Visible := false;
  rbNome.Checked := true;
end;

procedure TFrmFuncionarios.habilitarCampos;
begin
  EdtNome.Enabled := true;
  EdtCPF.Enabled := true;
  EdtEndereco.Enabled := true;
  EdtTel.Enabled := true;
  cbCargo.Enabled := true;
end;

procedure TFrmFuncionarios.limpar;
begin
  EdtNome.Text := '';
  EdtCPF.Text := '';
  EdtEndereco.Text := '';
  EdtTel.Text := '';
end;

procedure TFrmFuncionarios.listar;
begin
  Model.query_func.Close;
  Model.query_func.SQL.Clear;
  Model.query_func.SQL.Add('SELECT * from funcionarios order by nome asc');
  Model.query_func.Open;
end;

procedure TFrmFuncionarios.rbCPFClick(Sender: TObject);
begin
  listar;
  EdtBuscarCPF.Visible := true;
  EdtBuscarNome.Visible := false;
end;

procedure TFrmFuncionarios.rbNomeClick(Sender: TObject);
begin
  listar;
  EdtBuscarCPF.Visible := false;
  EdtBuscarNome.Visible := true;
end;

procedure TFrmFuncionarios.SB_CANCELARClick(Sender: TObject);
begin
Close;
end;

end.
