unit Vendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.MPlayer, ACBrBase, ACBrDFe, ACBrNFe, ACBrUtil,
  ACBrNFeNotasFiscais, pcnConversao, pcnConversaoNFe,
  pcnNFe, pnfsConversao, System.Math, Vcl.Buttons;

type
  TFrmVendas = class(TForm)
    painelGrid: TPanel;
    DBGrid1: TDBGrid;
    painelCentral: TPanel;
    edtCodBarras: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtProduto: TEdit;
    edtDescri??o: TEdit;
    edtQuantidade: TEdit;
    edtPreco: TEdit;
    edtEstoque: TEdit;
    imagem: TImage;
    MediaPlayer1: TMediaPlayer;
    painelTotal: TPanel;
    Panel3: TPanel;
    edtTotal: TEdit;
    edtSubTotal: TEdit;
    edtDesconto: TEdit;
    edtTotalCompra: TEdit;
    edtValorRecebido: TEdit;
    edtTroco: TEdit;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    nfce: TACBrNFe;
    btnLogin: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure edtCodBarrasChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure edtDescontoChange(Sender: TObject);
    procedure edtValorRecebidoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLoginClick(Sender: TObject);

  private
    { Private declarations }
    procedure limpar;
    procedure limparProdutos;
    procedure buscarProduto;
    procedure salvarItens;
    procedure salvarVenda;
    procedure limparFoto;
    procedure listar;

    procedure associarCamposDet;
    procedure associarCamposVenda;

    procedure IniciarNFCE;
    procedure gerarNFCE;

    procedure ImprimirCupom;

  public
    { Public declarations }
  end;

var
  FrmVendas: TFrmVendas;
  totalItem: double;
  totalVenda: double;
  estoque: double;
  totalcomDesconto: double;
  troco: double;

  idVenda: string;

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

uses DM.Model, CancelarItem, OrdemDeServico.View;

{ TFrmVendas }

{ PROCEDIMENTO PADR?O PARA RECUPERAR FOTO DO BANCO }
procedure ExibeFoto(DataSet: TDataSet; BlobFieldName: String;
  ImageExibicao: TImage);

var
  MemoryStream: TMemoryStream;
  jpg: TPicture;
const
  OffsetMemoryStream: Int64 = 0;

begin
  if not(DataSet.IsEmpty) and
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

procedure TFrmVendas.associarCamposDet;
begin
  Model.tb_detalhes_vendas.FieldByName('id_venda').Value := '0';
  Model.tb_detalhes_vendas.FieldByName('produto').Value := edtProduto.Text;
  Model.tb_detalhes_vendas.FieldByName('valor').Value := edtPreco.Text;
  Model.tb_detalhes_vendas.FieldByName('quantidade').Value := edtQuantidade.Text;
  Model.tb_detalhes_vendas.FieldByName('total').Value := totalItem;
  Model.tb_detalhes_vendas.FieldByName('id_produto').Value := idProduto;
  Model.tb_detalhes_vendas.FieldByName('funcionario').Value := nomeUsuario;
  Model.tb_detalhes_vendas.FieldByName('data').Value := DateToStr(Date);
end;

procedure TFrmVendas.associarCamposVenda;
begin
  Model.tb_vendas.FieldByName('valor').Value := totalcomDesconto;
  Model.tb_vendas.FieldByName('data').Value := DateToStr(Date);
  Model.tb_vendas.FieldByName('hora').Value := TimeToStr(Time);
  Model.tb_vendas.FieldByName('funcionario').Value := nomeUsuario;
  Model.tb_vendas.FieldByName('desconto').Value := strToFloat(edtDesconto.Text);
  Model.tb_vendas.FieldByName('valor_recebido').Value :=
    strToFloat(edtValorRecebido.Text);
  Model.tb_vendas.FieldByName('troco').Value := troco;
  Model.tb_vendas.FieldByName('status').Value := 'Conclu?da';
end;

procedure TFrmVendas.btnLoginClick(Sender: TObject);
begin
FRM_OS:= TFRM_OS.create(nil);
try
  FRM_OS.showmodal;
finally
 FRM_OS.free;
end;
end;

