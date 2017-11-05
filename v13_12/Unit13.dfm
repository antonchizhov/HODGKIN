object Form13: TForm13
  Left = 920
  Top = 377
  Hint = 'Ghystogramand correlation function of the signal set'
  Anchors = []
  AutoScroll = False
  AutoSize = True
  Caption = 'Form13: Statistics'
  ClientHeight = 586
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  ShowHint = True
  PixelsPerInch = 120
  TextHeight = 16
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 400
    Height = 249
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'Ghystogram of firing rate')
    BottomAxis.MinorTickCount = 4
    BottomAxis.Title.Caption = 'Hz'
    LeftAxis.MinorTickCount = 4
    Legend.Visible = False
    RightAxis.MinorTickCount = 4
    View3D = False
    TabOrder = 0
    object Series1: TBarSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Bar'
      YValues.Multiplier = 1
      YValues.Order = loNone
      object TeeFunction1: TAverageTeeFunction
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 256
    Width = 185
    Height = 73
    Caption = ' Parameters of ghystogram '
    TabOrder = 1
    object DDSpinEdit1: TDDSpinEdit
      Left = 120
      Top = 18
      Width = 41
      Height = 22
      StrWidth = 2
      StrDecimals = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Increment = 10
      ParentFont = False
      TabOrder = 0
      Value = 200
      OnChange = DDSpinEdit1Change
    end
    object StaticText42: TStaticText
      Left = 8
      Top = 22
      Width = 65
      Height = 17
      Caption = 'Min and Max'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object DDSpinEdit2: TDDSpinEdit
      Left = 80
      Top = 40
      Width = 41
      Height = 22
      StrWidth = 2
      StrDecimals = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Increment = 10
      ParentFont = False
      TabOrder = 2
      Value = 30
      OnChange = DDSpinEdit2Change
    end
    object StaticText1: TStaticText
      Left = 8
      Top = 44
      Width = 55
      Height = 17
      Caption = 'n_intervals'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object DDSpinEdit4: TDDSpinEdit
      Left = 80
      Top = 18
      Width = 41
      Height = 22
      StrWidth = 2
      StrDecimals = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Increment = 10
      ParentFont = False
      TabOrder = 4
      OnChange = DDSpinEdit4Change
    end
  end
  object Chart2: TChart
    Left = 0
    Top = 328
    Width = 400
    Height = 258
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'Correlation function ')
    BottomAxis.MinorTickCount = 4
    BottomAxis.Title.Caption = 'tau, ms'
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.ExactDateTime = False
    LeftAxis.Increment = 0.2
    LeftAxis.Maximum = 1.2
    LeftAxis.Minimum = -0.2
    LeftAxis.MinorTickCount = 4
    Legend.Visible = False
    RightAxis.MinorTickCount = 4
    TopAxis.Title.Caption = 'tau, ms'
    View3D = False
    TabOrder = 2
    object Label1: TLabel
      Left = 248
      Top = 72
      Width = 31
      Height = 16
      Caption = ' tau= '
    end
    object Label2: TLabel
      Left = 248
      Top = 40
      Width = 47
      Height = 16
      Caption = ' Mean= '
    end
    object Label3: TLabel
      Left = 248
      Top = 56
      Width = 67
      Height = 16
      Caption = ' Variance= '
    end
    object Series2: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 4194432
      LinePen.Color = 4194432
      LinePen.Width = 3
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1
      YValues.Order = loNone
    end
  end
  object GroupBox2: TGroupBox
    Left = 216
    Top = 256
    Width = 185
    Height = 73
    Caption = ' Parameters of corr. function'
    TabOrder = 3
    object DDSpinEdit3: TDDSpinEdit
      Left = 80
      Top = 18
      Width = 57
      Height = 22
      StrWidth = 2
      StrDecimals = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Increment = 10
      ParentFont = False
      TabOrder = 0
      Value = 1000
      OnChange = DDSpinEdit3Change
    end
    object StaticText2: TStaticText
      Left = 8
      Top = 22
      Width = 40
      Height = 17
      Caption = ' nt_corr'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
end
