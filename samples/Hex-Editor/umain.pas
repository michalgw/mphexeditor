unit umain;

{$MODE Delphi}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, MPHexEditor, MPHexEditorEx, ActnList, Menus, ToolWin,
  ComCtrls, ImgList, ExtCtrls, ufind, uReplace, StdCtrls, IniFiles, PrintersDlgs;

type
  TfmMain = class(TForm)
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    ActionList1: TActionList;
    MPHexEditorEx1: TMPHexEditorEx;
    acFileOpen: TAction;
    acFileNew: TAction;
    File1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    ImageList1: TImageList;
    OpenDialog1: TOpenDialog;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    acFileSave: TAction;
    Save1: TMenuItem;
    ToolButton3: TToolButton;
    acFileSaveAs: TAction;
    SaveAs1: TMenuItem;
    SaveDialog1: TSaveDialog;
    N1: TMenuItem;
    N2: TMenuItem;
    acFileExit: TAction;
    Exit1: TMenuItem;
    ToolButton4: TToolButton;
    acEditUndo: TAction;
    ToolButton5: TToolButton;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    acEditRedo: TAction;
    ToolButton6: TToolButton;
    Redo1: TMenuItem;
    acEditCopy: TAction;
    N3: TMenuItem;
    Copy1: TMenuItem;
    ToolButton7: TToolButton;
    acEditCut: TAction;
    Cut1: TMenuItem;
    ToolButton8: TToolButton;
    acEditPaste: TAction;
    Paste1: TMenuItem;
    ToolButton9: TToolButton;
    acEditInsertNibble: TAction;
    acEditDeleteNibble: TAction;
    acEditSelectAll: TAction;
    N4: TMenuItem;
    InsertNibble1: TMenuItem;
    DeleteNibble1: TMenuItem;
    SelectAll1: TMenuItem;
    acEditFind: TAction;
    acEditFindNext: TAction;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    N5: TMenuItem;
    Find1: TMenuItem;
    FindNext1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Cut2: TMenuItem;
    Copy2: TMenuItem;
    Paste2: TMenuItem;
    Undo2: TMenuItem;
    Redo2: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    SelectAll2: TMenuItem;
    acEditConvert: TAction;
    N8: TMenuItem;
    Convert1: TMenuItem;
    ToolButton12: TToolButton;
    acViewTranslationEditCustom: TAction;
    View1: TMenuItem;
    mnTranslation: TMenuItem;
    EditCustomTranslation1: TMenuItem;
    N9: TMenuItem;
    acEditReplace: TAction;
    ToolButton13: TToolButton;
    Replace1: TMenuItem;
    acFilePrint: TAction;
    acFilePrintSetup: TAction;
    ToolButton14: TToolButton;
    N10: TMenuItem;
    PagePreview1: TMenuItem;
    Print1: TMenuItem;
    PrintDialog1: TPrintDialog;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PopupMenu2: TPopupMenu;
    acViewOffsetEditFormat: TAction;
    EditOffsetDisplay1: TMenuItem;
    EditOffsetDisplay2: TMenuItem;
    acViewOffsetHex: TAction;
    acViewOffsetDec: TAction;
    acViewOffsetOct: TAction;
    OffsetFormat1: TMenuItem;
    Hex1: TMenuItem;
    Decimal1: TMenuItem;
    Octal1: TMenuItem;
    N11: TMenuItem;
    Octal2: TMenuItem;
    Decimal2: TMenuItem;
    Hex2: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    acViewBytesPerRow: TAction;
    acViewBytesPerColumn: TAction;
    BPR1: TMenuItem;
    BPC1: TMenuItem;
    BPR2: TMenuItem;
    BPC2: TMenuItem;
    acEditGoto: TAction;
    N14: TMenuItem;
    Goto1: TMenuItem;
    acViewReadOnlyView: TAction;
    N16: TMenuItem;
    NoEditing1: TMenuItem;
    N17: TMenuItem;
    NoEditing2: TMenuItem;
    acViewOptions: TAction;
    ToolButton15: TToolButton;
    N18: TMenuItem;
    Options1: TMenuItem;
    acViewBytesPerUnit: TAction;
    BPU1: TMenuItem;
    AboutTMPHexEditor1: TMenuItem;
    acViewUnicode: TAction;
    acViewUnicodeBE: TAction;
    Unicode1: TMenuItem;
    Unicodemode1: TMenuItem;
    UnicodeBigEndian1: TMenuItem;
    acViewBytesPerBlock: TAction;
    BPB1: TMenuItem;
    procedure acFileOpenExecute(Sender: TObject);
    procedure acFileNewExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MPHexEditorEx1Progress(Sender: TObject;
      const ProgressType: TMPHProgressKind; const aName: TFileName;
      const Percent: Byte; var Cancel: Boolean);
    procedure StatusBar1DrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
    procedure acFileSaveExecute(Sender: TObject);
    procedure acFileSaveAsExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure acFileExitExecute(Sender: TObject);
    procedure acEditUndoExecute(Sender: TObject);
    procedure acEditRedoExecute(Sender: TObject);
    procedure acEditCopyExecute(Sender: TObject);
    procedure acEditCutExecute(Sender: TObject);
    procedure acEditPasteExecute(Sender: TObject);
    procedure acEditSelectAllExecute(Sender: TObject);
    procedure acEditInsertNibbleExecute(Sender: TObject);
    procedure acEditDeleteNibbleExecute(Sender: TObject);
    procedure acEditFindExecute(Sender: TObject);
    procedure acEditFindNextExecute(Sender: TObject);
    procedure acEditConvertExecute(Sender: TObject);
    procedure acViewTranslationEditCustomExecute(Sender: TObject);
    procedure acEditReplaceExecute(Sender: TObject);
    procedure acFilePrintSetupExecute(Sender: TObject);
    procedure acFilePrintExecute(Sender: TObject);
    procedure acViewOffsetEditFormatExecute(Sender: TObject);
    procedure acViewOffsetHexExecute(Sender: TObject);
    procedure acViewOffsetDecExecute(Sender: TObject);
    procedure acViewOffsetOctExecute(Sender: TObject);
    procedure acViewBytesPerRowExecute(Sender: TObject);
    procedure acViewBytesPerColumnExecute(Sender: TObject);
    procedure acEditGotoExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure acViewReadOnlyViewExecute(Sender: TObject);
    procedure acViewOptionsExecute(Sender: TObject);
    procedure acViewBytesPerUnitExecute(Sender: TObject);
    procedure AboutTMPHexEditor1Click(Sender: TObject);
    procedure acViewUnicodeExecute(Sender: TObject);
    procedure acViewUnicodeBEExecute(Sender: TObject);
    procedure acViewBytesPerBlockExecute(Sender: TObject);
  private
    { Private-Deklarationen }
    // find storage
    FFindRec: TFindRec;
    // replace storage
    FReplaceRec: TReplaceRec;
    // array of known translations, built at runtime
    FTranslationActions: array[TMPHTranslationKind] of TAction;
    // goto amount
    FGoto: string;
    // storage
    FIni: TMemIniFile;
    // check save file
    function CheckChanges: Boolean;
    // do save file
    function SaveFile(const ForceNewName: Boolean): Boolean;
    // idle handler
    procedure AppIdle(Sender: TObject; var Done: Boolean);
    // translation handler
    procedure TranslationExecute(Sender: TObject);
    // save/restore bookmarks
    procedure LoadBookmarks;
    procedure SaveBookmarks;
    // editor properties storage
    procedure LoadEditorProps;
    procedure SaveEditorProps;
  public
    { Public-Deklarationen }
  end;

