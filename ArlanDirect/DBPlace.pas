unit DBPlace;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.Client, Data.DB, FireDAC.Comp.DataSet;

type
  TDBPlaceModule = class(TDataModule)
    FDConnectionDef: TFDConnection;
    FDTransactionDef: TFDTransaction;
    FDQueryDef: TFDQuery;
    FDMemTableDef: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DBPlaceModule: TDBPlaceModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDBPlaceModule.DataModuleCreate(Sender: TObject);
begin
  try
    FDConnectionDef.Connected := True;
  except
    FDConnectionDef.Connected := False;
  end;

  if (FDConnectionDef.Connected = True) then
  begin
    with FDQueryDef do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from catalog_list order by name_catalog');
      try
        Open;
        Close;
      except
        Close;
        FDConnectionDef.Connected := False;
      end;

    end;
  end;
end;

end.
