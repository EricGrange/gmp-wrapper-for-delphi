object frmGMPDemo: TfrmGMPDemo
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'GMP Library Demo'
  ClientHeight = 433
  ClientWidth = 451
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 5
    Top = 66
    Width = 24
    Height = 13
    Caption = #32467#26524
    Transparent = True
  end
  object Bevel1: TBevel
    Left = 5
    Top = 286
    Width = 442
    Height = 2
  end
  object Label1: TLabel
    Left = 8
    Top = 294
    Width = 84
    Height = 13
    Caption = #24403'X'#12289'Y'#20026#25972#25968#26102
  end
  object Bevel2: TBevel
    Left = 5
    Top = 388
    Width = 442
    Height = 2
  end
  object btnAdd: TButton
    Left = 32
    Top = 175
    Width = 95
    Height = 31
    Caption = 'X + Y'
    TabOrder = 0
    OnClick = btnCalculate
  end
  object editX: TLabeledEdit
    Left = 32
    Top = 8
    Width = 297
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = 'X'
    LabelPosition = lpLeft
    TabOrder = 1
    Text = '0.14159265358979323846264338327950288'
  end
  object editY: TLabeledEdit
    Left = 32
    Top = 35
    Width = 297
    Height = 21
    EditLabel.Width = 6
    EditLabel.Height = 13
    EditLabel.Caption = 'Y'
    LabelPosition = lpLeft
    TabOrder = 2
    Text = '2.71828182845904523536'
  end
  object btnMinus: TButton
    Tag = 1
    Left = 138
    Top = 175
    Width = 95
    Height = 31
    Caption = 'X - Y'
    TabOrder = 3
    OnClick = btnCalculate
  end
  object btnMultiply: TButton
    Tag = 2
    Left = 244
    Top = 175
    Width = 95
    Height = 31
    Caption = 'X * Y'
    TabOrder = 4
    OnClick = btnCalculate
  end
  object btnDivide: TButton
    Tag = 3
    Left = 350
    Top = 175
    Width = 95
    Height = 31
    Caption = 'X / Y'
    TabOrder = 5
    OnClick = btnCalculate
  end
  object btnSqrt: TButton
    Tag = 4
    Left = 32
    Top = 211
    Width = 95
    Height = 31
    Caption = 'Sqrt(X)'
    TabOrder = 6
    OnClick = btnCalculate
  end
  object editResultBase: TLabeledEdit
    Left = 389
    Top = 8
    Width = 55
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = #32467#26524#36827#21046
    LabelPosition = lpLeft
    TabOrder = 7
    Text = '10'
  end
  object editPrecision: TLabeledEdit
    Left = 389
    Top = 35
    Width = 55
    Height = 21
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = #31934#24230
    LabelPosition = lpLeft
    TabOrder = 8
    Text = '100'
  end
  object btnPi: TButton
    Tag = 11
    Left = 350
    Top = 248
    Width = 95
    Height = 31
    Caption = 'Pi'
    TabOrder = 9
    OnClick = btnCalculate
  end
  object btnPrimeSeries: TButton
    Left = 138
    Top = 350
    Width = 95
    Height = 31
    Caption = #36136#25968#25968#21015
    TabOrder = 10
    OnClick = btnPrimeSeriesClick
  end
  object btnPrintfScanf: TButton
    Left = 32
    Top = 396
    Width = 201
    Height = 31
    Caption = 'printf && scanf'
    TabOrder = 11
    OnClick = btnPrintfScanfClick
  end
  object btnPower: TButton
    Tag = 5
    Left = 138
    Top = 211
    Width = 95
    Height = 31
    Caption = 'X^Y'
    TabOrder = 12
    OnClick = btnCalculate
  end
  object btnLn: TButton
    Tag = 6
    Left = 244
    Top = 211
    Width = 95
    Height = 31
    Caption = 'Ln(X)'
    TabOrder = 13
    OnClick = btnCalculate
  end
  object btnSin: TButton
    Tag = 7
    Left = 350
    Top = 211
    Width = 95
    Height = 31
    Caption = 'Sin(X)'
    TabOrder = 14
    OnClick = btnCalculate
  end
  object btnCos: TButton
    Tag = 8
    Left = 32
    Top = 248
    Width = 95
    Height = 31
    Caption = 'Cos(X)'
    TabOrder = 15
    OnClick = btnCalculate
  end
  object btnArcSin: TButton
    Tag = 9
    Left = 138
    Top = 248
    Width = 95
    Height = 31
    Caption = 'ArcSin(X)'
    TabOrder = 16
    OnClick = btnCalculate
  end
  object btnArcTan: TButton
    Tag = 10
    Left = 244
    Top = 248
    Width = 95
    Height = 31
    Caption = 'ArcTan(X)'
    TabOrder = 17
    OnClick = btnCalculate
  end
  object editResult: TMemo
    Left = 32
    Top = 62
    Width = 412
    Height = 107
    ScrollBars = ssVertical
    TabOrder = 18
  end
  object btnGCM: TButton
    Left = 32
    Top = 314
    Width = 95
    Height = 31
    Caption = #26368#22823#20844#32422#25968
    TabOrder = 19
    OnClick = btnCalcIntegerClick
  end
  object btnLCM: TButton
    Tag = 1
    Left = 138
    Top = 314
    Width = 95
    Height = 31
    Caption = #26368#23567#20844#20493#25968
    TabOrder = 20
    OnClick = btnCalcIntegerClick
  end
  object btnFactorial: TButton
    Tag = 2
    Left = 244
    Top = 314
    Width = 95
    Height = 31
    Caption = 'X!'
    TabOrder = 21
    OnClick = btnCalcIntegerClick
  end
  object btnFibonacci: TButton
    Tag = 3
    Left = 350
    Top = 314
    Width = 95
    Height = 31
    Caption = #31532'X'#20010'Fibonacci'#25968
    ParentShowHint = False
    ShowHint = False
    TabOrder = 22
    OnClick = btnCalcIntegerClick
  end
  object btnRandomInteger: TButton
    Tag = 4
    Left = 32
    Top = 350
    Width = 95
    Height = 31
    Caption = 'XY'#38388#38543#26426#25972#25968
    TabOrder = 23
    OnClick = btnCalcIntegerClick
  end
  object Button1: TButton
    Tag = 5
    Left = 244
    Top = 350
    Width = 95
    Height = 31
    Caption = 'X'#22855#20598
    TabOrder = 24
    OnClick = btnCalcIntegerClick
  end
  object btnMod: TButton
    Tag = 6
    Left = 350
    Top = 350
    Width = 95
    Height = 31
    Caption = 'X mod Y'
    TabOrder = 25
    OnClick = btnCalcIntegerClick
  end
end
