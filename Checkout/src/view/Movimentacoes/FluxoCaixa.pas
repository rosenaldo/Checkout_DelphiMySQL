unit FluxoCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmFluxoCaixa = class(TForm)
    Label5: TLabel;
    dataBuscar: TDateTimePicker;
    DBGrid1: TDBGrid;
    btnRelatorio: TSpeedButton;
    P_CONTAINER: TPanel;
    P_TOPO: TPanel;
    P_GRID: TPanel;
    P_RODAPE: TPanel;
    SB_CANCELAR: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure dataBuscarChange(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure SB_CANCELARClick(Sender: TObject);
  private
    { Private declarations }
    procedure buscarData;
  public
    { Public declarations }
  end;

var
  FrmFluxoCaixa: TFrmFluxoCaixa;

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

uses DM.Model, RelatoriosPorDatas;

{ TFrmFluxoCaixa }

procedure TFrmFluxoCaixa.btnRelatorioClick(Sender: TObject);
begin
  rel := 'Caixa';
  FrmRelDatas := TFrmRelDatas.Create(self);
  FrmRelDatas.ShowModal;
end;

procedure TFrmFluxoCaixa.buscarData;
begin
  Model.query_caixa.Close;
  Model.query_caixa.SQL.Clear;
  Model.query_caixa.SQL.Add
    ('SELECT * from caixa where data_abertura = :data order by data_abertura desc');
  Model.query_caixa.ParamByName('data').Value := FormatDateTime('yyyy/mm/dd',
    dataBuscar.Date);
  Model.query_caixa.Open;
end;

procedure TFrmFluxoCaixa.dataBuscarChange(Sender: TObject);
begin
  buscarData;
end;

procedure TFrmFluxoCaixa.FormShow(Sender: TObject);
begin

  Model.tb_caixa.Active := True;
  dataBuscar.Date := Date;
  buscarData;
end;

procedure TFrmFluxoCaixa.SB_CANCELARClick(Sender: TObject);
begin
  Close;
end;

end.