procedure TFrmVendas.buscarProduto;
begin
  Model.query_produtos.Close;
  Model.query_produtos.SQL.Clear;
  Model.query_produtos.SQL.Add('SELECT * from produtos where codigo = :codigo');
  Model.query_produtos.ParamByName('codigo').Value := edtCodBarras.Text;
  Model.query_produtos.Open;

  if not Model.query_produtos.IsEmpty then
  begin

    edtQuantidade.enabled := false;

    edtProduto.Text := Model.query_produtos['nome'];
    edtDescri??o.Text := Model.query_produtos['descricao'];
    edtPreco.Text := Model.query_produtos['valor'];
    edtEstoque.Text := Model.query_produtos['estoque'];
    idProduto := Model.query_produtos['id'];

    ExibeFoto(Model.query_produtos, 'imagem', imagem);

    // NO PDV NAO ? NECESS?RIO VERIFICAR ESTOQUE NA VENDA
    if strtoInt(edtEstoque.Text) < strtoInt(edtQuantidade.Text) then
    begin
      MessageDlg('N?o existe produtos em estoque', mtInformation,
        mbOKCancel, 0);
      edtQuantidade.enabled := True;
      exit;
    end;

    totalItem := strToFloat(edtQuantidade.Text) * strToFloat(edtPreco.Text);
    totalVenda := totalVenda + totalItem;

    edtTotal.Text := FormatFloat('R$ #,,,,0.00', totalItem);
    edtSubTotal.Text := FormatFloat('R$ #,,,,0.00', totalVenda);
    edtTotalCompra.Text := FormatFloat('R$ #,,,,0.00', totalVenda);

    totalcomDesconto := totalVenda;
    edtValorRecebido.Text := floatToStr(totalVenda);

    Model.tb_detalhes_vendas.Insert;
    salvarItens;

  end
  else
  begin
    limparProdutos;

  end;

end;

procedure TFrmVendas.edtCodBarrasChange(Sender: TObject);
begin

  if edtCodBarras.Text <> '' then
    buscarProduto;

end;

procedure TFrmVendas.edtDescontoChange(Sender: TObject);

begin
  totalcomDesconto := totalVenda - strToFloat(edtDesconto.Text);
  edtTotalCompra.Text := FormatFloat('R$ #,,,,0.00', totalcomDesconto);
end;

procedure TFrmVendas.edtValorRecebidoChange(Sender: TObject);

begin
  if edtValorRecebido.Text <> '' then
  begin

    troco := strToFloat(edtValorRecebido.Text) - totalcomDesconto;
    edtTroco.Text := FormatFloat('R$ #,,,,0.00', troco);
  end;

end;

procedure TFrmVendas.FormActivate(Sender: TObject);
begin
  listar;

  totalVenda := totalVenda - totalProdutos;
  edtSubTotal.Text := FormatFloat('R$ #,,,,0.00', totalVenda);
  edtTotalCompra.Text := FormatFloat('R$ #,,,,0.00', totalVenda);
end;

procedure TFrmVendas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MediaPlayer1.Destroy;
end;