var
  fmMain: TfmMain;

implementation

uses uconvert, ucustomtranslation, uprinting, uinputnumber, uOptions, LazFileUtils,
  LCLIntf, LCLType;

{$R *.lfm}

// strings
const
  STR_SAVECHANGES = 'Save changes to %s?';
  STR_CAPTION = 'mirkes.de''s TMPHexEditor component';//'mirkes.de''s little hexer [%s]';
  STR_NOT_FOUND = 'No match found.';
  STR_NUM_REPLACED = '%d replacemets.';
  STR_INP_BPR = 'Change Bytes per row (0=AUTO)';
  STR_INP_BPC = 'Change Bytes per column';
  STR_INP_BPU = 'Change Bytes per unit';
  STR_INP_BPB = 'Change Bytes per block';

  // status bar
  STR_SB_POS  = 'Pos: %s';
  STR_SB_SEL  = 'Sel: %s-%s';
  STR_SB_SIZE = 'Size: %s';
  STR_SB_MOD : array[Boolean] of Char = (' ','*');
  STR_SB_RO : array[Boolean] of Char = (' ','R');
  STR_SB_INS : array[Boolean] of string = ('OVW','INS');

  // menu
  STR_MENU_EDIT_UNDO = 'Undo: %s';
  STR_MENU_EDIT_CONVERT_DATA = 'Convert Data...';
  STR_MENU_EDIT_CONVERT_SEL = 'Convert Selection...';
  STR_MENU_VIEW_BPR = 'Bytes Per Row: %d';
  STR_MENU_VIEW_BPR_AUTO = 'Bytes Per Row: AUTO (%d)';
  STR_MENU_VIEW_BPC = 'Bytes Per Column: %d';
  STR_MENU_VIEW_BPU = 'Bytes Per Unit: %d';
  STR_MENU_VIEW_BPB = 'Bytes Per Block: %d';

  // queries
  STR_QT_OFFSETPREFIX = 'Change Offset Format';
  STR_Q_OFFSETPREFIX = '[r|c|Units%][-|Width!]<Base>:[Prefix]|[Suffix]';

  STR_QT_GOTO = 'Goto';
  STR_Q_GOTO = '[-|+|!]<Amount>';

  // ini
  STR_INI_BOOKMARKS = 'Bookmarks';
  STR_INI_EDITOR    = 'Editor';

  // err->BytesPerUnit (Replace)
  STR_ERR_BPU_FINDTEXT = 'Size of data to search for must be a multiple '+
    'of Bytes per unit';
  STR_ERR_BPU_REPLACETEXT = 'Size of replacement data must be a multiple '+
    'of Bytes per unit';

