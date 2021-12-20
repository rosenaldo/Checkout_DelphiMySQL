unit Funcionario.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Data.DB,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Mask;

type
  TFRM_FUNCIONARIO = class(TForm)
    P_CONTAINER: TPanel;
    P_GRID: TPanel;
    P_TOPO: TPanel;
    EDT_BUSCARCPF: TMaskEdit;
    EDT_BUSCARNOME: TEdit;
    DBG_FUNCIONARIO: TDBGrid;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label3: TLabel;
    EDT_NOME: TEdit;
    EDT_ENDERECO: TEdit;
    ME_CPF: TMaskEdit;
    ME_TELEFONE: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CB_CARGO: TComboBox;
    Label6: TLabel;
    P_RODAPE: TPanel;
    SB_NOVO: TSpeedButton;
    SB_EDITAR: TSpeedButton;
    SB_SALVAR: TSpeedButton;
    SB_DELETAR: TSpeedButton;
    SB_SAIR: TSpeedButton;
    procedure SB_SAIRClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRM_FUNCIONARIO: TFRM_FUNCIONARIO;

implementation

{$R *.dfm}

procedure TFRM_FUNCIONARIO.SB_SAIRClick(Sender: TObject);
begin
  Close;
end;

end.
