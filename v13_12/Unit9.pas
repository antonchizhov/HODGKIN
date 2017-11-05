unit Unit9;    {Form9 - nu(u,s)}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  MathMyO, StdCtrls,Unit8,Graph,
  Init,typeNrnParsO,Threshold,Thread_u_s,Thread_FC,
  DDSpinEdit, Spin,
  FiringClamp,Noise, TeEngine, Series, ExtCtrls, TeeProcs, Chart, BubbleCh,
  Fiber_f_I_curve;

type
  TForm9 = class(TForm)
    Button1: TButton;
    DDSpinEdit1: TDDSpinEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Button2: TButton;
    DDSpinEdit2: TDDSpinEdit;
    DDSpinEdit3: TDDSpinEdit;
    StaticText3: TStaticText;
    Button3: TButton;
    Button4: TButton;
    DDSpinEdit4: TDDSpinEdit;
    StaticText4: TStaticText;
    CheckBox1: TCheckBox;
    DDSpinEdit6: TDDSpinEdit;
    StaticText6: TStaticText;
    DDSpinEdit7: TDDSpinEdit;
    DDSpinEdit8: TDDSpinEdit;
    RadioGroup1: TRadioGroup;
    DDSpinEdit9: TDDSpinEdit;
    Chart1: TChart;
    Series1: TBubbleSeries;
    GroupBox1: TGroupBox;
    StaticText5: TStaticText;
    DDSpinEdit5: TDDSpinEdit;
    StaticText7: TStaticText;
    DDSpinEdit10: TDDSpinEdit;
    DDSpinEdit11: TDDSpinEdit;
    StaticText8: TStaticText;
    DDSpinEdit12: TDDSpinEdit;
    StaticText9: TStaticText;
    DDSpinEdit13: TDDSpinEdit;
    StaticText10: TStaticText;
    Chart2: TChart;
    Series2: TLineSeries;
    Series3: TLineSeries;
    StaticText11: TStaticText;
    DDSpinEdit14: TDDSpinEdit;
    Chart3: TChart;
    Series4: TLineSeries;
    Series5: TLineSeries;
    Series6: TLineSeries;
    Button5: TButton;
    Series7: TLineSeries;
    Button22: TButton;
    CheckBox2: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure DDSpinEdit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DDSpinEdit2Change(Sender: TObject);
    procedure DDSpinEdit3Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DDSpinEdit7Change(Sender: TObject);
    procedure DDSpinEdit8Change(Sender: TObject);
    procedure DDSpinEdit9Change(Sender: TObject);
    procedure Chart1DblClick(Sender: TObject);
    procedure DDSpinEdit13Change(Sender: TObject);
    procedure Series3DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button22Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9                         :TForm9;
  MaxFreq,u_max,u_min,s_max,s_min     :double;
  dx,dy, If_fm_or_gm,If_u_s_or_Ge_Gi  :integer;


PROCEDURE Draw_nu_u_s(x,y,freq,Vav,avPSC :double);

implementation

{$R *.DFM}

procedure TForm9.FormShow(Sender: TObject);
begin
  dx:=6; dy:=6;
  MaxFreq:=Form9.DDSpinEdit1.Value;
  nue  :=trunc(Form9.DDSpinEdit7.Value);
  nse  :=trunc(Form9.DDSpinEdit8.Value);
  u_max:=Form9.DDSpinEdit2.Value;
  s_max:=Form9.DDSpinEdit3.Value;
  if NP0.HH_type='Calmar' then begin
     Form9.DDSpinEdit1.Value:=250;
     Form9.DDSpinEdit2.Value:=200;
     Form9.DDSpinEdit3.Value:=2.5;
  end;
end;

{*********************************************************************}
PROCEDURE Draw_nu_u_s(x,y,freq,Vav,avPSC :double);
var
     x1,y1,col                    :integer;
     u1,s1,ds,gE_max              :double;
     t1,t2                        :string;
     tcol                         :TColor;

BEGIN
  if Form9.CheckBox1.Checked=false then exit;
  freq:=max(freq,1);
  col:=trunc(15*freq/MaxFreq);
  col:=imin(col,15);  col:=imax(col,1);