procedure TfmMain.acFileOpenExecute(Sender: TObject);
begin
  if CheckChanges then
  begin
    SaveBookmarks;
    with OpenDialog1
    do
      if Execute
      then
        with MPHexEditorEx1 do
        begin
          try
            LoadFromFile(OpenDialog1.FileName);
            LoadBookmarks;
          finally
            StatusBar1.Panels[7].Text := '-';
          end;
          if ofReadOnly in Options
          then
            // set readonly in hexeditor if readonly was checked in dialog
            // if unchecked, let the hexeditor decide if it can save the file
            ReadOnlyFile := True;
        end;
  end;
end;

procedure TfmMain.acFileNewExecute(Sender: TObject);
begin
  if CheckChanges then
  begin
    // create a new empty file
    SaveBookmarks;
    MPHexEditorEx1.CreateEmptyFile('');
  end;
end;

function TfmMain.CheckChanges: Boolean;
begin
  with MPHexEditorEx1 do
  begin
    if Modified
    then
      case MessageDlg(Format(STR_SAVECHANGES,[FileName]), mtConfirmation, [mbYes, mbNo, mbCancel],0) of
        mrNo: Result := True;
        mrYes: Result := SaveFile(False);
      else
        Result := False;
      end
    else
      Result := True;
  end;
end;

function TfmMain.SaveFile(const ForceNewName: Boolean): Boolean;
begin
  Result := True;
  with MPHexEditorEx1 do
  try
    if (not Modified) or (not HasFile) or (ReadOnlyFile) or ForceNewName then
    begin
      with SaveDialog1
      do
        if Execute
        then
          SaveToFile(FileName)
        else
          Result := False;
    end
    else
      Save;
  except
    on E: Exception do
    begin
      StatusBar1.Panels[7].Text := '-';
      MPHexEditorEx1.Modified := True;  // saving failed, so modified again
      Result := False;
      Application.ShowException(E);
    end;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
var
  LEnumTrans: TMPHTranslationKind;
  LobjMenuItem: TMenuItem;
