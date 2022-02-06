unit CancelarItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmCancelarItem = class(TForm)
    edtIdItem: TEdit;
    Label1: TLabel;
    P_CONTAINER: TPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCancelarItem: TFrmCancelarItem;
  estoque : double;
  quantidade : double;

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

procedure TFrmCancelarItem.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = 13 then
begin
      if Trim(edtIdItem.Text) = '' then
         begin
             MessageDlg('Insira o Código do Item!', mtInformation, mbOKCancel, 0);
             edtIdItem.Text := '';
             edtIdItem.SetFocus;

             exit;
      end;



           //RECUPERAR A QUANTIDADE, VALOR e ID DO PRODUTO DO ITEM VENDIDO
           Model.query_coringa.Close;
          Model.query_coringa.SQL.Clear;
          Model.query_coringa.SQL.Add('SELECT * from detalhes_vendas where id = :id');
          Model.query_coringa.ParamByName('id').Value := edtIdItem.Text;
          Model.query_coringa.Open;


           if not Model.query_coringa.isEmpty then
                 begin

                  quantidade :=  Model.query_coringa['quantidade'];
                  totalProdutos :=  Model.query_coringa['total'];
                  idProduto := Model.query_coringa['id_produto'];

                 end;



                  //RECUPERAR O ESTOQUE DO PRODUTO EXCLUIDO
           Model.query_produtos.Close;
          Model.query_produtos.SQL.Clear;
          Model.query_produtos.SQL.Add('SELECT * from produtos where id = :id');
          Model.query_produtos.ParamByName('id').Value := idProduto;
          Model.query_produtos.Open;


           if not Model.query_produtos.isEmpty then
                 begin

                  estoque :=  Model.query_produtos['estoque'];

                 end;





//DEVOLVER  O PRODUTO PARA O ESTOQUE
       estoque := estoque + quantidade;

       Model.query_produtos.Close;
       Model.query_produtos.SQL.Clear;
       Model.query_produtos.SQL.Add('UPDATE produtos set estoque = :estoque where id = :id');
       Model.query_produtos.ParamByName('estoque').Value := estoque;

       Model.query_produtos.ParamByName('id').Value := idProduto;
       Model.query_produtos.ExecSQL;


       try
           Model.query_coringa.Close;
           Model.query_coringa.SQL.Clear;
           Model.query_coringa.SQL.Add('DELETE from detalhes_vendas where id = :id');
           Model.query_coringa.ParamByName('id').Value := edtIdItem.Text;
           Model.query_coringa.ExecSQL;
           close;

           except
           MessageDlg('Código do Produto Inválido!!', mtInformation, mbOKCancel, 0);
           edtIdItem.Text := '';
           edtIdItem.SetFocus;
           exit;
           end;





end;
end;

end.
