unit Unit8;    {Form8 - Firing-Clamp}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FiringClamp,MyTypes,Init,MathMyO,Noise,Thread_FC,
  TeEngine, Series, StdCtrls, ExtCtrls, TeeProcs, Chart,
  {sgr_def, sgr_data,} DDSpinEdit, BubbleCh;

type
  TForm8 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    StaticText1: TStaticText;
    Button5: TButton;
    Button6: TButton;
    DDSpinEdit1: TDDSpinEdit;
    CheckBox1: TCheckBox;
    Chart1: TChart;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
    Series5: TPointSeries;
    Series6: TPointSeries;
    Chart2: TChart;
    Series7: TPointSeries;
    Series8: TPointSeries;
    Series9: TPointSeries;
    Series10: TPointSeries;
    CheckBox2: TCheckBox;
    Chart3: TChart;
    Series11: TFastLineSeries;
    Series12: TFastLineSeries;
    Series13: TFastLineSeries;
    DDSpinEdit2: TDDSpinEdit;
    Series14: TFastLineSeries;
    Series15: TFastLineSeries;
    Series16: TFastLineSeries;
    Series17: TPointSeries;
    Chart4: TChart;
    Series18: TPointSeries;
    Series19: TPointSeries;
    Series20: TPointSeries;
    Chart5: TChart;
    Series21: TPointSeries;
    Series22: TPointSeries;
    Series23: TPointSeries;
    Series24: TBubbleSeries;
    Series25: TBubbleSeries;
    Series4: TLineSeries;
    Series3: TLineSeries;
    Series26: TPointSeries;
    CheckBox3: TCheckBox;
    procedure ClearAll;
    procedure TurnOnWiener;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Chart1DblClick(Sender: TObject);
    procedure Chart4DblClick(Sender: TObject);
    procedure Draw_f_in_Chart(f :matr_200x200; ie,je :integer; dx,dy,x0,y0 :double);
    procedure Draw_g_in_Chart(f :matr_200x200; ie,je :integer; dx,dy,x0,y0 :double);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

function SetMyColor(col :integer):TColor;

var  dx,dy,
     If_fm_or_gm :integer;

implementation

{$R *.DFM}

function SetMyColor(col :integer):TColor;
begin
       if col= 0 then  SetMyColor:=$00000000
  else if col= 1 then  SetMyColor:=$00FF1080
  else if col= 2 then  SetMyColor:=$00F02080
  else if col= 3 then  SetMyColor:=$00E03080
  else if col= 4 then  SetMyColor:=$00D04080
  else if col= 5 then  SetMyColor:=$00C05080
  else if col= 6 then  SetMyColor:=$00B06080
  else if col= 7 then  SetMyColor:=$00A07080
  else if col= 8 then  SetMyColor:=$00908080
  else if col= 9 then  SetMyColor:=$00809080
  else if col=10 then  SetMyColor:=$0070A080
  else if col=11 then  SetMyColor:=$0060B080
  else if col=12 then  SetMyColor:=$0050C080
  else if col=13 then  SetMyColor:=$0040D080
  else if col=14 then  SetMyColor:=$0030E080
  else if col=15 then  SetMyColor:=$0020F080
  else if col=16 then  SetMyColor:=$0010FF80
end;

{*************************************************************************}
procedure TForm8.Draw_f_in_Chart(f :matr_200x200; ie,je :integer; dx,dy,x0,y0 :double);
var
     col,i,j                            :integer;
     x1,y1,fmax,fmin,R                  :double;
     tcol                               :TColor;
begin
  Form8.Series24.Clear;
  fmax:=-1e6;
  fmin:= 1e6;
  for j:=0 to je do  for i:=0 to ie do  if f[i,j]<>0 then begin
      fmax:=max(fmax,f[i,j]);
      fmin:=min(fmin,f[i,j]);
  end;
  FOR j:=0 to je DO BEGIN
      FOR i:=0 to ie DO BEGIN
           col:=trunc(15*(f[i,j]-fmin)/max(fmax-fmin,1e-6));
           col:=imin(col,15);  col:=imax(col,1);
           x1:=i*dx+x0;
           y1:=j*dy+y0;
           tcol:=SetMyColor(col);
           Form8.Series24.AddBubble(x1,y1,dy/2*max(ie,je)/ie,'',tcol);
      END;
  END;
  Application.ProcessMessages;
end;

