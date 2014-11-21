{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit mphexeditorlaz;

interface

uses
  MPHexEditor, mphexeditreg, MPHexEditorEx, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('mphexeditreg', @mphexeditreg.Register);
end;

initialization
  RegisterPackage('mphexeditorlaz', @Register);
end.