begin
  // make sure that MYGRID is not defined in mphexeditor.pas
  Assert(MPHexEditorEx1 is TCustomGrid);

  // (p)reset
  FFindRec.StrData := '';
  FGoto := '+0x100';
  FIni := TMemIniFile.Create(ChangeFileExt(ParamStr(0),'.ini'));

  // create translation actions
  for LEnumTrans := High(TMPHTranslationKind) downto Low(TMPHTranslationKind) do
  begin
    FTranslationActions[LEnumTrans] := TAction.Create(self);
    with FTranslationActions[LEnumTrans] do
    begin
      ActionList := ActionList1;
      Tag := Integer(LEnumTrans);
      Caption := MPHTranslationDesc[LEnumTrans];
      GroupIndex := 1;
      OnExecute := TranslationExecute;

      // add menuitem
      LobjMenuItem := TMenuItem.Create(self);
      with LobjMenuItem do
      begin
        RadioItem := True;
        Action := FTranslationActions[LEnumTrans];
        mnTranslation.Insert(0,LobjMenuItem);
      end;
    end;
  end;

  // set idle handler to update actions and status
  Application.OnIdle := AppIdle;

  // load editor
  LoadEditorProps;

  // check command line
  if (ParamCount in [1,2]) and FileExistsUTF8(ParamStr(1)) { *Converted from FileExists* } then
  begin
    with MPHexEditorEx1 do
    begin
      try
        LoadFromFile(ParamStr(1));
        LoadBookmarks;
      finally
        StatusBar1.Panels[7].Text := '-';
      end;
    end;
    if ParamStr(2) = '/p' then
    begin
      MPHexEditorEx1.PrintOptions.Flags := MPHexEditorEx1.PrintOptions.Flags
        - [pfSelectionOnly, pfCurrentViewOnly];
      PrintPreview(MPHexEditorEx1, acFilePrintSetup, True);
      Application.Terminate;
    end;
  end;
end;

procedure TfmMain.AppIdle(Sender: TObject; var Done: Boolean);
var
  LEnumTrans: TMPHTranslationKind;
begin
  // all actions are processed in this handler
  Done := True;

  with MPHexEditorEx1 do
  begin
    // set form caption to show filename
    Caption := Format(STR_CAPTION,[FileName]);

    // set statusbar
    with StatusBar1 do
    begin
      // Position
      Panels[0].Text := Format(STR_SB_POS,[Trim(GetAnyOffsetString(GetCursorPos))]);
      // size
      Panels[1].Text := Format(STR_SB_SIZE,[Trim(GetAnyOffsetString(DataSize))]);
      // selection
      if SelCount > 0
      then
        Panels[2].Text := Format(STR_SB_SEL,[Trim(GetAnyOffsetString(Min(SelStart, SelEnd))),
          Trim(GetAnyOffsetString(Max(SelStart, SelEnd)))])
      else
        Panels[2].Text := '';
      // changed
      Panels[3].Text := STR_SB_MOD[Modified];
      // readonly
      Panels[4].Text := STR_SB_RO[ReadOnlyFile];
      // ovw/ins
      Panels[5].Text := STR_SB_INS[InsertMode];
      // translation / unicode
      if not UnicodeChars then
        Panels[6].Text := MPHTranslationDescShort[Translation]
      else
      begin
        if UnicodeBigEndian then
          Panels[6].Text := MPH_UC_BE_S
        else
          Panels[6].Text := MPH_UC_S
      end;
    end;

    // update actions - file
    acFileSave.Enabled := HasFile and Modified and not (ReadOnlyView or ReadOnlyFile);
    acFileSaveAs.Enabled := (not ReadOnlyView) and (DataSize > 0);

    acFilePrint.Enabled := DataSize > 0;

    // - edit
    with acEditUndo do
    begin
      Enabled := CanUndo;
      Caption := Format(STR_MENU_EDIT_UNDO,[UndoDescription]);
    end;
    acEditRedo.Enabled := CanRedo;

    acEditCut.Enabled := CanCut;
    acEditCopy.Enabled := CanCopy;
    acEditPaste.Enabled := CanPaste;

    acEditInsertNibble.Enabled := not ReadOnlyView;
    acEditDeleteNibble.Enabled := (DataSize > 0) and (not ReadOnlyView);
    acEditSelectAll.Enabled := DataSize > 0;

    acEditFind.Enabled := DataSize > 0;
    acEditFindNext.Enabled := (DataSize > 0) and (FFindRec.StrData <> '');
    acEditReplace.Enabled := (DataSize > 0) and (not ReadOnlyView);

    with acEditConvert do
    begin
      Enabled := (DataSize > 0) and (not ReadOnlyView);
      if SelCount > 0
      then
        Caption := STR_MENU_EDIT_CONVERT_SEL
      else
        Caption := STR_MENU_EDIT_CONVERT_DATA
    end;

    // - view
    // dynamic translation actions
    for LEnumTrans := Low(TMPHTranslationKind) to High(TMPHTranslationKind)
    do
      with FTranslationActions[LEnumTrans]
      do
        Checked := Integer(Translation) = Tag;

    acViewOffsetHex.Checked := OffsetFormat = MPHOffsetHex;
    acViewOffsetDec.Checked := OffsetFormat = MPHOffsetDec;
    acViewOffsetOct.Checked := OffsetFormat = MPHOffsetOct;

    if AutoBytesPerRow then
      acViewBytesPerRow.Caption := Format(STR_MENU_VIEW_BPR_AUTO,[BytesPerRow])
    else
      acViewBytesPerRow.Caption := Format(STR_MENU_VIEW_BPR,[BytesPerRow]);
    acViewBytesPerColumn.Caption := Format(STR_MENU_VIEW_BPC,[BytesPerColumn]);
    acViewBytesPerUnit.Caption := Format(STR_MENU_VIEW_BPU,[BytesPerUnit]);
    acViewBytesPerBlock.Caption := Format(STR_MENU_VIEW_BPB,[BytesPerBlock]);
    acViewBytesPerUnit.Enabled := not UnicodeChars;
    mnTranslation.Enabled := not UnicodeChars;

    acViewReadOnlyView.Checked := ReadOnlyView;

    acViewUnicode.Checked := UnicodeChars;
    if not acViewUnicode.Checked then
      acViewUnicode.Enabled := ((BytesPerRow mod 2) = 0) and
      ((BytesPerColumn mod 2) = 0)
    else
      acViewUnicode.Enabled := True;
    acViewUnicodeBE.Checked := UnicodeBigEndian;
    acViewUnicodeBE.Enabled := UnicodeChars;
  end;
