object Form3: TForm3
  Left = 928
  Top = 0
  Width = 456
  Height = 1162
  Caption = 'Form3: Threshold for refractory neuron'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 175
    Height = 16
    Caption = 'Adaptation must be turned off.'
    Color = clRed
    ParentColor = False
  end
  object Label1: TLabel
    Left = 16
    Top = 80
    Width = 152
    Height = 16
    Caption = 'Threshold criterion, dV/dt:'
  end
  object Button1: TButton
    Left = 80
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = Button2Click
  end
  object DDSpinEdit1: TDDSpinEdit
    Left = 392
    Top = 0
    Width = 52
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Increment = 100.000000000000000000
    ParentFont = False
    TabOrder = 2
    Value = 2000.000000000000000000
  end
  object DDSpinEdit4: TDDSpinEdit
    Left = 392
    Top = 20
    Width = 52
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
    TabOrder = 3
    Value = 40.000000000000000000
  end
  object StaticText1: TStaticText
    Left = 293
    Top = 0
    Width = 86
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' Iind_max, pA '
    TabOrder = 4
  end
  object StaticText4: TStaticText
    Left = 293
    Top = 20
    Width = 86
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' Step for Iind   '
    TabOrder = 5
  end
  object StaticText2: TStaticText
    Left = 293
    Top = 40
    Width = 95
    Height = 20
    BorderStyle = sbsSunken
    Caption = 'Oscillations, Hz'
    TabOrder = 6
  end
  object DDSpinEdit2: TDDSpinEdit
    Left = 392
    Top = 40
    Width = 52
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
    TabOrder = 7
  end
  object DDSpinEdit3: TDDSpinEdit
    Left = 392
    Top = 60
    Width = 52
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
    TabOrder = 8
  end
  object StaticText3: TStaticText
    Left = 293
    Top = 60
    Width = 56
    Height = 20
    BorderStyle = sbsSunken
    Caption = 'sgm, mV'
    TabOrder = 9
  end
  object CheckBox1: TCheckBox
    Left = 293
    Top = 80
    Width = 148
    Height = 17
    Caption = 'No noise in T-neuron'
    TabOrder = 10
  end
  object DDSpinEdit5: TDDSpinEdit
    Left = 32
    Top = 52
    Width = 49
    Height = 26
    StrWidth = 2
    StrDecimals = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Increment = 0.100000000000000000
    ParentFont = False
    TabOrder = 11
  end
  object StaticText5: TStaticText
    Left = 16
    Top = 53
    Width = 17
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' s '
    TabOrder = 12
  end
  object Chart2: TChart
    Left = 0
    Top = 96
    Width = 441
    Height = 217
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.Title.Caption = 'ms'
    LeftAxis.Title.Caption = 'mV'
    Legend.HorizMargin = 1
    Legend.LegendStyle = lsSeries
    Legend.ResizeChart = False
    Legend.ShadowSize = 0
    View3D = False
    TabOrder = 13
    object Series2: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'Th'
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series3: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 8404992
      Title = 'V, full model'
      LinePen.Width = 2
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
    object Series4: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clLime
      Title = 'V, thr. model'
      Pointer.Brush.Color = clLime
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 2
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series10: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'Th_Curv'
      Pointer.Brush.Color = 16744576
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series14: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clYellow
      Title = 'V12_- for Lyle-VT(h)'
      OnDblClick = Series14DblClick
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object Chart3: TChart
    Left = 0
    Top = 312
    Width = 441
    Height = 177
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'tAP, ms'
    LeftAxis.Title.Caption = 'Th, mV'
    Legend.ColorWidth = 40
    Legend.HorizMargin = 1
    Legend.LegendStyle = lsSeries
    Legend.ResizeChart = False
    Legend.ShadowSize = 0
    View3D = False
    TabOrder = 14
    object CheckBox2: TCheckBox
      Left = 312
      Top = 152
      Width = 121
      Height = 17
      Caption = 'Rate, not latency'
      TabOrder = 0
    end
    object Series5: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 8454016
      Title = 'Th'
      LinePen.Color = 8454016
      LinePen.Width = 2
      Pointer.Brush.Color = clGreen
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series9: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 16744576
      Title = 'Th1'
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 2
      Pointer.Visible = True
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
  object Chart4: TChart
    Left = 0
    Top = 488
    Width = 441
    Height = 178
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.Title.Caption = 'I ind, pA'
    LeftAxis.Title.Caption = 'Th, mV'
    Legend.Alignment = laTop
    Legend.ColorWidth = 40
    Legend.HorizMargin = 1
    Legend.LegendStyle = lsSeries
    Legend.ResizeChart = False
    Legend.ShadowSize = 0
    Legend.VertMargin = 1
    RightAxis.Title.Caption = 'tAP, ms'
    View3D = False
    TabOrder = 15
    object Series6: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 8454016
      Title = 'Th'
      LinePen.Color = 8454016
      LinePen.Width = 2
      Pointer.Brush.Color = clGreen
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series7: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 8454143
      Title = 'tAP'
      VertAxis = aRightAxis
      Pointer.Brush.Color = clYellow
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series11: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 16744576
      Title = 'Th_Curv'
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
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
  object Chart5: TChart
    Left = 0
    Top = 664
    Width = 393
    Height = 154
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.Title.Caption = 'I ind, pA'
    LeftAxis.Title.Caption = 'dV/dt, mV'
    Legend.ColorWidth = 40
    Legend.HorizMargin = 1
    Legend.LegendStyle = lsSeries
    Legend.ResizeChart = False
    Legend.ShadowSize = 0
    View3D = False
    TabOrder = 16
    object Series8: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clSilver
      Title = 'dV/dt'
      LinePen.Color = clSilver
      LinePen.Width = 2
      Pointer.Brush.Color = 8454016
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
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
  object Chart1: TChart
    Left = 0
    Top = 816
    Width = 441
    Height = 162
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'dV/dt, mV/ms'
    LeftAxis.Title.Caption = 'mV'
    Legend.ColorWidth = 40
    Legend.HorizMargin = 1
    Legend.LegendStyle = lsSeries
    Legend.ResizeChart = False
    Legend.ShadowSize = 0
    View3D = False
    TabOrder = 17
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 4227327
      Title = 'Th'
      LinePen.Color = 4227327
      LinePen.Width = 2
      Pointer.Brush.Color = clRed
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series12: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 16744576
      Title = 'Th_Curv'
      OnDblClick = Series12DblClick
      Pointer.Brush.Color = 16744576
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series13: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'Th1'
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Pen.Color = clYellow
      Pointer.Style = psCircle
      Pointer.VertSize = 2
      Pointer.Visible = True
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
  object DDSpinEdit6: TDDSpinEdit
    Left = 192
    Top = 72
    Width = 57
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 2.000000000000000000
    TabOrder = 18
    Value = 30.000000000000000000
  end
  object Chart6: TChart
    Left = -1
    Top = 976
    Width = 441
    Height = 145
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'hh'
    LeftAxis.Title.Caption = 'Th, mV'
    Legend.ColorWidth = 40
    Legend.HorizMargin = 1
    Legend.LegendStyle = lsSeries
    Legend.ResizeChart = False
    Legend.ShadowSize = 0
    View3D = False
    TabOrder = 19
    object CheckBox3: TCheckBox
      Left = 312
      Top = 152
      Width = 121
      Height = 17
      Caption = 'Rate, not latency'
      TabOrder = 0
    end
    object LineSeries1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 8454016
      Title = 'Th'
      LinePen.Color = 8454016
      LinePen.Width = 2
      Pointer.Brush.Color = clGreen
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 3
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object LineSeries2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 16744576
      Title = 'Th1'
      Pointer.HorizSize = 2
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 2
      Pointer.Visible = True
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
end
