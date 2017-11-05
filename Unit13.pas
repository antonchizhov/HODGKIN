unit Unit13;   {Form13 - Statistics }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, TeeFunci, ExtCtrls, TeeProcs, Chart, StdCtrls,
  DDSpinEdit;

type
  TForm13 = class(TForm)
    Chart1: TChart;
    TeeFunction1: TAverageTeeFunction;
    Series1: TBarSeries;
    GroupBox1: TGroupBox;
    DDSpinEdit1: TDDSpinEdit;
    StaticText42: TStaticText;
    DDSpinEdit2: TDDSpinEdit;
    StaticText1: TStaticText;
    Chart2: TChart;
    Series2: TFastLineSeries;
    GroupBox2: TGroupBox;
    DDSpinEdit3: TDDSpinEdit;
    StaticText2: TStaticText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DDSpinEdit4: TDDSpinEdit;
    procedure DDSpinEdit4Change(Sender: TObject);
    procedure DDSpinEdit1Change(Sender: TObject);
    procedure DDSpinEdit2Change(Sender: TObject);
    procedure DDSpinEdit3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form13: TForm13;

implementation

uses Init,Statistics;

{$R *.DFM}

procedure TForm13.DDSpinEdit4Change(Sender: TObject);
begin
  IfStartStat:=13;
end;

procedure TForm13.DDSpinEdit1Change(Sender: TObject);
begin
  IfStartStat:=13;
end;

procedure TForm13.DDSpinEdit2Change(Sender: TObject);
begin
  IfStartStat:=13;
end;

procedure TForm13.DDSpinEdit3Change(Sender: TObject);
begin
  IfStartStat:=13;
end;

end.
