unit uOptions;

{$MODE Delphi}

interface

uses
  {Windows, Messages,} SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, MPHexEditor,
  ValEdit, MPHexEditorEx, LCLType;

type

  { TdlgOptions }

  TdlgOptions = class(TForm)
    FontDialog1: TFontDialog;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    cbColors: TComboBox;
    cbFore: TColorButton;
    cbBack: TColorButton;
    GroupBox2: TGroupBox;
    ValueListEditor1: TValueListEditor;
    btnFont: TButton;
    Label1: TLabel;
    Bevel1: TBevel;
    Hexer: TMPHexEditorEx;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure cbColorsSelect(Sender: TObject);
    procedure cbForeSelect(Sender: TObject);
    procedure btnFontClick(Sender: TObject);
    procedure FontDialog1Apply(Sender: TObject; Wnd: HWND);
    procedure ValueListEditor1Validate(Sender: TObject; ACol,
      ARow: Integer; const KeyName, KeyValue: String);
    procedure ValueListEditor1KeyPress(Sender: TObject; var Key: Char);
    procedure ValueListEditor1StringsChange(Sender: TObject);
    procedure HexerQueryPublicProperty(Sender: TObject;
      const PropertyName: String; var IsPublic: Boolean);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure SetProperties;
  end;

var
  dlgOptions: TdlgOptions;

function EditEditorOptions(var Options: string): Boolean;

implementation

function EditEditorOptions(var Options: string): Boolean;
begin
  with TDlgOptions.Create(Application) do
  try
    Hexer.PropertiesAsString := Options;
    SetProperties;
    Result := ShowModal = mrOK;
    if Result
    then
      Options := Hexer.PropertiesAsString;
  finally
    Free;
  end;
end;

const
  // value list strings
  STR_VL_NOSIZECHG = 'Fixed file size';
  STR_VL_SWAPNIBBLES = 'Swap halfbytes (nibbles)';
  STR_VL_SHOWGRID = 'Show grid';
  STR_VL_OLEDND = 'OLE drag and drop';
  STR_VL_CREATEBACKUP = 'Create backups';
  STR_VL_BACKUPEXT = 'Backup file extension';
  STR_VL_CLIPHEX = 'Clipboard text data has Hex format';
  STR_VL_FLUSHCLIP = 'Preserve clipboard contents on close';
  STR_VL_FOREIGNCLIP = 'Support foreign clipboard formats';
  STR_VL_ZOOMONWHEEL = 'Use mouse wheel for zooming';
  STR_VL_MASKCHAR = 'Substitute whiteSpaces by';
  STR_VL_MAXUNDO = 'Max. size of Undo buffer (Byte)';
  STR_VL_HEXLOWER = 'Hex numbers in lower case';
  STR_VL_GUTTER3D = 'Gutter has 3D border';
  STR_VL_RULER = 'Show ruler';
  STR_VL_AUTOBYTESPERROW = 'Automatic row size';

  STR_BOOL: array[Boolean] of string = (
    'No', 'Yes'
  );
{$R *.lfm}

procedure TdlgOptions.FormCreate(Sender: TObject);
var
  LIntLoop: Integer;
  LStrData: string;
  LrecBook:TMPHBookmark;
begin

  LStrData := '';
  for LIntLoop := 0 to 255
  do
    LStrData := LStrData + Char(LIntLoop);

  Hexer.AsText := LStrData;

  Hexer.Seek(0,soFromBeginning);

  LrecBook.mPosition := 2;
  LrecBook.mInCharField := True;
  Hexer.Bookmark[4] := LrecBook;
  Hexer.ByteChanged[1] := True;
end;

