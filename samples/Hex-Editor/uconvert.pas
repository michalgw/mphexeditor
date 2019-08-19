unit uconvert;

{$MODE Delphi}

interface

uses
  SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls, Forms, MPHexEditor;

type
  TdlgConvert = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    cbFrom: TComboBox;
    Label2: TLabel;
    cbTo: TComboBox;
    procedure cbFromChange(Sender: TObject);
  end;

var
  dlgConvert: TdlgConvert;

// select a from-to translation
function SelectConvertTranslation(var AFrom, ATo: TMPHTranslationKind): Boolean;

implementation

{$R *.lfm}

// select a from-to translation
function SelectConvertTranslation(var AFrom, ATo: TMPHTranslationKind): Boolean;

  procedure FillCombo(CBox: TComboBox; const Translation: TMPHTranslationKind);
  var
    LEnumTrans: TMPHTranslationKind;
  begin
    with CBox.Items do
    begin
      Clear;
      for LEnumTrans := Low(TMPHTranslationKind) to High(TMPHTranslationKind)
      do
        AddObject(MPHTranslationDesc[LEnumTrans],Pointer(LEnumTrans));
      CBox.ItemIndex := IndexOfObject(Pointer(Translation));
    end;
  end;

begin
  with TdlgConvert.Create(Application) do
  try
    FillCombo(cbFrom, AFrom);
    FillCombo(cbTo, ATo);
    Result := ShowModal = mrOK;
    if Result then
    begin
      AFrom := TMPHTranslationKind(cbFrom.Items.Objects[cbFrom.ItemIndex]);
      ATo := TMPHTranslationKind(cbTo.Items.Objects[cbTo.ItemIndex]);
    end;
  finally
    Free;
  end;
end;

procedure TdlgConvert.cbFromChange(Sender: TObject);
begin
  // check item indices
  Button1.Enabled := cbTo.ItemIndex <> cbFrom.ItemIndex
end;

end.
