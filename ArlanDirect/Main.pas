unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.Actions, Vcl.ActnList;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    ArlanD1: TMenuItem;
    MMConnect: TMenuItem;
    N2: TMenuItem;
    MMExit: TMenuItem;
    MMSetting: TMenuItem;
    MMDirS1: TMenuItem;
    ActionList1: TActionList;
    Action1: TAction;
    procedure MMExitClick(Sender: TObject);
    procedure MMConnectClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MMDirS1Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
  private
    procedure AddItemsM(vMenu:TMainMenu; nmWindow: TMenuItem; nICaption: String; nITag: Integer);
    procedure RefreshMenuItems(mmItems: TMenuItem);
    procedure AddItemsMS(vMenu:TMainMenu; nICaption: String; nITag: Integer);
    procedure SelectSubMenuItems(Sender: TObject);
    procedure AddCatalogItems(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses DBPlace;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  MainForm.Caption := 'Arlan - система хранения документов';
  MMDirS1.Visible := False;
end;

procedure TMainForm.Action1Execute(Sender: TObject);
begin
  ShowMessage('as');
  AddItemsMS(MainMenu1,(Sender as TMenuItem).Caption,(Sender as TMenuItem).Tag);
end;

procedure TMainForm.AddCatalogItems(Sender: TObject);
begin
 MainForm.Caption := InputBox('Заголовок окна',
    'Введите, пожалуйста, заголовок окна:', MainForm.Caption);
end;

procedure TMainForm.AddItemsM(vMenu:TMainMenu; nmWindow: TMenuItem; nICaption: String; nITag: Integer);
var index: integer;
vItems :TMenuItem;
begin
  index := vMenu.Items.IndexOf(nmWindow);
  vItems := TMenuItem.Create(vMenu);
  vMenu.Items.Items[index].Add(vItems);
  vItems.Caption:=nICaption;
  vItems.MenuIndex := nITag;
  vItems.Tag := nITag;
  if (nmWindow = MMDirS1) then
  begin
    if (nICaption = 'Добавить') then
    begin
      vItems.OnClick := AddCatalogItems;
    end
    else
    begin
      vItems.OnClick := SelectSubMenuItems;
    end;
  end;

end;

procedure TMainForm.AddItemsMS(vMenu:TMainMenu; nICaption: String; nITag: Integer);
var index: integer;
vItems :TMenuItem;
begin
  vItems := TMenuItem.Create(vMenu);
  vMenu.Items.Add(vItems);
  vItems.Caption:=nICaption;
  vItems.Tag := nITag;
end;

procedure TMainForm.RefreshMenuItems(mmItems: TMenuItem);
begin
  with DBPlaceModule.FDQueryDef do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from catalog_list order by name_catalog');
    Open;
    while not Eof do
    begin
      AddItemsM(MainMenu1,mmItems,FieldByName('name_catalog').AsString, FieldByName('id_catalog').AsInteger);
      Next;
    end;
    Close;
  end;
  AddItemsM(MainMenu1,mmItems,'-', 99);
  AddItemsM(MainMenu1,mmItems,'Добавить', 100);
end;

procedure TMainForm.SelectSubMenuItems(Sender: TObject);
begin
  AddItemsMS(MainMenu1,(Sender as TMenuItem).Caption,(Sender as TMenuItem).Tag);
  (Sender as TMenuItem).Enabled := False;
end;

procedure TMainForm.MMConnectClick(Sender: TObject);
begin
  if (DBPlaceModule = nil) then
  begin
    try
      DBPlaceModule := TDBPlaceModule.Create(Self);
    except
      ShowMessage('!!! Проблемы с подкючением к БД !!!');
      MMDirS1.Visible := False;
      MMConnect.Enabled := True;
      DBPlaceModule.Free;
      DBPlaceModule := nil;

    end;

    if (DBPlaceModule.FDConnectionDef.Connected = True) then
    begin
      MMDirS1.Visible := True;
      MMConnect.Enabled := False;
      RefreshMenuItems(MMDirS1);
    end
    else
    begin
      ShowMessage('!!! Проблемы с подкючением к БД !!!');
      DBPlaceModule.Free;
      DBPlaceModule := nil;
    end;

  end;
 end;

procedure TMainForm.MMDirS1Click(Sender: TObject);
var dI: Integer;
begin

end;

procedure TMainForm.MMExitClick(Sender: TObject);
begin
  if (DBPlaceModule <> nil) then
  begin
    DBPlaceModule.Free;
  end;
  Self.Close;
end;

end.
