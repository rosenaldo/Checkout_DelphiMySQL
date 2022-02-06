unit Cargos.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Mask, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TFRM_CARGOS = class(TForm)
    P_CONTAINER: TPanel;
    P_GRID: TPanel;
    DBG_CARGOS: TDBGrid;
    P_TOPO: TPanel;
    Label1: TLabel;
    EDT_CARGO: TEdit;
    P_RODAPE: TPanel;
    SB_NOVO: TSpeedButton;
    SB_EDITAR: TSpeedButton;
    SB_SALVAR: TSpeedButton;
    SB_DELETAR: TSpeedButton;
    SB_SAIR: TSpeedButton;
    procedure SB_SAIRClick(Sender: TObject);
    procedure SB_NOVOClick(Sender: TObject);
    procedure SB_SALVARClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure associarCampos;
  public
    { Public declarations }
  end;

var
  FRM_CARGOS: TFRM_CARGOS;

implementation

{$R *.dfm}

uses Dm.Model;

procedure TFRM_CARGOS.associarCampos;
begin
  Model.FDT_CARGOS.FieldByName('CARGO').Value := EDT_CARGO.Text;
end;

procedure TFRM_CARGOS.FormCreate(Sender: TObject);
begin
  Model.FDT_CARGOS.Active := True;
end;

procedure TFRM_CARGOS.SB_NOVOClick(Sender: TObject);
begin
  Model.FDT_CARGOS.Insert;
  SB_SALVAR.Enabled := True;
  EDT_CARGO.Text := '';
  EDT_CARGO.SetFocus;
end;

procedure TFRM_CARGOS.SB_SAIRClick(Sender: TObject);
begin
  close;
end;

procedure TFRM_CARGOS.SB_SALVARClick(Sender: TObject);
begin
  if trim(EDT_CARGO.Text) = '' then
  begin
    ShowMessage('Informe o cargo !');
    EDT_CARGO.SetFocus;
    Exit;
  end;
  // Verifica se o cargo ja esta cadastrado
  Model.FDQ_CARGOS.SQL.Clear;
  Model.FDQ_CARGOS.SQL.Add('SELECT CARGO FROM CARGOS WHERE CARGO = ' + EDT_CARGO.Text);

    associarCampos;
  Model.FDT_CARGOS.Post;
  ShowMessage('Cargo salvo com sucesso!');
end;

end.
