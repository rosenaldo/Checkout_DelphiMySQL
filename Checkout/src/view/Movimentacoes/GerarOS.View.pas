unit GerarOS.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Buttons, Vcl.ComCtrls, Data.DB;

type
  TFRM_ADD_OS = class(TForm)
    P_CONTAINER_ADDOS: TPanel;
    Label1: TLabel;
    EDT_TECRESPONSAVEL: TEdit;
    EDT_CLIENTE: TEdit;
    Label2: TLabel;
    P_RODAPE: TPanel;
    SB_FINALIZAR: TSpeedButton;
    EDT_GARANTIA: TEdit;
    DT_INICIAL: TDateTimePicker;
    DT_FINAL: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    M_DESC_SERVICO: TMemo;
    M_DEFEITO: TMemo;
    M_LAUDO: TMemo;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    SB_CANCELAR: TSpeedButton;
    EDT_VALOR_TOTAL: TEdit;
    Label11: TLabel;
    CB_STATUS: TComboBox;
    M_OBS: TMemo;
    P_TOPO: TPanel;
    Panel1: TPanel;
    procedure SB_CANCELARClick(Sender: TObject);
    procedure SB_FINALIZARClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure imprimirOS;
    procedure LimparCampos;
       { Private declarations }
  public
    { Public declarations }
    procedure AssociarCampos;
    procedure EdicaoDeOS;
    procedure FormParaEdicaoDeOS;
    procedure ValidarOS;
  end;

var
  FRM_ADD_OS: TFRM_ADD_OS;

  idOS: string;
  id: string;

implementation

{$R *.dfm}

uses DM.Model;

procedure TFRM_ADD_OS.AssociarCampos;
begin
  Model.FDT_OS.FieldByName('CLIENTE').Value := EDT_CLIENTE.Text;
  Model.FDT_OS.FieldByName('TECNICO').Value := EDT_TECRESPONSAVEL.Text;
  Model.FDT_OS.FieldByName('DTINICIAL').Value := DT_INICIAL.Date;
  Model.FDT_OS.FieldByName('DTFINAL').Value := DT_FINAL.Date;
  Model.FDT_OS.FieldByName('GARANTIA').Value := EDT_GARANTIA.Text;
  Model.FDT_OS.FieldByName('DESCRICAO_SERVICO').Value := M_DESC_SERVICO.Text;
  Model.FDT_OS.FieldByName('DEFEITO').Value := M_DEFEITO.Text;
  Model.FDT_OS.FieldByName('OBSERVACAO').Value := M_OBS.Text;
  Model.FDT_OS.FieldByName('LAUDO_TECNICO').Value := M_LAUDO.Text;
  Model.FDT_OS.FieldByName('VALOR_TOTAL').Value := EDT_VALOR_TOTAL.Text;
  Model.FDT_OS.FieldByName('STATUS').Value := CB_STATUS.Text;
end;

procedure TFRM_ADD_OS.FormParaEdicaoDeOS;
begin

  EDT_CLIENTE.Text := Model.FDQ_OS.FieldByName('CLIENTE').Value;
  EDT_TECRESPONSAVEL.Text := Model.FDQ_OS.FieldByName('TECNICO').Value;
  DT_INICIAL.Date := Model.FDQ_OS.FieldByName('DTINICIAL').Value;
  DT_FINAL.Date := Model.FDQ_OS.FieldByName('DTFINAL').Value;
  EDT_GARANTIA.Text := Model.FDQ_OS.FieldByName('GARANTIA').Value;
  M_DESC_SERVICO.Text := Model.FDQ_OS.FieldByName('DESCRICAO_SERVICO').Value;
  M_DEFEITO.Text := Model.FDQ_OS.FieldByName('DEFEITO').Value;
  M_OBS.Text := Model.FDQ_OS.FieldByName('OBSERVACAO').Value;
  M_LAUDO.Text := Model.FDQ_OS.FieldByName('LAUDO_TECNICO').Value;
  EDT_VALOR_TOTAL.Text := Model.FDQ_OS.FieldByName('VALOR_TOTAL').Value;
  CB_STATUS.Text := Model.FDQ_OS.FieldByName('STATUS').Value;

  id := Model.FDQ_OS.FieldByName('ID').Value;
