unit Produtos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.ExtDlgs, Vcl.DBCtrls;

type
  TFrmProdutos = class(TForm)
    Label2: TLabel;
    EdtNome: TEdit;
    Label3: TLabel;
    edtDescricao: TEdit;
    DBGrid1: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    Label4: TLabel;
    imgCod: TImage;
    edtValor: TEdit;
    Label5: TLabel;
    imagem: TImage;
    btnAdd: TSpeedButton;
    Panel1: TPanel;
    btnImprimir: TSpeedButton;
    Panel2: TPanel;
    btnGerarCod: TSpeedButton;
    EdtBuscarNome: TEdit;
    rbCPF: TRadioButton;
    rbNome: TRadioButton;
    Label1: TLabel;
    EdtBuscarCodigo: TMaskEdit;
    dialog: TOpenPictureDialog;
    edtCodigo: TMaskEdit;
    P_GRID: TPanel;
    P_TOPO: TPanel;
    P_RODAPE: TPanel;
    P_CONTAINER: TPanel;
    SB_CANCELAR: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnGerarCodClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure rbNomeClick(Sender: TObject);
    procedure rbCPFClick(Sender: TObject);
    procedure EdtBuscarNomeChange(Sender: TObject);
    procedure EdtBuscarCodigoChange(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure edtCodigoChange(Sender: TObject);
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
    procedure buscarCodigo;

    procedure salvarFoto;
    procedure carregarImgPadrao;

    procedure GerarCodigo(codigo: string; Canvas: TCanvas);

  public
    { Public declarations }
  end;

var
  FrmProdutos: TFrmProdutos;
  id: string;
  img: TPicture;
  caminhoImg: string;
  alterou: boolean;

  // DECLARA??O DAS VARIAVEIS GLOBAIS
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

uses DM.Model,
ImprimirBarras;

{ TFrmProdutos }

procedure TFrmProdutos.associarCampos;
begin
  Model.query_produtosnome.Value := EdtNome.Text;
  Model.query_produtosdescricao.Value := edtDescricao.Text;
  Model.query_produtoscodigo.Value := edtCodigo.Text;
  Model.query_produtosvalor.Value := StrToCurr(edtValor.Text);
  // Model.tb_produtos.FieldByName('nome').Value := EdtNome.Text;
  // Model.tb_produtos.FieldByName('descricao').Value := edtDescricao.Text;
  // Model.tb_produtos.FieldByName('codigo').Value := edtCodigo.Text;
  // Model.tb_produtos.FieldByName('valor').Value := edtValor.Text;

  Model.query_produtosdata.Value := Date;
end;

procedure TFrmProdutos.btnAddClick(Sender: TObject);
begin
  dialog.Execute();
  imagem.Picture.LoadFromFile(dialog.FileName);
  alterou := true;
end;

procedure TFrmProdutos.BtnEditarClick(Sender: TObject);
begin
  if Trim(EdtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
    EdtNome.SetFocus;
    exit;
  end;

  associarCampos;
  Model.query_produtos.Close;
  Model.query_produtos.SQL.Clear;

  if alterou then
  begin
    Model.query_produtos.SQL.Add
      ('UPDATE produtos set codigo = :codigo, nome = :nome, descricao = :descricao,  valor = :valor, imagem = :imagem where id = :id');
    img := TPicture.Create;
    img.LoadFromFile(dialog.FileName);
    Model.query_produtos.ParamByName('imagem').Assign(img);
    img.Free;
    alterou := false;
  end
  else
  begin
    Model.query_produtos.SQL.Add
      ('UPDATE produtos set codigo = :codigo, nome = :nome, descricao = :descricao,  valor = :valor where id = :id');
  end;

  Model.query_produtos.ParamByName('codigo').Value := edtCodigo.Text;
  Model.query_produtos.ParamByName('nome').Value := EdtNome.Text;
  Model.query_produtos.ParamByName('descricao').Value := edtDescricao.Text;

  Model.query_produtos.ParamByName('valor').Value := strToFloat(edtValor.Text);

  Model.query_produtos.ParamByName('id').Value := id;
  Model.query_produtos.ExecSQL;

  listar;
  MessageDlg('Editado com Sucesso!!', mtInformation, mbOKCancel, 0);
  BtnEditar.Enabled := false;
  BtnExcluir.Enabled := false;
  limpar;
  desabilitarCampos;
end;

procedure TFrmProdutos.BtnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes then
  begin
    Model.query_produtos.Delete;
    MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

    BtnEditar.Enabled := false;
    BtnExcluir.Enabled := false;
    limpar;
    desabilitarCampos;
    listar;
  end;
end;

procedure TFrmProdutos.btnGerarCodClick(Sender: TObject);
var
  cod: string;
begin

  if Trim(edtCodigo.Text) = '' then
  begin
    MessageDlg('Preencha o Codigo!', mtInformation, mbOKCancel, 0);
    edtCodigo.SetFocus;
    exit;
  end;

  // VERIFICAR SE O codigo J? EST? CADASTRADO
  Model.query_coringa.Close;
  Model.query_coringa.SQL.Clear;
  Model.query_coringa.SQL.Add('SELECT * from produtos where codigo = ' +
    edtCodigo.Text);
  Model.query_coringa.Open;

  if not Model.query_coringa.isEmpty then
  begin
    cod := Model.query_coringa['codigo'];
    MessageDlg('O C?digo ' + cod + ' j? est? cadastrado!', mtInformation,
      mbOKCancel, 0);
    edtCodigo.Text := '';
    edtCodigo.SetFocus;
    exit;
  end;

  GerarCodigo(edtCodigo.Text, imgCod.Canvas);
  btnSalvar.Enabled := true;
end;

procedure TFrmProdutos.btnImprimirClick(Sender: TObject);
begin
  FrmImprimirBarras := TFrmImprimirBarras.Create(self);
  FrmImprimirBarras.ShowModal;
end;

procedure TFrmProdutos.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  Model.tb_produtos.Insert;
  Model.query_produtos.Insert;
  btnSalvar.Enabled := true;
  edtCodigo.SetFocus;
  limpar;

end;

procedure TFrmProdutos.btnSalvarClick(Sender: TObject);

begin
  if Trim(EdtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
    EdtNome.SetFocus;
    exit;
  end;

  if Trim(edtCodigo.Text) = '' then
  begin
    MessageDlg('Preencha o Codigo!', mtInformation, mbOKCancel, 0);
    edtCodigo.SetFocus;
    exit;
  end;

  try
    associarCampos;
    salvarFoto;
    Model.query_produtos.Post;
    // Model.tb_produtos.Post;
    MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
    limpar;
    desabilitarCampos;
    btnSalvar.Enabled := false;
    listar;

  except
    MessageDlg('Imagem grande demais', mtInformation, mbOKCancel, 0);
    Model.fd.Connected := true;
    Model.tb_produtos.Active := true;
    Model.tb_produtos.Insert;
    Model.query_produtos.Insert;
    carregarImgPadrao;
    listar;
  end;
end;

procedure TFrmProdutos.buscarCodigo;
begin
  Model.query_produtos.Close;
  Model.query_produtos.SQL.Clear;
  Model.query_produtos.SQL.Add
    ('SELECT * from produtos where codigo LIKE :codigo order by nome asc');
  Model.query_produtos.ParamByName('codigo').Value := EdtBuscarCodigo.Text + '%';
  Model.query_produtos.Open;
end;

procedure TFrmProdutos.buscarNome;
begin
  Model.query_produtos.Close;
  Model.query_produtos.SQL.Clear;
  Model.query_produtos.SQL.Add
    ('SELECT * from produtos where nome LIKE :nome order by nome asc');
  Model.query_produtos.ParamByName('nome').Value := EdtBuscarNome.Text + '%';
  Model.query_produtos.Open;
end;

procedure TFrmProdutos.carregarImgPadrao;
begin
  caminhoImg := ExtractFileDir(GetCurrentDir) + '\Release\img\sem-foto.jpg';
  imagem.Picture.LoadFromFile(caminhoImg);
end;

{ PROCEDIMENTO PADR?O PARA RECUPERAR FOTO DO BANCO }
procedure ExibeFoto(DataSet: TDataSet; BlobFieldName: String;
  ImageExibicao: TImage);

var
  MemoryStream: TMemoryStream;
  jpg: TPicture;
const
  OffsetMemoryStream: Int64 = 0;

begin
  if not(DataSet.isEmpty) and
    not((DataSet.FieldByName(BlobFieldName) as TBlobField).IsNull) then
    try
      MemoryStream := TMemoryStream.Create;
      jpg := TPicture.Create;
      (DataSet.FieldByName(BlobFieldName) as TBlobField)
        .SaveToStream(MemoryStream);
      MemoryStream.Position := OffsetMemoryStream;
      jpg.LoadFromStream(MemoryStream);
      ImageExibicao.Picture.Assign(jpg);
    finally
      // Jpg.Free;
      MemoryStream.Free;
    end
  else
    ImageExibicao.Picture := Nil;
end;

procedure TFrmProdutos.DBGrid1CellClick(Column: TColumn);
begin
  habilitarCampos;
  BtnEditar.Enabled := true;
  BtnExcluir.Enabled := true;
  btnImprimir.Enabled := true;
  btnGerarCod.Enabled := true;

  Model.tb_produtos.Edit;
  Model.query_produtos.Edit;

  EdtNome.Text := Model.query_produtos.FieldByName('nome').Value;

  edtDescricao.Text := Model.query_produtos.FieldByName('descricao').Value;
  edtValor.Text := Model.query_produtos.FieldByName('valor').Value;
  edtCodigo.Text := Model.query_produtos.FieldByName('codigo').Value;
  GerarCodigo(edtCodigo.Text, imgCod.Canvas);

  id := Model.query_produtos.FieldByName('id').Value;
  codigoProduto := Model.query_produtos.FieldByName('codigo').Value;

  if Model.query_produtos.FieldByName('imagem').Value <> null then
    ExibeFoto(Model.query_produtos, 'imagem', imagem);

end;

procedure TFrmProdutos.DBGrid1DblClick(Sender: TObject);
begin
  if chamada = 'Prod' then
  begin
    idProduto := Model.query_produtos.FieldByName('id').Value;
    nomeProduto := Model.query_produtos.FieldByName('nome').Value;
    estoqueProduto := Model.query_produtos.FieldByName('estoque').Value;
    Close;
    chamada := '';
  end;
end;

procedure TFrmProdutos.desabilitarCampos;
begin
  EdtNome.Enabled := false;
  edtDescricao.Enabled := false;
  edtCodigo.Enabled := false;
  edtValor.Enabled := false;
  btnAdd.Enabled := false;
  btnGerarCod.Enabled;
  imgCod.Visible := false;
end;

procedure TFrmProdutos.EdtBuscarCodigoChange(Sender: TObject);
begin
  buscarCodigo;
end;

procedure TFrmProdutos.EdtBuscarNomeChange(Sender: TObject);
begin
  buscarNome;
end;

procedure TFrmProdutos.edtCodigoChange(Sender: TObject);
begin

  btnGerarCod.Enabled := true;

end;

procedure TFrmProdutos.FormShow(Sender: TObject);
begin
  carregarImgPadrao;
  desabilitarCampos;
  Model.tb_produtos.Active := true;
  listar;

  rbNome.Checked := true;
  EdtBuscarCodigo.Visible := false;
  dialog.FileName := ExtractFileDir(GetCurrentDir) + '\Release\img\sem-foto.jpg';

end;

procedure TFrmProdutos.GerarCodigo(codigo: string; Canvas: TCanvas);
const

  digitos: array ['0' .. '9'] of string[5] = ('00110', '10001', '01001',
    '11000', '00101', '10100', '01100', '00011', '10010', '01010');
var
  s: string;
  i, j, x, t: Integer;
begin

  try

    // Gerar o valor para desenhar o c?digo de barras
    // Caracter de in?cio
    s := '0000';
    for i := 1 to length(codigo) div 2 do
      for j := 1 to 5 do
        s := s + Copy(digitos[codigo[i * 2 - 1]], j, 1) +
          Copy(digitos[codigo[i * 2]], j, 1);
    // Caracter de fim
    s := s + '100';
    // Desenhar em um objeto canvas
    // Configurar os par?metros iniciais
    x := 0;
    // Pintar o fundo do c?digo de branco
    Canvas.Brush.Color := clWhite;
    Canvas.Pen.Color := clWhite;
    Canvas.Rectangle(0, 0, 500, 50);
    // Definir as cores da caneta
    Canvas.Brush.Color := clBlack;
    Canvas.Pen.Color := clBlack;
    // Escrever o c?digo de barras no canvas
    for i := 1 to length(s) do
    begin
      // Definir a espessura da barra
      t := strToInt(s[i]) * 2 + 1;
      // Imprimir apenas barra sim barra n?o (preto/branco - intercalado);
      if i mod 2 = 1 then
        Canvas.Rectangle(x, 0, x + t, 50);
      // Passar para a pr?xima barra
      x := x + t;
    end;

  except
    MessageDlg('Preencha todo o c?digo!!', mtInformation, mbOKCancel, 0);
    Model.fd.Connected := true;
    Model.tb_produtos.Active := true;
    Model.tb_produtos.Insert;
    listar;
  end;
end;

procedure TFrmProdutos.habilitarCampos;
begin
  EdtNome.Enabled := true;
  edtDescricao.Enabled := true;
  edtCodigo.Enabled := true;
  edtValor.Enabled := true;
  btnAdd.Enabled := true;
  imgCod.Visible := true;
end;

procedure TFrmProdutos.limpar;
begin
  EdtNome.Text := '';
  edtDescricao.Text := '';
  edtCodigo.Text := '';
  edtValor.Text := '';
  carregarImgPadrao;

end;

procedure TFrmProdutos.listar;
begin
  Model.query_produtos.Close;
  Model.query_produtos.SQL.Clear;
  Model.query_produtos.SQL.Add('SELECT * from produtos order by nome asc');
  Model.query_produtos.Open;
end;

procedure TFrmProdutos.rbCPFClick(Sender: TObject);
begin
  listar;
  EdtBuscarCodigo.Visible := true;
  EdtBuscarNome.Visible := false;
  EdtBuscarCodigo.SetFocus;
end;

procedure TFrmProdutos.rbNomeClick(Sender: TObject);
begin
  listar;
  EdtBuscarCodigo.Visible := false;
  EdtBuscarNome.Visible := true;
  EdtBuscarNome.SetFocus;
end;

procedure TFrmProdutos.salvarFoto;
begin
  if dialog.FileName <> '' then
  begin

    img := TPicture.Create;
    img.LoadFromFile(dialog.FileName);

    Model.query_produtosimagem.Assign(img);
    // Model.tb_produtos.FieldByName('imagem').Assign(img);
    img.Free;
    dialog.FileName := ExtractFileDir(GetCurrentDir) +
      '\Release\img\sem-foto.jpg';
    alterou := false;

  end
  else
  begin
    Model.query_produtosimagem.AsBCD :=
      (ExtractFileDir(GetCurrentDir) + '\Release\img\sem-foto.jpg');


    // dm.tb_produtos.FieldByName('imagem').Value := ExtractFileDir(GetCurrentDir)
    // + '\Release\img\sem-foto.jpg';

  end;

end;

procedure TFrmProdutos.SB_CANCELARClick(Sender: TObject);
begin
  Close;
end;

end.
