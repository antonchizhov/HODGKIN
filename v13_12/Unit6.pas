unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DDSpinEdit,
  Init,Threshold, TeEngine, Series, ExtCtrls, TeeProcs,
  Chart;


type
  TForm6 = class(TForm)
    DDSpinEdit1: TDDSpinEdit;
    DDSpinEdit4: TDDSpinEdit;
    StaticText4: TStaticText;
    StaticText1: TStaticText;
    Button1: TButton;
    Button2: TButton;
    StaticText3: TStaticText;
    DDSpinEdit3: TDDSpinEdit;
    StaticText2: TStaticText;
    StaticText5: TStaticText;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Series5: TLineSeries;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DDSpinEdit1Change(Sender: TObject);
    procedure DDSpinEdit4Change(Sender: TObject);
    procedure DDSpinEdit3Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;
  dIind_AD,Iind_max_AD    :double;

implementation

{$R *.DFM}

procedure TForm6.FormShow(Sender: TObject);
begin
  Iind_max_AD:=400;
  dIind_AD:=8;
  Form6.DDSpinEdit1.Value:=Iind_max_AD;
  Form6.DDSpinEdit4.Value:=dIind_AD;
  Form6.DDSpinEdit3.Value:=t_end*1e3;
  Form6.Chart1.BottomAxis.Maximum:=Iind_max_AD;
end;

{ SpinEdits }

procedure TForm6.DDSpinEdit1Change(Sender: TObject);
begin
  Iind_max_AD  :=Form6.DDSpinEdit1.Value;
  Form6.Chart1.BottomAxis.Maximum:=Iind_max_AD;
end;

procedure TForm6.DDSpinEdit4Change(Sender: TObject);
begin
  dIind_AD  :=Form6.DDSpinEdit4.Value;
end;

procedure TForm6.DDSpinEdit3Change(Sender: TObject);
begin
  t_end  :=Form6.DDSpinEdit3.Value/1e3;
end;

{ Buttons }

procedure TForm6.Button1Click(Sender: TObject);
begin
  Plot_Adaptaion;
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
  Form6.Series1.Clear;
  Form6.Series2.Clear;
  Form6.Series3.Clear;
  Form6.Series4.Clear;
  Form6.Series5.Clear;
end;

end.
