program Project;

uses
  Vcl.Forms,
  Login.View in 'src\view\Login\Login.View.pas' {Form1},
  DM.Model in 'src\model\DM.Model.pas' {Model: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TModel, Model);
  Application.Run;
end.