procedure TdlgOptions.cbColorsSelect(Sender: TObject);
begin
  Label2.Enabled := True;
  Label3.Enabled := True;
  cbFore.Enabled := True;
  cbBack.Enabled := True;
  cbFore.OnColorChanged := nil;
  cbBack.OnColorChanged := nil;
  with cbColors do
    case ItemIndex of
      0://Offset
      begin
        cbFore.ButtonColor := Hexer.Colors.Offset;
        cbBack.ButtonColor := Hexer.Colors.OffsetBackGround;
      end;
      1://Current Offset
      begin
        cbFore.ButtonColor := Hexer.Colors.CurrentOffset;
        cbBack.ButtonColor := Hexer.Colors.CurrentOffsetBackGround;
      end;
      2://Characters
      begin
        cbFore.ButtonColor := Hexer.Font.Color;
        cbBack.ButtonColor := Hexer.Colors.Background;
      end;
      3://Even Column
      begin
        cbFore.ButtonColor := Hexer.Colors.EvenColumn;
        cbBack.ButtonColor := Hexer.Colors.Background;
      end;
      4://Odd Column
      begin
        cbFore.ButtonColor := Hexer.Colors.OddColumn;
        cbBack.ButtonColor := Hexer.Colors.Background;
      end;
      5://Modified
      begin
        cbFore.ButtonColor := Hexer.Colors.ChangedText;
        cbBack.ButtonColor := Hexer.Colors.ChangedBackground;
      end;
      6://Grid
      begin
        cbFore.ButtonColor := Hexer.Colors.Grid;
        cbBack.ButtonColor := Hexer.Colors.Background;
      end;
      7:
      begin
        cbBack.ButtonColor := Hexer.Colors.ActiveFieldBackground;
        cbFore.Enabled := False;
        Label2.Enabled := False;
      end;
    else
      Label2.Enabled := False;
      Label3.Enabled := False;
      cbFore.Enabled := False;
      cbBack.Enabled := False;
    end;
  cbFore.OnColorChanged := cbForeSelect;
  cbBack.OnColorChanged := cbForeSelect;
end;

procedure TdlgOptions.cbForeSelect(Sender: TObject);
begin
  with cbColors
  do
    case ItemIndex of
      0://Offset
      begin
        Hexer.Colors.Offset := cbFore.ButtonColor;
        Hexer.Colors.OffsetBackGround := cbBack.ButtonColor;
      end;
      1://Current Offset
      begin
        Hexer.Colors.CurrentOffset := cbFore.ButtonColor;
        Hexer.Colors.CurrentOffsetBackGround := cbBack.ButtonColor;
      end;
      2://Characters
      begin
        Hexer.Font.Color := cbFore.ButtonColor;
        Hexer.Colors.Background := cbBack.ButtonColor;
      end;
      3://Even Column
      begin
        Hexer.Colors.EvenColumn := cbFore.ButtonColor;
        Hexer.Colors.Background := cbBack.ButtonColor;
      end;
      4://Odd Column
      begin
        Hexer.Colors.OddColumn := cbFore.ButtonColor;
        Hexer.Colors.Background := cbBack.ButtonColor;
      end;
      5://Modified
      begin
        Hexer.Colors.ChangedText := cbFore.ButtonColor;
        Hexer.Colors.ChangedBackground := cbBack.ButtonColor;
      end;
      6://Grid
      begin
        Hexer.Colors.Grid := cbFore.ButtonColor;
        Hexer.Colors.Background := cbBack.ButtonColor;
      end;
      7: Hexer.Colors.ActiveFieldBackground := cbBack.ButtonColor;
    end;
end;

procedure TdlgOptions.btnFontClick(Sender: TObject);
var
  LfntTemp: TFont;
begin
  LfntTemp := TFont.Create;
  try
    LfntTemp.Assign(Hexer.Font);
    with FontDialog1 do
    begin
//      Device := fdScreen;
      Options := Options+[fdApplyButton];
      Font.Assign(LfntTemp);
      if Execute
      then
        Hexer.Font.Assign(Font)
      else
        Hexer.Font.Assign(LfntTemp);
    end;
  finally
    LfntTemp.Free;
  end;
end;

procedure TdlgOptions.FontDialog1Apply(Sender: TObject; Wnd: HWND);
begin
  Hexer.Font.Assign(FontDialog1.Font);
end;

procedure TdlgOptions.SetProperties;

  procedure AddBool(const Key: string; const Value: Boolean);
  var
    LIntRow: Integer;
  begin
    with ValueListEditor1 do
    begin
      LIntRow := Strings.Add(Key+'='+STR_BOOL[Value]);
      with ItemProps[LIntRow] do
      begin
        EditStyle := esPickList;
        PickList.Text := STR_BOOL[False]+#13#10+STR_BOOL[True];
        ReadOnly := True;
      end;
    end;
  end;

  procedure AddString(const Key, Value: string);
  begin
    ValueListEditor1.Strings.Add(Key+'='+Value)
  end;

