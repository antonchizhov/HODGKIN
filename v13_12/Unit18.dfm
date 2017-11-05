object Form18: TForm18
  Left = 660
  Top = 14
  Width = 470
  Height = 639
  Caption = 'Form18: ramps and steps'
  Color = clBackground
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Button1: TButton
    Left = 312
    Top = 112
    Width = 105
    Height = 33
    Caption = 'Run Steps'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DDSpinEdit1: TDDSpinEdit
    Left = 184
    Top = 48
    Width = 49
    Height = 26
    StrWidth = 1
    StrDecimals = 0
    Increment = 10.000000000000000000
    TabOrder = 1
    Value = 80.000000000000000000
    OnDblClick = DDSpinEdit1DblClick
  end
  object StaticText12: TStaticText
    Left = 14
    Top = 50
    Width = 163
    Height = 17
    AutoSize = False
    Caption = 'Number of voltage steps'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
  object DDSpinEdit2: TDDSpinEdit
    Left = 184
    Top = 72
    Width = 49
    Height = 26
    StrWidth = 1
    StrDecimals = 0
    Increment = 5.000000000000000000
    TabOrder = 3
    Value = -60.000000000000000000
  end
  object DDSpinEdit3: TDDSpinEdit
    Left = 184
    Top = 96
    Width = 49
    Height = 26
    StrWidth = 1
    StrDecimals = 0
    Increment = 10.000000000000000000
    TabOrder = 4
    Value = 20.000000000000000000
  end
  object StaticText1: TStaticText
    Left = 14
    Top = 74
    Width = 163
    Height = 17
    AutoSize = False
    Caption = 'Vmin'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
  end
  object StaticText2: TStaticText
    Left = 14
    Top = 98
    Width = 163
    Height = 17
    AutoSize = False
    Caption = 'Vmax'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
  end
  object DDSpinEdit4: TDDSpinEdit
    Left = 184
    Top = 8
    Width = 65
    Height = 26
    StrWidth = 1
    StrDecimals = 1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    Increment = 10.000000000000000000
    ParentFont = False
    TabOrder = 7
    Value = -30.000000000000000000
  end
  object StaticText3: TStaticText
    Left = 14
    Top = 12
    Width = 99
    Height = 17
    AutoSize = False
    Caption = 'Current level'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsItalic]
    ParentFont = False
    TabOrder = 8
  end
  object Chart1: TChart
    Left = 8
    Top = 176
    Width = 449
    Height = 297
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'mV'
    LeftAxis.Title.Caption = 'nA'
    Legend.Alignment = laTop
    Legend.ColorWidth = 50
    Legend.LegendStyle = lsSeries
    Legend.ShadowSize = 0
    Legend.VertMargin = 3
    View3D = False
    Color = clBackground
    TabOrder = 9
    object Button22: TButton
      Left = 352
      Top = 32
      Width = 97
      Height = 17
      Caption = 'CopyToBMP'
      TabOrder = 0
      OnClick = Button22Click
    end
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'Imin(V)'
      LinePen.Width = 2
      Pointer.Brush.Color = 33023
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
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'Imin2(V)'
      LinePen.Width = 2
      Pointer.Brush.Color = clLime
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
  object CheckBox1: TCheckBox
    Left = 368
    Top = 176
    Width = 89
    Height = 17
    Caption = 'IfClear'
    TabOrder = 10
  end
  object CheckBox2: TCheckBox
    Left = 368
    Top = 192
    Width = 89
    Height = 17
    Caption = 'Show lines'
    Checked = True
    State = cbChecked
    TabOrder = 11
    OnClick = CheckBox2Click
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 480
    Width = 185
    Height = 121
    Caption = 'Double steps'
    TabOrder = 12
    object CheckBox3: TCheckBox
      Left = 8
      Top = 24
      Width = 113
      Height = 17
      Caption = 'If double steps'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object DDSpinEdit6: TDDSpinEdit
      Left = 128
      Top = 44
      Width = 49
      Height = 26
      StrWidth = 1
      StrDecimals = 0
      Increment = 1.000000000000000000
      TabOrder = 1
      Value = 15.000000000000000000
    end
    object StaticText5: TStaticText
      Left = 6
      Top = 48
      Width = 123
      Height = 17
      AutoSize = False
      Caption = 'dV between steps'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object StaticText6: TStaticText
      Left = 6
      Top = 74
      Width = 123
      Height = 17
      AutoSize = False
      Caption = 'tau between steps'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object DDSpinEdit7: TDDSpinEdit
      Left = 128
      Top = 70
      Width = 49
      Height = 26
      StrWidth = 1
      StrDecimals = 1
      Increment = 1.000000000000000000
      TabOrder = 4
      Value = 10.000000000000000000
    end
  end
  object RadioGroup1: TRadioGroup
    Left = 272
    Top = 0
    Width = 185
    Height = 97
    Caption = 'DataSource'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGradientActiveCaption
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemIndex = 0
    Items.Strings = (
      '1-compatment model'
      'Distributed model'
      'Experiment (Form 31)')
    ParentFont = False
    TabOrder = 13
    OnClick = RadioGroup1Click
  end
  object StaticText7: TStaticText
    Left = 14
    Top = 122
    Width = 163
    Height = 17
    AutoSize = False
    Caption = 'V0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 14
  end
  object DDSpinEdit8: TDDSpinEdit
    Left = 184
    Top = 120
    Width = 49
    Height = 26
    StrWidth = 1
    StrDecimals = 0
    Increment = 1.000000000000000000
    TabOrder = 15
    Value = -65.000000000000000000
  end
  object GroupBox2: TGroupBox
    Left = 200
    Top = 480
    Width = 257
    Height = 121
    Caption = 'Timing'
    TabOrder = 16
    object StaticText10: TStaticText
      Left = 6
      Top = 16
      Width = 163
      Height = 17
      AutoSize = False
      Caption = 'Depolarizing step start, ms'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object DDSpinEdit9: TDDSpinEdit
      Left = 192
      Top = 15
      Width = 57
      Height = 26
      StrWidth = 1
      StrDecimals = 1
      Increment = 5.000000000000000000
      TabOrder = 2
      Value = 15.600000000000000000
    end
    object DDSpinEdit10: TDDSpinEdit
      Left = 192
      Top = 39
      Width = 57
      Height = 26
      StrWidth = 1
      StrDecimals = 1
      Increment = 50.000000000000000000
      TabOrder = 3
      Value = 200.000000000000000000
    end
    object DDSpinEdit11: TDDSpinEdit
      Left = 192
      Top = 63
      Width = 57
      Height = 26
      StrWidth = 1
      StrDecimals = 1
      Increment = 50.000000000000000000
      TabOrder = 1
      Value = 265.600000000000000000
    end
    object DDSpinEdit12: TDDSpinEdit
      Left = 192
      Top = 87
      Width = 57
      Height = 26
      StrWidth = 1
      StrDecimals = 1
      Increment = 50.000000000000000000
      TabOrder = 4
      Value = 310.600000000000000000
    end
    object StaticText8: TStaticText
      Left = 6
      Top = 64
      Width = 163
      Height = 17
      AutoSize = False
      Caption = 'First step start, ms'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
    object StaticText9: TStaticText
      Left = 6
      Top = 40
      Width = 163
      Height = 17
      AutoSize = False
      Caption = 'Depolarizing step duration, ms'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
    end
    object StaticText11: TStaticText
      Left = 6
      Top = 88
      Width = 163
      Height = 17
      AutoSize = False
      Caption = 'End of steps, ms'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
    end
  end
  object DDSpinEdit5: TDDSpinEdit
    Left = 184
    Top = 144
    Width = 49
    Height = 26
    StrWidth = 1
    StrDecimals = 0
    Increment = 1.000000000000000000
    TabOrder = 17
    Value = 30.000000000000000000
  end
  object StaticText4: TStaticText
    Left = 14
    Top = 146
    Width = 163
    Height = 17
    AutoSize = False
    Caption = 'V_DepStep'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -10
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 18
  end
end
