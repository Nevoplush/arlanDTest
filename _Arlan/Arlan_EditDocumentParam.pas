unit Arlan_EditDocumentParam;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TArlan_EditDocumentParamForm = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Arlan_EditDocumentParamForm: TArlan_EditDocumentParamForm;

implementation

{$R *.dfm}

procedure TArlan_EditDocumentParamForm.Button1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TArlan_EditDocumentParamForm.Button2Click(Sender: TObject);
begin
  Memo1.Clear;
  Self.Close;
end;

procedure TArlan_EditDocumentParamForm.FormShow(Sender: TObject);
begin
  Memo1.Clear;
end;

end.
