unit ExcluirDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TFrmExcluirDados = class(TForm)
    Label1: TLabel;
    dataInicial: TDateTimePicker;
    Label2: TLabel;
    dataFinal: TDateTimePicker;
    BtnExcluir: TSpeedButton;
    P_CONTAINER: TPanel;
    SB_CANCELAR: TSpeedButton;
    P_RODAPE: TPanel;
    P_TOPO: TPanel;
    procedure FormShow(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure SB_CANCELARClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmExcluirDados: TFrmExcluirDados;

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



procedure TFrmExcluirDados.BtnExcluirClick(Sender: TObject);
begin

  if excluir = 'Vendas' then
  begin

    if MessageDlg('Deseja Excluir as Vendas entre as datas de ' +
      DateToStr(dataInicial.Date) + ' à ' + DateToStr(dataFinal.Date) + ' ?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin

      Model.query_vendas.Close;
      Model.query_vendas.SQL.Clear;
      Model.query_vendas.SQL.Add
        ('DELETE from vendas where data >= :dataInicial and data <= :dataFinal');
      Model.query_vendas.ParamByName('dataInicial').Value :=
        FormatDateTime('yyyy/mm/dd', dataInicial.Date);
      Model.query_vendas.ParamByName('dataFinal').Value :=
        FormatDateTime('yyyy/mm/dd', dataFinal.Date);
      Model.query_vendas.ExecSql;

      Model.query_det_vendas.Close;
      Model.query_det_vendas.SQL.Clear;
      Model.query_det_vendas.SQL.Add
        ('DELETE from detalhes_vendas where data >= :dataInicial and data <= :dataFinal');
      Model.query_det_vendas.ParamByName('dataInicial').Value :=
        FormatDateTime('yyyy/mm/dd', dataInicial.Date);
      Model.query_det_vendas.ParamByName('dataFinal').Value :=
        FormatDateTime('yyyy/mm/dd', dataFinal.Date);
      Model.query_det_vendas.ExecSql;

      MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

    end;
  end;

  if excluir = 'Caixa' then

    if MessageDlg('Deseja Excluir os Registros do Caixa entre as datas de ' +
      DateToStr(dataInicial.Date) + ' à ' + DateToStr(dataFinal.Date) + ' ?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin

      begin
        Model.query_caixa.Close;
        Model.query_caixa.SQL.Clear;
        Model.query_caixa.SQL.Add
          ('DELETE from caixa where data_abertura >= :dataInicial and data_abertura <= :dataFinal');
        Model.query_caixa.ParamByName('dataInicial').Value :=
          FormatDateTime('yyyy/mm/dd', dataInicial.Date);
        Model.query_caixa.ParamByName('dataFinal').Value :=
          FormatDateTime('yyyy/mm/dd', dataFinal.Date);
        Model.query_caixa.ExecSql;

        MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

      end;
    end;

  if excluir = 'Movimentacoes' then

    if MessageDlg
      ('Deseja Excluir os Registros de Movimentações entre as datas de ' +
      DateToStr(dataInicial.Date) + ' à ' + DateToStr(dataFinal.Date) + ' ?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      begin
        Model.query_mov.Close;
        Model.query_mov.SQL.Clear;
        Model.query_mov.SQL.Add
          ('DELETE from movimentacoes where data >= :dataInicial and data <= :dataFinal');
        Model.query_mov.ParamByName('dataInicial').Value :=
          FormatDateTime('yyyy/mm/dd', dataInicial.Date);
        Model.query_mov.ParamByName('dataFinal').Value :=
          FormatDateTime('yyyy/mm/dd', dataFinal.Date);
        Model.query_mov.ExecSql;

        MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

      end;
    end;

end;

procedure TFrmExcluirDados.FormShow(Sender: TObject);
begin
  dataInicial.Date := Date;
  dataFinal.Date := Date;
end;

procedure TFrmExcluirDados.SB_CANCELARClick(Sender: TObject);
begin
  Close;
end;

end.
