unit ListaVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmListaVendas = class(TForm)
    Label3: TLabel;
    cbEntradaSaida: TComboBox;
    Label1: TLabel;
    dataInicial: TDateTimePicker;
    Label2: TLabel;
    dataFinal: TDateTimePicker;
    grid: TDBGrid;
    BtnCancelar: TSpeedButton;
    btnComprovante: TSpeedButton;
    btnNota: TSpeedButton;
    P_CONTAINER: TPanel;
    P_TOPO: TPanel;
    P_GRID: TPanel;
    P_RODAPE: TPanel;
    SB_CANCELAR: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure cbEntradaSaidaChange(Sender: TObject);
    procedure dataInicialChange(Sender: TObject);
    procedure dataFinalChange(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure btnComprovanteClick(Sender: TObject);
    procedure btnNotaClick(Sender: TObject);
    procedure SB_CANCELARClick(Sender: TObject);
  private
    { Private declarations }

    procedure buscarData;
  public
    { Public declarations }
  end;

var
  FrmListaVendas: TFrmListaVendas;
  idVenda: string;
  quantItem: Integer;
  id_produto: Integer;
  estoque: Integer;
  estoqueP: Integer;

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

{ TFrmListaVendas }

procedure TFrmListaVendas.BtnCancelarClick(Sender: TObject);
begin
  if MessageDlg('Deseja Cancelar a venda?', mtConfirmation, [mbYes, mbNo], 0) = mrYes
  then
  begin
    Model.query_vendas.Close;
    Model.query_vendas.SQL.Clear;
    Model.query_vendas.SQL.Add
      ('UPDATE vendas set status = :status where id = :id');

    Model.query_vendas.ParamByName('status').Value := 'Cancelada';
    Model.query_vendas.ParamByName('id').Value := idVenda;
    Model.query_vendas.ExecSql;

    // DELETAR TAMBÉM NA TABELA DE MOVIMENTAÇÕES
    Model.query_mov.Close;
    Model.query_mov.SQL.Clear;
    Model.query_mov.SQL.Add
      ('DELETE FROM movimentacoes where id_movimento = :id');
    Model.query_mov.ParamByName('id').Value := idVenda;
    Model.query_mov.ExecSql;

    // DEVOLVER OS ITENS DA VENDA AO ESTOQUE
    Model.query_det_vendas.Close;
    Model.query_det_vendas.SQL.Clear;
    Model.query_det_vendas.SQL.Add
      ('SELECT * from detalhes_vendas where id_venda = :id');
    Model.query_det_vendas.ParamByName('id').Value := idVenda;
    Model.query_det_vendas.Open;

    if not Model.query_det_vendas.isEmpty then
    begin
      while not Model.query_det_vendas.Eof do
      begin

        id_produto := Model.query_det_vendas['id_produto'];
        quantItem := Model.query_det_vendas['quantidade'];

        // ATUALIZAR O ESTOQUE

        // RECUPERAR O ESTOQUE ATUAL
        Model.query_produtos.Close;
        Model.query_produtos.SQL.Clear;
        Model.query_produtos.SQL.Add('select * from produtos where id = :id');

        Model.query_produtos.ParamByName('id').Value := id_produto;
        Model.query_produtos.Open;

        if not Model.query_produtos.isEmpty then
        begin
          estoqueP := Model.query_produtos['estoque'];

        end;

        estoque := estoqueP + quantItem;

        Model.query_produtos.Close;
        Model.query_produtos.SQL.Clear;
        Model.query_produtos.SQL.Add
          ('UPDATE produtos set estoque = :estoque where id = :id');
        Model.query_produtos.ParamByName('estoque').Value := estoque;
        Model.query_produtos.ParamByName('id').Value := id_produto;
        Model.query_produtos.ExecSql;

        Model.query_det_vendas.Next;

      end;
    end;

    MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

  end;

  BtnCancelar.Enabled := false;
  btnNota.Enabled := false;
  btnComprovante.Enabled := false;
  buscarData;
end;

procedure TFrmListaVendas.btnComprovanteClick(Sender: TObject);
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

  // Chamar o Relatório
  Model.rel_comprovante.LoadFromFile(GetCurrentDir + '\rel\comprovante.fr3');
  Model.rel_comprovante.ShowReport();
  // DM_RELATORIO.rel_comprovante.Print;

  btnComprovante.Enabled := false;
  btnNota.Enabled := false;
  buscarData;

end;

procedure TFrmListaVendas.btnNotaClick(Sender: TObject);
begin
  MessageDlg('Configurar a chamada como na tela de vendas!', mtInformation,
    mbOKCancel, 0);
  btnComprovante.Enabled := false;
  btnNota.Enabled := false;
end;

procedure TFrmListaVendas.buscarData;
begin

  Model.query_vendas.Close;
  Model.query_vendas.SQL.Clear;
  Model.query_vendas.SQL.Add
    ('select * from vendas where data >= :dataInicial and data <= :dataFinal and status = :status order by id desc');
  Model.query_vendas.ParamByName('dataInicial').Value :=
    FormatDateTime('yyyy/mm/dd', dataInicial.Date);
  Model.query_vendas.ParamByName('dataFinal').Value :=
    FormatDateTime('yyyy/mm/dd', dataFinal.Date);
  Model.query_vendas.ParamByName('status').Value := cbEntradaSaida.Text;
  Model.query_vendas.Open;

end;

procedure TFrmListaVendas.cbEntradaSaidaChange(Sender: TObject);
begin
  buscarData;
end;

procedure TFrmListaVendas.dataFinalChange(Sender: TObject);
begin
  buscarData;
end;

procedure TFrmListaVendas.dataInicialChange(Sender: TObject);
begin
  buscarData;
end;

procedure TFrmListaVendas.FormShow(Sender: TObject);
begin

  cbEntradaSaida.ItemIndex := 0;
  Model.tb_vendas.Active := True;
  dataInicial.Date := Date;
  dataFinal.Date := Date;
  buscarData;
end;

procedure TFrmListaVendas.gridCellClick(Column: TColumn);
begin
  BtnCancelar.Enabled := True;
  btnNota.Enabled := True;
  btnComprovante.Enabled := True;
  idVenda := Model.query_vendas.FieldByName('id').Value;

end;

procedure TFrmListaVendas.SB_CANCELARClick(Sender: TObject);
begin
  Close;
end;

end.
