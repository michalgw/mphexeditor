program sample2;

{$MODE Delphi}

uses
  Forms, Interfaces,
  umain in 'umain.pas' {fmMain},
  ureplace in 'ureplace.pas' {dlgReplace},
  uprintprogress in 'uprintprogress.pas' {dlgPrintProgress},
  ucustomtranslation in 'ucustomtranslation.pas' {dlgEditCustomTranslation},
  ufind in 'ufind.pas' {dlgFind},
  uprinting in 'uprinting.pas' {fmPrinting},
  uinputnumber in 'uinputnumber.pas' {dlgInputNumber},
  uconvert in 'uconvert.pas' {dlgConvert},
  uOptions in 'uoptions.pas' {dlgOptions};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'mirkes.de''s little hexer';
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