end;

procedure TfmMain.MPHexEditorEx1Progress(Sender: TObject;
  const ProgressType: TMPHProgressKind; const aName: TFileName;
  const Percent: Byte; var Cancel: Boolean);
begin
  // show progress indicator in statusbar
  StatusBar1.Panels[7].Text := IntToStr(Percent);
  Update;
  // check esc key
  Cancel := LongBool(GetKeyState(VK_MENU) and (not 1));
end;

procedure TfmMain.StatusBar1DrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
var
  LIntProgress: Integer;
  LRctTemp: TRect;
begin
  if Panel.Index = 7 then
  begin
    LIntProgress := StrToIntDef(Panel.Text, -1);
    if LIntProgress > -1 then
    begin
      if LIntProgress = 100
      then
        Panel.Text := '-' // progressing finished
      else
      begin
        // fill percentag of rect
        LRctTemp := Rect;
        InflateRect(LRctTemp,-2,-2);
        with StatusBar.Canvas do
        begin
          Frame3D(LRctTemp, clBtnShadow, clBtnHighlight, 1);
          //InflateRect(LRctTemp,-1,-1);
          with LRctTemp
          do
            Right := Left+Round((Right - Left) / 100 * LIntProgress);
          Brush.Color := clActiveCaption;
          FillRect(LRctTemp);
        end;
      end;
    end;
  end;
end;

procedure TfmMain.acFileSaveExecute(Sender: TObject);
begin
  SaveFile(False);
end;

procedure TfmMain.acFileSaveAsExecute(Sender: TObject);
begin
  SaveFile(True);
end;

procedure TfmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // eventually save modified file
  CanClose := CheckChanges;
  SaveBookmarks;
  if CanClose
  then
    SaveEditorProps;
end;

procedure TfmMain.acFileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.acEditUndoExecute(Sender: TObject);
begin
  MPHexEditorEx1.Undo;
end;

procedure TfmMain.acEditRedoExecute(Sender: TObject);
begin
  MPHexEditorEx1.Redo;
end;

procedure TfmMain.acEditCopyExecute(Sender: TObject);
begin
  MPHexEditorEx1.CBCopy;
end;

procedure TfmMain.acEditCutExecute(Sender: TObject);
begin
  MPHexEditorEx1.CBCut;
end;

procedure TfmMain.acEditPasteExecute(Sender: TObject);
begin
  MPHexEditorEx1.CBPaste;
end;

procedure TfmMain.acEditSelectAllExecute(Sender: TObject);
begin
  MPHexEditorEx1.SelectAll;
end;

procedure TfmMain.acEditInsertNibbleExecute(Sender: TObject);
begin
  with MPHexEditorEx1
  do
    InsertNibble(GetCursorPos, InCharField or ((Col mod 2) = 0));
end;

procedure TfmMain.acEditDeleteNibbleExecute(Sender: TObject);
begin
  with MPHexEditorEx1
  do
    DeleteNibble(GetCursorPos, InCharField or ((Col mod 2) = 0));
end;

