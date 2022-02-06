unit EstoqueBaixo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TFrmEstoqueBaixo = class(TForm)
    DBGrid1: TDBGrid;
    P_GRID: TPanel;
    P_RODAPE: TPanel;
    P_CONTAINER: TPanel;
    SB_CANCELAR: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure SB_CANCELARClick(Sender: TObject);
  private
    { Private declarations }
    procedure listar;
  public
    { Public declarations }
  end;

var
  FrmEstoqueBaixo: TFrmEstoqueBaixo;

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

uses DM.Model, EntradasProdutos;

procedure TFrmEstoqueBaixo.DBGrid1DblClick(Sender: TObject);
begin

  idProduto := Model.query_produtos.FieldByName('id').Value;
  nomeProduto := Model.query_produtos.FieldByName('nome').Value;
  estoqueProduto := Model.query_produtos.FieldByName('estoque').Value;

  chamada := 'Ent';
  FrmEntradaProdutos := TFrmEntradaProdutos.Create(self);
  FrmEntradaProdutos.Show;
end;

procedure TFrmEstoqueBaixo.FormActivate(Sender: TObject);
begin
  listar;
end;

procedure TFrmEstoqueBaixo.FormShow(Sender: TObject);
begin
  listar;
end;

procedure TFrmEstoqueBaixo.listar;
begin
  Model.query_produtos.Close;
  Model.query_produtos.SQL.Clear;
  Model.query_produtos.SQL.Add('SELECT * from produtos where estoque <= 10');
  Model.query_produtos.Open;
end;

procedure TFrmEstoqueBaixo.SB_CANCELARClick(Sender: TObject);
begin
  Close;
end;

end.
