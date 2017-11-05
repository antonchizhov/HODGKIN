object Form9: TForm9
  Left = 774
  Top = 23
  Width = 608
  Height = 733
  Caption = 'Form9: Calculates Freq. etc. on (u,s) plane '
  Color = 12443610
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object DDSpinEdit6: TDDSpinEdit
    Left = 536
    Top = 296
    Width = 57
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 10000.000000000000000000
    TabOrder = 13
    Value = 10002.000000000000000000
  end
  object Button1: TButton
    Left = 360
    Top = 168
    Width = 233
    Height = 25
    Caption = 'Plot Frequency(u,s)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object DDSpinEdit1: TDDSpinEdit
    Left = 536
    Top = 320
    Width = 57
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 10.000000000000000000
    TabOrder = 1
    Value = 50.000000000000000000
    OnChange = DDSpinEdit1Change
  end
  object StaticText1: TStaticText
    Left = 448
    Top = 324
    Width = 85
    Height = 20
    Caption = 'Max Freq., Hz'
    TabOrder = 2
  end
  object StaticText2: TStaticText
    Left = 416
    Top = 360
    Width = 70
    Height = 20
    Caption = 'nue x nse ='
    TabOrder = 3
  end
  object Button2: TButton
    Left = 440
    Top = 240
    Width = 75
    Height = 25
    Caption = 'Clear'
    TabOrder = 4
    OnClick = Button2Click
  end
  object StaticText3: TStaticText
    Left = 392
    Top = 384
    Width = 98
    Height = 20
    Caption = 'u_max, s_max ='
    TabOrder = 7
  end
  object Button3: TButton
    Left = 440
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 8
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 384
    Top = 264
    Width = 185
    Height = 25
    Caption = 'Show Form for FiringClamp'
    TabOrder = 9
    OnClick = Button4Click
  end
  object DDSpinEdit4: TDDSpinEdit
    Left = 536
    Top = 440
    Width = 57
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 100.000000000000000000
    TabOrder = 10
    Value = 500.000000000000000000
  end
  object StaticText4: TStaticText
    Left = 464
    Top = 448
    Width = 67
    Height = 20
    Caption = ' t_end, ms '
    TabOrder = 11
  end
  object CheckBox1: TCheckBox
    Left = 408
    Top = 16
    Width = 161
    Height = 17
    Caption = 'Show (u,s)-plot or not '
    Checked = True
    State = cbChecked
    TabOrder = 12
  end
  object StaticText6: TStaticText
    Left = 400
    Top = 300
    Width = 134
    Height = 20
    Caption = 'Max number of spikes'
    TabOrder = 14
  end
  object DDSpinEdit7: TDDSpinEdit
    Left = 496
    Top = 352
    Width = 49
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 1.000000000000000000
    TabOrder = 15
    Value = 20.000000000000000000
    OnChange = DDSpinEdit7Change
  end
  object DDSpinEdit8: TDDSpinEdit
    Left = 544
    Top = 352
    Width = 49
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 1.000000000000000000
    TabOrder = 16
    Value = 8.000000000000000000
    OnChange = DDSpinEdit8Change
  end
  object DDSpinEdit2: TDDSpinEdit
    Left = 496
    Top = 376
    Width = 49
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 1.000000000000000000
    TabOrder = 5
    Value = 10.000000000000000000
    OnChange = DDSpinEdit2Change
  end
  object DDSpinEdit3: TDDSpinEdit
    Left = 544
    Top = 376
    Width = 49
    Height = 26
    StrWidth = 2
    StrDecimals = 1
    Increment = 0.100000000000000000
    TabOrder = 6
    Value = 0.500000000000000000
    OnChange = DDSpinEdit3Change
  end
  object RadioGroup1: TRadioGroup
    Left = 400
    Top = 88
    Width = 161
    Height = 73
    Hint = 'Parameters are on the panel Form4\Others\Noise'
    Caption = 'Noise'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 0
    Items.Strings = (
      'no Noise'
      'Noise-current'
      'Noise-conductances')
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
  end
  object DDSpinEdit9: TDDSpinEdit
    Left = 544
    Top = 400
    Width = 49
    Height = 26
    StrWidth = 2
    StrDecimals = 1
    Increment = 0.100000000000000000
    TabOrder = 18
    OnChange = DDSpinEdit9Change
  end
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 353
    Height = 337
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    MarginBottom = 1
    MarginLeft = 1
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'u'
    LeftAxis.Title.Caption = 's'
    Legend.Alignment = laTop
    Legend.ColorWidth = 30
    Legend.LegendStyle = lsSeries
    Legend.ResizeChart = False
    Legend.ShadowSize = 0
    Legend.VertMargin = 23
    Legend.Visible = False
    View3D = False
    Color = 12443610
    TabOrder = 19
    OnDblClick = Chart1DblClick
    object Button22: TButton
      Left = 248
      Top = 0
      Width = 105
      Height = 17
      Caption = 'CopyToBMP'
      TabOrder = 0
      OnClick = Button22Click
    end
    object Series1: TBubbleSeries
      Marks.ArrowLength = 0
      Marks.Frame.Visible = False
      Marks.Transparent = True
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'Field'
      Pointer.HorizSize = 32
      Pointer.InflateMargins = False
      Pointer.Style = psRectangle
      Pointer.VertSize = 32
      Pointer.Visible = True
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
      RadiusValues.DateTime = False
      RadiusValues.Name = 'Radius'
      RadiusValues.Multiplier = 1.000000000000000000
      RadiusValues.Order = loNone
    end
    object Series7: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'gI=0'
      LinePen.Width = 2
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
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
  object GroupBox1: TGroupBox
    Left = 392
    Top = 512
    Width = 201
    Height = 121
    Caption = ' Voltage limits: '
    TabOrder = 20
    object StaticText5: TStaticText
      Left = 9
      Top = 22
      Width = 102
      Height = 20
      Caption = 'Limit for Vav, mV'
      TabOrder = 0
    end
    object DDSpinEdit5: TDDSpinEdit
      Left = 144
      Top = 20
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Increment = 5.000000000000000000
      ParentFont = False
      TabOrder = 1
      Value = -15.000000000000000000
    end
    object StaticText7: TStaticText
      Left = 9
      Top = 40
      Width = 126
      Height = 20
      Caption = 'Level for avPSC, mV'
      TabOrder = 2
    end
    object DDSpinEdit10: TDDSpinEdit
      Left = 144
      Top = 38
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Increment = 5.000000000000000000
      ParentFont = False
      TabOrder = 3
      Value = -40.000000000000000000
    end
    object DDSpinEdit11: TDDSpinEdit
      Left = 144
      Top = 56
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Increment = 5.000000000000000000
      ParentFont = False
      TabOrder = 4
      Value = -20.000000000000000000
    end
    object StaticText8: TStaticText
      Left = 9
      Top = 58
      Width = 136
      Height = 20
      Caption = 'Level for WidthAP, mV'
      TabOrder = 5
    end
    object DDSpinEdit12: TDDSpinEdit
      Left = 144
      Top = 74
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Increment = 5.000000000000000000
      ParentFont = False
      TabOrder = 6
      Value = -30.000000000000000000
    end
    object StaticText9: TStaticText
      Left = 9
      Top = 76
      Width = 107
      Height = 20
      Caption = 'Start of spike, mV'
      TabOrder = 7
    end
    object StaticText11: TStaticText
      Left = 9
      Top = 94
      Width = 125
      Height = 20
      Caption = 'Anticiptn for VT_1ms'
      TabOrder = 8
    end
    object DDSpinEdit14: TDDSpinEdit
      Left = 144
      Top = 92
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Increment = 0.100000000000000000
      ParentFont = False
      TabOrder = 9
      Value = 1.200000000000000000
    end
  end
  object DDSpinEdit13: TDDSpinEdit
    Left = 496
    Top = 400
    Width = 49
    Height = 26
    StrWidth = 2
    StrDecimals = 1
    Increment = 1.000000000000000000
    TabOrder = 21
    OnChange = DDSpinEdit13Change
  end
  object StaticText10: TStaticText
    Left = 392
    Top = 408
    Width = 90
    Height = 20
    Caption = 'u_min, s_min ='
    TabOrder = 22
  end
  object Chart2: TChart
    Left = 0
    Top = 336
    Width = 385
    Height = 225
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'muA/cm^2'
    LeftAxis.Title.Caption = 'for F'
    Legend.Alignment = laTop
    Legend.ColorWidth = 100
    Legend.LegendStyle = lsSeries
    Legend.ResizeChart = False
    Legend.ShadowSize = 0
    Legend.TopPos = 0
    Legend.VertMargin = 1
    RightAxis.Title.Caption = 'for G'
    View3D = False
    Color = 12443610
    TabOrder = 23
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 8421631
      Title = 'F'
      Pointer.Brush.Color = clRed
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
    object Series3: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clLime
      Title = 'G'
      VertAxis = aRightAxis
      OnDblClick = Series3DblClick
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
  end
  object Chart3: TChart
    Left = 0
    Top = 560
    Width = 385
    Height = 130
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'u, mkA/cm^2'
    LeftAxis.Title.Caption = 'mV'
    Legend.ColorWidth = 30
    Legend.ResizeChart = False
    Legend.ShadowSize = 0
    Legend.TopPos = 5
    RightAxis.Title.Caption = 'mV'
    View3D = False
    Color = 12443610
    TabOrder = 24
    object Series4: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlack
      Title = 'Vmax'
      LinePen.Width = 2
      Pointer.Brush.Color = clYellow
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psTriangle
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
    object Series5: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clLime
      Title = 'V_Conv'
      VertAxis = aRightAxis
      LinePen.Width = 2
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
    object Series6: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlack
      Title = 'Vmin'
      LinePen.Width = 2
      Pointer.Brush.Color = clYellow
      Pointer.HorizSize = 3
      Pointer.InflateMargins = True
      Pointer.Style = psTriangle
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
  end
  object Button5: TButton
    Left = 360
    Top = 192
    Width = 233
    Height = 25
    Caption = 'Plot Frequency(Ge,Gi)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 25
    OnClick = Button5Click
  end
  object CheckBox2: TCheckBox
    Left = 408
    Top = 68
    Width = 137
    Height = 17
    Caption = 'IfDistributedModel'
    TabOrder = 26
  end
end
