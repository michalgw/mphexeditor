unit uinputnumber;

{$MODE Delphi}

interface

uses
  SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls, Forms, MPHexEditor,
  ComCtrls;

type
  TdlgInputNumber = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    UpDown1: TUpDown;
  end;

var
  dlgInputNumber: TdlgInputNumber;

// select a number
function InputNumber(const AText: string; var Number: Integer; const Min, Max: Integer): Boolean;

implementation

{$R *.lfm}

// select a number
function InputNumber(const AText: string; var Number: Integer; const Min, Max: Integer): Boolean;
begin
  with TdlgInputNumber.Create(Application) do
  try
    UpDown1.Min := Min;
    UpDown1.Max := Max;
    UpDown1.Position := Number;
    Edit1.Text := IntToStr(Number);
    Caption := AText;
    Result := ShowModal = mrOK;
    if Result
    then
      Number := UpDown1.Position
  finally
    Free;
  end;
end;

end.
