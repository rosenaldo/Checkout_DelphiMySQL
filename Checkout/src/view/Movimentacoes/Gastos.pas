unit Gastos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls;

type
  TFrmGastos = class(TForm)
    Label2: TLabel;
    EdtMotivo: TEdit;
    grid: TDBGrid;
    edtValor: TEdit;
    Label1: TLabel;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    Label3: TLabel;
    dataBuscar: TDateTimePicker;
    P_CONTAINER: TPanel;
    P_TOPO: TPanel;
    P_GRID: TPanel;
    P_RODAPE: TPanel;
    SB_CANCELAR: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure dataBuscarChange(Sender: TObject);
    procedure SB_CANCELARClick(Sender: TObject);

  private
    { Private declarations }
    procedure associarCampos;
    procedure listar;
    procedure buscarData;

  public
    { Public declarations }
  end;

var
  FrmGastos: TFrmGastos;
  idGasto : string;


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

procedure TFrmGastos.associarCampos;
begin
Model.tb_gastos.FieldByName('motivo').Value := EdtMotivo.Text;
Model.tb_gastos.FieldByName('valor').Value := EdtValor.Text;
Model.tb_gastos.FieldByName('funcionario').Value := nomeUsuario;
Model.tb_gastos.FieldByName('data').Value := DateToStr(Date);
end;



procedure TFrmGastos.BtnExcluirClick(Sender: TObject);
begin
if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
begin
  Model.tb_gastos.Delete;


  //DELETAR TAMBÉM NA TABELA DE MOVIMENTAÇÕES
     Model.query_mov.Close;
      Model.query_mov.SQL.Clear;
      Model.query_mov.SQL.Add('DELETE FROM movimentacoes where id_movimento = :id');
      Model.query_mov.ParamByName('id').Value := idGasto;
      Model.query_mov.ExecSQL;


    MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

     listar;


     BtnExcluir.Enabled := false;
     edtMotivo.Text := '';
     edtValor.Text := '';

end;
end;

procedure TFrmGastos.btnNovoClick(Sender: TObject);
begin
btnSalvar.Enabled := true;
edtMotivo.Enabled := true;
edtValor.Enabled := true;
edtMotivo.Text := '';
edtMotivo.SetFocus;

Model.tb_gastos.Insert;
end;

procedure TFrmGastos.btnSalvarClick(Sender: TObject);
begin
      if Trim(EdtMotivo.Text) = '' then
       begin
           MessageDlg('Preencha o Motivo!', mtInformation, mbOKCancel, 0);
           EdtMotivo.SetFocus;
           exit;
     end;

      if Trim(EdtValor.Text) = '' then
       begin
           MessageDlg('Preencha o Valor!', mtInformation, mbOKCancel, 0);
           EdtValor.SetFocus;
           exit;
     end;

associarCampos;
Model.tb_gastos.Post;


//RECUPERAR O ID DO ULTIMO GASTO INSERIDO
      Model.query_gastos.Close;
      Model.query_gastos.SQL.Clear;
      Model.query_gastos.SQL.Add('SELECT * from gastos order by id desc');

      Model.query_gastos.Open;

       if not Model.query_gastos.isEmpty then
       begin
         idGasto :=  Model.query_gastos['id'];
       end;


//LANÇAR O VALOR DO GASTO NAS MOVIMENTAÇÕES
       Model.query_mov.Close;
      Model.query_mov.SQL.Clear;
      Model.query_mov.SQL.Add('INSERT INTO movimentacoes (tipo, movimento, valor, funcionario, data, id_movimento) VALUES (:tipo, :movimento, :valor, :funcionario, curDate(), :id_movimento)');
      Model.query_mov.ParamByName('tipo').Value := 'Saída';
      Model.query_mov.ParamByName('movimento').Value := 'Gasto';
      Model.query_mov.ParamByName('valor').Value := edtValor.Text;
      Model.query_mov.ParamByName('funcionario').Value := nomeUsuario;
      Model.query_mov.ParamByName('id_movimento').Value := idGasto;
      Model.query_mov.ExecSQL;


MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
edtMotivo.Text := '';
edtMotivo.Enabled := false;
edtValor.Text := '';
edtValor.Enabled := false;
btnSalvar.Enabled := false;
listar;
end;

procedure TFrmGastos.buscarData;
begin
       Model.query_gastos.Close;
       Model.query_gastos.SQL.Clear;
       Model.query_gastos.SQL.Add('SELECT * FROM gastos where data = :data order by data desc');
       Model.query_gastos.ParamByName('data').Value := FormatDateTime('yyyy/mm/dd' ,dataBuscar.Date);
       Model.query_gastos.Open;
end;

procedure TFrmGastos.dataBuscarChange(Sender: TObject);
begin
buscarData;
end;

procedure TFrmGastos.FormShow(Sender: TObject);
begin
Model.tb_gastos.Active := true;
 dataBuscar.Date := Date;
  buscarData;

end;

procedure TFrmGastos.gridCellClick(Column: TColumn);
begin
btnExcluir.Enabled := true;
idGasto := Model.query_gastos.FieldByName('id').Value;
end;

procedure TFrmGastos.listar;
begin
  Model.query_gastos.Close;
     Model.query_gastos.SQL.Clear;
     Model.query_gastos.SQL.Add('SELECT * from gastos order by data desc');
     Model.query_gastos.Open;
end;

procedure TFrmGastos.SB_CANCELARClick(Sender: TObject);
begin
Close;
end;

end.
