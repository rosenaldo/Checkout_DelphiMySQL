program Project;

uses
  Vcl.Forms,
  DM.Model in 'model\DM.Model.pas' {Model: TDataModule},
  Cargos in 'view\Cadastros\Cargos.pas' {FrmCargos},
  Usuarios in 'view\Cadastros\Usuarios.pas' {FrmUsuarios},
  Funcionarios in 'view\Cadastros\Funcionarios.pas' {FrmFuncionarios},
  Empresa in 'view\Cadastros\Empresa.pas' {FRM_EMPRESA},
  Fornecedores in 'view\Cadastros\Fornecedores.pas' {FrmFornecedores},
  Produtos in 'view\Cadastros\Produtos.pas' {FrmProdutos},
  EntradasProdutos in 'view\Estoque\EntradasProdutos.pas' {FrmEntradaProdutos},
  EstoqueBaixo in 'view\Estoque\EstoqueBaixo.pas' {FrmEstoqueBaixo},
  SaidasProdutos in 'view\Estoque\SaidasProdutos.pas' {FrmSaidaProdutos},
  ExcluirDados in 'view\Ferramentas\ExcluirDados.pas' {FrmExcluirDados},
  Caixa in 'view\Movimentacoes\Caixa.pas' {FrmCaixa},
  Vendas in 'view\Movimentacoes\Vendas.pas' {FrmVendas},
  CancelarItem in 'view\Movimentacoes\CancelarItem.pas' {FrmCancelarItem},
  CertificadoDigital in 'view\Ferramentas\CertificadoDigital.pas' {FrmCertificado},
  ImprimirBarras in 'view\Ferramentas\ImprimirBarras.pas' {FrmImprimirBarras},
  FluxoCaixa in 'view\Movimentacoes\FluxoCaixa.pas' {FrmFluxoCaixa},
  Gastos in 'view\Movimentacoes\Gastos.pas' {FrmGastos},
  GerarOS.View in 'view\Movimentacoes\GerarOS.View.pas' {FRM_ADD_OS},
  ListaVendas in 'view\Movimentacoes\ListaVendas.pas' {FrmListaVendas},
  Movimentacoes in 'view\Movimentacoes\Movimentacoes.pas' {FrmMovimentacoes},
  OrdemDeServico.View in 'view\Movimentacoes\OrdemDeServico.View.pas' {FRM_OS},
  RelatoriosPorDatas in 'view\Relatorios\RelatoriosPorDatas.pas' {FrmRelDatas},
  Login in 'view\Login\Login.pas' {FrmLogin},
  Menu in 'view\Menu\Menu.pas' {FrmMenu},
  ConexaoBD.View in 'view\testes\ConexaoBD.View.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TModel, Model);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
