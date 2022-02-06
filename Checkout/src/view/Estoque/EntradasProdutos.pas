unit EntradasProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFrmEntradaProdutos = class(TForm)
    Label2: TLabel;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    Label1: TLabel;
    btnBuscarPro: TSpeedButton;
    Label3: TLabel;
    EdtProduto: TEdit;
    DBGrid1: TDBGrid;
    edtQuantidade: TEdit;
    Label4: TLabel;
    edtValor: TEdit;
    edtFornecedor: TEdit;
    btnBuscarForn: TSpeedButton;
    Label5: TLabel;
    dataBuscar: TDateTimePicker;
    lblTotal: TLabel;
    P_CONTAINER: TPanel;
    P_TOPO: TPanel;
    P_GRID: TPanel;
    P_RODAPE: TPanel;
    SB_CANCELAR: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnBuscarProClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnBuscarFornClick(Sender: TObject);
    procedure edtQuantidadeChange(Sender: TObject);
    procedure edtValorChange(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BtnExcluirClick(Sender: TObject);
    procedure dataBuscarChange(Sender: TObject);
    procedure SB_CANCELARClick(Sender: TObject);
  private
    { Private declarations }

    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;

    procedure associarCampos;
    procedure listar;
    procedure buscarData;
  public
    { Public declarations }
  end;

var
  FrmEntradaProdutos: TFrmEntradaProdutos;
  total: double;
  estoque: double;
  idProdutoEst: string;
  idEntrada: string;

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

uses DM.Model, Produtos, Fornecedores;

procedure TFrmEntradaProdutos.associarCampos;
begin
  Model.tb_entrada_pro.FieldByName('produto').Value := EdtProduto.Text;
  Model.tb_entrada_pro.FieldByName('quantidade').Value := edtQuantidade.Text;
  Model.tb_entrada_pro.FieldByName('fornecedor').Value := idFornecedor;
  Model.tb_entrada_pro.FieldByName('valor').Value := edtValor.Text;
  Model.tb_entrada_pro.FieldByName('total').Value := total;
  Model.tb_entrada_pro.FieldByName('data').Value := DateToStr(Date);
  Model.tb_entrada_pro.FieldByName('id_produto').Value := idProduto;
end;

procedure TFrmEntradaProdutos.btnBuscarFornClick(Sender: TObject);
begin
  chamada := 'Forn';
  FrmFornecedores := TFrmFornecedores.Create(self);
  FrmFornecedores.Show;
end;

procedure TFrmEntradaProdutos.btnBuscarProClick(Sender: TObject);
begin
  chamada := 'Prod';
  FrmProdutos := TFrmProdutos.Create(self);
  FrmProdutos.Show;
end;

procedure TFrmEntradaProdutos.BtnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes then
  begin
    Model.tb_entrada_pro.Delete;


    // ATUALIZAR O ESTOQUE

    // RECUPERAR O ESTOQUE ATUAL
    Model.query_produtos.Close;
    Model.query_produtos.SQL.Clear;
    Model.query_produtos.SQL.Add('select * from produtos where id = :id');

    Model.query_produtos.ParamByName('id').Value := idProdutoEst;
    Model.query_produtos.Open;

    if not Model.query_produtos.isEmpty then
    begin
      estoqueProduto := Model.query_produtos['estoque'];

    end;

    estoque := estoqueProduto - strToFloat(edtQuantidade.Text);

    Model.query_produtos.Close;
    Model.query_produtos.SQL.Clear;
    Model.query_produtos.SQL.Add
      ('UPDATE produtos set estoque = :estoque where id = :id');
    Model.query_produtos.ParamByName('estoque').Value := estoque;
    Model.query_produtos.ParamByName('id').Value := idProduto;
    Model.query_produtos.ExecSQL;

    MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

    listar;

    BtnExcluir.Enabled := false;

  end;
end;

procedure TFrmEntradaProdutos.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  Model.tb_entrada_pro.Insert;
  btnSalvar.Enabled := true;

end;

procedure TFrmEntradaProdutos.btnSalvarClick(Sender: TObject);
begin
  if Trim(EdtProduto.Text) = '' then
  begin
    MessageDlg('Escolha um Produto!', mtInformation, mbOKCancel, 0);

    exit;
  end;

  if Trim(edtFornecedor.Text) = '' then
  begin
    MessageDlg('Escolha um Produto!', mtInformation, mbOKCancel, 0);

    exit;
  end;

  if (Trim(edtValor.Text) = '0') or (Trim(edtValor.Text) = '') then
  begin
    MessageDlg('Insira um valor!', mtInformation, mbOKCancel, 0);
    edtValor.SetFocus;
    exit;
  end;

  associarCampos;
  Model.tb_entrada_pro.Post;

  // ATUALIZAR O ESTOQUE e DATA DA ULTIMA COMPRA  e ADICIONAR OS PRODUTOS COMPRADOS AO ESTOQUE

  estoque := estoqueProduto + strToFloat(edtQuantidade.Text);

  Model.query_produtos.Close;
  Model.query_produtos.SQL.Clear;
  Model.query_produtos.SQL.Add
    ('UPDATE produtos set estoque = :estoque, ultima_compra = :data where id = :id');
  Model.query_produtos.ParamByName('estoque').Value := estoque;
  Model.query_produtos.ParamByName('data').Value := Date;
  Model.query_produtos.ParamByName('id').Value := idProduto;
  Model.query_produtos.ExecSQL;

  // RECUPERAR O ID DA ULTIMA COMPRA INSERIDA
  Model.query_coringa.Close;
  Model.query_coringa.SQL.Clear;
  Model.query_coringa.SQL.Add('SELECT * from entrada_produtos order by id desc');

  Model.query_coringa.Open;

  if not Model.query_coringa.isEmpty then
  begin
    idEntrada := Model.query_coringa['id'];
  end;

  // LANÇAR O VALOR  NAS MOVIMENTAÇÕES
  Model.query_mov.Close;
  Model.query_mov.SQL.Clear;
  Model.query_mov.SQL.Add
    ('INSERT INTO movimentacoes (tipo, movimento, valor, funcionario, data, id_movimento) VALUES (:tipo, :movimento, :valor, :funcionario, curDate(), :id_movimento)');
  Model.query_mov.ParamByName('tipo').Value := 'Saída';
  Model.query_mov.ParamByName('movimento').Value := 'Compra de Produtos';
  Model.query_mov.ParamByName('valor').Value := total;
  Model.query_mov.ParamByName('funcionario').Value := nomeUsuario;
  Model.query_mov.ParamByName('id_movimento').Value := idEntrada;
  Model.query_mov.ExecSQL;

  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;

end;

procedure TFrmEntradaProdutos.buscarData;
begin
  Model.query_entrada_pro.Close;
  Model.query_entrada_pro.SQL.Clear;
  Model.query_entrada_pro.SQL.Add
    ('SELECT e.id, e.produto, e.quantidade, e.fornecedor, e.valor, e.total, e.data, e.id_produto, f.nome, f.telefone from entrada_produtos as e INNER JOIN fornecedores as f on e.fornecedor = f.id where e.data = :data order by e.data desc');
  Model.query_entrada_pro.ParamByName('data').Value :=
    FormatDateTime('yyyy/mm/dd', dataBuscar.Date);
  Model.query_entrada_pro.Open;
end;

procedure TFrmEntradaProdutos.dataBuscarChange(Sender: TObject);
begin
  buscarData;
end;

procedure TFrmEntradaProdutos.DBGrid1CellClick(Column: TColumn);
begin

  BtnExcluir.Enabled := true;

  EdtProduto.Text := Model.query_entrada_pro.FieldByName('produto').Value;

  edtFornecedor.Text := Model.query_entrada_pro.FieldByName('id').Value;
  edtValor.Text := Model.query_entrada_pro.FieldByName('valor').Value;
  edtQuantidade.Text := Model.query_entrada_pro.FieldByName('quantidade').Value;

  id := Model.query_entrada_pro.FieldByName('id').Value;
  idProdutoEst := Model.query_entrada_pro.FieldByName('id_produto').Value;

  total := Model.query_entrada_pro.FieldByName('total').Value;
  lblTotal.Caption := FormatFloat('R$ #,,,,0.00',
    Model.query_entrada_pro.FieldByName('total').Value);

end;

procedure TFrmEntradaProdutos.desabilitarCampos;
begin

  edtValor.Enabled := false;
  edtQuantidade.Enabled := false;
  btnBuscarPro.Enabled := false;
  btnBuscarForn.Enabled := false;
end;

procedure TFrmEntradaProdutos.edtQuantidadeChange(Sender: TObject);
begin
  if edtQuantidade.Text <> '' then
  begin
    total := strToFloat(edtQuantidade.Text) * strToFloat(edtValor.Text);
    lblTotal.Caption := FormatFloat('R$ #,,,,0.00', total);
  end;
end;

procedure TFrmEntradaProdutos.edtValorChange(Sender: TObject);
begin
  if edtValor.Text <> '' then
  begin
    total := strToFloat(edtQuantidade.Text) * strToFloat(edtValor.Text);
    lblTotal.Caption := FormatFloat('R$ #,,,,0.00', total);
  end;
end;

procedure TFrmEntradaProdutos.FormActivate(Sender: TObject);
begin
  EdtProduto.Text := nomeProduto;
  edtFornecedor.Text := nomeFornecedor;
end;

procedure TFrmEntradaProdutos.FormShow(Sender: TObject);
begin

  if chamada = 'Ent' then
  BEGIN
    habilitarCampos;
    Model.tb_entrada_pro.Active := true;
    Model.tb_entrada_pro.Insert;
    btnSalvar.Enabled := true;
  end
  else
  begin
    desabilitarCampos;
    Model.tb_entrada_pro.Active := true;
  END;

  // listar;
  dataBuscar.Date := Date;
  buscarData;

end;

procedure TFrmEntradaProdutos.habilitarCampos;
begin
  edtValor.Enabled := true;
  edtQuantidade.Enabled := true;
  btnBuscarPro.Enabled := true;
  btnBuscarForn.Enabled := true;
end;

procedure TFrmEntradaProdutos.limpar;
begin
  edtValor.Text := '0';
  edtQuantidade.Text := '1';
  EdtProduto.Text := '';
  edtFornecedor.Text := '';
  lblTotal.Caption := '0';
  total := 0;
  estoque := 0;
end;

procedure TFrmEntradaProdutos.listar;
begin
  Model.query_entrada_pro.Close;
  Model.query_entrada_pro.SQL.Clear;
  Model.query_entrada_pro.SQL.Add
    ('SELECT e.id, e.produto, e.quantidade, e.fornecedor, e.valor, e.total, e.data, e.id_produto, f.nome, f.telefone from entrada_produtos as e INNER JOIN fornecedores as f on e.fornecedor = f.id order by e.data desc');
  Model.query_entrada_pro.Open;
end;

procedure TFrmEntradaProdutos.SB_CANCELARClick(Sender: TObject);
begin
  Close;
end;

end.
