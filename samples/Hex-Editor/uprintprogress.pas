unit uprintprogress;

{$MODE Delphi}

interface

uses
  SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls, Forms,
  MPHexEditorEx, ComCtrls, LCLType, LMessages;

type
  TdlgPrintProgress = class(TForm)
    Button2: TButton;
    lbPrinting: TLabel;
    ProgressBar1: TProgressBar;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FFrom,
    FTo: Integer;
    FCancel: Boolean;
    FEditor: TMPHexEditorEx;
    procedure WMUser1(var Msg: TMsg); message LM_USER+1;
  end;

var
  dlgPrintProgress: TdlgPrintProgress;

// do printing
function DoPrint(Editor: TMPHexEditorEx; const PageFrom, PageTo: Integer): Boolean;

implementation
uses
  Printers, LCLIntf;

{$R *.lfm}

const
  STR_PRINTING = 'Printing page %d of %d';
  STR_PRINTTITLE = 'TMPHexEditorEx Print Job';
  
// do printing
function DoPrint(Editor: TMPHexEditorEx; const PageFrom, PageTo: Integer): Boolean;
begin
  with TdlgPrintProgress.Create(Application) do
  try
    FEditor := Editor;
    FFrom := PageFrom;
    FTo := PageTo;
    Result := (ShowModal = mrOK) and (not FCancel);
  finally
    Free;
  end;
end;

procedure TdlgPrintProgress.FormCreate(Sender: TObject);
begin
  FCancel := False;
end;

procedure TdlgPrintProgress.Button2Click(Sender: TObject);
begin
  FCancel := True;
  ModalResult := mrCancel;
end;

procedure TdlgPrintProgress.FormShow(Sender: TObject);
begin
  PostMessage(Handle, WM_USER+1,0,0);
end;

procedure TdlgPrintProgress.WMUser1(var Msg: TMsg);
var
  LIntLoop: Integer;
begin
  Printer.Title := STR_PRINTTITLE;
  Printer.BeginDoc;
  try
    ProgressBar1.Min := FFrom;
    ProgressBar1.Max := FTo;
    for LIntLoop := FFrom to FTo do
    begin
      ProgressBar1.Position := LIntLoop;
      lbPrinting.Caption := Format(STR_PRINTING,[LIntLoop,FTo]);
      Application.ProcessMessages;
      if FCancel
      then
        Break;
      try
        FEditor.Print(LIntLoop);
      except
        ModalResult := mrCancel;
        Break;
      end;
      if LIntLoop < FTo
      then
        Printer.NewPage;
    end;
  finally
    if FCancel then
    begin
      Printer.Abort;
      ModalResult := mrCancel
    end
    else
    begin
      Printer.EndDoc;
      ModalResult := mrOK;
    end;
  end;
end;

end.
