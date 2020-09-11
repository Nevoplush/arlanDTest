program ArlanDirect;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  DBPlace in 'DBPlace.pas' {DBPlaceModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
