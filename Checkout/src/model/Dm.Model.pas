unit DM.Model;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.Client,
  Data.DB,
  FireDAC.Comp.DataSet,

//  frxClass, frxDBSet,
//  frxExportImage,
//  frxExportBaseDialog,
//  frxExportPDF,

  winsock,
  inifiles,
  controls,
  forms,
  dialogs,
  stdctrls;

type
  TConectINI = record
    ServEndereco: string;
    NameBase: string;
    Port: string;
    NameUsuario: string;
    Senha: string;

  end;

type
  TModel = class(TDataModule)
    fd: TFDConnection;
    query_cargos: TFDQuery;
    query_cargosid: TFDAutoIncField;
    query_cargoscargo: TStringField;
    tb_cargos: TFDTable;
    DSCargos: TDataSource;
    DSUsuarios: TDataSource;
    query_usuarios: TFDQuery;
    tb_usuarios: TFDTable;
    query_usuariosid: TFDAutoIncField;
    query_usuariosnome: TStringField;
    query_usuariosusuario: TStringField;
    query_usuariossenha: TStringField;
    query_usuarioscargo: TStringField;
    query_usuariosid_funcionario: TIntegerField;
    tb_func: TFDTable;
    query_func: TFDQuery;
    query_funcid: TFDAutoIncField;
    query_funcnome: TStringField;
    query_funccpf: TStringField;
    query_functelefone: TStringField;
    query_funcendereco: TStringField;
    query_funccargo: TStringField;
    query_funcdata: TDateField;
    DSFunc: TDataSource;
    TB_EMPRESA: TFDTable;
    Q_EMPRESA: TFDQuery;
    Q_EMPRESAid: TFDAutoIncField;
    Q_EMPRESArazao_social: TStringField;
    Q_EMPRESAnome_fantasia: TStringField;
    Q_EMPRESAendereco: TStringField;
    Q_EMPRESAbairro: TStringField;
    Q_EMPRESAcidade: TStringField;
    Q_EMPRESAuf: TStringField;
    Q_EMPRESAcnpj: TStringField;
    Q_EMPRESAtelefone: TStringField;
    Q_EMPRESAie: TStringField;
    Q_EMPRESAemail: TStringField;
    DS_EMPRESA: TDataSource;
    tb_forn: TFDTable;
    query_forn: TFDQuery;
    query_fornid: TFDAutoIncField;
    query_fornnome: TStringField;
    query_fornproduto: TStringField;
    query_fornendereco: TStringField;
    query_forntelefone: TStringField;
    query_forndata: TDateField;
    DSForn: TDataSource;
    tb_produtos: TFDTable;
    query_produtos: TFDQuery;
    query_produtosid: TFDAutoIncField;
    query_produtoscodigo: TStringField;
    query_produtosnome: TStringField;
    query_produtosdescricao: TStringField;
    query_produtosvalor: TBCDField;
    query_produtosestoque: TIntegerField;
    query_produtosdata: TDateField;
    query_produtosimagem: TBlobField;
    query_produtosultima_compra: TDateField;
    DSProdutos: TDataSource;
    query_coringa_vendas: TFDQuery;
    query_coringa_vendasid: TFDAutoIncField;
    query_coringa_vendasvalor: TBCDField;
    query_coringa_vendasdata: TDateField;
    query_coringa_vendashora: TTimeField;
    query_coringa_vendasfuncionario: TStringField;
    query_coringa_vendasdesconto: TBCDField;
    query_coringa_vendasvalor_recebido: TBCDField;
    query_coringa_vendastroco: TBCDField;
    query_coringa_vendasstatus: TStringField;
    tb_entrada_pro: TFDTable;
    query_entrada_pro: TFDQuery;
    query_entrada_proid: TFDAutoIncField;
    query_entrada_proproduto: TStringField;
    query_entrada_proquantidade: TIntegerField;
    query_entrada_profornecedor: TIntegerField;
    query_entrada_provalor: TBCDField;
    query_entrada_prototal: TBCDField;
    query_entrada_prodata: TDateField;
    query_entrada_proid_produto: TIntegerField;
    DSEntradaProdutos: TDataSource;
    tb_saida_pro: TFDTable;
    query_saida_pro: TFDQuery;
    query_saida_proid: TFDAutoIncField;
    query_saida_proproduto: TStringField;
    query_saida_proquantidade: TIntegerField;
    query_saida_promotivo: TStringField;
    query_saida_prodata: TDateField;
    query_saida_proid_produto: TIntegerField;
    DSSaidaProdutos: TDataSource;
    query_coringa: TFDQuery;
    tb_mov: TFDTable;
    query_mov: TFDQuery;
    DSMovimentacoes: TDataSource;
    query_movid: TFDAutoIncField;
    query_movtipo: TStringField;
    query_movmovimento: TStringField;
    query_movvalor: TBCDField;
    query_movfuncionario: TStringField;
    query_movdata: TDateField;
    query_movid_movimento: TIntegerField;
    tb_vendas: TFDTable;
    query_vendas: TFDQuery;
    query_vendasid: TFDAutoIncField;
    query_vendasvalor: TBCDField;
    query_vendasdata: TDateField;
    query_vendashora: TTimeField;
    query_vendasfuncionario: TStringField;
    query_vendasdesconto: TBCDField;
    query_vendasvalor_recebido: TBCDField;
    query_vendastroco: TBCDField;
    query_vendasstatus: TStringField;
    DSVendas: TDataSource;
    DSDetVendas: TDataSource;
    query_det_vendas: TFDQuery;
    query_det_vendasid: TFDAutoIncField;
    query_det_vendasid_venda: TIntegerField;
    query_det_vendasproduto: TStringField;
    query_det_vendasvalor: TBCDField;
    query_det_vendasquantidade: TIntegerField;
    query_det_vendastotal: TBCDField;
    query_det_vendasid_produto: TIntegerField;
    query_det_vendasfuncionario: TStringField;
    query_det_vendasdata: TDateField;
    tb_detalhes_vendas: TFDTable;
    tb_caixa: TFDTable;
    query_caixa: TFDQuery;
    query_caixaid: TFDAutoIncField;
    query_caixadata_abertura: TDateField;
    query_caixahora_abertura: TTimeField;
    query_caixavalor_abertura: TBCDField;
    query_caixafuncionario_abertura: TStringField;
    query_caixadata_fechamento: TDateField;
    query_caixahora_fechamento: TTimeField;
    query_caixavalor_fechamento: TBCDField;
    query_caixavalor_vendido: TBCDField;
    query_caixavalor_quebra: TBCDField;
    query_caixafuncionario_fechamento: TStringField;
    query_caixanum_caixa: TIntegerField;
    query_caixaoperador: TStringField;
    query_caixastatus: TStringField;
    DSCaixa: TDataSource;
    tb_gastos: TFDTable;
    query_gastos: TFDQuery;
    query_gastosid: TFDAutoIncField;
    query_gastosmotivo: TStringField;
    query_gastosvalor: TBCDField;
    query_gastosfuncionario: TStringField;
    query_gastosdata: TDateField;
    DSGastos: TDataSource;
    FDQ_OS: TFDQuery;
    FDQ_OSid: TFDAutoIncField;
    FDQ_OScliente: TStringField;
    FDQ_OStecnico: TStringField;
    FDQ_OSdtinicial: TDateField;
    FDQ_OSdtfinal: TDateField;
    FDQ_OSstatus: TStringField;
    FDQ_OSgarantia: TStringField;
    FDQ_OSdescricao_servico: TMemoField;
    FDQ_OSdefeito: TMemoField;
    FDQ_OSobservacao: TMemoField;
    FDQ_OSlaudo_tecnico: TMemoField;
    FDQ_OSvalor_total: TStringField;
    FDT_OS: TFDTable;
    DS_OS: TDataSource;
    query_caixa_Coringa: TFDQuery;
    query_caixa_Coringaid: TFDAutoIncField;
    query_caixa_Coringadata_abertura: TDateField;
    query_caixa_Coringahora_abertura: TTimeField;
    query_caixa_Coringavalor_abertura: TBCDField;
    query_caixa_Coringafuncionario_abertura: TStringField;
    query_caixa_Coringadata_fechamento: TDateField;
    query_caixa_Coringahora_fechamento: TTimeField;
    query_caixa_Coringavalor_fechamento: TBCDField;
    query_caixa_Coringavalor_vendido: TBCDField;
    query_caixa_Coringavalor_quebra: TBCDField;
    query_caixa_Coringafuncionario_fechamento: TStringField;
    query_caixa_Coringanum_caixa: TIntegerField;
    query_caixa_Coringaoperador: TStringField;
    query_caixa_Coringastatus: TStringField;
    query_coringa_caixa: TFDQuery;
    DSCaixaCoringa: TDataSource;
    query_coringa_produtos: TFDQuery;
    rel_Mov_Entradas: TFDQuery;
    rel_Mov_Saidas: TFDQuery;
    query_coringa_mov: TFDQuery;
    DSCoringaVendas: TDataSource;
