object Form7: TForm7
  Left = 74
  Top = 48
  Width = 476
  Height = 934
  Caption = 'Form7: Rate of Gaussian ensemble'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Label4: TLabel
    Left = 16
    Top = 80
    Width = 386
    Height = 16
    Caption = 'Calculate Rate in case of Gaussian thresholds or noise'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic, fsUnderline]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 496
    Width = 424
    Height = 16
    Caption = 'Calculate Rate for an ansemble with Gaussian conductances'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic, fsUnderline]
    ParentFont = False
  end
  object Label16: TLabel
    Left = 0
    Top = 104
    Width = 227
    Height = 16
    Caption = '<----------Gaussian thresholds----------->'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Label17: TLabel
    Left = 232
    Top = 104
    Width = 225
    Height = 16
    Caption = '<---------------------Noise--------------------->'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsItalic]
    ParentFont = False
  end
  object Label20: TLabel
    Left = 352
    Top = 152
    Width = 65
    Height = 16
    Caption = 'tau_Noise='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Chart1: TChart
    Left = 0
    Top = 616
    Width = 465
    Height = 281
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    BackWall.Color = clWhite
    LeftWall.Brush.Color = clWhite
    MarginBottom = 1
    MarginTop = 5
    Title.Font.Charset = DEFAULT_CHARSET
    Title.Font.Color = clMaroon
    Title.Font.Height = -13
    Title.Font.Name = 'Arial'
    Title.Font.Style = []
    Title.Text.Strings = (
      'Conductanses are Gaussian!')
    Title.Visible = False
    BackColor = clWhite
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.Maximum = 25.000000000000000000
    BottomAxis.MinorTickCount = 4
    BottomAxis.Title.Caption = 't, ms'
    BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
    BottomAxis.Title.Font.Color = clBlack
    BottomAxis.Title.Font.Height = -13
    BottomAxis.Title.Font.Name = 'Arial'
    BottomAxis.Title.Font.Style = [fsBold]
    LeftAxis.MinorTickCount = 4
    LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
    LeftAxis.Title.Font.Color = clBlack
    LeftAxis.Title.Font.Height = -13
    LeftAxis.Title.Font.Name = 'Arial'
    LeftAxis.Title.Font.Style = [fsBold]
    Legend.Color = clSilver
    Legend.ColorWidth = 20
    Legend.Font.Charset = DEFAULT_CHARSET
    Legend.Font.Color = clBlack
    Legend.Font.Height = -13
    Legend.Font.Name = 'Arial'
    Legend.Font.Style = [fsBold]
    Legend.HorizMargin = 1
    Legend.LegendStyle = lsSeries
    Legend.ResizeChart = False
    Legend.ShadowSize = 0
    Legend.TextStyle = ltsPlain
    Legend.TopPos = 6
    Legend.VertMargin = 1
    RightAxis.MinorTickCount = 4
    View3D = False
    TabOrder = 5
    object Series1: TPointSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'V(t)'
      Pointer.Brush.Color = clRed
      Pointer.HorizSize = 1
      Pointer.InflateMargins = False
      Pointer.Pen.Color = clRed
      Pointer.Style = psCircle
      Pointer.VertSize = 1
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
    object Series2: TPointSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGreen
      ShowInLegend = False
      Title = 'Ends'
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
    object Series3: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clYellow
      Title = 'Mean'
      Dark3D = False
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
    object Series4: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlue
      Title = 'Mean+Dispersion'
      LinePen.Color = clBlue
      LinePen.Width = 2
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series5: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlue
      Title = 'Mean-Dispersion'
      LinePen.Color = clBlue
      LinePen.Width = 2
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series6: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clWhite
      Title = 'V(mean gE)'
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Pen.Color = clGreen
      Pointer.Style = psCircle
      Pointer.VertSize = 1
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
    object Series7: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 16384
      Title = 'V(mean gE)+sgm_V'
      LinePen.Color = 16384
      LinePen.Width = 3
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loNone
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series8: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 16384
      Title = 'V(mean gE)-sgm_V'
      LinePen.Color = 16384
      LinePen.Width = 3
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
  object Button1: TButton
    Left = 0
    Top = 120
    Width = 113
    Height = 25
    Caption = 'Run HH'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 112
    Top = 120
    Width = 113
    Height = 25
    Caption = 'Run Thr. Model'
    TabOrder = 1
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 465
    Height = 73
    Caption = 'Problem'
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 35
      Height = 16
      Caption = 'dt, ms'
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 57
      Height = 16
      Caption = 't_end, ms'
    end
    object Label3: TLabel
      Left = 144
      Top = 20
      Width = 55
      Height = 16
      Caption = 't_Iind, ms'
    end
    object Label19: TLabel
      Left = 312
      Top = 20
      Width = 91
      Height = 16
      Caption = 'Oscillations, Hz'
    end
    object DDSpinEdit2: TDDSpinEdit
      Left = 72
      Top = 16
      Width = 57
      Height = 26
      StrWidth = 2
      StrDecimals = 3
      Increment = 0.010000000000000000
      TabOrder = 0
      Value = 0.050000000000000000
    end
    object DDSpinEdit3: TDDSpinEdit
      Left = 72
      Top = 40
      Width = 57
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Increment = 20.000000000000000000
      TabOrder = 1
      Value = 120.000000000000000000
    end
    object DDSpinEdit4: TDDSpinEdit
      Left = 208
      Top = 16
      Width = 57
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Increment = 20.000000000000000000
      TabOrder = 2
      Value = 2000.000000000000000000
    end
    object CheckBox1: TCheckBox
      Left = 144
      Top = 48
      Width = 129
      Height = 17
      Caption = 'Fix Threshold, mV:'
      TabOrder = 3
      OnClick = CheckBox1Click
    end
    object DDSpinEdit1: TDDSpinEdit
      Left = 280
      Top = 40
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 1
      Enabled = False
      Increment = 1.000000000000000000
      TabOrder = 4
      Value = 14.000000000000000000
    end
    object DDSpinEdit15: TDDSpinEdit
      Left = 408
      Top = 16
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Increment = 10.000000000000000000
      TabOrder = 5
    end
    object CheckBox2: TCheckBox
      Left = 368
      Top = 48
      Width = 89
      Height = 17
      Caption = 'Don'#39't clear'
      TabOrder = 6
    end
  end
  object Button3: TButton
    Left = 112
    Top = 520
    Width = 113
    Height = 25
    Caption = 'Run Thr. Model'
    TabOrder = 3
    OnClick = Button3Click
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 552
    Width = 465
    Height = 65
    Hint = 'if 0 then cond. is constant'
    Caption = 'Set for dispersed conductances'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    object Label9: TLabel
      Left = 8
      Top = 24
      Width = 89
      Height = 12
      Caption = 'Ampl_gE, mS/cm^2'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 8
      Top = 44
      Width = 43
      Height = 12
      Caption = 'tau_E, ms'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 168
      Top = 24
      Width = 49
      Height = 12
      Caption = 'sigmaG_nd'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 304
      Top = 24
      Width = 37
      Height = 12
      Caption = 'Iind, pA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label13: TLabel
      Left = 164
      Top = 44
      Width = 68
      Height = 12
      Caption = 'Mesh for Gauss'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object DDSpinEdit8: TDDSpinEdit
      Left = 105
      Top = 18
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Increment = 0.010000000000000000
      ParentFont = False
      TabOrder = 0
      Value = 0.010000000000000000
    end
    object DDSpinEdit9: TDDSpinEdit
      Left = 105
      Top = 38
      Width = 49
      Height = 26
      StrWidth = 2
      StrDecimals = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Increment = 10.000000000000000000
      ParentFont = False
      TabOrder = 1
    end
    object DDSpinEdit10: TDDSpinEdit
      Left = 240
      Top = 18
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
      TabOrder = 2
      Value = 0.200000000000000000
    end
    object DDSpinEdit11: TDDSpinEdit
      Left = 344
      Top = 18
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
      TabOrder = 3
    end
    object DDSpinEdit12: TDDSpinEdit
      Left = 240
      Top = 38
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
      TabOrder = 4
      Value = 4.000000000000000000
    end
  end
  object Button4: TButton
    Left = 0
    Top = 520
    Width = 113
    Height = 25
    Caption = 'Run HH'
    TabOrder = 6
    OnClick = Button4Click
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 176
    Width = 465
    Height = 65
    Caption = 'Set parameters '
    TabOrder = 7
    object Label8: TLabel
      Left = 180
      Top = 16
      Width = 68
      Height = 12
      Caption = 'Mesh for Gauss'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 348
      Top = 16
      Width = 37
      Height = 12
      Caption = 'Iind, pA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 180
      Top = 36
      Width = 89
      Height = 12
      Caption = 'Mesh for rate, Nrate'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label14: TLabel
      Left = 8
      Top = 20
      Width = 29
      Height = 12
      Caption = 'sgm_V'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 352
      Top = 35
      Width = 19
      Height = 12
      Caption = 'nV='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label18: TLabel
      Left = 8
      Top = 36
      Width = 100
      Height = 12
      Caption = 'sgmV at t=               ='
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object DDSpinEdit5: TDDSpinEdit
      Left = 400
      Top = 12
      Width = 57
      Height = 21
      StrWidth = 2
      StrDecimals = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      Increment = 20.000000000000000000
      ParentFont = False
      TabOrder = 1
      Value = 300.000000000000000000
    end
    object DDSpinEdit7: TDDSpinEdit
      Left = 280
      Top = 15
      Width = 57
      Height = 21
      StrWidth = 2
      StrDecimals = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      Increment = 20.000000000000000000
      ParentFont = False
      TabOrder = 0
      Value = 4000.000000000000000000
    end
    object DDSpinEdit6: TDDSpinEdit
      Left = 280
      Top = 35
      Width = 57
      Height = 21
      StrWidth = 2
      StrDecimals = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      Increment = 20.000000000000000000
      ParentFont = False
      TabOrder = 2
      Value = 240.000000000000000000
    end
    object DDSpinEdit13: TDDSpinEdit
      Left = 59
      Top = 15
      Width = 46
      Height = 21
      StrWidth = 2
      StrDecimals = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      Increment = 0.200000000000000000
      ParentFont = False
      TabOrder = 3
      Value = 3.000000000000000000
    end
    object DDSpinEdit14: TDDSpinEdit
      Left = 59
      Top = 35
      Width = 46
      Height = 21
      StrWidth = 2
      StrDecimals = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      Increment = 5.000000000000000000
      ParentFont = False
      TabOrder = 4
      Value = 100.000000000000000000
    end
  end
  object Button5: TButton
    Left = 232
    Top = 120
    Width = 113
    Height = 25
    Caption = 'Run HH'
    TabOrder = 8
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 344
    Top = 120
    Width = 113
    Height = 25
    Caption = 'Run Thr. Model'
    TabOrder = 9
    OnClick = Button6Click
  end
  object Chart2: TChart
    Left = 0
    Top = 240
    Width = 465
    Height = 250
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    MarginBottom = 1
    MarginLeft = 1
    MarginRight = 1
    MarginTop = 5
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.MinorTickCount = 4
    BottomAxis.Title.Caption = 't, ms'
    BottomAxis.Title.Font.Charset = DEFAULT_CHARSET
    BottomAxis.Title.Font.Color = clBlack
    BottomAxis.Title.Font.Height = -13
    BottomAxis.Title.Font.Name = 'Arial'
    BottomAxis.Title.Font.Style = [fsBold]
    LeftAxis.MinorTickCount = 4
    LeftAxis.Title.Angle = 0
    LeftAxis.Title.Caption = 'Hz'
    LeftAxis.Title.Font.Charset = DEFAULT_CHARSET
    LeftAxis.Title.Font.Color = clBlack
    LeftAxis.Title.Font.Height = -13
    LeftAxis.Title.Font.Name = 'Arial'
    LeftAxis.Title.Font.Style = [fsBold]
    Legend.Alignment = laTop
    Legend.Color = clSilver
    Legend.ColorWidth = 30
    Legend.Font.Charset = DEFAULT_CHARSET
    Legend.Font.Color = clBlack
    Legend.Font.Height = -13
    Legend.Font.Name = 'Arial'
    Legend.Font.Style = [fsBold]
    Legend.HorizMargin = 1
    Legend.ResizeChart = False
    Legend.ShadowSize = 0
    Legend.TopPos = 2
    Legend.VertMargin = 1
    RightAxis.Grid.Visible = False
    RightAxis.MinorTickCount = 4
    RightAxis.Title.Angle = 0
    RightAxis.Title.Caption = 'mV'
    RightAxis.Title.Font.Charset = DEFAULT_CHARSET
    RightAxis.Title.Font.Color = clBlack
    RightAxis.Title.Font.Height = -13
    RightAxis.Title.Font.Name = 'Arial'
    RightAxis.Title.Font.Style = [fsBold]
    View3D = False
    TabOrder = 10
    object Series10: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGray
      Title = 'V(t)'
      VertAxis = aRightAxis
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
    object Series9: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clMaroon
      Title = 'ro(t,0)'
      LinePen.Width = 2
      Pointer.Brush.Color = clWhite
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
  object ComboBox1: TComboBox
    Left = 104
    Top = 192
    Width = 65
    Height = 20
    Hint = 'Is sgm  relative or fixed in mV?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 12
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    Text = 'ComboBox1'
    OnChange = ComboBox1Change
    OnDblClick = ComboBox1DblClick
    Items.Strings = (
      'in mV'
      'nondim.')
  end
  object Button7: TButton
    Left = 0
    Top = 144
    Width = 113
    Height = 25
    Caption = 'Run Network'
    TabOrder = 12
    OnClick = Button7Click
  end
  object CheckBox3: TCheckBox
    Left = 114
    Top = 167
    Width = 105
    Height = 17
    Caption = 'Thr. Renewal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
  end
  object Button8: TButton
    Left = 232
    Top = 144
    Width = 113
    Height = 25
    Hint = 'Written only for white noise'
    Caption = 'Run Network'
    TabOrder = 14
    OnClick = Button8Click
  end
  object ComboBox2: TComboBox
    Left = 114
    Top = 144
    Width = 113
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 15
    Text = 'ComboBox2'
    OnChange = ComboBox2Change
    Items.Strings = (
      'Disperse Thr.'
      'Disperse gL'
      'Disperse Thr. and gL')
  end
  object DDSpinEdit16: TDDSpinEdit
    Left = 424
    Top = 152
    Width = 41
    Height = 21
    StrWidth = 2
    StrDecimals = 1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'Tahoma'
    Font.Style = []
    Increment = 1.000000000000000000
    ParentFont = False
    TabOrder = 16
    OnDblClick = DDSpinEdit16DblClick
  end
end