procedure TForm8.Draw_g_in_Chart(f :matr_200x200; ie,je :integer; dx,dy,x0,y0 :double);
var
     col,i,j                            :integer;
     x1,y1,fmax,fmin,R                  :double;
     tcol                               :TColor;
begin
  Form8.Series25.Clear;
  fmax:=-1e6;
  fmin:= 1e6;
  for j:=0 to je do  for i:=0 to ie do  if f[i,j]<>0 then begin
      fmax:=max(fmax,f[i,j]);
      fmin:=min(fmin,f[i,j]);
  end;
  FOR j:=0 to je DO BEGIN
      FOR i:=0 to ie DO BEGIN
           col:=trunc(15*(f[i,j]-fmin)/max(fmax-fmin,1e-6));
           col:=imin(col,15);  col:=imax(col,1);
           x1:=i*dx+x0;
           y1:=j*dy+y0;
           tcol:=SetMyColor(col);
           Form8.Series25.AddBubble(x1,y1,dy/2*max(ie,je)/ie,'',tcol);
      END;
  END;
  Application.ProcessMessages;
end;

procedure TForm8.Chart4DblClick(Sender: TObject);
begin
  if If_fm_or_gm<>2 then begin
     Draw_gm;
     If_fm_or_gm:=2;
  end else begin
     Draw_fm;
     If_fm_or_gm:=1;
  end;
end;
{*************************************************************************}

procedure TForm8.ClearAll;
begin
  dx:=6; dy:=6;
//  Form8.Chart1.BottomAxis.Maximum:=t_end*1e3;
//  Form8.Chart1.LeftAxis.Maximum:=ss[1]*(1+NoiseToSignal);
  Form8.Series1.Clear;
  Form8.Series2.Clear;
  Form8.Series3.Clear;
  Form8.Series4.Clear;
  Form8.Series5.Clear;
  Form8.Series6.Clear;
  Form8.Series7.Clear;
  Form8.Series8.Clear;
  Form8.Series9.Clear;
  Form8.Series10.Clear;
  Form8.Series11.Clear;
  Form8.Series12.Clear;
  Form8.Series13.Clear;
  Form8.Series14.Clear;
  Form8.Series15.Clear;
  Form8.Series16.Clear;
  Form8.Series17.Clear;
  Form8.Series18.Clear;
  Form8.Series19.Clear;
  Form8.Series20.Clear;
  Form8.Series21.Clear;
  Form8.Series22.Clear;
  Form8.Series23.Clear;
end;

procedure TForm8.Button1Click(Sender: TObject);
begin
  CheckFiringClamp;
end;

procedure TForm8.Button2Click(Sender: TObject);
begin
  ClearAll;
end;

procedure TForm8.Button3Click(Sender: TObject);
begin
  Form8.Button3.Enabled:=false;
//  AnalyzeByFiringClamp_In_Thread:=TFCinThread.Create(False);
  AnalyzeByFiringClamp(n_FC,F_FC,G_FC,H_FC,U_FC,S_FC,T_FC,Ua_FC,Sa_FC,
                                             Tg_FC,gE_FC,gI_FC);
  Form8.Button3.Enabled:=true;
end;

procedure TForm8.Button5Click(Sender: TObject);
begin
  Form8.Button5.Enabled:=false;
//  AnalyzeSetsByFiringClamp_In_Thread:=TSetOfFCinThread.Create(False);
  StatisticsOfConductanceEstimations;
  Form8.Button5.Enabled:=true;
end;

procedure TForm8.Button6Click(Sender: TObject);
begin
  if IfActive1 then AnalyzeByFiringClamp_In_Thread    .Suspend;
  if IfActive1 then AnalyzeByFiringClamp_In_Thread    .Terminate;
  if IfActive2 then AnalyzeSetsByFiringClamp_In_Thread.Suspend;
  if IfActive2 then AnalyzeSetsByFiringClamp_In_Thread.Terminate;
end;

procedure TForm8.TurnOnWiener;
begin
  AssignFile(fff, 'V(t).dat');  //Rewrite(fff);
  IfWriteInFFF:=1;
end;

procedure TForm8.FormShow(Sender: TObject);
begin
  ClearAll;
  if Form8.CheckBox1.Checked then TurnOnWiener;
end;

procedure TForm8.CheckBox1Click(Sender: TObject);
begin
  if Form8.CheckBox1.Checked then TurnOnWiener else IfWriteInFFF:=0;
end;

procedure TForm8.Chart1DblClick(Sender: TObject);
begin
  Form8.Chart1.DragMode:=dmManual;
end;

end.
