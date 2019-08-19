unit ucustomtranslation;

{$MODE Delphi}

interface

uses
  SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls, Forms, Buttons,
  Grids, MPHexEditor, ComCtrls, ToolWin, Dialogs;

type
  TdlgEditCustomTranslation = class(TForm)
    Button1: TButton;
    Button2: TButton;
    MPHexEditor1: TMPHexEditor;
    ToolBar1: TToolBar;
    btnLoad: TToolButton;
    btnSave: TToolButton;
    btnAuto: TToolButton;
    ToolButton1: TToolButton;
    TabSet1: TTabControl;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    pnPos: TPanel;
    procedure TabSet1Change(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnAutoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FOldIdle: TIdleEvent;
    FCustTrans: TMPHCharConv;
    procedure ShowTable(Index: Integer);
    procedure SetTable(Index: Integer);
    // idle handler
    procedure AppIdle(Sender: TObject; var Done: Boolean);
  end;

var
  dlgEditCustomTranslation: TdlgEditCustomTranslation;

  // edit custom translation
function EditCustomTranslation: Boolean;

implementation
uses umain, inifiles, LazFileUtils;

{$R *.lfm}

const
  STR_ERR_UNKNOWNTABLE = 'Unknown Table Format';
  STR_ERR_TABLEVALNOTUSE =
    'Byte %2x is not used in the table, so i cannot do an 1:1 translation';
  STR_ERR_TABLEVALMULTIPLE =
    'Byte %2x is used multiple times, so icannot do an 1:1 translation';

  // edit custom translation

function EditCustomTranslation: Boolean;
begin
  with TdlgEditCustomTranslation.Create(Application) do
  try
    FCustTrans := MPHCustomCharConv;
    ShowTable(0);
    Result := ShowModal = mrok;
    if Result then
      MPHCustomCharConv := FCustTrans;
  finally
    Free;
  end;
end;

{ TdlgEditCustomTranslation }

procedure TdlgEditCustomTranslation.SetTable(Index: Integer);
begin
  if Index = 0 then
    MPHexEditor1.ReadBuffer(FCustTrans[cctFromAnsi], 0,
      sizeof(FCustTrans[cctFromAnsi]))
  else
    MPHexEditor1.ReadBuffer(FCustTrans[cctToAnsi], 0,
      sizeof(FCustTrans[cctToAnsi]))
end;

procedure TdlgEditCustomTranslation.ShowTable;
var
  LIntLoop: Integer;
begin
  MPHexEditor1.DataSize := sizeof(TMPHCharConvTable);
  if Index = 0 then
    MPHexEditor1.WriteBuffer(FCustTrans[cctFromAnsi], 0,
      sizeof(FCustTrans[cctFromAnsi]))
  else
    MPHexEditor1.WriteBuffer(FCustTrans[cctToAnsi], 0,
      sizeof(FCustTrans[cctToAnsi]));

  for LIntLoop := 0 to 255 do
    MPHexEditor1.ByteChanged[LIntLoop] :=
      MPHexEditor1.Data[LIntLoop] <> LIntLoop;

  MPHexEditor1.Repaint;
end;

procedure TdlgEditCustomTranslation.TabSet1Change(Sender: TObject;
  NewTab: Integer; var AllowChange: Boolean);
var
  LIntPos: Integer;
  LBoolChars: Boolean;
begin
  with MPHexEditor1 do
  begin
    LIntPos := GetCursorPos;
    LBoolChars := InCharField;
    SetTable(TabSet1.TabIndex);
    ShowTable(NewTab);
    Seek(LIntPos, soFromBeginning);
    InCharField := LBoolChars;
  end;
end;

procedure TdlgEditCustomTranslation.btnLoadClick(Sender: TObject);
var
  aIni: TIniFile;
  i: integer;
  s: string;
begin
  with OpenDialog1 do
    if Execute then
    begin
      aIni := TIniFile.Create(FileName);
      with aIni do
      try
        for i := 0 to 255 do
        begin
          s := aIni.ReadString('From_Ansi', '0x' + IntToHex(i, 2),
            '0x' + IntToHex(i, 2));
          FCustTrans[cctFromAnsi][i] := Char(StrToIntDef(s, i));
          s := aIni.ReadString('To_Ansi', '0x' + IntToHex(i, 2),
            '0x' + IntToHex(i, 2));
          FCustTrans[cctToAnsi][i] := Char(StrToIntDef(s, i));
        end;
        ShowTable(TabSet1.TabIndex);
      finally
        Free;
      end;
    end;
end;

procedure TdlgEditCustomTranslation.btnSaveClick(Sender: TObject);
var
  aIni: TIniFile;
  i: integer;
begin
  with SaveDialog1 do
    if Execute then
    begin
      SetTable(TabSet1.TabIndex);
      if FileExistsUTF8(FileName) { *Converted from FileExists* } then
        DeleteFileUTF8(PChar(FileName)); { *Converted from DeleteFile* }
      aIni := TIniFile.Create(FileName);
      with aIni do
      try
        EraseSection('From_Ansi');
        EraseSection('To_Ansi');
        for i := 0 to 255 do
        begin
          aIni.WriteString('From_Ansi', '0x' + IntToHex(i, 2),
            '0x' + IntToHex(Byte(FCustTrans[cctFromAnsi][i]), 2));
          aIni.WriteString('To_Ansi', '0x' + IntToHex(i, 2),
            '0x' + IntToHex(Byte(FCustTrans[cctToAnsi][i]), 2));
        end;
      finally
        Free;
      end;
    end;
end;

procedure TdlgEditCustomTranslation.btnAutoClick(Sender: TObject);
var
  LBytCheck: array[Byte] of Byte;
  LIntLoop,
    LIntLoop1: Integer;
begin
  SetTable(TabSet1.TabIndex);
  // check if the current table is unambigous
  FillChar(LBytCheck, sizeof(LBytCheck), #0);
  for LIntLoop := 0 to 255 do
    if TabSet1.TabIndex = 0 then
      Inc(LBytCheck[Ord(FCustTrans[cctFromAnsi][LIntLoop])])
    else
      Inc(LBytCheck[Ord(FCustTrans[cctToAnsi][LIntLoop])]);
  // whole check array must be set to 1 (else no 1:1 translation)
  for LIntLoop := 0 to 255 do
    case LBytCheck[LIntLoop] of
      0: // not used, whine
        raise Exception.CreateFmt(STR_ERR_TABLEVALNOTUSE, [LIntLoop]);
      1: ; //ok
    else
      for LIntLoop1 := 0 to 255 do
        MPHexEditor1.ByteChanged[LIntLoop1] := MPHexEditor1.Data[LIntLoop1] =
          LIntLoop;
      MPHexEditor1.Repaint;
      raise Exception.CreateFmt(STR_ERR_TABLEVALMULTIPLE, [LIntLoop]);
    end;
  // all ok, create other table
  for LIntLoop := 0 to 255 do
    if TabSet1.TabIndex = 0 then
      FCustTrans[cctToAnsi][Byte(FCustTrans[cctFromAnsi][LIntLoop])] := Char(LIntLoop)
    else
      FCustTrans[cctFromAnsi][Byte(FCustTrans[cctToAnsi][LIntLoop])] := Char(LIntLoop)
end;

procedure TdlgEditCustomTranslation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SetTable(TabSet1.TabIndex);
end;

procedure TdlgEditCustomTranslation.FormCreate(Sender: TObject);
begin
  FOldIdle := Application.OnIdle;
  Application.OnIdle := AppIdle;
end;

procedure TdlgEditCustomTranslation.FormDestroy(Sender: TObject);
begin
  Application.OnIdle := FOldIdle;
end;

procedure TdlgEditCustomTranslation.AppIdle(Sender: TObject;
  var Done: Boolean);
begin
  with MPHexEditor1 do
    pnPos.Caption := IntToHex(GetCursorPos, 2) + ':' +
      IntToHex(Byte(Data[GetCursorPos]), 2)
end;

end.

