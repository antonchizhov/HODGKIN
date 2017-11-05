object Form6: TForm6
  Left = 283
  Top = 45
  Width = 437
  Height = 402
  AutoSize = True
  Caption = 'Form6: Adaptation'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object DDSpinEdit1: TDDSpinEdit
    Left = 335
    Top = 47
    Width = 69
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 100.000000000000000000
    TabOrder = 0
    OnChange = DDSpinEdit1Change
  end
  object DDSpinEdit4: TDDSpinEdit
    Left = 335
    Top = 71
    Width = 69
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 1.000000000000000000
    TabOrder = 1
    OnChange = DDSpinEdit4Change
  end
  object StaticText4: TStaticText
    Left = 245
    Top = 71
    Width = 86
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' Step for Iind   '
    TabOrder = 2
  end
  object StaticText1: TStaticText
    Left = 245
    Top = 47
    Width = 86
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' Iind_max, pA '
    TabOrder = 3
  end
  object Button1: TButton
    Left = 0
    Top = 47
    Width = 75
    Height = 24
    Caption = 'Start'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 73
    Top = 47
    Width = 73
    Height = 24
    Caption = 'Clear'
    TabOrder = 5
    OnClick = Button2Click
  end
  object StaticText3: TStaticText
    Left = 245
    Top = 95
    Width = 85
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' t_end, ms       '
    TabOrder = 6
  end
  object DDSpinEdit3: TDDSpinEdit
    Left = 335
    Top = 92
    Width = 69
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 10.000000000000000000
    TabOrder = 7
    OnChange = DDSpinEdit3Change
  end
  object StaticText2: TStaticText
    Left = 0
    Top = 20
    Width = 231
    Height = 20
    Caption = ' The plot is written in '#39'adaptation(I).dat'#39' '
    TabOrder = 8
  end
  object StaticText5: TStaticText
    Left = 0
    Top = 0
    Width = 429
    Height = 20
    Caption = 
      ' Draws reverse interspike intervals (1/ISI) versus stimulation c' +
      'urrent (Iind)'
    TabOrder = 9
  end
  object Chart1: TChart
    Left = 0
    Top = 120
    Width = 409
    Height = 250
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'Iind, pA'
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Title.Caption = '1/ISI, Hz'
    Legend.Alignment = laTop
    Legend.ColorWidth = 40
    Legend.ResizeChart = False
    Legend.ShadowSize = 0
    Legend.VertMargin = 1
    View3D = False
    TabOrder = 10
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'first'
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
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'second'
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
    object Series3: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clYellow
      Title = 'third'
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
    object Series4: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlue
      Title = 'forth'
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
    object Series5: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 8453888
      Title = 'fifth'
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
  end
end
