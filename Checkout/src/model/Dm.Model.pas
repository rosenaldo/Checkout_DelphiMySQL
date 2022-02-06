unit Dm.Model;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TMODEL = class(TDataModule)
    FDConnection: TFDConnection;
    FDT_CARGOS: TFDTable;
    FDQ_CARGOS: TFDQuery;
    DS_CARGOS: TDataSource;
    FDQ_CARGOSID: TFDAutoIncField;
    FDQ_CARGOSCARGO: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MODEL: TMODEL;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
