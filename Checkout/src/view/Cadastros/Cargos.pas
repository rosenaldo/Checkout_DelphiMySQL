unit Cargos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmCargos = class(TForm)
    Label2: TLabel;
    EdtNome: TEdit;
    grid: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    P_CONTAINER: TPanel;
    P_GRID: TPanel;
    P_RODAPE: TPanel;
    P_TOPO: TPanel;
    SB_CANCELAR: TSpeedButton;
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure gridCellClick(Column: TColumn);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure SB_CANCELARClick(Sender: TObject);
  private
    { Private declarations }
    procedure associarCampos;
    procedure listar;
  public
    { Public declarations }
  end;

var
  FrmCargos: TFrmCargos;
  id: string;

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

uses DM.Model;

procedure TFrmCargos.associarCampos;
begin
  Model.tb_Cargos.FieldByName('cargo').Value := EdtNome.Text;
end;

procedure TFrmCargos.BtnEditarClick(Sender: TObject);
var
  cargo: string;
begin

  if Trim(EdtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Cargo!', mtInformation, mbOKCancel, 0);
    EdtNome.SetFocus;
    exit;
  end;

  // VERIFICAR SE O CARGO J? EST? CADASTRADO
  Model.query_cargos.Close;
  Model.query_cargos.SQL.Clear;
  Model.query_cargos.SQL.Add('SELECT * from cargos where cargo = ' +
    QuotedStr(Trim(EdtNome.Text)));
  Model.query_cargos.Open;

  if not Model.query_cargos.isEmpty then
  begin
    cargo := Model.query_cargos['cargo'];
    MessageDlg('O cargo ' + cargo + ' j? est? cadastrado!', mtInformation,
      mbOKCancel, 0);
    EdtNome.Text := '';
    EdtNome.SetFocus;
    exit;
  end;

  associarCampos;
  Model.query_cargos.Close;
  Model.query_cargos.SQL.Clear;
  Model.query_cargos.SQL.Add('UPDATE cargos set cargo = :cargo where id = :id');
  Model.query_cargos.ParamByName('cargo').Value := EdtNome.Text;
  Model.query_cargos.ParamByName('id').Value := id;
  Model.query_cargos.ExecSQL;

  listar;
  MessageDlg('Editado com Sucesso!!', mtInformation, mbOKCancel, 0);
  BtnEditar.Enabled := false;
  BtnExcluir.Enabled := false;
  EdtNome.Text := '';

end;

procedure TFrmCargos.BtnExcluirClick(Sender: TObject);
begin
  if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes then
  begin
    Model.tb_Cargos.Delete;
    MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

    listar;

    BtnEditar.Enabled := false;
    BtnExcluir.Enabled := false;
    EdtNome.Text := '';

  end;

end;

procedure TFrmCargos.btnNovoClick(Sender: TObject);
begin
  Model.tb_Cargos.Insert;
  btnSalvar.Enabled := true;
  EdtNome.Enabled := true;
  EdtNome.Text := '';
  EdtNome.SetFocus;

end;

procedure TFrmCargos.btnSalvarClick(Sender: TObject);
var
  cargo: string;
begin

  if Trim(EdtNome.Text) = '' then
  begin
    MessageDlg('Preencha o Cargo!', mtInformation, mbOKCancel, 0);
    EdtNome.SetFocus;
    exit;
  end;

  // VERIFICAR SE O CARGO J? EST? CADASTRADO
  Model.query_cargos.Close;
  Model.query_cargos.SQL.Clear;
  Model.query_cargos.SQL.Add('SELECT * from cargos where cargo = ' +
    QuotedStr(Trim(EdtNome.Text)));
  Model.query_cargos.Open;

  if not Model.query_cargos.isEmpty then
  begin
    cargo := Model.query_cargos['cargo'];
    MessageDlg('O cargo ' + cargo + ' j? est? cadastrado!', mtInformation,
      mbOKCancel, 0);
    EdtNome.Text := '';
    EdtNome.SetFocus;
    exit;
  end;

  associarCampos;
  Model.tb_Cargos.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  EdtNome.Text := '';
  EdtNome.Enabled := false;
  btnSalvar.Enabled := false;
  listar;
end;

procedure TFrmCargos.FormCreate(Sender: TObject);
begin
  Model.tb_Cargos.Active := true;
  listar;
end;

procedure TFrmCargos.gridCellClick(Column: TColumn);
begin
  EdtNome.Enabled := true;
  BtnEditar.Enabled := true;
  BtnExcluir.Enabled := true;

  Model.tb_Cargos.Edit;

  if Model.query_cargos.FieldByName('cargo').Value <> null then
    EdtNome.Text := Model.query_cargos.FieldByName('cargo').Value;

  id := Model.query_cargos.FieldByName('id').Value;

end;

procedure TFrmCargos.listar;
begin
  Model.query_cargos.Close;
  Model.query_cargos.SQL.Clear;
  Model.query_cargos.SQL.Add('SELECT * from cargos order by cargo asc');
  Model.query_cargos.Open;
end;

procedure TFrmCargos.SB_CANCELARClick(Sender: TObject);
begin
Close;
end;

end.
