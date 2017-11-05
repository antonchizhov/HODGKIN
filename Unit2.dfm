object Form2: TForm2
  Left = 272
  Top = 0
  Width = 860
  Height = 740
  AutoSize = True
  Caption = 'Form2'
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
  object XYPlot1: Tsp_XYPlot
    Left = 0
    Top = 50
    Width = 457
    Height = 224
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    PopupMenu = PopupMenu5
    TabOrder = 1
    LeftAxis.Margin = 30
    LeftAxis.Caption = 'I/Imax'
    LeftAxis.TicksCount = 6
    LeftAxis.LineAttr.Color = clBlack
    LeftAxis.LineAttr.Visible = True
    LeftAxis.GridAttr.Color = clGray
    LeftAxis.GridAttr.Visible = True
    LeftAxis.LabelFormat = '###0.##'
    LeftAxis.SFlags = 193
    LeftAxis.SLinePos = (
      56
      179
      174)
    LeftAxis.fMin = 0.775000000000000000
    LeftAxis.fMax = 10.225000000000000000
    RightAxis.Margin = 60
    RightAxis.Caption = 'g/gmax, m^3, h'
    RightAxis.TicksCount = 6
    RightAxis.LineAttr.Color = clBlack
    RightAxis.LineAttr.Visible = True
    RightAxis.GridAttr.Color = clGray
    RightAxis.GridAttr.Visible = False
    RightAxis.LabelFormat = '###0.##'
    RightAxis.SFlags = 233
    RightAxis.SLinePos = (
      370
      179
      174)
    RightAxis.fMin = 0.775000000000000000
    RightAxis.fMax = 10.225000000000000000
    BottomAxis.Margin = 25
    BottomAxis.Caption = 'V, mV'
    BottomAxis.TicksCount = 8
    BottomAxis.LineAttr.Color = clBlack
    BottomAxis.LineAttr.Visible = True
    BottomAxis.GridAttr.Color = clGray
    BottomAxis.GridAttr.Visible = True
    BottomAxis.LabelFormat = '###0.##'
    BottomAxis.SFlags = 0
    BottomAxis.SLinePos = (
      57
      180
      312)
    BottomAxis.fMin = -100.000000000000000000
    BottomAxis.fMax = 50.000000000000000000
    TopAxis.Margin = 4
    TopAxis.LineAttr.Color = clBlack
    TopAxis.LineAttr.Visible = True
    TopAxis.GridAttr.Color = clGray
    TopAxis.GridAttr.Visible = False
    TopAxis.LabelFormat = '###0.##'
    TopAxis.SFlags = 56
    TopAxis.SLinePos = (
      57
      4
      312)
    TopAxis.fMax = 10.000000000000000000
    BorderStyle = bs_Raised
    FieldColor = clWhite
    BufferedDisplay = True
  end
  object XYPlot2: Tsp_XYPlot
    Left = 0
    Top = 299
    Width = 457
    Height = 222
    Color = clBtnFace
    ParentColor = False
    TabOrder = 2
    LeftAxis.Margin = 30
    LeftAxis.Caption = 'I Peak'
    LeftAxis.TicksCount = 6
    LeftAxis.LineAttr.Color = clBlack
    LeftAxis.LineAttr.Visible = True
    LeftAxis.GridAttr.Color = clGray
    LeftAxis.GridAttr.Visible = True
    LeftAxis.LabelFormat = '###0.##'
    LeftAxis.SFlags = 193
    LeftAxis.SLinePos = (
      56
      177
      172)
    LeftAxis.fMin = 0.775000000000000000
    LeftAxis.fMax = 10.225000000000000000
    RightAxis.Margin = 60
    RightAxis.TicksCount = 6
    RightAxis.LineAttr.Color = clBlack
    RightAxis.LineAttr.Visible = True
    RightAxis.GridAttr.Color = clGray
    RightAxis.GridAttr.Visible = False
    RightAxis.LabelFormat = '###0.##'
    RightAxis.SFlags = 57
    RightAxis.SLinePos = (
      396
      177
      172)
    RightAxis.fMax = 1.000000000000000000
    BottomAxis.Margin = 25
    BottomAxis.Caption = 'V, mV'
    BottomAxis.TicksCount = 8
    BottomAxis.LineAttr.Color = clBlack
    BottomAxis.LineAttr.Visible = True
    BottomAxis.GridAttr.Color = clGray
    BottomAxis.GridAttr.Visible = True
    BottomAxis.LabelFormat = '###0.##'
    BottomAxis.SFlags = 0
    BottomAxis.SLinePos = (
      57
      178
      338)
    BottomAxis.fMin = -100.000000000000000000
    BottomAxis.fMax = 50.000000000000000000
    TopAxis.Margin = 4
    TopAxis.LineAttr.Color = clBlack
    TopAxis.LineAttr.Visible = True
    TopAxis.GridAttr.Color = clGray
    TopAxis.GridAttr.Visible = False
    TopAxis.LabelFormat = '###0.##'
    TopAxis.SFlags = 56
    TopAxis.SLinePos = (
      57
      4
      338)
    TopAxis.fMax = 10.000000000000000000
    BorderStyle = bs_Raised
    FieldColor = clWhite
    BufferedDisplay = True
  end
  object StaticText1: TStaticText
    Left = 183
    Top = 280
    Width = 103
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' Voltage-Current '
    TabOrder = 3
  end
  object XYPlot3: Tsp_XYPlot
    Left = 0
    Top = 546
    Width = 453
    Height = 159
    Color = clBtnFace
    ParentColor = False
    TabOrder = 4
    LeftAxis.Margin = 40
    LeftAxis.Caption = 'PSC'
    LeftAxis.LineAttr.Color = clBlack
    LeftAxis.LineAttr.Visible = True
    LeftAxis.GridAttr.Color = clGray
    LeftAxis.GridAttr.Visible = True
    LeftAxis.LabelFormat = '###0.##'
    LeftAxis.SFlags = 193
    LeftAxis.SLinePos = (
      73
      114
      104)
    LeftAxis.fMin = 1.800000000000000000
    LeftAxis.fMax = 10.200000000000000000
    RightAxis.Margin = 4
    RightAxis.LineAttr.Color = clBlack
    RightAxis.LineAttr.Visible = True
    RightAxis.GridAttr.Color = clGray
    RightAxis.GridAttr.Visible = False
    RightAxis.LabelFormat = '###0.##'
    RightAxis.SFlags = 57
    RightAxis.SLinePos = (
      440
      114
      104)
    RightAxis.fMax = 10.000000000000000000
    BottomAxis.Margin = 25
    BottomAxis.Caption = 't, ms'
    BottomAxis.LineAttr.Color = clBlack
    BottomAxis.LineAttr.Visible = True
    BottomAxis.GridAttr.Color = clGray
    BottomAxis.GridAttr.Visible = True
    BottomAxis.LabelFormat = '###0.##'
    BottomAxis.SFlags = 128
    BottomAxis.SLinePos = (
      74
      115
      365)
    BottomAxis.fMax = 9.225000000000000000
    TopAxis.Margin = 4
    TopAxis.LineAttr.Color = clBlack
    TopAxis.LineAttr.Visible = True
    TopAxis.GridAttr.Color = clGray
    TopAxis.GridAttr.Visible = False
    TopAxis.LabelFormat = '###0.##'
    TopAxis.SFlags = 56
    TopAxis.SLinePos = (
      74
      9
      365)
    TopAxis.fMax = 10.000000000000000000
    BorderStyle = bs_Raised
    FieldColor = clWhite
    BufferedDisplay = True
  end
  object StaticText2: TStaticText
    Left = 190
    Top = 526
    Width = 106
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' Evolution in time '
    TabOrder = 5
  end
  object StaticText3: TStaticText
    Left = 145
    Top = 30
    Width = 205
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' Peak currents and conductances '
    TabOrder = 6
  end
  object Button1: TButton
    Left = 128
    Top = 0
    Width = 129
    Height = 25
    Hint = '?????????????'
    Caption = 'I/I_max, g/g_max'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    PopupMenu = PopupMenu2
    ShowHint = True
    TabOrder = 8
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 256
    Top = 0
    Width = 129
    Height = 25
    Hint = '????????? m^3, h (??? ??????????? ??????? ????????)'
    Caption = '????????? m^3, h'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    PopupMenu = PopupMenu3
    ShowHint = True
    TabOrder = 9
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 0
    Top = 0
    Width = 127
    Height = 25
    Hint = 
      '????????? ??????????? ???????????? ????????????? ? ????? ?? ????' +
      '?????? ????????'
    Caption = '????????? g ? I'
    Default = True
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    PopupMenu = PopupMenu1
    ShowHint = True
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 512
    Top = 0
    Width = 96
    Height = 25
    Caption = ' Clear All '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnClick = Button4Click
  end
  object XYPlot4: Tsp_XYPlot
    Left = 464
    Top = 50
    Width = 386
    Height = 224
    Color = clBtnFace
    ParentColor = False
    PopupMenu = PopupMenu4
    TabOrder = 11
    LeftAxis.Margin = 30
    LeftAxis.Caption = 'tau, ms'
    LeftAxis.TicksCount = 6
    LeftAxis.LineAttr.Color = clBlack
    LeftAxis.LineAttr.Visible = True
    LeftAxis.GridAttr.Color = clGray
    LeftAxis.GridAttr.Visible = True
    LeftAxis.LabelFormat = '###0.##'
    LeftAxis.SFlags = 129
    LeftAxis.SLinePos = (
      49
      179
      173)
    LeftAxis.fMax = 10.250000000000000000
    RightAxis.Margin = 30
    RightAxis.Caption = 'a, b'
    RightAxis.LineAttr.Color = clBlack
    RightAxis.LineAttr.Visible = True
    RightAxis.GridAttr.Color = clGray
    RightAxis.GridAttr.Visible = False
    RightAxis.LabelFormat = '###0.##'
    RightAxis.SFlags = 233
    RightAxis.SLinePos = (
      329
      179
      173)
    RightAxis.fMin = 0.775000000000000000
    RightAxis.fMax = 10.225000000000000000
    BottomAxis.Margin = 25
    BottomAxis.Caption = 'V, mV'
    BottomAxis.TicksCount = 8
    BottomAxis.LineAttr.Color = clBlack
    BottomAxis.LineAttr.Visible = True
    BottomAxis.GridAttr.Color = clGray
    BottomAxis.GridAttr.Visible = True
    BottomAxis.LabelFormat = '###0.##'
    BottomAxis.SFlags = 0
    BottomAxis.SLinePos = (
      50
      180
      278)
    BottomAxis.fMin = -100.000000000000000000
    BottomAxis.fMax = 50.000000000000000000
    TopAxis.Margin = 4
    TopAxis.LineAttr.Color = clBlack
    TopAxis.LineAttr.Visible = True
    TopAxis.GridAttr.Color = clGray
    TopAxis.GridAttr.Visible = False
    TopAxis.LabelFormat = '###0.##'
    TopAxis.SFlags = 56
    TopAxis.SLinePos = (
      50
      5
      278)
    TopAxis.fMax = 10.000000000000000000
    BorderStyle = bs_Raised
    FieldColor = clWhite
  end
  object StaticText4: TStaticText
    Left = 657
    Top = 30
    Width = 46
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' tau_m '
    TabOrder = 12
  end
  object Button5: TButton
    Left = 384
    Top = 0
    Width = 129
    Height = 25
    Hint = '????????? tau ??? m ? h'
    Caption = 'tau_m, tau_h'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    PopupMenu = PopupMenu4
    ShowHint = True
    TabOrder = 13
    OnClick = Button5Click
  end
  object XYPlot5: Tsp_XYPlot
    Left = 464
    Top = 299
    Width = 388
    Height = 222
    Color = clBtnFace
    ParentColor = False
    PopupMenu = PopupMenu4
    TabOrder = 14
    LeftAxis.Margin = 30
    LeftAxis.Caption = 'tau, ms'
    LeftAxis.TicksCount = 6
    LeftAxis.LineAttr.Color = clBlack
    LeftAxis.LineAttr.Visible = True
    LeftAxis.GridAttr.Color = clGray
    LeftAxis.GridAttr.Visible = True
    LeftAxis.LabelFormat = '###0.##'
    LeftAxis.SFlags = 129
    LeftAxis.SLinePos = (
      49
      177
      171)
    LeftAxis.fMax = 10.250000000000000000
    RightAxis.Margin = 30
    RightAxis.Caption = 'a, b'
    RightAxis.LineAttr.Color = clBlack
    RightAxis.LineAttr.Visible = True
    RightAxis.GridAttr.Color = clGray
    RightAxis.GridAttr.Visible = False
    RightAxis.LabelFormat = '###0.##'
    RightAxis.SFlags = 233
    RightAxis.SLinePos = (
      331
      177
      171)
    RightAxis.fMin = 0.775000000000000000
    RightAxis.fMax = 10.225000000000000000
    BottomAxis.Margin = 25
    BottomAxis.Caption = 'V, mV'
    BottomAxis.TicksCount = 8
    BottomAxis.LineAttr.Color = clBlack
    BottomAxis.LineAttr.Visible = True
    BottomAxis.GridAttr.Color = clGray
    BottomAxis.GridAttr.Visible = True
    BottomAxis.LabelFormat = '###0.##'
    BottomAxis.SFlags = 0
    BottomAxis.SLinePos = (
      50
      178
      280)
    BottomAxis.fMin = -100.000000000000000000
    BottomAxis.fMax = 50.000000000000000000
    TopAxis.Margin = 4
    TopAxis.LineAttr.Color = clBlack
    TopAxis.LineAttr.Visible = True
    TopAxis.GridAttr.Color = clGray
    TopAxis.GridAttr.Visible = False
    TopAxis.LabelFormat = '###0.##'
    TopAxis.SFlags = 56
    TopAxis.SLinePos = (
      50
      5
      280)
    TopAxis.fMax = 10.000000000000000000
    BorderStyle = bs_Raised
    FieldColor = clWhite
  end
  object StaticText5: TStaticText
    Left = 657
    Top = 280
    Width = 42
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' tau_h '
    TabOrder = 15
  end
  object Button6: TButton
    Left = 744
    Top = 0
    Width = 107
    Height = 25
    Caption = 'MoveLegends'
    TabOrder = 16
    OnClick = Button6Click
  end
  object Button7: TButton
    Left = 609
    Top = 0
    Width = 96
    Height = 25
    Hint = '?????????? ?????????? ?????????? g ? I'
    Caption = ' Stop '
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Times New Roman'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 17
    OnClick = Button7Click
  end
  object Chart1: TChart
    Left = 0
    Top = 184
    Width = 265
    Height = 89
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    MarginBottom = 2
    MarginLeft = 2
    MarginRight = 1
    MarginTop = 2
    Title.Text.Strings = (
      'Peak currents and conductances')
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.ExactDateTime = False
    BottomAxis.Increment = 20.000000000000000000
    BottomAxis.Maximum = 50.000000000000000000
    BottomAxis.Minimum = -100.100000000000000000
    BottomAxis.Title.Caption = 'V, mV'
    LeftAxis.Title.Caption = 'I / Imax'
    Legend.ColorWidth = 30
    Legend.HorizMargin = 1
    Legend.ShadowSize = 0
    Legend.TopPos = 2
    RightAxis.Title.Caption = 'g/gmax'
    View3D = False
    Color = clWhite
    TabOrder = 0
    Visible = False
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'g/gMax'
      VertAxis = aRightAxis
      LinePen.Width = 2
      LinePen.Visible = False
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
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clLime
      Title = 'I/IMax'
      LinePen.Width = 2
      LinePen.Visible = False
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
    object Series3: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 4227327
      Title = 'm^3, exp'
      VertAxis = aRightAxis
      LinePen.Color = 4227327
      LinePen.Width = 2
      Pointer.HorizSize = 6
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
    object Series4: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'h, exp'
      LinePen.Width = 2
      Pointer.HorizSize = 6
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
  end
  object XYLine1: Tsp_XYLine
    Plot = XYPlot1
    YAxis = dsyRight
    Legend = 'g/gMax'
    LineAttr.Color = clNavy
    LineAttr.Width = 2
    LineAttr.Visible = False
    PointAttr.Color = clRed
    PointAttr.Kind = ptRectangle
    PointAttr.Visible = True
    Left = 392
    Top = 64
  end
  object XYLine2: Tsp_XYLine
    Plot = XYPlot1
    Legend = 'I/IMax'
    LineAttr.Color = clRed
    LineAttr.Width = 2
    LineAttr.Visible = False
    PointAttr.Color = clLime
    PointAttr.Kind = ptEllipse
    PointAttr.Visible = True
    Left = 64
    Top = 64
  end
  object XYLine3: Tsp_XYLine
    Plot = XYPlot1
    YAxis = dsyRight
    Legend = 'm_inf^3'
    LineAttr.Color = clRed
    LineAttr.Visible = True
    PointAttr.Kind = ptRectangle
    PointAttr.Visible = False
    Left = 432
    Top = 32
  end
  object XYLine4: Tsp_XYLine
    Plot = XYPlot1
    YAxis = dsyRight
    Legend = 'h_inf'
    LineAttr.Color = clLime
    LineAttr.Visible = True
    PointAttr.Kind = ptRectangle
    PointAttr.Visible = False
    Left = 416
    Top = 32
  end
  object XYLine5: Tsp_XYLine
    Plot = XYPlot1
    YAxis = dsyRight
    Legend = 'm^3, exp'
    LineAttr.Color = clBlack
    LineAttr.Visible = False
    PointAttr.Color = 33023
    PointAttr.Kind = ptEllipse
    PointAttr.HSize = 15
    PointAttr.Visible = True
    Left = 424
    Top = 64
  end
  object XYLine6: Tsp_XYLine
    Plot = XYPlot1
    Legend = 'h, exp'
    LineAttr.Color = clBlack
    LineAttr.Visible = False
    PointAttr.Color = 4227200
    PointAttr.Kind = ptEllipse
    PointAttr.HSize = 15
    PointAttr.Visible = True
    Left = 96
    Top = 64
  end
  object XYLine7: Tsp_XYLine
    Plot = XYPlot2
    Legend = 'BAX, exp.'
    LineAttr.Color = clBlack
    LineAttr.Width = 3
    LineAttr.Visible = False
    PointAttr.Kind = ptEllipse
    PointAttr.HSize = 15
    PointAttr.Visible = True
    PointAttr.BorderWidth = 2
    Left = 8
    Top = 408
  end
  object XYLine8: Tsp_XYLine
    Plot = XYPlot2
    Legend = 'BAX, inact.'
    LineAttr.Color = clGreen
    LineAttr.Visible = True
    PointAttr.Color = clLime
    PointAttr.Kind = ptEllipse
    PointAttr.Visible = True
    Left = 8
    Top = 448
  end
  object XYLine9: Tsp_XYLine
    Plot = XYPlot3
    Legend = 'I(t)'
    LineAttr.Color = clAqua
    LineAttr.Width = 2
    LineAttr.Visible = True
    PointAttr.Kind = ptRectangle
    PointAttr.Visible = False
    Left = 16
    Top = 672
  end
  object XYLine10: Tsp_XYLine
    Plot = XYPlot3
    Legend = 'I(t), exp.'
    LineAttr.Color = clGray
    LineAttr.Visible = True
    PointAttr.Kind = ptEllipse
    PointAttr.HSize = 15
    PointAttr.Visible = True
    Left = 64
    Top = 672
  end
  object XYLine11: Tsp_XYLine
    Plot = XYPlot2
    Legend = 'BAX, act.'
    LineAttr.Color = clRed
    LineAttr.Visible = True
    PointAttr.Color = 33023
    PointAttr.Kind = ptEllipse
    PointAttr.Visible = True
    Left = 40
    Top = 448
  end
  object XYLine12: Tsp_XYLine
    Plot = XYPlot4
    Legend = 'tau_m'
    LineAttr.Color = clRed
    LineAttr.Visible = True
    PointAttr.Color = 4227327
    PointAttr.Kind = ptEllipse
    PointAttr.Visible = True
    Left = 640
    Top = 72
  end
  object XYLine13: Tsp_XYLine
    Plot = XYPlot5
    Legend = 'tau_h'
    LineAttr.Color = clRed
    LineAttr.Visible = True
    PointAttr.Color = 4227327
    PointAttr.Kind = ptEllipse
    PointAttr.Visible = True
    Left = 640
    Top = 344
  end
  object XYLine14: Tsp_XYLine
    Plot = XYPlot4
    YAxis = dsyRight
    Legend = 'alpha for tau_m'
    LineAttr.Color = clYellow
    LineAttr.Visible = True
    PointAttr.Color = clYellow
    PointAttr.Kind = ptEllipse
    PointAttr.Visible = True
    Left = 624
    Top = 96
  end
  object XYLine15: Tsp_XYLine
    Plot = XYPlot4
    YAxis = dsyRight
    Legend = 'beta for tau_m'
    LineAttr.Color = clBlue
    LineAttr.Visible = True
    PointAttr.Color = clAqua
    PointAttr.Kind = ptEllipse
    PointAttr.Visible = True
    Left = 648
    Top = 96
  end
  object XYLine16: Tsp_XYLine
    Plot = XYPlot5
    YAxis = dsyRight
    Legend = 'alpha for tau_h'
    LineAttr.Color = clYellow
    LineAttr.Visible = True
    PointAttr.Color = clYellow
    PointAttr.Kind = ptEllipse
    PointAttr.Visible = True
    Left = 624
    Top = 368
  end
  object XYLine17: Tsp_XYLine
    Plot = XYPlot5
    YAxis = dsyRight
    Legend = 'beta for tau_h'
    LineAttr.Color = clBlue
    LineAttr.Visible = True
    PointAttr.Color = clAqua
    PointAttr.Kind = ptEllipse
    PointAttr.Visible = True
    Left = 648
    Top = 368
  end
  object SaveDialog1: TSaveDialog
    OnCanClose = SaveDialog1CanClose
    Left = 416
    Top = 16
  end
  object SaveDialog2: TSaveDialog
    OnCanClose = SaveDialog2CanClose
    Left = 288
    Top = 16
  end
  object SaveDialog3: TSaveDialog
    OnCanClose = SaveDialog3CanClose
    Left = 136
    Top = 16
  end
  object SaveDialog4: TSaveDialog
    OnCanClose = SaveDialog4CanClose
    Left = 168
    Top = 16
  end
  object SaveDialog5: TSaveDialog
    OnCanClose = SaveDialog5CanClose
    Left = 32
    Top = 16
  end
  object SaveDialog6: TSaveDialog
    OnCanClose = SaveDialog6CanClose
    Left = 64
    Top = 16
  end
  object PopupMenu1: TPopupMenu
    Left = 96
    Top = 16
    object Savegtofile1: TMenuItem
      Caption = 'Save g to file'
      OnClick = Savegtofile1Click
    end
    object SaveItofile1: TMenuItem
      Caption = 'Save I to file'
      OnClick = SaveItofile1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 200
    Top = 16
    object Saveggmaxtofile1: TMenuItem
      Caption = 'Save g/g_max to file'
      OnClick = Saveggmaxtofile1Click
    end
    object SaveIImaxtofile1: TMenuItem
      Caption = 'Save I/I_max to file'
      OnClick = SaveIImaxtofile1Click
    end
  end
  object PopupMenu3: TPopupMenu
    Left = 320
    Top = 16
    object Savem3htofile1: TMenuItem
      Caption = 'Save m^3, h to file'
      OnClick = Savem3htofile1Click
    end
  end
  object PopupMenu4: TPopupMenu
    Left = 448
    Top = 16
    object Savetaumtauhtofile1: TMenuItem
      Caption = 'Save tau_m, tau_h to file'
      OnClick = Savetaumtauhtofile1Click
    end
  end
  object PopupMenu5: TPopupMenu
    Left = 408
    Top = 128
    object Savegtofile2: TMenuItem
      Caption = 'Save g to file'
      OnClick = Savegtofile1Click
    end
    object SaveItofile2: TMenuItem
      Caption = 'Save I to file'
      OnClick = SaveItofile1Click
    end
    object Saveggmaxtofile2: TMenuItem
      Caption = 'Save g/g_max to file'
      OnClick = Saveggmaxtofile1Click
    end
    object SaveIImaxtofile2: TMenuItem
      Caption = 'Save I/I_max to file'
      OnClick = SaveIImaxtofile1Click
    end
    object Savem3htofile2: TMenuItem
      Caption = 'Save m^3, h to file'
      OnClick = Savem3htofile1Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 48
    Top = 24
  end
end
