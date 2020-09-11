unit Arlan_AddDocument;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, ComObj;

type
  TArlan_AddDocumentForm = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    Label2: TLabel;
    DataSource1: TDataSource;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    CatalogId: Integer;
    DocumentTypeId: Integer;
    function FindAndReplace(FindText,ReplaceText:string):boolean;
    { Public declarations }
  end;

var
  Arlan_AddDocumentForm: TArlan_AddDocumentForm;

implementation

{$R *.dfm}

uses Arlan_DataModule_Database, Arlan_EditDocumentParam, Arlan_Main;

var Word, Excel, WorkSheet: variant;
DocumentShablon, tmpfilename: String;

function TArlan_AddDocumentForm.FindAndReplace(FindText,ReplaceText:string):boolean;
  const wdReplaceAll = 2;
begin
  Word.Selection.Find.MatchSoundsLike := False;
  Word.Selection.Find.MatchAllWordForms := False;
  Word.Selection.Find.MatchWholeWord := False;
  Word.Selection.Find.Format := False;
  Word.Selection.Find.Forward := True;
  Word.Selection.Find.ClearFormatting;
  Word.Selection.Find.Text:=FindText;
  Word.Selection.Find.Replacement.Text:=ReplaceText;
  FindAndReplace:=Word.Selection.Find.Execute(Replace:=wdReplaceAll);
end;

procedure TArlan_AddDocumentForm.Button1Click(Sender: TObject);
begin
  Self.Close;
end;

procedure TArlan_AddDocumentForm.Button2Click(Sender: TObject);
begin

  if (VarIsNull(Word) = False) then
  begin
    if (VarIsEmpty(Word) = False) then
    begin
      Word.ActiveDocument.Save;
      Word.Quit;
      DeleteFile(pchar(tmpfilename));
    end;

  end;
  Self.Close;
end;

procedure TArlan_AddDocumentForm.ComboBox1Select(Sender: TObject);
var FileGUID : TGUID;
begin

  Label2.Caption := '';
//  ShowMessage(IntToStr(integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex])));
  DocumentTypeId := integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]);
//открываем шаблон
  //получение имени шаблона
  with DataModule_Database.FDQuery3 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select document_shablon from document_type_list where document_type_id='+IntToStr(DocumentTypeId)+'');
    Open;
    while not Eof do
    begin
      DocumentShablon := FieldByName('document_shablon').AsString;
      Next;
    end;
    Close;
  end;
  if (FileExists('content\tmpdoc\'+DocumentShablon)) then
  begin
      CreateGUID(FileGUID);
      tmpfilename := ExtractFileDir(Application.ExeName) + '\content\basefile\'+GUIDToString(FileGUID)+'.docx';
      CopyFile(Pchar(ExtractFileDir(Application.ExeName) + '\content\tmpdoc\'+DocumentShablon), Pchar(tmpfilename), false) ;

      try
        Word := CreateOleObject('Word.Application');
        Word.Documents.Open(tmpfilename);
        Word.Visible := True;
        Label2.Font.Color := clGreen;
        Label2.Caption := 'шаблон загружен';
      except
        ShowMessage('Не могу запустить Microsoft Word');
      end;
  end
  else
  begin
    Label2.Font.Color := clRed;
    Label2.Caption := 'шаблон не найден!!!';
  end;
  Application.ProcessMessages;

  if (VarIsNull(Word) = False) then
  begin

    with DataModule_Database.FDQuery3 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from document_parametrs where dp_document_type='+IntToStr(DocumentTypeId)+'');
      Open;
    end;
    DataSource1.Enabled := False;
    DataSource1.DataSet := DataModule_Database.FDQuery3;
    DataSource1.Enabled := True;
  end;


end;

procedure TArlan_AddDocumentForm.DBGrid1DblClick(Sender: TObject);
var ParamSearch, ValueParam: String;
begin
  ParamSearch := '%'+DBGrid1.DataSource.DataSet.FieldByName('dp_name').AsString+'%';
  try
    Arlan_EditDocumentParamForm := TArlan_EditDocumentParamForm.Create(Self);
    Arlan_EditDocumentParamForm.Caption := 'Значение параметра: ' + DBGrid1.DataSource.DataSet.FieldByName('dp_caption').AsString;
    Arlan_EditDocumentParamForm.ShowModal;
  finally
    ValueParam := trim(Arlan_EditDocumentParamForm.Memo1.Text);
    if (ValueParam <> '') then
    begin
      FindAndReplace(ParamSearch,ValueParam);
      ComboBox1.Enabled := False;
    end;
  end;
end;

procedure TArlan_AddDocumentForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DataSource1.Enabled := False;
  if (ComboBox1.Enabled = False) then
  begin
    Word.ActiveDocument.Save;
    Word.Quit;

    with DataModule_Database.FDQuery3 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('insert into document_list (document_name,document_type_id,document_link, cil_id) values ');
      SQL.Add('(');
      SQL.Add(' '''+ExtractFileName(tmpfilename)+''', '+IntToStr(DocumentTypeId)+', '''+tmpfilename+''', ');
      SQL.Add(''+IntToStr(CatalogTag)+'');
      SQL.Add(')');
      Execute;
      Close;
    end;

  end;
end;

procedure TArlan_AddDocumentForm.FormShow(Sender: TObject);
begin
  Label2.Caption := '';

  ComboBox1.Clear;
  ComboBox1.Items.AddObject('--- выбрать ---', TObject(0));

  with DataModule_Database.FDQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from document_type_list where catalog_id='+IntToStr(CatalogId)+' order by document_type_name');
    Open;
      while not Eof do
      begin
        ComboBox1.Items.AddObject(FieldByName('document_type_name').AsString, TObject(FieldByName('document_type_id').AsInteger));
        Next;
      end;
    Close;
  end;

  ComboBox1.ItemIndex := 0;
end;

end.
