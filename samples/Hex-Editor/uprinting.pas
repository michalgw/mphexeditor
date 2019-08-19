unit uprinting;

{$MODE Delphi}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  MPHexEditorEx, ActnList, ExtCtrls, StdCtrls, Buttons, ComCtrls, LMessages,
  LCLType;

type
  TfmPrinting = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    rbPrintAllPages: TRadioButton;
    rbPrintCurrentPage: TRadioButton;
    rbPrintSelection: TRadioButton;
    GroupBox2: TGroupBox;
    edMarginTop: TEdit;
    edMarginLeft: TEdit;
    edMarginRight: TEdit;
    edMarginBottom: TEdit;
    btnSetup: TBitBtn;
    cbColors: TCheckBox;
    cbBack: TCheckBox;
    cbSelBold: TCheckBox;
    edPage: TEdit;
    udPage: TUpDown;
    Label1: TLabel;
    lbPageNum: TLabel;
    Button1: TButton;
    Button2: TButton;
    FontDialog1: TFontDialog;
    sbPreview: TScrollBox;
    imgPreview: TImage;
    Label2: TLabel;
    edZoom: TEdit;
    udZoom: TUpDown;
    Button3: TButton;
    Label3: TLabel;
    edPageHeader: TEdit;
    Label4: TLabel;
    edPageFooter: TEdit;
    rbPrintCurrentView: TRadioButton;
    cbPrintRuler: TCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbPreviewResize(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure cbSelBoldClick(Sender: TObject);
    procedure cbBackClick(Sender: TObject);
    procedure cbColorsClick(Sender: TObject);
    procedure udPageClick(Sender: TObject; Button: TUDBtnType);
    procedure rbPrintSelectionClick(Sender: TObject);
    procedure udZoomClick(Sender: TObject; Button: TUDBtnType);
    procedure edPageHeaderChange(Sender: TObject);
    procedure edMarginTopChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbPrintRulerClick(Sender: TObject);
  private
    { Private-Deklarationen }
    FEditor: TMPHexEditorEx;
    FSetup: TAction;
    FMeta: TBitmap;
    FSetting: Boolean;
    FAutoPrint: Boolean;
    procedure SetupClick(Sender: TObject);
    procedure SetControls;
    procedure SetImageBounds;
    procedure CreatePreview;
    procedure WMAPP(var Msg: TLMessage); message $8000;
  public
    { Public-Deklarationen }
  end;

var
  fmPrinting: TfmPrinting;

// printing
procedure PrintPreview(Editor: TMPHexEditorEx; SetupAction: TAction;
  AutoPrint: Boolean);

implementation

uses uprintprogress, LCLIntf;

{$R *.lfm}

const
  STR_NUMPG = 'of %d';
  STR_INVMARGINS = 'Invalid page margins.';

// printing
procedure PrintPreview(Editor: TMPHexEditorEx; SetupAction: TAction;
  AutoPrint: Boolean);
begin
  with TfmPrinting.Create(Application) do
  try
    FEditor := Editor;
    btnSetup.Action := SetupAction;
    FSetup := SetupAction;
    btnSetup.Action := nil;
    btnSetup.OnClick := SetupClick;
    FAutoPrint := AutoPrint;
    ShowModal;
  finally
    Free;
  end;
end;

{ TfmPrinting }

procedure TfmPrinting.SetupClick(Sender: TObject);
begin
  FSetup.Execute;
  SetControls;
  CreatePreview;
  SetImageBounds;
end;

procedure TfmPrinting.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TfmPrinting.FormShow(Sender: TObject);
begin
  rbPrintSelection.Enabled := FEditor.SelCount > 0;
  rbPrintSelection.Checked := rbPrintSelection.Enabled and (pfSelectionOnly in FEditor.PrintOptions.Flags);
  rbPrintCurrentView.Checked := (pfCurrentViewOnly in FEditor.PrintOptions.Flags);
  SetControls;
  CreatePreview;
  SetImageBounds;
  if FAutoPrint
  then
    PostMessage(Handle, $8000, 0 ,0);
end;

procedure TfmPrinting.SetControls;
begin
  with FEditor.PrintOptions do
  begin
    FSetting := True;
    try
      cbColors.Checked := not (pfMonochrome in Flags);
      cbBack.Enabled := cbColors.Checked;
      cbBack.Checked := cbColors.Checked and (pfUseBackGroundColor in Flags);
      cbSelBold.Enabled := not rbPrintSelection.Checked;
      cbSelBold.Checked := cbSelBold.Enabled and (pfSelectionBold in Flags);
      cbPrintRuler.Enabled := FEditor.ShowRuler;
      if not cbPrintRuler.Enabled then
        Flags := Flags - [pfIncludeRuler];
      cbPrintRuler.Checked := pfIncludeRuler in Flags;

      edMarginTop.Text := IntToStr(MarginTop);
      edMarginLeft.Text := IntToStr(MarginLeft);
      edMarginRight.Text := IntToStr(MarginRight);
      edMarginBottom.Text := IntToStr(MarginBottom);

      try
        udPage.Max := FEditor.PrintNumPages;
      except
        udPage.Max := 1;
      end;
      if udPage.Max < udPage.Position
      then
        udPage.Position := udPage.Max;
      edPage.Text := IntToStr(udPage.Position);
      Label1.Enabled := udPage.Max > 1;
      edPage.Enabled := udPage.Max > 1;
      udPage.Enabled := udPage.Max > 1;
      lbPageNum.Enabled := udPage.Max > 1;
      lbPageNum.Caption := Format(STR_NUMPG,[udPage.Max]);

      edPageHeader.Text := PageHeader;
      edPageFooter.Text := PageFooter;
    finally
      FSetting := False;
    end;
  end;
end;

procedure TfmPrinting.FormCreate(Sender: TObject);
begin
  FMeta := nil;
  FSetting := False;
  FAutoPrint := False;
  sbPreview.DoubleBuffered := True;
end;

procedure TfmPrinting.FormDestroy(Sender: TObject);
begin
  if Assigned(FMeta)
  then
    FMeta.Free;
  FMeta := nil;
end;

procedure TfmPrinting.SetImageBounds;
var
  LDblRatio: Single;
  LIntW, LIntH: Integer;
begin
  if Assigned(FMeta) then
  begin
    // get height/width ratio
    LDblRatio := FMeta.Width / FMeta.Height;
    // calc max bounds of image (depending on pnPreview.clientw/h)
    LIntW := sbPreview.Width-16;
    LIntH := Round(LIntW / LDblRatio);
    if LIntH > (sbPreview.Height-16) then
    begin
      LIntH := sbPreview.Height-16;
      LIntW := Round(LIntH * LDblRatio);
    end;
    // calc zoom
    LIntW := LIntW * udZoom.Position div 100;
    LIntH := LIntH * udZoom.Position div 100;
    with imgPreview do
    begin
      Width := LIntW;
      Height := LIntH;
      Picture.Bitmap.Width := 0;
      Picture.Bitmap.Height := 0;
      Picture.Bitmap.Width := LIntW;
      Picture.Bitmap.Height := LIntH;
      Picture.Bitmap.Canvas.StretchDraw(Rect(0,0,LIntW, LIntH),FMeta);
    end;
  end;
end;

procedure TfmPrinting.CreatePreview;
begin
  if Assigned(FMeta)
  then
    FMeta.Free;
  FMeta := nil;
  try
    FMeta := FEditor.PrintPreview(udPage.Position);
  except
    FMeta := nil;
    Raise;
  end;
end;

procedure TfmPrinting.sbPreviewResize(Sender: TObject);
begin
  SetImageBounds;
end;

procedure TfmPrinting.Button3Click(Sender: TObject);
begin
  with FontDialog1 do
  begin
    if FEditor.UseEditorFontForPrinting
    then
      Font.Assign(FEditor.Font)
    else
      Font.Assign(FEditor.PrintFont);
    if Execute then
    begin
      FEditor.PrintFont := Font;
      SetControls;
      CreatePreview;
      SetImageBounds;
    end;
  end;
end;

procedure TfmPrinting.cbSelBoldClick(Sender: TObject);
begin
  if FSetting
  then
    Exit;
  with FEditor.PrintOptions
  do
    if cbSelBold.Checked
    then
      Flags := Flags+ [pfSelectionBold]
    else
      Flags := Flags- [pfSelectionBold];
  SetControls;
  CreatePreview;
  SetImageBounds;
end;

procedure TfmPrinting.cbBackClick(Sender: TObject);
begin
  if FSetting
  then
    Exit;
  with FEditor.PrintOptions
  do
    if cbBack.Checked
    then
      Flags := Flags+ [pfUseBackgroundColor]
    else
      Flags := Flags- [pfUseBackgroundColor];
  SetControls;
  CreatePreview;
  SetImageBounds;
end;

procedure TfmPrinting.cbColorsClick(Sender: TObject);
begin
  if FSetting
  then
    Exit;
  with FEditor.PrintOptions
  do
    if cbColors.Checked
    then
      Flags := Flags- [pfMonochrome]
    else
      Flags := Flags+ [pfMonochrome];
  SetControls;
  CreatePreview;
  SetImageBounds;
end;

procedure TfmPrinting.udPageClick(Sender: TObject; Button: TUDBtnType);
begin
  if FSetting
  then
    Exit;
  try
    CreatePreview;
    SetImageBounds;
  except
  end;
end;

procedure TfmPrinting.rbPrintSelectionClick(Sender: TObject);
begin
  if FSetting
  then
    Exit;
  with FEditor.PrintOptions do
  begin
    if rbPrintSelection.Checked
    then
      Flags := Flags+ [pfSelectionOnly]
    else
      Flags := Flags- [pfSelectionOnly];
    if rbPrintCurrentView.Checked then
      Flags := Flags+ [pfCurrentViewOnly]
    else
      Flags := Flags- [pfCurrentViewOnly];
  end;
  SetControls;
  CreatePreview;
  SetImageBounds;
end;

procedure TfmPrinting.udZoomClick(Sender: TObject; Button: TUDBtnType);
begin
  SetImageBounds;
end;

procedure TfmPrinting.edPageHeaderChange(Sender: TObject);
begin
  if FSetting
  then
    Exit;
  with FEditor.PrintOptions do
  begin
    PageHeader := edPageHeader.Text;
    PageFooter := edPageFooter.Text;
  end;
  SetControls;
  CreatePreview;
  SetImageBounds;
end;

procedure TfmPrinting.edMarginTopChange(Sender: TObject);
var
  LIntLeft,
  LIntTop,
  LIntRight,
  LIntBottom: Integer;
begin
  if FSetting or (TEdit(Sender).Text = '')
  then
    Exit;
  with FEditor.PrintOptions do
  begin
    // save in case of invalid values (no line per page)
    LIntLeft := MarginLeft;
    LIntTop := MarginTop;
    LIntRight := MarginRight;
    LIntBottom := MarginBottom;

    try
      MarginLeft := StrToIntDef(edMarginLeft.Text, MarginLeft);
      MarginTop := StrToIntDef(edMarginTop.Text, MarginTop);
      MarginRight := StrToIntDef(edMarginRight.Text, MarginRight);
      MarginBottom := StrToIntDef(edMarginBottom.Text, MarginBottom);
      SetControls;
      CreatePreview;
      SetImageBounds;
    except
      MarginLeft := LIntLeft;
      MarginTop := LIntTop;
      MarginRight := LIntRight;
      MarginBottom := LIntBottom;
      try
        SetControls;
        CreatePreview;
        SetImageBounds;
      except
        MarginLeft := 0;
        MarginTop := 0;
        MarginRight := 0;
        MarginBottom := 0;
        SetControls;
        CreatePreview;
        SetImageBounds;
      end;
      Raise Exception.Create(STR_INVMARGINS);
    end;
  end;
end;

procedure TfmPrinting.Button1Click(Sender: TObject);
var
  LIntFrom,
  LIntTo: Integer;
begin
  if rbPrintCurrentPage.Checked then
  begin
    LIntFrom := udPage.Position;
    LIntTo := LIntFrom;
  end
  else
  begin
    LIntFrom := 1;
    LIntTo := udPage.Max;
  end;
  DoPrint(FEditor, LIntFrom, LIntTo);
end;

procedure TfmPrinting.WMAPP(var Msg: TLMessage);
begin
  Button1.Click;
  ModalResult := mrOK;
end;

procedure TfmPrinting.cbPrintRulerClick(Sender: TObject);
begin
  if FSetting
  then
    Exit;
  with FEditor.PrintOptions
  do
    if cbPrintRuler.Checked
    then
      Flags := Flags+ [pfIncludeRuler]
    else
      Flags := Flags- [pfIncludeRuler];
  SetControls;
  CreatePreview;
  SetImageBounds;
end;

end.