end;
//
// procedure TFRM_ADD_OS.EdicaoDeOS;
// begin
//
// Model.FDQ_OS.Close;
// Model.FDQ_OS.SQL.Clear;
// Model.FDQ_OS.SQL.Add
// ('UPDATE OS SET CLIENTE =:CLIENTE, TECNICO =:TECNICO, DTINICIAL =:DTINICIAL, DTFINAL =:DTFINAL, GARANTIA =:GARANTIA, DESCRICAO_SERVICO =:DESCRICAO_SERVICO, DEFEITO =:DEFEITO, OBSERVACAO =:OBSERVACAO, LAUDO_TECNICO =:LAUDO_TECNICO, VALOR_TOTAL =:VALOR_TOTAL, STATUS =:STATUS WHERE ID =:ID');
// Model.FDQ_OS.ParamByName('CLIENTE').Value := EDT_CLIENTE.Text;
// Model.FDQ_OS.ParamByName('TECNICO').Value := EDT_TECRESPONSAVEL.Text;
// Model.FDQ_OS.ParamByName('DTINICIAL').Value := DT_INICIAL.Date;
// Model.FDQ_OS.ParamByName('DTFINAL').Value := DT_FINAL.Date;
// Model.FDQ_OS.ParamByName('GARANTIA').Value := EDT_GARANTIA.Text;
// Model.FDQ_OS.ParamByName('DESCRICAO_SERVICO').Value := M_DESC_SERVICO.Text;
// Model.FDQ_OS.ParamByName('DEFEITO').Value := M_DEFEITO.Text;
// Model.FDQ_OS.ParamByName('OBSERVACAO').Value := M_OBS.Text;
// Model.FDQ_OS.ParamByName('LAUDO_TECNICO').Value := M_LAUDO.Text;
// Model.FDQ_OS.ParamByName('VALOR_TOTAL').Value := EDT_VALOR_TOTAL.Text;
// Model.FDQ_OS.ParamByName('STATUS').Value := CB_STATUS.Text;
// Model.FDQ_OS.ParamByName('ID').Value := id;
// Model.FDQ_OS.ExecSQL;
// end;

procedure TFRM_ADD_OS.FormCreate(Sender: TObject);
begin
  AssociarCampos;
end;

procedure TFRM_ADD_OS.FormShow(Sender: TObject);
begin
  Model.FDT_OS.Active := True;
end;

procedure TFRM_ADD_OS.SB_CANCELARClick(Sender: TObject);
begin
  Model.FDT_OS.Cancel;
  Close;
end;

procedure TFRM_ADD_OS.SB_FINALIZARClick(Sender: TObject);
begin

  if Model.FDT_OS.State in [dsInsert] then
  begin
    try
      ValidarOS;
      Model.FDT_OS.Post;
      ShowMessage('OS gerado com sucesso!');
      LimparCampos;
      Model.ListarOS;
      Close;
    except
      on E: Exception do

    end;
  end;
  if Model.FDT_OS.State in [dsEdit] then
  begin
    try
      ValidarOS;
      AssociarCampos;
      EdicaoDeOS;
      ShowMessage('Editado com sucesso!');
      LimparCampos;
      Model.ListarOS;
      Close;
    except
      on E: Exception do

    end;
  end;

end;

procedure TFRM_ADD_OS.LimparCampos;
begin
  EDT_CLIENTE.Text := '';
  EDT_GARANTIA.Text := '';
  EDT_TECRESPONSAVEL.Text := '';
  EDT_VALOR_TOTAL.Text := '';
  CB_STATUS.Text := '';
  M_DESC_SERVICO.Text := '';
  M_DEFEITO.Text := '';
  M_OBS.Text := '';
  M_LAUDO.Text := '';
end;