procedure TFrmVendas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  if Key = VK_ESCAPE then
  begin
    FrmCancelarItem := TFrmCancelarItem.Create(self);
    FrmCancelarItem.Show;
  end;

  if Key = 13 then
  begin

    Model.tb_vendas.Insert;
    if MessageDlg('Deseja Fechar a venda?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
    then
    begin

      if strToFloat(edtValorRecebido.Text) >= totalcomDesconto then
      begin
        salvarVenda;
      end
      else
      begin
        MessageDlg('O valor pago deve ser maior que o valor da venda!',
          mtInformation, mbOKCancel, 0);
        edtValorRecebido.SetFocus;
      end;

    end;

  end;

end;

procedure TFrmVendas.FormShow(Sender: TObject);
begin
  limpar;
  Model.tb_vendas.Active := True;
  Model.tb_detalhes_vendas.Active := True;

  totalItem := 0;
  totalVenda := 0;
  estoque := 0;
  totalcomDesconto := 0;
  troco := 0;

end;

procedure TFrmVendas.gerarNFCE;
Var
  NotaF: NotaFiscal;
  item: integer;
  Produto: TDetCollectionItem;
  InfoPgto: TpagCollectionItem;

begin
  nfce.NotasFiscais.Clear;
  NotaF := nfce.NotasFiscais.Add;


  // DADOS DA NOTA FISCAL

  NotaF.NFe.Ide.natOp := 'VENDA';
  NotaF.NFe.Ide.indPag := ipVista;
  NotaF.NFe.Ide.modelo := 65;
  NotaF.NFe.Ide.serie := 1;
  NotaF.NFe.Ide.nNF := strtoInt(idVenda);
  NotaF.NFe.Ide.dEmi := Date;
  NotaF.NFe.Ide.dSaiEnt := Date;
  NotaF.NFe.Ide.hSaiEnt := Now;
  NotaF.NFe.Ide.tpNF := tnSaida;
  NotaF.NFe.Ide.tpEmis := teNormal;
  NotaF.NFe.Ide.tpAmb := taHomologacao;
  // Lembre-se de trocar esta vari?vel quando for para ambiente de produ??o
  NotaF.NFe.Ide.verProc := '1.0.0.0'; // Vers?o do seu sistema
  NotaF.NFe.Ide.cUF := 24; // CODIGO DA CIDADE
  NotaF.NFe.Ide.cMunFG := 0624123;
  // VOCE PRECISA ALTERAR DE ACORDO COM O CODIGO DE EMISSAO DE NFCE PARA SEU MUNICIPIO
  NotaF.NFe.Ide.finNFe := fnNormal;


  // DADOS DO EMITENTE

  NotaF.NFe.Emit.CNPJCPF := '18311776000198';
  NotaF.NFe.Emit.IE := '';
  NotaF.NFe.Emit.xNome := 'Q-Cursos Networks';
  NotaF.NFe.Emit.xFant := 'Q-Cursos';

  NotaF.NFe.Emit.EnderEmit.fone := '(31)3333-3333';
  NotaF.NFe.Emit.EnderEmit.CEP := 30512660;
  NotaF.NFe.Emit.EnderEmit.xLgr := 'Rua A';
  NotaF.NFe.Emit.EnderEmit.nro := '325';
  NotaF.NFe.Emit.EnderEmit.xCpl := '';
  NotaF.NFe.Emit.EnderEmit.xBairro := 'Santa Monica';
  NotaF.NFe.Emit.EnderEmit.cMun := 0624123;
  NotaF.NFe.Emit.EnderEmit.xMun := 'Belo Horizonte';
  NotaF.NFe.Emit.EnderEmit.UF := 'MG';
  NotaF.NFe.Emit.EnderEmit.cPais := 1058;
  NotaF.NFe.Emit.EnderEmit.xPais := 'BRASIL';

  NotaF.NFe.Emit.IEST := '';
  // NotaF.NFe.Emit.IM                := '2648800'; // Preencher no caso de existir servi?os na nota
  // NotaF.NFe.Emit.CNAE              := '6201500'; // Verifique na cidade do emissor da NFe se ? permitido
  // a inclus?o de servi?os na NFe
  NotaF.NFe.Emit.CRT := crtSimplesNacional;
  // (1-crtSimplesNacional, 2-crtSimplesExcessoReceita, 3-crtRegimeNormal)



  // DADOS DO DESTINAT?RIO

  // NotaF.NFe.Dest.CNPJCPF           := '05481336000137';
  // NotaF.NFe.Dest.IE                := '687138770110';
  // NotaF.NFe.Dest.ISUF              := '';
  // NotaF.NFe.Dest.xNome             := 'D.J. COM. E LOCA??O DE SOFTWARES LTDA - ME';

  //
  // NotaF.NFe.Dest.EnderDest.Fone    := '1532599600';
  // NotaF.NFe.Dest.EnderDest.CEP     := 18270170;
  // NotaF.NFe.Dest.EnderDest.xLgr    := 'Rua Coronel Aureliano de Camargo';
  // NotaF.NFe.Dest.EnderDest.nro     := '973';
  // NotaF.NFe.Dest.EnderDest.xCpl    := '';
  // NotaF.NFe.Dest.EnderDest.xBairro := 'Centro';
  // NotaF.NFe.Dest.EnderDest.cMun    := 3554003;
  // NotaF.NFe.Dest.EnderDest.xMun    := 'Tatui';
  // NotaF.NFe.Dest.EnderDest.UF      := 'SP';
  // NotaF.NFe.Dest.EnderDest.cPais   := 1058;
  // NotaF.NFe.Dest.EnderDest.xPais   := 'BRASIL';



  // ITENS DA VENDA NA NOTA

  // RELACIONANDO OS ITENS COM A  VENDA
  item := 1;
  Model.query_det_vendas.Close;
  Model.query_det_vendas.SQL.Clear;
  Model.query_det_vendas.SQL.Add
    ('select * from detalhes_vendas WHERE id_venda = :num order by id asc');
  Model.query_det_vendas.ParamByName('num').Value := idVenda;
  Model.query_det_vendas.Open;
  Model.query_det_vendas.First;

  while not Model.query_det_vendas.eof do
  begin
    Produto := NotaF.NFe.Det.New;
    Produto.Prod.nItem := item;
    // N?mero sequencial, para cada item deve ser incrementado
    Produto.Prod.cProd := '123456';
    Produto.Prod.cEAN := '7896523206646';
    Produto.Prod.xProd := Model.query_det_vendas.FieldByName('produto').Value;
    Produto.Prod.NCM := '94051010';
    // Tabela NCM dispon?vel em  http://www.receita.fazenda.gov.br/Aliquotas/DownloadArqTIPI.htm
    Produto.Prod.EXTIPI := '';
    Produto.Prod.CFOP := '5101';
    Produto.Prod.uCom := 'UN';
    Produto.Prod.qCom := Model.query_det_vendas.FieldByName('quantidade').Value;
    Produto.Prod.vUnCom := Model.query_det_vendas.FieldByName('valor').Value;
    Produto.Prod.vProd := Model.query_det_vendas.FieldByName('total').Value;

    // INFORMA??ES DE IMPOSTOS SOBRE OS PRODUTOS
    Produto.Prod.cEANTrib := '7896523206646';
    Produto.Prod.uTrib := 'UN';
    Produto.Prod.qTrib := 1;
    Produto.Prod.vUnTrib := 100;

    Produto.Prod.vOutro := 0;
    Produto.Prod.vFrete := 0;
    Produto.Prod.vSeg := 0;
    Produto.Prod.vDesc := 0;

    Produto.Prod.CEST := '1111111';

    Produto.infAdProd := 'Informacao Adicional do Produto';

    // lei da transparencia nos impostos
    Produto.Imposto.vTotTrib := 0;
    Produto.Imposto.ICMS.CST := cst00;
    Produto.Imposto.ICMS.orig := oeNacional;
    Produto.Imposto.ICMS.modBC := dbiValorOperacao;
    Produto.Imposto.ICMS.vBC := 100;
    Produto.Imposto.ICMS.pICMS := 18;
    Produto.Imposto.ICMS.vICMS := 18;
    Produto.Imposto.ICMS.modBCST := dbisMargemValorAgregado;
    Produto.Imposto.ICMS.pMVAST := 0;
    Produto.Imposto.ICMS.pRedBCST := 0;
    Produto.Imposto.ICMS.vBCST := 0;
    Produto.Imposto.ICMS.pICMSST := 0;
    Produto.Imposto.ICMS.vICMSST := 0;
    Produto.Imposto.ICMS.pRedBC := 0;

    // partilha do ICMS e fundo de probreza
    Produto.Imposto.ICMSUFDest.vBCUFDest := 0.00;
    Produto.Imposto.ICMSUFDest.pFCPUFDest := 0.00;
    Produto.Imposto.ICMSUFDest.pICMSUFDest := 0.00;
    Produto.Imposto.ICMSUFDest.pICMSInter := 0.00;
    Produto.Imposto.ICMSUFDest.pICMSInterPart := 0.00;
    Produto.Imposto.ICMSUFDest.vFCPUFDest := 0.00;
    Produto.Imposto.ICMSUFDest.vICMSUFDest := 0.00;
    Produto.Imposto.ICMSUFDest.vICMSUFRemet := 0.00;

    item := item + 1;
    Model.query_det_vendas.Next;
  end;

  // totalizando

  NotaF.NFe.Total.ICMSTot.vBC := 100;
  NotaF.NFe.Total.ICMSTot.vICMS := 18;
  NotaF.NFe.Total.ICMSTot.vBCST := 0;
  NotaF.NFe.Total.ICMSTot.vST := 0;
  NotaF.NFe.Total.ICMSTot.vProd := totalVenda;
  NotaF.NFe.Total.ICMSTot.vFrete := 0;
  NotaF.NFe.Total.ICMSTot.vSeg := 0;
  NotaF.NFe.Total.ICMSTot.vDesc := strToFloat(edtDesconto.Text);
  NotaF.NFe.Total.ICMSTot.vII := 0;
  NotaF.NFe.Total.ICMSTot.vIPI := 0;
  NotaF.NFe.Total.ICMSTot.vPIS := 0;
  NotaF.NFe.Total.ICMSTot.vCOFINS := 0;
  NotaF.NFe.Total.ICMSTot.vOutro := 0;
  NotaF.NFe.Total.ICMSTot.vNF := totalcomDesconto;

  // lei da transparencia de impostos
  NotaF.NFe.Total.ICMSTot.vTotTrib := 0;

  // partilha do icms e fundo de probreza
  NotaF.NFe.Total.ICMSTot.vFCPUFDest := 0.00;
  NotaF.NFe.Total.ICMSTot.vICMSUFDest := 0.00;
  NotaF.NFe.Total.ICMSTot.vICMSUFRemet := 0.00;

  NotaF.NFe.Transp.modFrete := mfSemFrete; // SEM FRETE

  // YA. Informa??es de pagamento

  InfoPgto := NotaF.NFe.pag.New;
  InfoPgto.indPag := ipVista;
  InfoPgto.tPag := fpDinheiro;
  InfoPgto.vPag := totalcomDesconto;

  // RECUPERAR O NUMERO DE SERIE DO CERTIFICADO
  nfce.Configuracoes.Certificados.NumeroSerie := certificadoDig;

  nfce.NotasFiscais.Assinar;
  nfce.Enviar(integer(idVenda));
  ShowMessage(nfce.WebServices.StatusServico.Msg);

end;

procedure TFrmVendas.ImprimirCupom;
begin
  Model.query_vendas.Close;
  Model.query_vendas.SQL.Clear;
  Model.query_vendas.SQL.Add('SELECT * from vendas where id = :id');
  Model.query_vendas.ParamByName('id').Value := idVenda;
  Model.query_vendas.Open;

  Model.query_det_vendas.Close;
  Model.query_det_vendas.SQL.Clear;
  Model.query_det_vendas.SQL.Add
    ('SELECT * from detalhes_vendas where id_venda = :id');
  Model.query_det_vendas.ParamByName('id').Value := idVenda;
  Model.query_det_vendas.Open;

  // Chamar o Relat?rio
  Model.rel_comprovante.LoadFromFile(GetCurrentDir + '\rel\comprovante.fr3');
  Model.rel_comprovante.ShowReport();
  // DM_RELATORIO.rel_comprovante.Print;
end;

procedure TFrmVendas.IniciarNFCE;
var
  caminhoNFCE: string;
begin
  caminhoNFCE := ExtractFilePath(Application.ExeName) + 'nfe\';
  nfce.Configuracoes.Arquivos.PathSchemas := caminhoNFCE;

end;

procedure TFrmVendas.limpar;
begin
  edtCodBarras.Text := '';
  edtProduto.Text := '';
  edtDescri??o.Text := '';
  edtPreco.Text := '0';
  edtQuantidade.Text := '1';
  edtEstoque.Text := '';

  edtTotal.Text := '0';
  edtSubTotal.Text := '0';
  edtTotalCompra.Text := '0';
  edtDesconto.Text := '0';
  edtValorRecebido.Text := '0';
  edtTroco.Text := '0';

  limparFoto;
  edtCodBarras.SetFocus;
end;

procedure TFrmVendas.limparFoto;
var
  caminhoImg: string;
begin
  caminhoImg := ExtractFileDir(GetCurrentDir) + '\Release\img\sem-foto.jpg';
  imagem.Picture.LoadFromFile(caminhoImg);
end;

procedure TFrmVendas.limparProdutos;
begin
  edtProduto.Text := '';
  edtDescri??o.Text := '';
  edtPreco.Text := '0';

  edtEstoque.Text := '';
  limparFoto;
  totalItem := 0;
end;

procedure TFrmVendas.listar;
begin
  Model.query_det_vendas.Close;
  Model.query_det_vendas.SQL.Clear;
  Model.query_det_vendas.SQL.Add
    ('SELECT * from detalhes_vendas where id_venda = 0 and funcionario = :func order by id asc');
  Model.query_det_vendas.ParamByName('func').Value := nomeUsuario;
  Model.query_det_vendas.Open;

  DBGrid1.Columns[0].Alignment := taCenter;
  DBGrid1.Columns[2].Alignment := taCenter;
  DBGrid1.Columns[3].Alignment := taLeftJustify;

end;

procedure TFrmVendas.salvarItens;
begin

  edtQuantidade.enabled := True;

  if (Trim(edtQuantidade.Text) = '') or (edtQuantidade.Text = '0') then
  begin
    MessageDlg('Insira a quantidade correta!', mtInformation, mbOKCancel, 0);
    edtQuantidade.SetFocus;
    edtCodBarras.Text := '';
    exit;
  end;

  associarCamposDet;
  Model.tb_detalhes_vendas.Post;
  listar;

  MediaPlayer1.FileName := ExtractFileDir(GetCurrentDir) +
    '\Release\img\barCode.wav';
  MediaPlayer1.Open;
  MediaPlayer1.Play;

  // ABATER DO ESTOQUE O PRODUTO
  estoque := strToFloat(edtEstoque.Text) - strToFloat(edtQuantidade.Text);

  Model.query_produtos.Close;
  Model.query_produtos.SQL.Clear;
  Model.query_produtos.SQL.Add
    ('UPDATE produtos set estoque = :estoque where id = :id');
  Model.query_produtos.ParamByName('estoque').Value := estoque;

  Model.query_produtos.ParamByName('id').Value := idProduto;
  Model.query_produtos.ExecSQL;

  edtCodBarras.Text := '';
  edtCodBarras.SetFocus;
  edtQuantidade.Text := '1';

end;

procedure TFrmVendas.salvarVenda;
begin
  associarCamposVenda;
  Model.tb_vendas.Post;

  // RELACIONAR O ID DA VENDA COM OS ID_VENDA DOS ITENS
  Model.query_vendas.Close;
  Model.query_vendas.SQL.Clear;
  Model.query_vendas.SQL.Add('SELECT * from vendas order by id desc');
  // Model.query_vendas.ParamByName('func').Value := nomeFunc;
  Model.query_vendas.Open;

  if not Model.query_vendas.IsEmpty then
  begin
    idVenda := Model.query_vendas['id'];
  end;

  Model.query_det_vendas.Close;
  Model.query_det_vendas.SQL.Clear;
  Model.query_det_vendas.SQL.Add
    ('UPDATE detalhes_vendas set id_venda = :id where id_venda = 0 and funcionario = :func');
  Model.query_det_vendas.ParamByName('id').Value := idVenda;
  Model.query_det_vendas.ParamByName('func').Value := nomeUsuario;
  Model.query_det_vendas.ExecSQL;

  // LAN?AR O VALOR DA VENDA NAS MOVIMENTA??ES
  Model.query_mov.Close;
  Model.query_mov.SQL.Clear;
  Model.query_mov.SQL.Add
    ('INSERT INTO movimentacoes (tipo, movimento, valor, funcionario, data, id_movimento) VALUES (:tipo, :movimento, :valor, :funcionario, curDate(), :id_movimento)');
  Model.query_mov.ParamByName('tipo').Value := 'Entrada';
  Model.query_mov.ParamByName('movimento').Value := 'Venda';
  Model.query_mov.ParamByName('valor').Value := totalcomDesconto;;
  Model.query_mov.ParamByName('funcionario').Value := nomeUsuario;
  Model.query_mov.ParamByName('id_movimento').Value := idVenda;
  Model.query_mov.ExecSQL;


  // IMPRIMIR O CUPOM FISCAL
  // IniciarNFCE;
  // gerarNFCE;

  // IMPRIMIR O CUPOM N?O FISCAL BASEADO NA NF
  ImprimirCupom;

  limpar;
  edtQuantidade.Text := '1';
  totalItem := 0;
  totalVenda := 0;
  estoque := 0;
  totalcomDesconto := 0;
  troco := 0;
  listar;

end;

end.
