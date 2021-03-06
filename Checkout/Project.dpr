program Project;

uses
  Vcl.Forms,
  Login.Wiew in 'src\view\Login\Login.Wiew.pas' {FRM_LOGIN},
  Menu.View in 'src\view\Menu\Menu.View.pas' {FRM_MENU},
  Usuario.View in 'src\view\Cadastros\Usuario.View.pas' {FRM_USUARIO},
  Funcionario.View in 'src\view\Cadastros\Funcionario.View.pas' {FRM_FUNCIONARIO},
  Dm.Model in 'src\model\Dm.Model.pas' {MODEL: TDataModule},
  Cargos.View in 'src\view\Cadastros\Cargos.View.pas' {FRM_CARGOS};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFRM_LOGIN, FRM_LOGIN);
  Application.CreateForm(TFRM_MENU, FRM_MENU);
  Application.CreateForm(TFRM_USUARIO, FRM_USUARIO);
  Application.CreateForm(TFRM_FUNCIONARIO, FRM_FUNCIONARIO);
  Application.CreateForm(TMODEL, MODEL);
  Application.CreateForm(TFRM_CARGOS, FRM_CARGOS);
  Application.Run;
end.
