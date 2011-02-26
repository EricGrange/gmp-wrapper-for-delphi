program Project3;

uses
  Forms,
  Unit3 in 'Unit3.pas' {frmGMPDemo},
  gmp_lib in 'gmp_lib.pas',
  gmp_obj in 'gmp_obj.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmGMPDemo, frmGMPDemo);
  Application.Run;
end.
