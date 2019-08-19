unit ufind;

{$MODE Delphi}

interface

uses
  SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls, Forms;

type
  // search record
  TFindRec = record
    StrText,              // textual format
    StrData: string;      // real data to find
    BoolIgnoreCase,        // ignore upper/lower case
    BoolFindText: Boolean; // find text or hex data
  end;

  TdlgFind = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    edFind: TEdit;
    cbText: TCheckBox;
    cbNoCase: TCheckBox;
    procedure edFindChange(Sender: TObject);
  end;

var
  dlgFind: TdlgFind;

// create a find dialog and get options
function FindGetOptions(var Options: TFindRec): Boolean;

implementation

{$R *.lfm}

// determine if a text contains only hex chars and ' '
function IsHex(const Str: string): Boolean;
var
  LIntLoop: Integer;
begin
  Result := Trim(Str) <> '';
  if Result
  then
    for LIntLoop := 1 to Length(Str)
    do
      if not (Str[LIntLoop] in ['0'..'9',' ','a'..'f','A'..'F']) then
      begin
        Result := False;
        Break;
      end;
end;

// create a find dialog and get options
function FindGetOptions(var Options: TFindRec): Boolean;
begin
  with TdlgFind.Create(Application) do
  try
    edFind.Text := Options.StrText;

    // if no previous search, gray "find text" to auto determine text/hex
    if Options.StrText <> ''
    then
      cbText.Checked := Options.BoolFindText;

    cbNoCase.Checked := Options.BoolIgnoreCase;
    Result := ShowModal = mrOK;
    if Result
    then
      with Options do
      begin
        StrText := edFind.Text;
        BoolFindText := cbText.Checked;

        // eventually find out whether text or hex values (0..9,a..f,' ') are entered
        if cbText.State = cbGrayed
        then
          BoolFindText := not IsHex(edFind.Text);

        StrData := StrText;

        BoolIgnoreCase := cbNoCase.Checked;
      end;

  finally
    Free;
  end;
end;

procedure TdlgFind.edFindChange(Sender: TObject);
begin
  Button1.Enabled := edFind.Text <> '';
end;

end.