procedure TfmMain.acEditFindExecute(Sender: TObject);
var
  LIntSize: Integer;
begin
  if FindGetOptions(FFindRec) then
  begin
    with FFindRec do
    begin
      if not BoolFindText then
      begin
        // convert hex data to string
        SetLength(StrData, Length(StrText));
        UniqueString(StrData);
        ConvertHexToBin(PChar(StrText), PChar(StrData), Length(StrText), MPHexEditorEx1.SwapNibbles, LIntSize);
        SetLength(StrData, LIntSize);
      end;
      if Length(StrData) > 0 then
      begin
        // start find
        acEditFindNext.Enabled := True;
        acEditFindNext.Execute;
      end;
    end;
  end;
end;

procedure TfmMain.acEditFindNextExecute(Sender: TObject);
var
  LIntFound,
    LIntPos: Integer;
  LStrFind: string;
begin
  with MPHexEditorEx1, FFindRec
  do
    if StrData <> '' then
    begin
      LIntPos := Max(0, GetCursorPos);
      if (Length(StrData) = 1) and ((SelCount) = 1)
      then
        Inc(LIntPos);
      if LIntPos >= DataSize
      then
        LIntFound := -1
      else
      begin
        LStrFind := PrepareFindReplaceData(StrData, BoolIgnoreCase, BoolFindText);
        if (Length(LStrFind) mod BytesPerUnit) <> 0 then
        begin
          MessageDlg(STR_ERR_BPU_FINDTEXT, mtError, [mbOK], 0);
          Exit;
        end;
        LIntFound := Find(PChar(LStrFind), Length(LStrFind), LIntPos, DataSize -1,
          BoolIgnoreCase);
      end;
      if LIntFound = -1
      then
        ShowMessage(STR_NOT_FOUND)
      else
      begin
        SelStart := LIntFound + Length(LStrFind)-1;
        SelEnd := LIntFound;
      end;
    end;
end;

procedure TfmMain.acEditConvertExecute(Sender: TObject);
var
  LEnumFrom,
  LEnumTo: TMPHTranslationKind;
  LIntStart,
  LIntEnd: Integer;
begin
  with MPHexEditorEx1 do
  begin
    LEnumFrom := Translation;
    LEnumTo := Translation;
    if SelectConvertTranslation(LEnumFrom, LEnumTo) and (LEnumFrom <> LEnumTo) then
    begin
      if SelCount > 0 then
      begin
        // just selection
        LIntStart := Min(SelStart, SelEnd);
        LIntEnd := Max(SelStart, SelEnd);
      end
      else
      begin
        // whole file
        LIntStart := 0;
        LIntEnd := Pred(DataSize);
      end;
      ConvertRange(LIntStart, LIntEnd, LEnumFrom, LEnumTo);
      if SelCount = 0
      then
        Translation := LEnumTo;
    end;
  end;
end;

procedure TfmMain.acViewTranslationEditCustomExecute(Sender: TObject);
begin
  with MPHexEditorEx1
  do
    if EditCustomTranslation and (Translation = tkCustom)
    then
      Repaint;
end;

procedure TfmMain.TranslationExecute(Sender: TObject);
begin
  with TAction(Sender)
  do
    MPHexEditorEx1.Translation := TMPHTranslationKind(Tag);
end;


procedure TfmMain.acEditReplaceExecute(Sender: TObject);
var
  LIntSize,
  LIntPos,
  LIntDone,
  LIntPos2: Integer;

  LStrFind,
    LStrReplace: string;