//    rel_comprovante: TfrxReport;
//    rel_DS_Vendas: TfrxDBDataset;
//    rel_DS_DetVendas: TfrxDBDataset;
//    rel_produtos: TfrxReport;
//    rel_vendas: TfrxReport;
//    rel_movimentacoes: TfrxReport;
//    rel_caixa: TfrxReport;
//    rel_DS_Caixa: TfrxDBDataset;
//    rel_DS_Prod: TfrxDBDataset;
//    rel_DS_Mov: TfrxDBDataset;
//    R_OS: TfrxReport;
//    REL_DS_OS: TfrxDBDataset;
//    rel_DS_EMPRESA: TfrxDBDataset;
//    frxPDFExport1: TfrxPDFExport;
//    frxJPEGExport1: TfrxJPEGExport;
    FDMySQLDriver: TFDPhysMySQLDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListarOS;
  end;

var
  Model: TModel;

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
  configINI: TConectINI;

procedure LerArquivoINI();
procedure GravarArquivoINI();

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}
{ TModel }

procedure TModel.ListarOS;
begin
  Model.FDQ_OS.Close;
  Model.FDQ_OS.SQL.Clear;
  Model.FDQ_OS.SQL.Add
    ('SELECT ID, CLIENTE, TECNICO, DTINICIAL, DTFINAL, STATUS, GARANTIA, DESCRICAO_SERVICO, DEFEITO, OBSERVACAO, LAUDO_TECNICO, VALOR_TOTAL FROM OS ORDER BY ID');
  Model.FDQ_OS.Open;
