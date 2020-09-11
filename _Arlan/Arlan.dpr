program Arlan;

uses
  Vcl.Forms,
  Arlan_Main in 'Arlan_Main.pas' {Form_Main},
  Arlan_CustomDialog in 'Arlan_CustomDialog.pas' {Form_CustomDialog},
  Arlan_DataModule_Database in 'Arlan_DataModule_Database.pas' {DataModule_Database: TDataModule},
  Arlan_AddDocument in 'Arlan_AddDocument.pas' {Arlan_AddDocumentForm},
  Arlan_EditDocumentParam in 'Arlan_EditDocumentParam.pas' {Arlan_EditDocumentParamForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Арлан (система хранения документов)';
  Application.CreateForm(TForm_Main, Form_Main);
  Application.CreateForm(TDataModule_Database, DataModule_Database);
  Application.CreateForm(TArlan_EditDocumentParamForm, Arlan_EditDocumentParamForm);
  Application.Run;
end.
