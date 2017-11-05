unit Unit3;     { Threshold }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DDSpinEdit,
  Init,Threshold, TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DDSpinEdit1: TDDSpinEdit;
    DDSpinEdit4: TDDSpinEdit;
    StaticText1: TStaticText;
    StaticText4: TStaticText;
    StaticText2: TStaticText;
    DDSpinEdit2: TDDSpinEdit;
    DDSpinEdit3: TDDSpinEdit;
    StaticText3: TStaticText;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    DDSpinEdit5: TDDSpinEdit;
    StaticText5: TStaticText;
    Chart2: TChart;
    Series2: TPointSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Chart3: TChart;
    Chart4: TChart;
    Chart5: TChart;
    Series5: TLineSeries;
    Series6: TLineSeries;
    Series7: TLineSeries;
    Series8: TLineSeries;
    Series9: TLineSeries;
    Chart1: TChart;
    Series1: TLineSeries;
    DDSpinEdit6: TDDSpinEdit;
    Label1: TLabel;
    Series10: TPointSeries;
    Series11: TLineSeries;
    Series12: TLineSeries;
    CheckBox2: TCheckBox;
    Series13: TLineSeries;
    Chart6: TChart;
    CheckBox3: TCheckBox;
    LineSeries1: TLineSeries;
    LineSeries2: TLineSeries;
    Series14: TPointSeries;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Series12DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series14DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.DFM}

procedure TForm3.Button1Click(Sender: TObject);
begin
  Form3.Series1.Clear;
  Form3.Series2.Clear;
  Form3.Series3.Clear;
  Form3.Series4.Clear;
  Form3.Series5.Clear;
  Form3.Series6.Clear;
  Form3.Series7.Clear;
  Form3.Series8.Clear;
  Form3.Series9.Clear;
  Form3.Series10.Clear;
  Form3.Series11.Clear;
  Form3.Series12.Clear;
  Form3.Series13.Clear;
  Form3.LineSeries1.Clear;
  Form3.LineSeries2.Clear;
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  FindThresholdO;
end;

procedure TForm3.Series12DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Series12.Active:=false;
end;

procedure TForm3.Series14DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Series14.Active:=false;
end;

end.
