object Form5: TForm5
  Left = 288
  Top = 741
  Width = 420
  Height = 421
  AutoSize = True
  Caption = 'Form5: Frequency-Current'
  Color = 12443610
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object DDSpinEdit1: TDDSpinEdit
    Left = 343
    Top = 0
    Width = 69
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 500.000000000000000000
    TabOrder = 3
    OnChange = DDSpinEdit1Change
  end
  object DDSpinEdit4: TDDSpinEdit
    Left = 343
    Top = 25
    Width = 69
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 10.000000000000000000
    TabOrder = 0
    OnChange = DDSpinEdit4Change
  end
  object StaticText4: TStaticText
    Left = 253
    Top = 25
    Width = 86
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' Step for Iind   '
    TabOrder = 1
  end
  object StaticText1: TStaticText
    Left = 253
    Top = 0
    Width = 86
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' Iind_max, pA '
    TabOrder = 2
  end
  object Button1: TButton
    Left = 8
    Top = 0
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 81
    Top = 0
    Width = 73
    Height = 25
    Caption = 'Clear'
    TabOrder = 5
    OnClick = Button2Click
  end
  object StaticText3: TStaticText
    Left = 253
    Top = 48
    Width = 85
    Height = 20
    BorderStyle = sbsSunken
    Caption = ' t_end, ms       '
    TabOrder = 6
  end
  object DDSpinEdit3: TDDSpinEdit
    Left = 343
    Top = 46
    Width = 69
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 100.000000000000000000
    TabOrder = 7
    OnChange = DDSpinEdit3Change
  end
  object StaticText2: TStaticText
    Left = 8
    Top = 30
    Width = 199
    Height = 20
    Caption = ' Plot is to be written in '#39'v(Iind).dat'#39' '
    TabOrder = 8
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 52
    Width = 97
    Height = 17
    Caption = 'IfNoise'
    TabOrder = 9
    OnClick = CheckBox1Click
  end
  object Chart1: TChart
    Left = 0
    Top = 104
    Width = 409
    Height = 282
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.Title.Caption = 'pA'
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMaximum = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Maximum = 100.000000000000000000
    LeftAxis.Title.Caption = 'Hz'
    Legend.Visible = False
    View3D = False
    Color = 12443610
    TabOrder = 10
    object Button22: TButton
      Left = 304
      Top = 264
      Width = 105
      Height = 17
      Caption = 'CopyToBMP'
      TabOrder = 0
      OnClick = Button22Click
    end
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Pointer.Brush.Color = 33023
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
  end
  object DDSpinEdit6: TDDSpinEdit
    Left = 155
    Top = 72
    Width = 57
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 10000.000000000000000000
    TabOrder = 11
    Value = 10002.000000000000000000
  end
  object StaticText6: TStaticText
    Left = 14
    Top = 76
    Width = 134
    Height = 20
    Caption = 'Max number of spikes'
    TabOrder = 12
  end
  object ComboBox1: TComboBox
    Left = 252
    Top = 72
    Width = 157
    Height = 24
    ItemHeight = 16
    ItemIndex = 2
    TabOrder = 13
    Text = 'Mean for last third of t_end'
    Items.Strings = (
      'Number of spikes'
      'Reverse last ISI'
      'Mean for last third of t_end')
  end
  object CheckBox2: TCheckBox
    Left = 104
    Top = 52
    Width = 137
    Height = 17
    Caption = 'IfDistributedModel'
    TabOrder = 14
    OnClick = CheckBox1Click
  end
end
