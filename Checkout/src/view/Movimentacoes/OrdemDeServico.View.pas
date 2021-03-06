unit OrdemDeServico.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.Imaging.jpeg;

type
  TFRM_OS = class(TForm)
    P_CONTAINER: TPanel;
    P_MENU: TPanel;
    P_GRID_OS: TPanel;
    SB_ADD_OS: TSpeedButton;
    EDT_CLIENTE: TEdit;
    DBG_OS: TDBGrid;
    SB_DELETAR: TSpeedButton;
    SB_IMPRIMIR_OS: TSpeedButton;
    SB_EDITAR: TSpeedButton;
    Label1: TLabel;
    P_RODAPE: TPanel;
    SpeedButton1: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure SB_ADD_OSClick(Sender: TObject);
    procedure EDT_CLIENTEKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SB_DELETARClick(Sender: TObject);
    procedure SB_IMPRIMIR_OSClick(Sender: TObject);
    procedure DBG_OSCellClick(Column: TColumn);
    procedure SB_EDITARClick(Sender: TObject);
    procedure SB_SAIRClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRM_OS: TFRM_OS;
  idOS: string;

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

uses  DM.Model, GerarOS.View;

procedure TFRM_OS.DBG_OSCellClick(Column: TColumn);
begin
  SB_EDITAR.Enabled := True;
  SB_DELETAR.Enabled := True;
end;

procedure TFRM_OS.EDT_CLIENTEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  DBG_OS.DataSource.DataSet.Filter := 'CLIENTE LIKE ' +
    QuotedStr('%' + EDT_CLIENTE.Text + '%');
  DBG_OS.DataSource.DataSet.Filtered := True;

end;

procedure TFRM_OS.FormShow(Sender: TObject);
begin

  Model.FDT_OS.Active := True;
  Model.Listaros;

end;

procedure TFRM_OS.SB_ADD_OSClick(Sender: TObject);
 begin
  Model.FDT_OS.Insert;
  FRM_ADD_OS := TFRM_ADD_OS.Create(Nil);
  try
    FRM_ADD_OS.ShowModal;
  finally
    FRM_ADD_OS.Free;
  end;
  Model.Listaros;
end;

procedure TFRM_OS.SB_DELETARClick(Sender: TObject);
begin
  if MessageDlg('Deseja deletar o registro?', mtConfirmation, [mbYes, mbNo], 0)
    = mrYes then
  begin
    Model.FDQ_OS.Delete;
    ShowMessage('Deletado com sucesso!');
    Model.Listaros;
    SB_DELETAR.Enabled := False;
    SB_EDITAR.Enabled := False;
  end;
end;

procedure TFRM_OS.SB_EDITARClick(Sender: TObject);
begin
  Model.FDT_OS.Edit;
  FRM_ADD_OS := TFRM_ADD_OS.Create(Nil);
  try

    FRM_ADD_OS.FormParaEdicaoDeOS;
    FRM_ADD_OS.ShowModal;
  finally
    FRM_ADD_OS.Free;
  end;
  Model.Listaros;
  SB_DELETAR.Enabled := False;
  SB_EDITAR.Enabled := False;
end;

procedure TFRM_OS.SB_IMPRIMIR_OSClick(Sender: TObject);
begin
  try
    idOS := Model.FDQ_OS['ID'];
    Model.FDQ_OS.Close;
    Model.FDQ_OS.SQL.Clear;
    Model.FDQ_OS.SQL.Add
      ('SELECT ID, CLIENTE, TECNICO, DTINICIAL, DTFINAL, STATUS, GARANTIA, DESCRICAO_SERVICO, DEFEITO, OBSERVACAO, LAUDO_TECNICO, VALOR_TOTAL FROM OS WHERE ID = :ID');
    Model.FDQ_OS.ParamByName('ID').Value := idOS;
    Model.FDQ_OS.Open;
    Model.R_OS.LoadFromFile(GetCurrentDir + '\rel\os.fr3');
    Model.R_OS.ShowReport();
    Model.Listaros;
  except
    on E: Exception do
      ShowMessage('Não há dados para imprimir!');
  end;
end;

procedure TFRM_OS.SB_SAIRClick(Sender: TObject);
begin
  Close;
end;

procedure TFRM_OS.SpeedButton1Click(Sender: TObject);
begin
Close;
end;

end.