//           u1:=(u_max-u_min)/nue*nu + u_min;
//           s1:=(s_max-s_min)/nse*ns + s_min;
//           ds:=(s_max-s_min)/nse;
  tcol:=SetMyColor(col);
  Form9.Series1.AddBubble(x,y,(s_max-s_min)/nse/2*max(nse/nue,1),'',tcol);
  if If_u_s_or_Ge_Gi=1 then begin    { for (u,s)-plot }
     { Line gS=0 }
     gE_max:=u_max/1000/(-Vus);
     Form9.Series7.AddXY(0,0);
     Form9.Series7.AddXY(u_max/4,gE_max/4);
  end;
//  Form9.Canvas.Brush.Color:=SetMyColor(col);
//  Form9.Canvas.Pen.Color  :=clBlack;
//  x1:=20+nu*dx;
//  y1:=20+(nse-ns)*dy;
//  Form9.Canvas.Rectangle(x1,y1, x1+dx,y1-dy);
      { Numbers }
//  str(freq:3:0,t1);
//  Form9.Canvas.TextOut(x1,y1,t1);
      { Lines }
  Form9.Series2.AddXY(x,FromRadioGroup3);
  Form9.Series3.AddXY(x,FromRadioGroup2);
  Form9.Series4.AddXY(x,Vmax*1000);
  Form9.Series5.AddXY(x,V_Conv*1000);
  Form9.Series6.AddXY(x,Vmin_prev*1000);
END;

procedure ClearTheRectangle;
begin
  Form9.Series1.Clear;
  Form9.Series2.Clear;
  Form9.Series3.Clear;
//  Form9.Canvas.Brush.Color:=$00000000;
//  Form9.Canvas.Rectangle(0,0,40+dx*nue,40+dy*nse);
  Form9.Series4.Clear;
  Form9.Series5.Clear;
  Form9.Series6.Clear;
end;

procedure TForm9.Button1Click(Sender: TObject);
begin
  Form9.Button1.Enabled:=false;
  If_u_s_or_Ge_Gi:=1;
  ClearTheRectangle;
//  Plot_for_u_s_In_Thread:=TPlot2D.Create(False);
  if Form9.CheckBox2.Checked=false then begin
     PlotForControlParametersO;
  end else begin // IfDistributedModel
     PlotForControlParameters_FiberO;
  end;
  beep;
  Form9.Button1.Enabled:=true;
end;

procedure TForm9.Button5Click(Sender: TObject);
begin
  If_u_s_or_Ge_Gi:=2;
  ClearTheRectangle;
  PlotForControlParametersO;
end;

procedure TForm9.DDSpinEdit1Change(Sender: TObject);
begin
  MaxFreq:=Form9.DDSpinEdit1.Value;
end;

procedure TForm9.DDSpinEdit7Change(Sender: TObject);
begin
  nue:=trunc(Form9.DDSpinEdit7.Value);
end;

procedure TForm9.DDSpinEdit8Change(Sender: TObject);
begin
  nse:=trunc(Form9.DDSpinEdit8.Value);
end;

procedure TForm9.Button2Click(Sender: TObject);
begin
  ClearTheRectangle;
end;

procedure TForm9.DDSpinEdit2Change(Sender: TObject);
begin
  u_max:=Form9.DDSpinEdit2.Value;
end;

procedure TForm9.DDSpinEdit13Change(Sender: TObject);
begin
  u_min:=Form9.DDSpinEdit13.Value;
end;

procedure TForm9.DDSpinEdit3Change(Sender: TObject);
begin
  s_max:=Form9.DDSpinEdit3.Value;
end;

procedure TForm9.DDSpinEdit9Change(Sender: TObject);
begin
  s_min:=Form9.DDSpinEdit9.Value;
end;

procedure TForm9.Button3Click(Sender: TObject);
begin
  Plot_for_u_s_In_Thread.Suspend;
  Plot_for_u_s_In_Thread.Terminate;
  CloseFile(ddd);
end;

procedure TForm9.Button4Click(Sender: TObject);
begin
  Form8.Visible:=true;
end;


procedure TForm9.Chart1DblClick(Sender: TObject);
begin
  if If_fm_or_gm=0  then Read_f_g_From_File;
  if If_fm_or_gm<>2 then begin
     Draw_gm;
     If_fm_or_gm:=2;
  end else begin
     Draw_fm;
     If_fm_or_gm:=1;
  end;
end;

procedure TForm9.Series3DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form9.Series3.Active:=false;
end;

procedure TForm9.Button22Click(Sender: TObject);
begin
  Form9.Chart1.CopyToClipboardBitmap;
end;

end.
