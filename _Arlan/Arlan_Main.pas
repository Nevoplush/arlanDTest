unit Arlan_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls,
  Vcl.Menus, Vcl.Imaging.pngimage, System.ImageList, Vcl.ImgList, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.DBCGrids, ComObj;

type
  TForm_Main = class(TForm)
    Panel_MainMenu: TPanel;
    Panel1: TPanel;
    Image1: TImage;
    PopupMenu_Main: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    Bevel5: TBevel;
    Panel5: TPanel;
    Panel6: TPanel;
    Splitter1: TSplitter;
    Panel7: TPanel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Image6: TImage;
    Bevel1: TBevel;
    Image7: TImage;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    procedure BitBtn1Click(Sender: TObject);
    procedure Panel1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N2Click(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure Panel3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Panel4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Image3Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image3MouseEnter(Sender: TObject);
    procedure Image3MouseLeave(Sender: TObject);
    procedure Image4MouseEnter(Sender: TObject);
    procedure Image4MouseLeave(Sender: TObject);
    procedure Image2MouseEnter(Sender: TObject);
    procedure Image2MouseLeave(Sender: TObject);
    procedure Image5MouseEnter(Sender: TObject);
    procedure Image5MouseLeave(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure Image6MouseEnter(Sender: TObject);
    procedure Image6MouseLeave(Sender: TObject);
    procedure Image7MouseEnter(Sender: TObject);
    procedure Image7MouseLeave(Sender: TObject);
    procedure Image6Click(Sender: TObject);
    procedure Image7Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid2DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Main: TForm_Main;
  customWSstate: integer; //0 - normal; 1 - min; 2 - max
  CatalogTag: Integer;

implementation

{$R *.dfm}

uses Arlan_DataModule_Database, Arlan_CustomDialog, Arlan_AddDocument;
var WordOpen, ExcelOpen, WorkSheetOpen: variant;


procedure TForm_Main.BitBtn1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TForm_Main.DBGrid1DblClick(Sender: TObject);
begin
  DataSource2.Enabled := False;
  DataSource2.DataSet := DataModule_Database.FDQuery4;

  if (DBGrid1.DataSource.DataSet.Fields[0].AsInteger <> CatalogTag) then
  begin
    Label3.Caption := DBGrid1.DataSource.DataSet.Fields[1].AsString;
    Label3.Visible := True;
    CatalogTag := DBGrid1.DataSource.DataSet.Fields[0].AsInteger;
  end;

  Bevel1.Visible := True;
  Image7.Visible := True;

  with DataModule_Database.FDQuery4 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select dl.*, (select document_type_name from document_type_list dtl where dtl.document_type_id=dl.document_type_id) as document_type from document_list dl');
    SQL.Add(' where cil_id='+IntToStr(CatalogTag)+'');
    Open;
  end;
  DataSource2.Enabled := True;

end;

procedure TForm_Main.DBGrid2DblClick(Sender: TObject);
begin
  if (DataSource2.DataSet.RecordCount <> 0) then
  begin

    try
      WordOpen := CreateOleObject('Word.Application');
      WordOpen.Documents.Open(DataSource2.DataSet.FieldByName('document_link').AsString);
      WordOpen.Visible := True;
      except
        ShowMessage('Не могу запустить Microsoft Word');
      end;
  end;
end;

procedure TForm_Main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DataSource1.Enabled := False;
  DataSource2.Enabled := False;
end;

procedure TForm_Main.FormShow(Sender: TObject);
begin
  Self.WindowState := wsNormal;
  customWSstate := 0;
  Panel1.Caption := 'Arlan (система хранения документов)';
  Panel5.Visible := False;
//  Label3.Visible := False;
//  Label2.Visible := False;
  Panel6.Visible := False;
  Panel7.Visible := False;

  Image6.Visible := False;

  Bevel1.Visible := False;
  Image7.Visible := False;


  CatalogTag := 0;
  DataSource1.Enabled := False;
  DataSource2.Enabled := False;

end;

procedure TForm_Main.Image2Click(Sender: TObject);
begin
  DataModule_Database.FDQuery1.Close;
  DataModule_Database.FDConnection1.Connected := False;
  Self.Close;
end;

procedure TForm_Main.Image2MouseEnter(Sender: TObject);
begin
  Image2.Picture.LoadFromFile('content/image/ar_studio_close_32x32_p34x34_v1_down.png');
end;

procedure TForm_Main.Image2MouseLeave(Sender: TObject);
begin
  Image2.Picture.LoadFromFile('content/image/ar_studio_close_32x32_p34x34_v1.png');
end;

procedure TForm_Main.Image3Click(Sender: TObject);
begin
  if (customWSstate = 0) then
  begin
    Form_Main.WindowState := wsMaximized;
    Image3.Picture.LoadFromFile('content/image/ar_studio_norm_32x32_p34x34_v1.png');
    customWSstate := 2;
  end
  else
  begin
    Form_Main.WindowState := wsNormal;
    Image3.Picture.LoadFromFile('content/image/ar_studio_max_32x32_p34x34_v1.png');
    customWSstate := 0;
  end;
end;

procedure TForm_Main.Image3MouseEnter(Sender: TObject);
begin
  if (customWSstate = 2) then
  begin
    Image3.Picture.LoadFromFile('content/image/ar_studio_norm_32x32_p34x34_v1_down.png');
  end
  else
  begin
    Image3.Picture.LoadFromFile('content/image/ar_studio_max_32x32_p34x34_v1_down.png');
  end;
end;

procedure TForm_Main.Image3MouseLeave(Sender: TObject);
begin
  if (customWSstate = 2) then
  begin
    Image3.Picture.LoadFromFile('content/image/ar_studio_norm_32x32_p34x34_v1.png');
  end
  else
  begin
    Image3.Picture.LoadFromFile('content/image/ar_studio_max_32x32_p34x34_v1.png');
  end;
end;

procedure TForm_Main.Image4Click(Sender: TObject);
begin
  Form_Main.WindowState := wsMinimized;
  customWSstate := 1;
end;

procedure TForm_Main.Image4MouseEnter(Sender: TObject);
begin
  Image4.Picture.LoadFromFile('content/image/ar_studio_min_32x32_p34x34_v1_down.png');
end;

procedure TForm_Main.Image4MouseLeave(Sender: TObject);
begin
  Image4.Picture.LoadFromFile('content/image/ar_studio_min_32x32_p34x34_v1.png');
end;

procedure TForm_Main.Image5Click(Sender: TObject);
begin
  CatalogTag := 0;
  Label3.Visible := False;
  DataSource2.Enabled := False;
  Bevel1.Visible := False;
  Image7.Visible := False;

  try
    DataModule_Database.FDConnection1.Connected := True;
  except
    DataModule_Database.FDConnection1.Connected := False;
  end;

  if (DataModule_Database.FDConnection1.Connected = True) then
  begin

    //Panel5.Caption := '  Общий каталог /';
    Panel5.Visible := True;
    Panel6.Visible := True;
    Panel7.Visible := True;

    DataModule_Database.FDQuery1.Close;
    DataModule_Database.FDQuery1.SQL.Clear;
    DataModule_Database.FDQuery1.SQL.Add('select * from catalog_list order by name_catalog');
    DataModule_Database.FDQuery1.Open;
    DBGrid1.Columns.Clear;
    DBGrid1.Columns.Add;
    DBGrid1.Columns[0].FieldName := 'name_catalog';

    DataSource1.Enabled := True;

    Image6.Visible := True;

  end
  else
  begin
    Form_CustomDialog.ShowModal;
  end;

end;

procedure TForm_Main.Image5MouseEnter(Sender: TObject);
begin
  Image5.Picture.LoadFromFile('content/image/ar_studio_catalog_32x32_p34x34_v1_down.png');
end;

procedure TForm_Main.Image5MouseLeave(Sender: TObject);
begin
  Image5.Picture.LoadFromFile('content/image/ar_studio_catalog_32x32_p34x34_v1.png');
end;

procedure TForm_Main.Image6Click(Sender: TObject);
var
  s: string;
  id_catalog: Integer;
begin
    if not InputQuery('Наименование раздела',
    'Введите, пожалуйста, наименование раздела:', s)
        then s := '';

    if (trim(s) <> '') then
    begin
      DataModule_Database.FDQuery2.Close;
      DataModule_Database.FDQuery2.SQL.Clear;
      DataModule_Database.FDQuery2.SQL.Add('select max(id_catalog) from catalog_list');
      DataModule_Database.FDQuery2.Open;
        id_catalog := DataModule_Database.FDQuery2.Fields[0].AsInteger;
      DataModule_Database.FDQuery2.Close;

      DataModule_Database.FDQuery2.SQl.Clear;
      DataModule_Database.FDQuery2.SQL.Add('insert into catalog_list (id_catalog, name_catalog) values ('+IntToStr(id_catalog + 1)+', '''+s+''' )');
      DataModule_Database.FDQuery2.Execute;
      DataModule_Database.FDQuery2.Close;
    end;

  Label3.Visible := False;
  CatalogTag := 0;
  Image5Click(nil);

end;

procedure TForm_Main.Image6MouseEnter(Sender: TObject);
begin
  Image6.Picture.LoadFromFile('content/image/ar_studio_catalog_add_32x32_p34x34_v1_down.png');
end;

procedure TForm_Main.Image6MouseLeave(Sender: TObject);
begin
  Image6.Picture.LoadFromFile('content/image/ar_studio_catalog_add_32x32_p34x34_v1.png');
end;

procedure TForm_Main.Image7Click(Sender: TObject);
begin
  try
    Arlan_AddDocumentForm := TArlan_AddDocumentForm.Create(Self);
    Arlan_AddDocumentForm.CatalogId := CatalogTag;
    Arlan_AddDocumentForm.ShowModal;
  finally
    Arlan_AddDocumentForm.Free;
    DBGrid1DblClick(nil);
  end;
end;

procedure TForm_Main.Image7MouseEnter(Sender: TObject);
begin
  Image7.Picture.LoadFromFile('content/image/ar_studio_document_add_32x32_p34x34_v1_down.png');
end;

procedure TForm_Main.Image7MouseLeave(Sender: TObject);
begin
  Image7.Picture.LoadFromFile('content/image/ar_studio_document_add_32x32_p34x34_v1.png');
end;

procedure TForm_Main.Label1Click(Sender: TObject);
begin
  Label3.Visible := False;
  CatalogTag := 0;
  Image5Click(nil);
end;

procedure TForm_Main.N2Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TForm_Main.Panel1DblClick(Sender: TObject);
begin
  Form_Main.WindowState := wsMaximized;
end;

procedure TForm_Main.Panel1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Form_Main.perform(WM_SysCommand,$F012,0);
end;

procedure TForm_Main.Panel3MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Form_Main.perform(WM_SysCommand,$F002,0);
end;

procedure TForm_Main.Panel4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ReleaseCapture;
  Form_Main.perform(WM_SysCommand,$F006,0);
end;

end.