end;

procedure GravarArquivoINI();
var
  objIniEscrever: TIniFile;
begin
  objIniEscrever := TIniFile.Create(ExtractFileDir(Application.ExeName) +
    '\configINI.ini');
  try
    objIniEscrever.WriteString('BDCONFIG', 'BDEndereco',
      configINI.ServEndereco);
    objIniEscrever.WriteString('BDCONFIG', 'BDNome', configINI.NameBase);
    objIniEscrever.WriteString('BDCONFIG', 'BDPorta', configINI.Port);
    objIniEscrever.WriteString('BDCONFIG', 'BDUsuario', configINI.NameUsuario);
    objIniEscrever.WriteString('BDCONFIG', 'BDSenha', configINI.Senha);

  finally
    FreeAndNil(objIniEscrever);
  end;
end;

procedure LerArquivoINI();
var
  objIniLer: TIniFile;
begin
  objIniLer := TIniFile.Create(ExtractFileDir(Application.ExeName) +
    '\configINI.ini');
  try
    configINI.ServEndereco := objIniLer.ReadString('BDCONFIG', 'BDEndereco',
      'localhost');
    configINI.NameBase := objIniLer.ReadString('BDCONFIG', 'BDNome', '');
    configINI.Port := objIniLer.ReadString('BDCONFIG', 'BDPorta', '');
    configINI.NameUsuario := objIniLer.ReadString('BDCONFIG', 'BDUsuario', '');
    configINI.Senha := objIniLer.ReadString('BDCONFIG', 'BDSenha', '');

  finally
    FreeAndNil(objIniLer);
  end;

end;

end.