procedure TFRM_ADD_OS.ValidarOS;
begin
  AssociarCampos;
  if Trim(EDT_CLIENTE.Text) = '' then
  begin
    MessageDlg('Informe o cliente!', mtWarning, mbOKCancel, 0);
    EDT_CLIENTE.SetFocus;
    Abort;
  end;
  if Trim(EDT_TECRESPONSAVEL.Text) = '' then
  begin
    MessageDlg('Informe um responsável!', mtWarning, mbOKCancel, 0);
    EDT_TECRESPONSAVEL.SetFocus;
    Abort;
  end;

  if Trim(EDT_GARANTIA.Text) = '' then
  begin
    MessageDlg('Informe a garantia!', mtWarning, mbOKCancel, 0);
    EDT_GARANTIA.SetFocus;
    Abort;
  end;
  if Trim(M_DESC_SERVICO.Text) = '' then
  begin
    MessageDlg('Descreva o serviço!', mtWarning, mbOKCancel, 0);
    M_DESC_SERVICO.SetFocus;
    Abort;
  end;

  if Trim(M_DEFEITO.Text) = '' then
  begin
    MessageDlg('Descreva o defeito!', mtWarning, mbOKCancel, 0);
    M_DEFEITO.SetFocus;
    Abort;
  end;
  if Trim(M_OBS.Text) = '' then
  begin
    MessageDlg('Informe uma observação!', mtWarning, mbOKCancel, 0);
    M_OBS.SetFocus;
    Abort;
  end;

  if Trim(M_LAUDO.Text) = '' then
  begin
    MessageDlg('Informe o laudo técnico!', mtWarning, mbOKCancel, 0);
    M_LAUDO.SetFocus;
    Abort;
  end;
  if Trim(EDT_VALOR_TOTAL.Text) = '' then
  begin
    MessageDlg('Não esqueça de cobrar, informe o valor total!', mtWarning,
      mbOKCancel, 0);
    EDT_VALOR_TOTAL.SetFocus;
    Abort;
  end;

end;

procedure TFRM_ADD_OS.imprimirOS;
begin
  idOS := Model.FDQ_OS['ID'];
  Model.FDQ_OS.Close;
  Model.FDQ_OS.SQL.Clear;
  Model.FDQ_OS.SQL.Add
    ('SELECT ID, CLIENTE, TECNICO, DTINICIAL, DTFINAL, STATUS, GARANTIA, DESCRICAO_SERVICO, DEFEITO, OBSERVACAO, LAUDO_TECNICO, VALOR_TOTAL FROM OS WHERE ID = :ID ');
  Model.FDQ_OS.ParamByName('ID').Value := idOS;
  Model.FDQ_OS.Open;
  Model.R_OS.ShowReport();
  Model.ListarOS;

end;

procedure TFRM_ADD_OS.EdicaoDeOS;
begin

  Model.FDQ_OS.Close;
  Model.FDQ_OS.SQL.Clear;
  Model.FDQ_OS.SQL.Add('UPDATE OS SET CLIENTE =:CLIENTE,');
  Model.FDQ_OS.SQL.Add(' TECNICO =:TECNICO,');
  Model.FDQ_OS.SQL.Add(' DTINICIAL =:DTINICIAL,');
  Model.FDQ_OS.SQL.Add(' DTFINAL =:DTFINAL,');
  Model.FDQ_OS.SQL.Add(' GARANTIA =:GARANTIA,');
  Model.FDQ_OS.SQL.Add('DESCRICAO_SERVICO =:DESCRICAO_SERVICO,');
  Model.FDQ_OS.SQL.Add(' DEFEITO =:DEFEITO, OBSERVACAO =:OBSERVACAO,');
  Model.FDQ_OS.SQL.Add(' LAUDO_TECNICO =:LAUDO_TECNICO,');
  Model.FDQ_OS.SQL.Add(' VALOR_TOTAL =:VALOR_TOTAL,');
  Model.FDQ_OS.SQL.Add('STATUS =:STATUS WHERE ID =:ID');

  Model.FDQ_OS.ParamByName('CLIENTE').Value := EDT_CLIENTE.Text;
  Model.FDQ_OS.ParamByName('TECNICO').Value := EDT_TECRESPONSAVEL.Text;
  Model.FDQ_OS.ParamByName('DTINICIAL').Value := DT_INICIAL.Date;
  Model.FDQ_OS.ParamByName('DTFINAL').Value := DT_FINAL.Date;
  Model.FDQ_OS.ParamByName('GARANTIA').Value := EDT_GARANTIA.Text;
  Model.FDQ_OS.ParamByName('DESCRICAO_SERVICO').Value := M_DESC_SERVICO.Text;
  Model.FDQ_OS.ParamByName('DEFEITO').Value := M_DEFEITO.Text;
  Model.FDQ_OS.ParamByName('OBSERVACAO').Value := M_OBS.Text;
  Model.FDQ_OS.ParamByName('LAUDO_TECNICO').Value := M_LAUDO.Text;
  Model.FDQ_OS.ParamByName('VALOR_TOTAL').Value := EDT_VALOR_TOTAL.Text;
  Model.FDQ_OS.ParamByName('STATUS').Value := CB_STATUS.Text;
  Model.FDQ_OS.ParamByName('ID').Value := id;
  Model.FDQ_OS.ExecSQL;
end;

end.
