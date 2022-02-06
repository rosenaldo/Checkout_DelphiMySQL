unit Fornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TFrmFornecedores = class(TForm)
    EdtBuscarNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EdtNome: TEdit;
    Label4: TLabel;
    EdtTel: TMaskEdit;
    Label5: TLabel;
    EdtEndereco: TEdit;
    DBGrid1: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    Label3: TLabel;
    edtProduto: TEdit;
    P_CONTAINER: TPanel;
    P_TOPO: TPanel;
    P_RODAPE: TPanel;
    P_GRID: TPanel;
    SB_CANCELAR: TSpeedButton;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BtnExcluirClick(Sender: TObject);
    procedure EdtBuscarNomeChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure SB_CANCELARClick(Sender: TObject);
  private
    { Private declarations }
    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;

    procedure associarCampos;
    procedure listar;

    procedure buscarNome;
  public
    { Public declarations }
  end;

var
  FrmFornecedores: TFrmFornecedores;
  id: string;

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


{ TFrmFornecedores }

procedure TFrmFornecedores.associarCampos;
begin
  Model.tb_forn.FieldByName('nome').Value := EdtNome.Text;
  Model.tb_forn.FieldByName('produto').Value := edtProduto.Text;
  Model.tb_forn.FieldByName('telefone').Value := EdtTel.Text;
  Model.tb_forn.FieldByName('endereco').Value := EdtEndereco.Text;

  Model.tb_forn.FieldByName('data').Value := DateToStr(Date);
end;

procedure TFrmFornecedores.BtnEditarClick(Sender: TObject);
begin
  if Trim(EdtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
    EdtNome.SetFocus;
    exit;
  end;

  associarCampos;
  Model.query_forn.Close;
  Model.query_forn.SQL.Clear;
  Model.query_forn.SQL.Add
    ('UPDATE fornecedores set nome = :nome, produto = :produto, endereco = :endereco, telefone = :telefone where id = :id');
  Model.query_forn.ParamByName('nome').Value := EdtNome.Text;
  Model.query_forn.ParamByName('produto').Value := edtProduto.Text;
  Model.query_forn.ParamByName('endereco').Value := EdtEndereco.Text;
  Model.query_forn.ParamByName('telefone').Value := EdtTel.Text;

  Model.query_forn.ParamByName('id').Value := id;
  Model.query_forn.ExecSQL;

  listar;
  MessageDlg('Editado com Sucesso!!', mtInformation, mbOKCancel, 0);
  BtnEditar.Enabled := false;
  BtnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;
end;

procedure TFrmFornecedores.BtnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes then
  begin
    Model.tb_forn.Delete;
    MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

    BtnEditar.Enabled := false;
    BtnExcluir.Enabled := false;
    EdtNome.Text := '';
    listar;
  end;
end;

procedure TFrmFornecedores.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  Model.tb_forn.Insert;
  btnSalvar.Enabled := true;
end;

procedure TFrmFornecedores.btnSalvarClick(Sender: TObject);
begin
  if Trim(EdtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
    EdtNome.SetFocus;
    exit;
  end;

  associarCampos;
  Model.tb_forn.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;

end;

procedure TFrmFornecedores.buscarNome;
begin
  Model.query_forn.Close;
  Model.query_forn.SQL.Clear;
  Model.query_forn.SQL.Add
    ('SELECT * from fornecedores where nome LIKE :nome order by nome asc');
  Model.query_forn.ParamByName('nome').Value := EdtBuscarNome.Text + '%';
  Model.query_forn.Open;
end;

procedure TFrmFornecedores.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;
  BtnEditar.Enabled := true;
  BtnExcluir.Enabled := true;

  Model.tb_forn.Edit;

  EdtNome.Text := Model.query_forn.FieldByName('nome').Value;

  edtProduto.Text := Model.query_forn.FieldByName('produto').Value;

  if Model.query_forn.FieldByName('telefone').Value <> null then
    EdtTel.Text := Model.query_forn.FieldByName('telefone').Value;

  if Model.query_forn.FieldByName('endereco').Value <> null then
    EdtEndereco.Text := Model.query_forn.FieldByName('endereco').Value;

  id := Model.query_forn.FieldByName('id').Value;

end;

procedure TFrmFornecedores.DBGrid1DblClick(Sender: TObject);
begin
  if chamada = 'Forn' then
  begin
    idFornecedor := Model.query_forn.FieldByName('id').Value;
    nomeFornecedor := Model.query_forn.FieldByName('nome').Value;

    Close;
    chamada := '';
  end;
end;

procedure TFrmFornecedores.desabilitarCampos;
begin
  EdtNome.Enabled := false;
  edtProduto.Enabled := false;
  EdtEndereco.Enabled := false;
  EdtTel.Enabled := false;

end;

procedure TFrmFornecedores.EdtBuscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

procedure TFrmFornecedores.FormShow(Sender: TObject);
begin
  desabilitarCampos;
  Model.tb_forn.Active := true;
  listar;
end;

procedure TFrmFornecedores.habilitarCampos;
begin
  EdtNome.Enabled := true;
  edtProduto.Enabled := true;
  EdtEndereco.Enabled := true;
  EdtTel.Enabled := true;
end;

procedure TFrmFornecedores.limpar;
begin
  EdtNome.Text := '';
  edtProduto.Text := '';
  EdtEndereco.Text := '';
  EdtTel.Text := '';
end;

procedure TFrmFornecedores.listar;
begin
  Model.query_forn.Close;
  Model.query_forn.SQL.Clear;
  Model.query_forn.SQL.Add('SELECT * from fornecedores order by nome asc');
  Model.query_forn.Open;
end;

procedure TFrmFornecedores.SB_CANCELARClick(Sender: TObject);
begin
  Close;
end;

end.