begin
  cbColors.ItemIndex := 0;
  cbColorsSelect(cbColors);
  ValueListEditor1.Clear;
  with Hexer do
  begin
    AddBool(STR_VL_NOSIZECHG, NoSizeChange);
    AddBool(STR_VL_SWAPNIBBLES, SwapNibbles);
    AddBool(STR_VL_SHOWGRID, DrawGridLines);
    AddBool(STR_VL_OLEDND, OleDragDrop);
    AddBool(STR_VL_CREATEBACKUP, CreateBackup);
    AddString(STR_VL_BACKUPEXT, BackupExtension);
    AddBool(STR_VL_CLIPHEX, ClipboardAsHexText);
    AddBool(STR_VL_FLUSHCLIP, FlushClipboardAtShutDown);
    AddBool(STR_VL_FOREIGNCLIP, SupportsOtherClipFormats);
    AddBool(STR_VL_ZOOMONWHEEL, ZoomOnWheel);
    AddString(STR_VL_MASKCHAR, MaskChar);
    AddString(STR_VL_MAXUNDO, IntToStr(MaxUndo));
    AddBool(STR_VL_HEXLOWER, HexLowerCase);
    AddBool(STR_VL_GUTTER3D, DrawGutter3D);
    AddBool(STR_VL_RULER, ShowRuler);
    AddBool(STR_VL_AUTOBYTESPERROW, AutoBytesPerRow);
  end;
  Hexer.AllowInsertMode := False;
  Hexer.ReadOnlyView := True;
  Hexer.ByteChanged[1] := True;
end;

procedure TdlgOptions.ValueListEditor1Validate(Sender: TObject; ACol,
  ARow: Integer; const KeyName, KeyValue: String);
begin
  with Hexer
  do
    case ARow of
      1: NoSizeChange := KeyValue = STR_BOOL[True];
      2: SwapNibbles := KeyValue = STR_BOOL[True];
      3: DrawGridLines := KeyValue = STR_BOOL[True];
      4: OleDragDrop := KeyValue = STR_BOOL[True];
      5: CreateBackup := KeyValue = STR_BOOL[True];
      6: BackupExtension := KeyValue;
      7: ClipboardAsHexText := KeyValue = STR_BOOL[True];
      8: FlushClipboardAtShutDown := KeyValue = STR_BOOL[True];
      9: SupportsOtherClipFormats := KeyValue = STR_BOOL[True];
      10: ZoomOnWheel := KeyValue = STR_BOOL[True];
      11: MaskChar := (KeyValue+#0)[1];
      12: MaxUndo := StrToInt('0'+KeyValue);
      13: HexLowerCase := KeyValue = STR_BOOL[True];
      14: DrawGutter3D := KeyValue = STR_BOOL[True];
      15: ShowRuler := KeyValue = STR_BOOL[True];
      16: AutoBytesPerRow := KeyValue = STR_BOOL[True];
  end;
end;

procedure TdlgOptions.ValueListEditor1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13
  then
    with ValueListEditor1
    do
      ValueListEditor1Validate(ValueListEditor1, Col, Row, Keys[Row],Values[Keys[Row]]);
end;

procedure TdlgOptions.ValueListEditor1StringsChange(Sender: TObject);
begin
  with ValueListEditor1
  do
    if Values[Keys[Row]] <> ''
    then
      ValueListEditor1Validate(ValueListEditor1, Col, Row, Keys[Row],Values[Keys[Row]]);

end;

procedure TdlgOptions.HexerQueryPublicProperty(Sender: TObject;
  const PropertyName: String; var IsPublic: Boolean);
const
  // properties not to get/set
  NO_PROPS = ';ReadOnlyView;AllowInsertMode;CaretKind;InsertMode;';
begin
  IsPublic := Pos(';'+LowerCase(PropertyName)+';', LowerCase(NO_PROPS)) = 0;
end;

end.
