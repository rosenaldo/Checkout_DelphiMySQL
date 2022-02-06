unit SaidasProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TFrmSaidaProdutos = class(TForm)
    Label2: TLabel;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    Label1: TLabel;
    btnBuscarPro: TSpeedButton;
    Label3: TLabel;
    EdtProduto: TEdit;
    DBGrid1: TDBGrid;
    edtQuantidade: TEdit;
    dataBuscar: TDateTimePicker;
    edtMotivo: TEdit;
    Label4: TLabel;
    P_CONTAINER: TPanel;
    P_TOPO: TPanel;
    P_GRID: TPanel;
    P_RODAPE: TPanel;
    SB_SAIR: TSpeedButton;
    IMG_BUSCAR: TImage;
    procedure btnNovoClick(Sender: TObject);
    procedure btnBuscarProClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dataBuscarChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure SB_SAIRClick(Sender: TObject);
    procedure IMG_BUSCARClick(Sender: TObject);
  private
    { Private declarations }
    procedure limpar;
    procedure habilitarCampos;
    procedure desabilitarCampos;

    procedure associarCampos;
    procedure listar;
    procedure buscarData;
  public
    { Public declarations }
  end;

var
  FrmSaidaProdutos: TFrmSaidaProdutos;
  estoque: double;
  idProdutoEst: string;
  id: string;

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

uses DM.Model, Produtos;

{ TFrmSaidaProdutos }

procedure TFrmSaidaProdutos.associarCampos;
begin
  Model.tb_saida_pro.FieldByName('produto').Value := EdtProduto.Text;
  Model.tb_saida_pro.FieldByName('quantidade').Value := edtQuantidade.Text;
  Model.tb_saida_pro.FieldByName('motivo').Value := edtMotivo.Text;
  Model.tb_saida_pro.FieldByName('data').Value := DateToStr(Date);
  Model.tb_saida_pro.FieldByName('id_produto').Value := idProduto;
end;

procedure TFrmSaidaProdutos.btnBuscarProClick(Sender: TObject);
begin
  chamada := 'Prod';
  FrmProdutos := TFrmProdutos.Create(self);
  FrmProdutos.Show;
end;

procedure TFrmSaidaProdutos.BtnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes then
  begin
    Model.tb_saida_pro.Delete;


    // ATUALIZAR O ESTOQUE

    // RECUPERAR O ESTOQUE ATUAL
    Model.query_produtos.Close;
    Model.query_produtos.SQL.Clear;
    Model.query_produtos.SQL.Add('select * from produtos where id = :id');

    Model.query_produtos.ParamByName('id').Value := idProdutoEst;
    Model.query_produtos.Open;

    if not Model.query_produtos.isEmpty then
    begin
      estoqueProduto := Model.query_produtos['estoque'];

    end;

    estoque := estoqueProduto + strToFloat(edtQuantidade.Text);

    Model.query_produtos.Close;
    Model.query_produtos.SQL.Clear;
    Model.query_produtos.SQL.Add
      ('UPDATE produtos set estoque = :estoque where id = :id');
    Model.query_produtos.ParamByName('estoque').Value := estoque;
    Model.query_produtos.ParamByName('id').Value := idProduto;
    Model.query_produtos.ExecSQL;

    MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

    listar;

    BtnExcluir.Enabled := false;

  end;
end;

procedure TFrmSaidaProdutos.btnNovoClick(Sender: TObject);
begin
  habilitarCampos;
  Model.tb_saida_pro.Insert;
  btnSalvar.Enabled := true;
  IMG_BUSCAR.Enabled:= True;
end;

procedure TFrmSaidaProdutos.btnSalvarClick(Sender: TObject);
begin
  if Trim(EdtProduto.Text) = '' then
  begin
    MessageDlg('Escolha um Produto!', mtInformation, mbOKCancel, 0);

    exit;
  end;

  if Trim(edtQuantidade.Text) = '' then
  begin
    MessageDlg('Insira a quantidade!', mtInformation, mbOKCancel, 0);
    edtQuantidade.SetFocus;
    exit;
  end;

  if Trim(edtMotivo.Text) = '' then
  begin
    MessageDlg('Insira o motivo!', mtInformation, mbOKCancel, 0);
    edtMotivo.SetFocus;
    exit;
  end;

  associarCampos;
  Model.tb_saida_pro.Post;


  // ATUALIZAR O ESTOQUE

  estoque := estoqueProduto - strToFloat(edtQuantidade.Text);

  Model.query_produtos.Close;
  Model.query_produtos.SQL.Clear;
  Model.query_produtos.SQL.Add
    ('UPDATE produtos set estoque = :estoque where id = :id');
  Model.query_produtos.ParamByName('estoque').Value := estoque;

  Model.query_produtos.ParamByName('id').Value := idProduto;
  Model.query_produtos.ExecSQL;

  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;

end;

procedure TFrmSaidaProdutos.buscarData;
begin
  Model.query_saida_pro.Close;
  Model.query_saida_pro.SQL.Clear;
  Model.query_saida_pro.SQL.Add
    ('SELECT * from saida_produtos where data = :data order by data desc');
  Model.query_saida_pro.ParamByName('data').Value :=
    FormatDateTime('yyyy/mm/dd', dataBuscar.Date);
  Model.query_saida_pro.Open;
end;

procedure TFrmSaidaProdutos.dataBuscarChange(Sender: TObject);
begin
  buscarData;
end;

procedure TFrmSaidaProdutos.DBGrid1CellClick(Column: TColumn);
begin
  BtnExcluir.Enabled := true;

  EdtProduto.Text := Model.query_saida_pro.FieldByName('produto').Value;

  edtMotivo.Text := Model.query_saida_pro.FieldByName('motivo').Value;
  edtQuantidade.Text := Model.query_saida_pro.FieldByName('quantidade').Value;

  id := Model.query_saida_pro.FieldByName('id').Value;
  idProdutoEst := Model.query_saida_pro.FieldByName('id_produto').Value;

end;

procedure TFrmSaidaProdutos.desabilitarCampos;
begin
  edtMotivo.Enabled := false;
  edtQuantidade.Enabled := false;
  btnBuscarPro.Enabled := false;

end;

procedure TFrmSaidaProdutos.FormActivate(Sender: TObject);
begin
  EdtProduto.Text := nomeProduto;
end;

procedure TFrmSaidaProdutos.FormShow(Sender: TObject);
begin
  desabilitarCampos;
  Model.tb_saida_pro.Active := true;
  // listar;
  dataBuscar.Date := Date;
  buscarData;
end;

procedure TFrmSaidaProdutos.habilitarCampos;
begin
  edtMotivo.Enabled := true;
  edtQuantidade.Enabled := true;
  btnBuscarPro.Enabled := true;
end;

procedure TFrmSaidaProdutos.IMG_BUSCARClick(Sender: TObject);
begin
  chamada := 'Prod';
  FrmProdutos := TFrmProdutos.Create(self);
  FrmProdutos.Show;
end;

procedure TFrmSaidaProdutos.limpar;
begin
  edtMotivo.Text := '';
  edtQuantidade.Text := '';
  EdtProduto.Text := '';

end;

procedure TFrmSaidaProdutos.listar;
begin
  Model.query_saida_pro.Close;
  Model.query_saida_pro.SQL.Clear;
  Model.query_saida_pro.SQL.Add('SELECT * from saida_produtos order by data desc');

  Model.query_saida_pro.Open;
end;

procedure TFrmSaidaProdutos.SB_SAIRClick(Sender: TObject);
begin
  Close;
end;

end.
