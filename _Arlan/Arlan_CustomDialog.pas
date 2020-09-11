unit Arlan_CustomDialog;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons;

type
  TForm_CustomDialog = class(TForm)
    SB_Cancel: TSpeedButton;
    procedure SB_CancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_CustomDialog: TForm_CustomDialog;

implementation

{$R *.dfm}

procedure TForm_CustomDialog.SB_CancelClick(Sender: TObject);
begin
  Self.Close;
end;

end.
