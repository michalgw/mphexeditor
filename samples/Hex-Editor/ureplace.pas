unit ureplace;

{$MODE Delphi}

interface

uses
  SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls, Forms;

type
  // search record
  TReplaceRec = record
    StrTextToFind,            // textual format
    StrTextToReplace,
    StrDataToFind,            // real data to find
    StrDataToReplace: string; // real data to replace with
    BoolIgnoreCase,            // ignore upper/lower case
    BoolFindText,
    BoolReplaceText,  // find/replace by text or hex data
    BoolReplaceAll: Boolean;
  end;

  TdlgReplace = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    edFind: TEdit;
    cbFindText: TCheckBox;
    cbNoCase: TCheckBox;
    Label2: TLabel;
    edReplace: TEdit;
    cbReplaceText: TCheckBox;
    Button3: TButton;
    procedure edFindChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    FReplaceAll: Boolean;
  end;

var
  dlgReplace: TdlgReplace;

// create a replace dialog and get options
function ReplaceGetOptions(var Options: TReplaceRec): Boolean;

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

// create a replace dialog and get options
function ReplaceGetOptions(var Options: TReplaceRec): Boolean;
begin
  with TdlgReplace.Create(Application) do
  try
    edFind.Text := Options.StrTextToFind;
    edReplace.Text := Options.StrTextToReplace;

    // if no previous search, gray "find text" to auto determine text/hex
    if Options.StrTextToFind <> ''
    then
      cbFindText.Checked := Options.BoolFindText;
    if Options.StrTextToReplace <> ''
    then
      cbReplaceText.Checked := Options.BoolReplaceText;


    cbNoCase.Checked := Options.BoolIgnoreCase;
    Result := ShowModal = mrOK;
    if Result
    then
      with Options do
      begin
        StrTextToFind := edFind.Text;
        BoolFindText := cbFindText.Checked;

        StrTextToReplace := edReplace.Text;
        BoolReplaceText := cbReplaceText.Checked;

        // eventually find out whether text or hex values (0..9,a..f,' ') are entered
        if cbFindText.State = cbGrayed
        then
          BoolFindText := not IsHex(edFind.Text);
        if cbReplaceText.State = cbGrayed
        then
          BoolReplaceText := not IsHex(edReplace.Text);

        StrDataToFind := StrTextToFind;
        StrDataToReplace := StrTextToReplace;

        BoolIgnoreCase := cbNoCase.Checked;
        BoolReplaceAll := FReplaceAll;
      end;

  finally
    Free;
  end;
end;

procedure TdlgReplace.edFindChange(Sender: TObject);
begin
  Button1.Enabled := edFind.Text <> '';
  Button3.Enabled := edFind.Text <> '';
end;

procedure TdlgReplace.FormCreate(Sender: TObject);
begin
  FReplaceAll := False;
end;

procedure TdlgReplace.Button3Click(Sender: TObject);
begin
  FReplaceAll := True;
end;

end.
