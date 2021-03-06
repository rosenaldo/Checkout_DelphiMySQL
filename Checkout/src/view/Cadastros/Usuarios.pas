unit Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Buttons, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmUsuarios = class(TForm)
    Label2: TLabel;
    EdtNome: TEdit;
    DBGrid1: TDBGrid;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    EdtBuscarNome: TEdit;
    Label1: TLabel;
    btnBuscarFunc: TSpeedButton;
    Label3: TLabel;
    edtUsuario: TEdit;
    edtSenha: TEdit;
    Label4: TLabel;
    P_RODAPE: TPanel;
    P_CONTAINER: TPanel;
    P_GRID: TPanel;
    P_TOPO: TPanel;
    SB_CANCELAR: TSpeedButton;
    procedure btnBuscarFuncClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure EdtBuscarNomeChange(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure BtnExcluirClick(Sender: TObject);
    procedure SB_CANCELARClick(Sender: TObject);
  private
    { Private declarations }

      procedure limpar;
      procedure habilitarCampos;
      procedure desabilitarCampos;

      procedure associarCampos;
      procedure listar;
      procedure buscarNome;
  public
    { Public declarations }
  end;

var
  FrmUsuarios: TFrmUsuarios;
  usuarioAntigo: string;


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

uses Funcionarios, DM.Model;

procedure TFrmUsuarios.associarCampos;
begin
   Model.tb_usuarios.FieldByName('nome').Value := edtNome.Text;
   Model.tb_usuarios.FieldByName('usuario').Value := edtUsuario.Text;
   Model.tb_usuarios.FieldByName('senha').Value := edtSenha.Text;
    Model.tb_usuarios.FieldByName('cargo').Value := cargoFunc;
     Model.tb_usuarios.FieldByName('id_funcionario').Value := idFunc;
end;

procedure TFrmUsuarios.btnBuscarFuncClick(Sender: TObject);
begin
chamada := 'Func';
FrmFuncionarios := TFrmFuncionarios.Create(self);
FrmFuncionarios.Show;
end;




procedure TFrmUsuarios.BtnEditarClick(Sender: TObject);
var
  usuario : string;
  begin

      if Trim(EdtNome.Text) = '' then
       begin
           MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
           EdtNome.SetFocus;
           exit;
       end;

        if Trim(edtUsuario.Text) = '' then
       begin
           MessageDlg('Preencha o Usuario!', mtInformation, mbOKCancel, 0);
           edtUsuario.SetFocus;
           exit;
       end;


        if Trim(edtSenha.Text) = '' then
       begin
           MessageDlg('Preencha a Senha!', mtInformation, mbOKCancel, 0);
           edtSenha.SetFocus;
           exit;
       end;

        if usuarioAntigo <> edtUsuario.Text then
           begin
           //VERIFICAR SE O usuário JÁ ESTÁ CADASTRADO
           Model.query_usuarios.Close;
           Model.query_usuarios.SQL.Clear;
           Model.query_usuarios.SQL.Add('SELECT * from usuarios where usuario = ' + QuotedStr(Trim(edtUsuario.Text)));
           Model.query_usuarios.Open;

           if not Model.query_usuarios.isEmpty then
           begin
             usuario :=  Model.query_usuarios['usuario'];
             MessageDlg('O Usuário ' + usuario + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
             edtUsuario.Text := '';
             edtUsuario.SetFocus;
             exit;
           end;

       end;



         //associarCampos;
       Model.query_usuarios.Close;
       Model.query_usuarios.SQL.Clear;
       Model.query_usuarios.SQL.Add('UPDATE usuarios set nome = :nome, usuario = :usuario, senha = :senha where id = :id');
       Model.query_usuarios.ParamByName('nome').Value := edtNome.Text;
        Model.query_usuarios.ParamByName('usuario').Value := edtUsuario.Text;
         Model.query_usuarios.ParamByName('senha').Value := edtSenha.Text;

       Model.query_usuarios.ParamByName('id').Value := id;
       Model.query_usuarios.ExecSQL;

       listar;
       MessageDlg('Editado com Sucesso!!', mtInformation, mbOKCancel, 0);
       btnEditar.Enabled := false;
       BtnExcluir.Enabled := false;
       limpar;
       desabilitarCampos;





end;

procedure TFrmUsuarios.BtnExcluirClick(Sender: TObject);
begin
if MessageDlg('Deseja Excluir o registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
begin

     Model.query_usuarios.Close;
     Model.query_usuarios.SQL.Clear;
     Model.query_usuarios.SQL.Add('DELETE FROM usuarios WHERE id = :id');
     Model.query_usuarios.ParamByName('id').Value := id;
     Model.query_usuarios.ExecSQL;
    MessageDlg('Deletado com Sucesso!!', mtInformation, mbOKCancel, 0);

     listar;

     btnEditar.Enabled := false;
     BtnExcluir.Enabled := false;
     edtNome.Text := '';

end;
end;

procedure TFrmUsuarios.btnNovoClick(Sender: TObject);
begin
 habilitarCampos;
  Model.tb_usuarios.Insert;
  btnSalvar.Enabled := true;
end;

procedure TFrmUsuarios.btnSalvarClick(Sender: TObject);
var
  usuario : string;
  begin

      if Trim(EdtNome.Text) = '' then
       begin
           MessageDlg('Preencha o Nome!', mtInformation, mbOKCancel, 0);
           EdtNome.SetFocus;
           exit;
       end;

        if Trim(edtUsuario.Text) = '' then
       begin
           MessageDlg('Preencha o Usuario!', mtInformation, mbOKCancel, 0);
           edtUsuario.SetFocus;
           exit;
       end;


        if Trim(edtSenha.Text) = '' then
       begin
           MessageDlg('Preencha a Senha!', mtInformation, mbOKCancel, 0);
           edtSenha.SetFocus;
           exit;
       end;


           //VERIFICAR SE O usuário JÁ ESTÁ CADASTRADO
           Model.query_usuarios.Close;
           Model.query_usuarios.SQL.Clear;
           Model.query_usuarios.SQL.Add('SELECT * from usuarios where usuario = ' + QuotedStr(Trim(edtUsuario.Text)));
           Model.query_usuarios.Open;

           if not Model.query_usuarios.isEmpty then
           begin
             usuario :=  Model.query_usuarios['usuario'];
             MessageDlg('O Usuário ' + usuario + ' já está cadastrado!', mtInformation, mbOKCancel, 0);
             edtUsuario.Text := '';
             edtUsuario.SetFocus;
             exit;
           end;



  associarCampos;
  Model.tb_usuarios.Post;
  MessageDlg('Salvo com Sucesso', mtInformation, mbOKCancel, 0);
  limpar;
  desabilitarCampos;
  btnSalvar.Enabled := false;
  listar;


end;

procedure TFrmUsuarios.buscarNome;
begin
       Model.query_usuarios.Close;
       Model.query_usuarios.SQL.Clear;
       Model.query_usuarios.SQL.Add('SELECT * from usuarios where nome LIKE :nome and cargo <> :cargo order by nome asc');
       Model.query_usuarios.ParamByName('nome').Value := EdtBuscarNome.Text + '%';
       Model.query_usuarios.ParamByName('cargo').Value := 'admin';
       Model.query_usuarios.Open;
end;

procedure TFrmUsuarios.DBGrid1CellClick(Column: TColumn);
begin

habilitarCampos;
  btnEditar.Enabled := true;
  btnExcluir.Enabled := true;

  Model.tb_usuarios.Edit;


  edtNome.Text := Model.query_usuarios.FieldByName('nome').Value;

  edtUsuario.Text := Model.query_usuarios.FieldByName('usuario').Value;
  edtSenha.Text := Model.query_usuarios.FieldByName('senha').Value;


  id := Model.query_usuarios.FieldByName('id').Value;

  usuarioAntigo := Model.query_usuarios.FieldByName('usuario').Value;

end;

procedure TFrmUsuarios.desabilitarCampos;
begin
  edtNome.Enabled := false;
  edtUsuario.Enabled := false;
  edtSenha.Enabled := false;
   btnBuscarFunc.Enabled := false;
end;

procedure TFrmUsuarios.EdtBuscarNomeChange(Sender: TObject);
begin
buscarNome;
end;

procedure TFrmUsuarios.FormActivate(Sender: TObject);
begin
edtNome.Text := nomeFunc;
end;

procedure TFrmUsuarios.FormShow(Sender: TObject);
begin
 desabilitarCampos;
  Model.tb_usuarios.Active := true;
  listar;
end;

procedure TFrmUsuarios.habilitarCampos;
begin

  edtUsuario.Enabled := true;
  edtSenha.Enabled := true;
  btnBuscarFunc.Enabled := true;
end;

procedure TFrmUsuarios.limpar;
begin
edtNome.text := '';
  edtUsuario.text := '';
  edtSenha.text := '';
end;

procedure TFrmUsuarios.listar;
begin
       Model.query_usuarios.Close;
       Model.query_usuarios.SQL.Clear;
       Model.query_usuarios.SQL.Add('SELECT * from usuarios where cargo <> :cargo order by nome asc');
       Model.query_usuarios.ParamByName('cargo').Value := 'admin';
       Model.query_usuarios.Open;
end;

procedure TFrmUsuarios.SB_CANCELARClick(Sender: TObject);
begin
Close;
end;

end.
