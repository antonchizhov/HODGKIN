object Form15: TForm15
  Left = 552
  Top = 638
  Width = 408
  Height = 397
  AutoSize = True
  Caption = 'Form15: Synaptic Current for the Net'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 248
    Top = 3
    Width = 107
    Height = 16
    Caption = 'gGABA, mS/cm^2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 248
    Top = 23
    Width = 70
    Height = 16
    Caption = 'alGABA, Hz'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 248
    Top = 43
    Width = 72
    Height = 16
    Caption = 'beGABA,Hz'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 248
    Top = 63
    Width = 72
    Height = 16
    Caption = 'VGABA, mV'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 248
    Top = 83
    Width = 58
    Height = 16
    Caption = 'delay, ms'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DDSpinEdit1: TDDSpinEdit
    Left = 344
    Top = 0
    Width = 49
    Height = 26
    StrWidth = 2
    StrDecimals = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Increment = 0.200000000000000000
    ParentFont = False
    TabOrder = 0
    Value = 1.000000000000000000
  end
  object DDSpinEdit2: TDDSpinEdit
    Left = 344
    Top = 20
    Width = 49
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Increment = 20.000000000000000000
    ParentFont = False
    TabOrder = 1
    Value = 320.000000000000000000
  end
  object DDSpinEdit3: TDDSpinEdit
    Left = 344
    Top = 40
    Width = 49
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Increment = 20.000000000000000000
    ParentFont = False
    TabOrder = 2
    Value = 320.000000000000000000
  end
  object Chart1: TChart
    Left = 0
    Top = 112
    Width = 400
    Height = 250
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    MarginBottom = 1
    MarginLeft = 1
    MarginTop = 1
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.MinorTickCount = 4
    BottomAxis.Title.Caption = 't, ms'
    BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
    BottomAxis.Title.Font.Color = clBlack
    BottomAxis.Title.Font.Height = -13
    BottomAxis.Title.Font.Name = 'Arial'
    BottomAxis.Title.Font.Style = [fsBold]
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.MinorTickCount = 4
    LeftAxis.Title.Caption = 'mGABA'
    LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
    LeftAxis.Title.Font.Color = clBlack
    LeftAxis.Title.Font.Height = -13
    LeftAxis.Title.Font.Name = 'Arial'
    LeftAxis.Title.Font.Style = [fsBold]
    Legend.Alignment = laTop
    Legend.ColorWidth = 30
    Legend.LegendStyle = lsSeries
    Legend.ShadowSize = 0
    Legend.TopPos = 0
    Legend.VertMargin = 4
    RightAxis.MinorTickCount = 4
    View3D = False
    TabOrder = 3
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'mGABA'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object DDSpinEdit4: TDDSpinEdit
    Left = 344
    Top = 60
    Width = 49
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Increment = 1.000000000000000000
    ParentFont = False
    TabOrder = 4
    Value = -80.000000000000000000
  end
  object DDSpinEdit5: TDDSpinEdit
    Left = 344
    Top = 80
    Width = 49
    Height = 26
    StrWidth = 2
    StrDecimals = 1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Increment = 0.500000000000000000
    ParentFont = False
    TabOrder = 5
    Value = 1.000000000000000000
  end
end
