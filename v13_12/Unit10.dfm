object Form10: TForm10
  Left = 397
  Top = 181
  Width = 422
  Height = 293
  Caption = 'Form10'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnDeactivate = FormDeactivate
  PixelsPerInch = 120
  TextHeight = 16
  object Chart1: TChart
    Left = 8
    Top = 8
    Width = 400
    Height = 250
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'TChart')
    Title.Visible = False
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.AutomaticMinimum = False
    BottomAxis.Maximum = 25.000000000000000000
    BottomAxis.MinorTickCount = 4
    BottomAxis.Title.Caption = 't, ms'
    LeftAxis.AxisValuesFormat = '#,##0.0000'
    LeftAxis.MinorTickCount = 4
    Legend.Visible = False
    RightAxis.MinorTickCount = 4
    View3D = False
    TabOrder = 0
    object Series1: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      LinePen.Color = clRed
      LinePen.Width = 2
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
