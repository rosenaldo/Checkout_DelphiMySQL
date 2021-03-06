unit RelatoriosPorDatas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TFrmRelDatas = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    dataInicial: TDateTimePicker;
    dataFinal: TDateTimePicker;
    btnRelatorio: TSpeedButton;
    lblStatus: TLabel;
    cbStatus: TComboBox;
    P_CONTAINER: TPanel;
    P_RODAPE: TPanel;
    SB_CANCELAR: TSpeedButton;
    P_TOPO: TPanel;
    procedure FormShow(Sender: TObject);
    procedure btnRelatorioClick(Sender: TObject);
    procedure SB_CANCELARClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelDatas: TFrmRelDatas;
  totalEntradas: double;
  totalSaidas: double;
  

implementation

{$R *.dfm}

uses DM.Model;

procedure TFrmRelDatas.btnRelatorioClick(Sender: TObject);
begin
  if rel = 'Caixa' then
  begin
    Model.query_caixa.Close;
    Model.query_caixa.SQL.Clear;
    Model.query_caixa.SQL.Add
      ('SELECT * from caixa where data_abertura >= :dataInicial and data_abertura <= :dataFinal order by data_abertura desc');
    Model.query_caixa.ParamByName('dataInicial').Value :=
      FormatDateTime('yyyy/mm/dd', dataInicial.Date);
    Model.query_caixa.ParamByName('dataFinal').Value :=
      FormatDateTime('yyyy/mm/dd', dataFinal.Date);
    Model.query_caixa.Open;

    Model.rel_caixa.LoadFromFile(GetCurrentDir + '\rel\caixa.fr3');
    Model.rel_caixa.Variables['dataInicial'] := dataInicial.Date;
    Model.rel_caixa.Variables['dataFinal'] := dataFinal.Date;
    Model.rel_caixa.ShowReport();
  end;

  if rel = 'Movimentacoes' then
  begin
    Model.query_mov.Close;
    Model.query_mov.SQL.Clear;
    Model.query_mov.SQL.Add
      ('SELECT * from movimentacoes where data >= :dataInicial and data <= :dataFinal order by data asc');
    Model.query_mov.ParamByName('dataInicial').Value :=
      FormatDateTime('yyyy/mm/dd', dataInicial.Date);
    Model.query_mov.ParamByName('dataFinal').Value :=
      FormatDateTime('yyyy/mm/dd', dataFinal.Date);
    Model.query_mov.Open;

    Model.rel_Mov_Entradas.Close;
    Model.rel_Mov_Entradas.SQL.Clear;
    Model.rel_Mov_Entradas.SQL.Add
      ('select sum(valor) as total from movimentacoes where data >= :dataInicial and data <= :dataFinal and tipo = "Entrada" ');
    Model.rel_Mov_Entradas.ParamByName('dataInicial').Value :=
      FormatDateTime('yyyy/mm/dd', dataInicial.Date);
    Model.rel_Mov_Entradas.ParamByName('dataFinal').Value :=
      FormatDateTime('yyyy/mm/dd', dataFinal.Date);
    Model.rel_Mov_Entradas.Prepare;
    Model.rel_Mov_Entradas.Open;
    totalEntradas := Model.rel_Mov_Entradas.FieldByName('total').AsFloat;

    Model.rel_Mov_Saidas.Close;
    Model.rel_Mov_Saidas.SQL.Clear;
    Model.rel_Mov_Saidas.SQL.Add
      ('select sum(valor) as total from movimentacoes where data >= :dataInicial and data <= :dataFinal and tipo = "Sa?da" ');
    Model.rel_Mov_Saidas.ParamByName('dataInicial').Value :=
      FormatDateTime('yyyy/mm/dd', dataInicial.Date);
    Model.rel_Mov_Saidas.ParamByName('dataFinal').Value :=
      FormatDateTime('yyyy/mm/dd', dataFinal.Date);
    Model.rel_Mov_Saidas.Prepare;
    Model.rel_Mov_Saidas.Open;
    totalSaidas := Model.rel_Mov_Saidas.FieldByName('total').AsFloat;

    Model.rel_movimentacoes.LoadFromFile(GetCurrentDir + '\rel\movimentacoes.fr3');
    Model.rel_movimentacoes.Variables['dataInicial'] := dataInicial.Date;
    Model.rel_movimentacoes.Variables['dataFinal'] := dataFinal.Date;
    Model.rel_movimentacoes.Variables['totalEntradas'] := totalEntradas;
    Model.rel_movimentacoes.Variables['totalSaidas'] := totalSaidas;
    Model.rel_movimentacoes.ShowReport();

  end;

  if rel = 'Vendas' then
  begin

    Model.query_vendas.Close;
    Model.query_vendas.SQL.Clear;
    Model.query_vendas.SQL.Add
      ('SELECT * from vendas where data >= :dataInicial and data <= :dataFinal and status = :status order by data desc');
    Model.query_vendas.ParamByName('dataInicial').Value :=
      FormatDateTime('yyyy/mm/dd', dataInicial.Date);
    Model.query_vendas.ParamByName('dataFinal').Value :=
      FormatDateTime('yyyy/mm/dd', dataFinal.Date);
    Model.query_vendas.ParamByName('status').Value := cbStatus.Text;
    Model.query_vendas.Open;

    Model.rel_vendas.LoadFromFile(GetCurrentDir + '\rel\vendas.fr3');
    Model.rel_vendas.Variables['dataInicial'] := dataInicial.Date;
    Model.rel_vendas.Variables['dataFinal'] := dataFinal.Date;
    Model.rel_vendas.Variables['status'] := '''' + cbStatus.Text + '''';
    Model.rel_vendas.ShowReport();
  end;

end;

procedure TFrmRelDatas.FormShow(Sender: TObject);
begin
  dataInicial.Date := Date;
  dataFinal.Date := Date;

  if rel = 'Vendas' then
  begin
    cbStatus.ItemIndex := 0;
    lblStatus.Visible := true;
    cbStatus.Visible := true;

  end;

end;

procedure TFrmRelDatas.SB_CANCELARClick(Sender: TObject);
begin
  Close;
end;

end.