begin
  if ReplaceGetOptions(FReplaceRec)
  then
    with MPHexEditorEx1, FReplaceRec do
    try
      if not BoolFindText then
      begin
        // convert hex data to string
        SetLength(StrDataToFind, Length(StrTextToFind));
        UniqueString(StrDataToFind);
        ConvertHexToBin(PChar(StrTextToFind), PChar(StrDataToFind),
          Length(StrTextToFind), SwapNibbles, LIntSize);
        SetLength(StrDataToFind, LIntSize);
      end;
      UniqueString(StrDataToReplace);
      if (not BoolReplaceText) and (StrTextToReplace <> '') then
      begin
        // convert hex data to string
        SetLength(StrDataToReplace, Length(StrTextToReplace));
        ConvertHexToBin(PChar(StrTextToReplace), PChar(StrDataToReplace),
          Length(StrTextToReplace), SwapNibbles, LIntSize);
        SetLength(StrDataToReplace, LIntSize);
      end;

      LStrFind := PrepareFindReplaceData(StrDataToFind, BoolIgnoreCase, BoolFindText);
      LStrReplace := PrepareFindReplaceData(StrDataToReplace, False, BoolReplaceText);

      if BoolReplaceAll
      then
        LIntPos := 0
      else
        LIntPos := Max(0, GetCursorPos);

      LIntDone := 0;

      // check length of data to find and data to replace depending on bytesperunit
      if (Length(LStrFind) mod BytesPerUnit) <> 0 then
      begin
        MessageDlg(STR_ERR_BPU_FINDTEXT, mtError, [mbOK], 0);
        Exit;
      end;

      if (Length(LStrReplace) mod BytesPerUnit) <> 0 then
      begin
        MessageDlg(STR_ERR_BPU_REPLACETEXT, mtError, [mbOK], 0);
        Exit;
      end;

      repeat
        LIntPos2 := Find(PChar(LStrFind), Length(LStrFind), LIntPos, DataSize -1,
          BoolIgnoreCase);
        if LIntPos2 = -1
        then
          Break;
        Inc(LIntDone);
        SelStart := LIntPos2;
        SelEnd := LIntPos2 + Length(LStrFind)-1;
        if LStrReplace <> ''
        then
          ReplaceSelection(PChar(LStrReplace), Length(LStrReplace), '', False)
        else
          DeleteSelection;
        LIntPos := LIntPos2 + Length(LStrReplace);

        with StatusBar1 do
        begin
          Panels[7].Text := IntToStr(Round(LIntPos2/DataSize*100));
          Update;
        end;
      until not BoolReplaceAll;

      if LIntDone = 0
      then
        Raise Exception.Create(STR_NOT_FOUND)
      else
        if BoolReplaceAll
        then
          ShowMessage(Format(STR_NUM_REPLACED,[LIntDone]));
    finally
      StatusBar1.Panels[7].Text := '-';
    end;
end;

procedure TfmMain.acFilePrintSetupExecute(Sender: TObject);
begin
  PrinterSetupDialog1.Execute;
end;

procedure TfmMain.acFilePrintExecute(Sender: TObject);
begin
  PrintPreview(MPHexEditorEx1, acFilePrintSetup, False);
end;

procedure TfmMain.acViewOffsetEditFormatExecute(Sender: TObject);
var
  LStrPrefix: string;
begin
  with MPHexEditorEx1 do
  begin
    LStrPrefix := OffsetFormat;
    if InputQuery(STR_QT_OFFSETPREFIX, STR_Q_OFFSETPREFIX, LStrPrefix)
    then
      OffsetFormat := LStrPrefix;
  end;
end;

procedure TfmMain.acViewOffsetHexExecute(Sender: TObject);
begin
  MPHexEditorEx1.OffsetFormat := MPHOffsetHex;
  MPHexEditorEx1.RulerNumberBase := 16;
end;

procedure TfmMain.acViewOffsetDecExecute(Sender: TObject);
begin
  MPHexEditorEx1.OffsetFormat := MPHOffsetDec;
  MPHexEditorEx1.RulerNumberBase := 10;
end;

procedure TfmMain.acViewOffsetOctExecute(Sender: TObject);
begin
  MPHexEditorEx1.OffsetFormat := MPHOffsetOct;
  MPHexEditorEx1.RulerNumberBase := 8;
end;

procedure TfmMain.LoadBookmarks;
begin
  with MPHexEditorEx1
  do
    if HasFile
    then
      BookMarksAsString := FIni.ReadString(STR_INI_BOOKMARKS, FileName, '')
end;

procedure TfmMain.SaveBookmarks;
begin
  with MPHexEditorEx1
  do
    if HasFile then
    begin
      if BookmarksAsString = ''
      then
        FIni.DeleteKey(STR_INI_BOOKMARKS, FileName)
      else
        FIni.WriteString(STR_INI_BOOKMARKS, FileName, BookmarksAsString)
    end;
end;

procedure TfmMain.acViewBytesPerRowExecute(Sender: TObject);
var
  LIntVal: Integer;
begin
  with MPHexEditorEx1 do
  begin
    LIntVal := BytesPerRow;
    if InputNumber(STR_INP_BPR,LIntVal, 0, 255) then
    begin
      if LIntVal = 0 then
        AutoBytesPerRow := True
      else
      begin
        AutoBytesPerRow := False;
        BytesPerRow := LIntVal
      end;
    end;
  end;
