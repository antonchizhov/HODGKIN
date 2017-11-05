object Form31: TForm31
  Left = 182
  Top = 50
  Width = 1145
  Height = 956
  AutoSize = True
  Caption = 'Form31: RampAnalyzer v.13.12'
  Color = 16760253
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 1000
    Top = 620
    Width = 45
    Height = 16
    Caption = 'n_Draw'
  end
  object Label2: TLabel
    Left = 560
    Top = 47
    Width = 40
    Height = 20
    Caption = 'Smpl'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 704
    Top = 4
    Width = 65
    Height = 16
    Caption = 'File  name:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -7
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    OnClick = Label7Click
  end
  object Label11: TLabel
    Left = 8
    Top = 608
    Width = 285
    Height = 16
    Caption = 
      'Criterio for threshold:  dIdt=                              pA/m' +
      's'
  end
  object Label12: TLabel
    Left = 128
    Top = 632
    Width = 177
    Height = 16
    Caption = ' d2Idt2=                          pA/ms^2'
  end
  object Label4: TLabel
    Left = 112
    Top = 656
    Width = 160
    Height = 16
    Caption = ' Conv_thr=                           pA'
  end
  object Label5: TLabel
    Left = 32
    Top = 680
    Width = 240
    Height = 16
    Caption = ' SpikeShapeAmplitude=                          pA'
  end
  object Label6: TLabel
    Left = 16
    Top = 704
    Width = 255
    Height = 16
    Caption = ' SpikeShapeHalfDuration=                          ms'
  end
  object Label8: TLabel
    Left = 80
    Top = 728
    Width = 192
    Height = 16
    Caption = ' MinSpikeAmpl=                          pA'
  end
  object Label9: TLabel
    Left = 968
    Top = 644
    Width = 86
    Height = 16
    Caption = 't_maxLimit, ms'
  end
  object Label10: TLabel
    Left = 908
    Top = 699
    Width = 212
    Height = 16
    Caption = 'Cesium shifts voltage by                mV'
  end
  object DDSpinEdit1: TDDSpinEdit
    Left = 1056
    Top = 616
    Width = 65
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 1.000000000000000000
    TabOrder = 0
    Value = 1.000000000000000000
  end
  object Button1: TButton
    Left = 0
    Top = 0
    Width = 161
    Height = 25
    Caption = 'ReadAndDrawData'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = Button1Click
  end
  object Chart1: TChart
    Left = 0
    Top = 80
    Width = 1137
    Height = 250
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    LeftAxis.Title.Caption = 'mV'
    Legend.Alignment = laTop
    Legend.ColorWidth = 20
    Legend.LegendStyle = lsSeries
    Legend.ShadowSize = 0
    View3D = False
    Color = 16760253
    TabOrder = 2
    OnDblClick = Chart1DblClick
    object Button13: TButton
      Left = 1064
      Top = 16
      Width = 73
      Height = 17
      Caption = 'Auto'
      TabOrder = 0
      OnClick = Button13Click
    end
    object Button21: TButton
      Left = 1040
      Top = 32
      Width = 97
      Height = 17
      Caption = 'CopyToBMP'
      TabOrder = 1
      OnClick = Button21Click
    end
    object Button11: TButton
      Left = 968
      Top = 0
      Width = 169
      Height = 17
      Caption = 'Adjust range to current'
      TabOrder = 2
      OnClick = Button11Click
    end
    object Series1: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'Vexp'
      OnDblClick = Series1DblClick
      LinePen.Visible = False
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Pen.Color = clRed
      Pointer.Style = psCircle
      Pointer.VertSize = 1
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
      SeriesColor = clGreen
      Title = 'Vfilt'
      OnDblClick = Series3DblClick
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
    object Series5: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clYellow
      Title = 'Pointer'
      OnDblClick = Series5DblClick
      Pointer.Brush.Color = clGreen
      Pointer.HorizSize = 5
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 5
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
    object Series6: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clBlue
      Title = 'Ramp'
      OnDblClick = Series6DblClick
      Pointer.Brush.Color = clYellow
      Pointer.InflateMargins = True
      Pointer.Pen.Color = 33023
      Pointer.Pen.Width = 2
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
    object Series9: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clGray
      Title = 'VT'
      OnDblClick = Series9DblClick
      Pointer.Brush.Color = clLime
      Pointer.InflateMargins = True
      Pointer.Pen.Color = clLime
      Pointer.Style = psRectangle
      Pointer.VertSize = 1
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
  object Chart2: TChart
    Left = 0
    Top = 336
    Width = 1137
    Height = 265
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'ms'
    LeftAxis.Title.Caption = 'pA'
    Legend.Alignment = laTop
    Legend.ColorWidth = 20
    Legend.LegendStyle = lsSeries
    Legend.ShadowSize = 0
    View3D = False
    Color = 16760253
    TabOrder = 3
    object Button5: TButton
      Left = 968
      Top = 0
      Width = 169
      Height = 17
      Caption = 'Adjust range to voltage'
      TabOrder = 0
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 1064
      Top = 16
      Width = 73
      Height = 17
      Caption = 'Auto'
      TabOrder = 1
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 1040
      Top = 32
      Width = 97
      Height = 17
      Caption = 'CopyToBMP'
      TabOrder = 2
      OnClick = Button7Click
    end
    object Series2: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'Iexp'
      OnDblClick = Series2DblClick
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
    object Series4: TPointSeries
      Marks.ArrowLength = 0
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'Pointer'
      OnDblClick = Series4DblClick
      Pointer.HorizSize = 5
      Pointer.InflateMargins = True
      Pointer.Style = psCircle
      Pointer.VertSize = 5
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
    object Series7: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'Ifilt'
      OnDblClick = Series7DblClick
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
    object Series8: TLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clYellow
      Title = 'Spike'
      OnDblClick = Series8DblClick
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
  object DDSpinEdit2: TDDSpinEdit
    Left = 608
    Top = 40
    Width = 49
    Height = 36
    StrWidth = 2
    StrDecimals = 0
    Color = 16760253
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Increment = 1.000000000000000000
    ParentFont = False
    TabOrder = 4
    Value = 1.000000000000000000
    OnChange = DDSpinEdit2Change
  end
  object ComboBox1: TComboBox
    Left = 328
    Top = 0
    Width = 369
    Height = 24
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -7
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 16
    ParentFont = False
    TabOrder = 5
    Text = 'E:\Anton\NN_Data\Na-channels\09_02_2010\Cell_1\'
    OnChange = ComboBox1Change
    Items.Strings = (
      'E:\Anton\NN_Data\Na-channels\09_02_2010\Cell_1\'
      'E:\Anton\NN_Data\Na-channels\09_02_2010\Cell_3\'
      'E:\Anton\NN_Data\Na-channels\09_02_2010\Cell_3\Lyle\'
      'E:\Anton\NN_Data\Na-channels\09_02_2010\Cell_3\Destexhe\'
      
        'E:\Anton\NN_Data\Na-channels\09_02_2010\Cell_3\Soma+Axon_Miglior' +
        'e\'
      'Data from simulations')
  end
  object Memo1: TMemo
    Left = 680
    Top = 120
    Width = 313
    Height = 137
    Lines.Strings = (
      'The program reads all the experimental data from '
      'the given file, filters the current, '
      'finds the first spike-current in the response to ramp,'
      'calculates the threshold VT and '
      'plots VT versus tau.'
      ''
      'The output file is'
      'out_VT_tau.dat.')
    TabOrder = 6
    OnClick = Memo1Click
  end
  object DDSpinEdit9: TDDSpinEdit
    Left = 184
    Top = 600
    Width = 65
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 10.000000000000000000
    TabOrder = 7
    Value = 20.000000000000000000
  end
  object DDSpinEdit10: TDDSpinEdit
    Left = 184
    Top = 624
    Width = 65
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 100.000000000000000000
    TabOrder = 8
    Value = 100.000000000000000000
  end
  object Button2: TButton
    Left = 0
    Top = 24
    Width = 161
    Height = 25
    Caption = 'FilterCurrent'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    OnClick = Button2Click
  end
  object GroupBox1: TGroupBox
    Left = 112
    Top = 792
    Width = 145
    Height = 49
    Caption = 'Filter'
    TabOrder = 10
    object Label3: TLabel
      Left = 8
      Top = 20
      Width = 59
      Height = 16
      Caption = 'tauFilt, ms'
    end
    object DDSpinEdit3: TDDSpinEdit
      Left = 72
      Top = 16
      Width = 65
      Height = 26
      StrWidth = 2
      StrDecimals = 3
      Increment = 0.100000000000000000
      TabOrder = 0
      Value = 0.500000000000000000
    end
  end
  object Button3: TButton
    Left = 0
    Top = 48
    Width = 161
    Height = 25
    Caption = 'FindThreshold'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    OnClick = Button3Click
  end
  object DDSpinEdit4: TDDSpinEdit
    Left = 184
    Top = 648
    Width = 65
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 50.000000000000000000
    TabOrder = 12
    Value = 100.000000000000000000
  end
  object Button4: TButton
    Left = 160
    Top = 48
    Width = 161
    Height = 25
    Caption = 'AllSamples'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    OnClick = Button4Click
  end
  object Chart3: TChart
    Left = 320
    Top = 600
    Width = 553
    Height = 321
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Title.Caption = 'ms'
    LeftAxis.Title.Caption = 'mV'
    Legend.Alignment = laTop
    Legend.LegendStyle = lsSeries
    Legend.ResizeChart = False
    Legend.ShadowSize = 0
    Legend.VertMargin = 1
    RightAxis.Title.Caption = 'pA'
    View3D = False
    Color = 16760253
    TabOrder = 14
    object Button8: TButton
      Left = 456
      Top = 0
      Width = 97
      Height = 17
      Caption = 'CopyToBMP'
      TabOrder = 0
      OnClick = Button8Click
    end
    object Series10: TPointSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlack
      Title = 'VT(tau)'
      OnDblClick = Series10DblClick
      Pointer.InflateMargins = True
      Pointer.Pen.Color = clRed
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
    object Series11: TPointSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'SpikeAmpl'
      VertAxis = aRightAxis
      OnDblClick = Series11DblClick
      Pointer.Brush.Color = clYellow
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
  object DDSpinEdit5: TDDSpinEdit
    Left = 184
    Top = 672
    Width = 65
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 100.000000000000000000
    TabOrder = 15
    Value = 300.000000000000000000
  end
  object DDSpinEdit6: TDDSpinEdit
    Left = 184
    Top = 696
    Width = 65
    Height = 26
    StrWidth = 2
    StrDecimals = 2
    Increment = 0.500000000000000000
    TabOrder = 16
    Value = 1.500000000000000000
  end
  object ComboBox2: TComboBox
    Left = 16
    Top = 760
    Width = 233
    Height = 24
    ItemHeight = 16
    ItemIndex = 1
    TabOrder = 17
    Text = 'Unscaled spike shape'
    OnChange = ComboBox2Change
    Items.Strings = (
      'Scaled spike shape'
      'Unscaled spike shape')
  end
  object DDSpinEdit7: TDDSpinEdit
    Left = 184
    Top = 720
    Width = 65
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 50.000000000000000000
    TabOrder = 18
    Value = 100.000000000000000000
  end
  object CheckBox1: TCheckBox
    Left = 168
    Top = 28
    Width = 153
    Height = 17
    Caption = 'WriteSpikeMarkers'
    Checked = True
    State = cbChecked
    TabOrder = 19
  end
  object DDSpinEdit8: TDDSpinEdit
    Left = 1056
    Top = 640
    Width = 65
    Height = 26
    StrWidth = 2
    StrDecimals = 0
    Increment = 100.000000000000000000
    TabOrder = 20
    Value = 490.000000000000000000
  end
  object Button9: TButton
    Left = 952
    Top = 672
    Width = 169
    Height = 17
    Caption = 'Enable all series'
    TabOrder = 21
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 160
    Top = 0
    Width = 161
    Height = 25
    Caption = 'DataFromSimulation'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
    TabOrder = 22
    OnClick = Button10Click
  end
  object DDSpinEdit11: TDDSpinEdit
    Left = 1056
    Top = 696
    Width = 41
    Height = 26
    Hint = '70mV by default'
    StrWidth = 2
    StrDecimals = 0
    Increment = 70.000000000000000000
    ParentShowHint = False
    ShowHint = True
    TabOrder = 23
  end
  object OpenDialog1: TOpenDialog
    Left = 456
    Top = 24
  end
end
