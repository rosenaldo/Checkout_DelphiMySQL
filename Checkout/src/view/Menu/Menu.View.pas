unit Menu.View;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

type
  TFRM_MENU = class(TForm)
    Menu: TMainMenu;
    Cadastro1: TMenuItem;
    Estoque1: TMenuItem;
    Movimentao1: TMenuItem;
    Relatrio1: TMenuItem;
    Sair1: TMenuItem;
    Funcionrio1: TMenuItem;
    Usurio1: TMenuItem;
    Cargos1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure Funcionrio1Click(Sender: TObject);
    procedure Usurio1Click(Sender: TObject);
    procedure Cargos1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRM_MENU: TFRM_MENU;

implementation

{$R *.dfm}

uses Funcionario.View, Usuario.View, Cargos.View;

procedure TFRM_MENU.Cargos1Click(Sender: TObject);
begin
  FRM_CARGOS := TFRM_CARGOS.Create(nil);
  try
    FRM_CARGOS.ShowModal
  finally
    FRM_CARGOS.Free;
  end;
end;

procedure TFRM_MENU.Funcionrio1Click(Sender: TObject);
begin
  FRM_FUNCIONARIO := TFRM_FUNCIONARIO.Create(nil);
  try
    FRM_FUNCIONARIO.ShowModal;
  finally
    FRM_FUNCIONARIO.Free;
  end;
end;

procedure TFRM_MENU.Sair1Click(Sender: TObject);
begin
  Close;
end;

procedure TFRM_MENU.Usurio1Click(Sender: TObject);
begin
  FRM_USUARIO := TFRM_USUARIO.Create(nil);
  try
    FRM_USUARIO.ShowModal;
  finally
    FRM_USUARIO.Free;
  end;
end;

end.
