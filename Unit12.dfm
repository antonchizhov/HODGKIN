object Form12: TForm12
  Left = 363
  Top = 291
  Width = 498
  Height = 622
  Caption = 'Form12: Drawing m_inf(V), h_inf(V)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object sp_XYPlot1: Tsp_XYPlot
    Left = 48
    Top = 48
    Width = 385
    Height = 249
    Color = clBtnFace
    ParentColor = False
    TabOrder = 0
    LeftAxis.Margin = 4
    LeftAxis.TicksCount = 6
    LeftAxis.LineAttr.Color = clBlack
    LeftAxis.LineAttr.Visible = True
    LeftAxis.GridAttr.Color = clGray
    LeftAxis.GridAttr.Visible = True
    LeftAxis.LabelFormat = '###0.##'
    LeftAxis.SFlags = 1
    LeftAxis.SLinePos = (
      30
      209
      199)
    LeftAxis.fMax = 1.000000000000000000
    RightAxis.Margin = 4
    RightAxis.LineAttr.Color = clBlack
    RightAxis.LineAttr.Visible = True
    RightAxis.GridAttr.Color = clGray
    RightAxis.GridAttr.Visible = False
    RightAxis.LabelFormat = '###0.##'
    RightAxis.SFlags = 57
    RightAxis.SLinePos = (
      380
      209
      199)
    RightAxis.fMax = 10.000000000000000000
    BottomAxis.Margin = 20
    BottomAxis.Caption = 'V, mV'
    BottomAxis.LineAttr.Color = clBlack
    BottomAxis.LineAttr.Visible = True
    BottomAxis.GridAttr.Color = clGray
    BottomAxis.GridAttr.Visible = True
    BottomAxis.LabelFormat = '###0.##'
    BottomAxis.SFlags = 192
    BottomAxis.SLinePos = (
      31
      210
      348)
    BottomAxis.fMin = -0.225000000000000000
    BottomAxis.fMax = 9.225000000000000000
    TopAxis.Margin = 4
    TopAxis.LineAttr.Color = clBlack
    TopAxis.LineAttr.Visible = True
    TopAxis.GridAttr.Color = clGray
    TopAxis.GridAttr.Visible = False
    TopAxis.LabelFormat = '###0.##'
    TopAxis.SFlags = 56
    TopAxis.SLinePos = (
      31
      9
      348)
    TopAxis.fMax = 10.000000000000000000
    BorderStyle = bs_None
    FieldColor = clWhite
    BufferedDisplay = True
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Redraw'
    TabOrder = 1
    OnClick = Button1Click
  end
  object sp_XYPlot2: Tsp_XYPlot
    Left = 32
    Top = 312
    Width = 409
    Height = 280
    Color = clBtnFace
    ParentColor = False
    TabOrder = 2
    LeftAxis.Margin = 20
    LeftAxis.Caption = 'ms'
    LeftAxis.TicksCount = 6
    LeftAxis.LineAttr.Color = clBlack
    LeftAxis.LineAttr.Visible = True
    LeftAxis.GridAttr.Color = clGray
    LeftAxis.GridAttr.Visible = True
    LeftAxis.LabelFormat = '###0.##'
    LeftAxis.SFlags = 129
    LeftAxis.SLinePos = (
      39
      240
      235)
    LeftAxis.fMax = 10.250000000000000000
    RightAxis.Margin = 4
    RightAxis.LineAttr.Color = clBlack
    RightAxis.LineAttr.Visible = True
    RightAxis.GridAttr.Color = clGray
    RightAxis.GridAttr.Visible = False
    RightAxis.LabelFormat = '###0.##'
    RightAxis.SFlags = 57
    RightAxis.SLinePos = (
      404
      240
      235)
    RightAxis.fMax = 10.000000000000000000
    BottomAxis.Margin = 20
    BottomAxis.Caption = 'V, mv'
    BottomAxis.LineAttr.Color = clBlack
    BottomAxis.LineAttr.Visible = True
    BottomAxis.GridAttr.Color = clGray
    BottomAxis.GridAttr.Visible = True
    BottomAxis.LabelFormat = '###0.##'
    BottomAxis.SFlags = 192
    BottomAxis.SLinePos = (
      40
      241
      363)
    BottomAxis.fMin = -0.225000000000000000
    BottomAxis.fMax = 9.225000000000000000
    TopAxis.Margin = 4
    TopAxis.LineAttr.Color = clBlack
    TopAxis.LineAttr.Visible = True
    TopAxis.GridAttr.Color = clGray
    TopAxis.GridAttr.Visible = False
    TopAxis.LabelFormat = '###0.##'
    TopAxis.SFlags = 56
    TopAxis.SLinePos = (
      40
      4
      363)
    TopAxis.fMax = 10.000000000000000000
    BorderStyle = bs_None
    FieldColor = clWhite
  end
  object sp_XYLine1: Tsp_XYLine
    Plot = sp_XYPlot1
    Legend = 'm_inf(V)'
    LineAttr.Color = clRed
    LineAttr.Width = 2
    LineAttr.Visible = True
    PointAttr.Kind = ptRectangle
    PointAttr.Visible = False
    Left = 352
    Top = 32
  end
  object sp_XYLine2: Tsp_XYLine
    Plot = sp_XYPlot1
    Legend = 'h_inf(V)'
    LineAttr.Color = clGreen
    LineAttr.Width = 2
    LineAttr.Visible = True
    PointAttr.Kind = ptRectangle
    PointAttr.Visible = False
    Left = 352
    Top = 72
  end
  object sp_XYLine3: Tsp_XYLine
    Plot = sp_XYPlot2
    Legend = 'tau_m'
    LineAttr.Color = clRed
    LineAttr.Width = 2
    LineAttr.Visible = True
    PointAttr.Kind = ptRectangle
    PointAttr.Visible = False
    Left = 384
    Top = 320
  end
  object sp_XYLine4: Tsp_XYLine
    Plot = sp_XYPlot2
    Legend = 'tau_h'
    LineAttr.Color = clGreen
    LineAttr.Width = 2
    LineAttr.Visible = True
    PointAttr.Kind = ptRectangle
    PointAttr.Visible = False
    Left = 384
    Top = 352
  end
end
