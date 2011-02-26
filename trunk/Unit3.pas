unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Math;

type
  TfrmGMPDemo = class(TForm)
    btnAdd: TButton;
    editX: TLabeledEdit;
    editY: TLabeledEdit;
    btnMinus: TButton;
    btnMultiply: TButton;
    btnDivide: TButton;
    btnSqrt: TButton;
    editResultBase: TLabeledEdit;
    editPrecision: TLabeledEdit;
    btnPi: TButton;
    btnPrimeSeries: TButton;
    btnPrintfScanf: TButton;
    btnPower: TButton;
    btnLn: TButton;
    btnSin: TButton;
    btnCos: TButton;
    btnArcSin: TButton;
    btnArcTan: TButton;
    editResult: TMemo;
    lbl1: TLabel;
    Bevel1: TBevel;
    Label1: TLabel;
    btnGCM: TButton;
    btnLCM: TButton;
    btnFactorial: TButton;
    btnFibonacci: TButton;
    btnRandomInteger: TButton;
    Bevel2: TBevel;
    Button1: TButton;
    btnMod: TButton;
    procedure btnCalculate(Sender: TObject);
    procedure btnPrimeSeriesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnPrintfScanfClick(Sender: TObject);
    procedure btnCalcIntegerClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmGMPDemo: TfrmGMPDemo;

implementation
uses gmp_lib, gmp_obj;

{$R *.dfm}

procedure TfrmGMPDemo.btnCalculate(Sender: TObject);
var
   Base: Cardinal;
   x, y, p: gmpFloat;
begin
   Base := StrToInt(editResultBase.Text);
   SetDefaultFloatPrecision(StrToInt(editPrecision.Text));

   try
      gmpCreateF([@x, @y, @p]); // x.Create(0) is OK.
      x.Assign(editX.Text);
      y.Assign(editY.Text);

      case (Sender as TComponent).Tag of
         0: p.Assign(x + y);
         1: p.Assign(x - y);
         2: p.Assign(x * y);
         3: p.Assign(x / y);
         4:
            begin
               p.Assign(x);
               p.SetSqrt;
               // p.Assign(gmpSqrt(x));
            end;
         5: p.Assign(gmpPower(x, y));
         6: p.Assign(gmpLn(x));
         7: p.Assign(gmpSin(x));
         8: p.Assign(gmpCos(x));
         9: p.Assign(gmpArcSin(x));
         10: p.Assign(gmpArcTan(x));
         11: p.Assign(gmpPi);
      end;

      editResult.Text := p.ToString(Base);
   finally
      gmpFree([@p, @x, @y]);

      // This is OK.
      //p.Free;
      //x.Free;
      //y.Free;
   end;
end;

procedure TfrmGMPDemo.btnCalcIntegerClick(Sender: TObject);
var
   Base: Cardinal;
   x, y, p: gmpInteger;
begin
   Base := StrToInt(editResultBase.Text);

   try
      gmpCreateI([@x, @y, @p]);
      x.Assign(editX.Text);

      if (Sender as TComponent).Tag in [0, 1, 4, 6] then
         y.Assign(editY.Text);

      case (Sender as TComponent).Tag of
         0: p.Assign(gmpGCD(x, y));
         1: p.Assign(gmpLCM(x, y));
         2: p.Assign(gmpFactorial(StrToInt(editX.Text)));
         3: p.Assign(gmpFibonacci(StrToInt(editX.Text)));
         4: p.Assign(gmpRandomRange(x, y));
         5: if x.IsOdd then
               ShowMessage('X是奇数')
            else
               ShowMessage('X是偶数');
         6: p.Assign(x mod y);
      end;

      editResult.Text := p.ToString(Base);
   finally
      gmpFree([@p, @x, @y]);
   end;
end;

procedure TfrmGMPDemo.btnPrimeSeriesClick(Sender: TObject);
var
   idx: Integer;
   i, t: gmpInteger;
begin
   i.Create(0);
   t.Create(0);
   idx := 0;
   while True do
   begin
      Inc(idx);
      t.Assign(gmpNextLikelyPrime(i));
      if MessageDlg(Format('第%d个质数为%s', [idx, t.ToString]),
         mtConfirmation, [mbYes, mbNo], 0) = mrNo then
         Break;

      Inc(idx);
      i.Assign(gmpNextLikelyPrime(t));
      if MessageDlg(Format('第%d个质数为%s', [idx, i.ToString]),
         mtConfirmation, [mbYes, mbNo], 0) = mrNo then
         Break;
   end;
   i.Free;
   t.Free;
end;

procedure TfrmGMPDemo.btnPrintfScanfClick(Sender: TObject);
var
   buf: AnsiString;
   i: gmpInteger;
   p, q: gmpRational;
begin
   SetLength(buf, 1000);
   i.Create(1020304041);
   gmp_printf(PAnsiChar(buf), '%s is an mpz %Zd', PAnsiChar('hear'), i.NativeObject);
   editResult.Text := buf;
   i.Free;

   p.Create(0);
   q.Create(0);
   gmp_scanf('0377 + 0x10/0x11', '%Qi + %Qi', p.NativeObject, q.NativeObject);
   ShowMessage(p.ToStringFraction());
   ShowMessage(q.ToStringFraction());
   p.Free;
   q.Free;
end;

procedure TfrmGMPDemo.FormCreate(Sender: TObject);
begin
   ReportMemoryLeaksOnShutdown := True;
end;

end.