end;

procedure TfmMain.acViewBytesPerColumnExecute(Sender: TObject);
var
  LIntVal: Integer;
begin
  with MPHexEditorEx1 do
  begin
    LIntVal := BytesPerColumn;
    if InputNumber(STR_INP_BPC,LIntVal, 1, 255)
    then
      BytesPerColumn := LIntVal
  end;
end;

procedure TfmMain.acEditGotoExecute(Sender: TObject);
var
  LChrRel: Char;
  LIntPos: Integer;
  LStrTemp: string;
begin
  with MPHexEditorEx1
  do
    if InputQuery(STR_QT_GOTO, STR_Q_GOTO, FGoto) and (FGoto <> '') then
    begin
      LChrRel := #0;
      LStrTemp := FGoto;
      if LStrTemp[1] in ['-','+','!'] then
      begin
        LChrRel := LStrTemp[1];
        Delete(LStrTemp,1,1);
      end;
      //LIntPos := CheckRadixToInt(LStrTemp);
      LIntPos := StrToInt(LStrTemp);
      case LChrRel of
        '-': Seek(-LIntPos, soFromCurrent);
        '+': Seek(LIntPos, soFromCurrent);
        '!': Seek(-LIntPos, soFromEnd);
      else
        Seek(LIntPos, soFromBeginning);
      end;
    end;
end;



procedure TfmMain.FormDestroy(Sender: TObject);
begin
  FIni.UpdateFile;
  FIni.Free;
end;

procedure TfmMain.LoadEditorProps;
var
  LsrlData: TStrings;
begin
  LsrlData := TStringList.Create;
  try
    FIni.ReadSectionValues(STR_INI_EDITOR, LsrlData);
    if LsrlData.Count > 1 then
    try
      MPHexEditorEx1.PropertiesAsString := LsrlData.Text;
    except
    end;
  finally
    LsrlData.Free;
  end;
end;

procedure TfmMain.SaveEditorProps;
var
  LsrlData: TStrings;
  LIntPos: Integer;
begin
  LsrlData := TStringList.Create;
  try
    FIni.EraseSection(STR_INI_EDITOR);
    with LsrlData do
    begin
      Text := MPHexEditorEx1.PropertiesAsString;
      if Count > 0
      then
        for LIntPos := 0 to Pred(Count)
        do
          FIni.WriteString(STR_INI_EDITOR, Names[LIntPos], Values[Names[LIntPos]]);
    end;
  finally
    LsrlData.Free;
  end;
end;

procedure TfmMain.acViewReadOnlyViewExecute(Sender: TObject);
begin
  with MPHexEditorEx1
  do
    ReadOnlyView := not ReadOnlyView;
end;

procedure TfmMain.acViewOptionsExecute(Sender: TObject);
var
  LStrOptions: string;
begin
  with MPHexEditorEx1 do
  begin
    LStrOptions := PropertiesAsString;
    if EditEditorOptions(LStrOptions)
    then
      PropertiesAsString := LStrOptions;
  end;
end;

procedure TfmMain.acViewBytesPerUnitExecute(Sender: TObject);
var
  LIntVal: Integer;
begin
  with MPHexEditorEx1 do
  begin
    LIntVal := BytesPerUnit;
    if InputNumber(STR_INP_BPU,LIntVal, 1, 8)
    then
      BytesPerUnit := LIntVal
  end;
end;

procedure TfmMain.AboutTMPHexEditor1Click(Sender: TObject);
begin
  MessageDlg('TMPHexEditor version:'#13#10+MPHexEditorEx1.Version, mtInformation,[mbOK],0);
end;

procedure TfmMain.acViewUnicodeExecute(Sender: TObject);
begin
  with MPHexEditorEx1 do
    UnicodeChars := not UnicodeChars;
end;

procedure TfmMain.acViewUnicodeBEExecute(Sender: TObject);
begin
  with MPHexEditorEx1 do
    UnicodeBigEndian := not UnicodeBigEndian;
end;


procedure TfmMain.acViewBytesPerBlockExecute(Sender: TObject);
var
  LIntVal: Integer;
begin
  with MPHexEditorEx1 do
  begin
    LIntVal := BytesPerBlock;
    if InputNumber(STR_INP_BPB,LIntVal, -1, BytesPerRow)
    then
      BytesPerBlock := LIntVal
  end;
end;

end.
