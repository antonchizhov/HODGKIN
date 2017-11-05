unit Unit14;  {Form14 - Z-function to correct F-C }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart, StdCtrls,
  Init,t_dtO,Unit1, DDSpinEdit, TeeShape;

procedure CorrectByWienerKernel(t1,t2 :double; var u0,s0 :double);

type
  TForm14 = class(TForm)
    RadioGroup1: TRadioGroup;
    Chart2: TChart;
    Series7: TLineSeries;
    Series1: TFastLineSeries;
    Button1: TButton;
    Chart1: TChart;
    Series2: TFastLineSeries;
    Series3: TFastLineSeries;
    Series4: TFastLineSeries;
    Series5: TFastLineSeries;
    Chart3: TChart;
    Series6: TFastLineSeries;
    DDSpinEdit1: TDDSpinEdit;
    Label2: TLabel;
    Chart4: TChart;
    Series8: TPointSeries;
    Chart5: TChart;
    Series9: TPointSeries;
    Series10: TPointSeries;
    RadioGroup2: TRadioGroup;
    Chart6: TChart;
    Series11: TPointSeries;
    Series12: TPointSeries;
    Series13: TPointSeries;
    Series14: TFastLineSeries;
    Chart7: TChart;
    Series15: TPointSeries;
    Series16: TFastLineSeries;
    Series17: TPointSeries;
    Series18: TChartShape;
    Series19: TChartShape;
    Series20: TFastLineSeries;
    Series21: TFastLineSeries;
    Series22: TPointSeries;
    Series23: TFastLineSeries;
    Series24: TFastLineSeries;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Chart2ClickSeries(Sender: TCustomChart; Series: TChartSeries;
      ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
      Y: Integer);
    procedure Chart2DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form14: TForm14;

implementation

uses SetNrnParsO,Clamp,Noise,FiringClamp,function_Z,Unit8,Threshold;

{$R *.DFM}

procedure TForm14.FormShow(Sender: TObject);
begin
  tau_E:=0;
  tau_I:=0;
  NP0.HH_type:='Calmar';
  NP0.IfSet_gL_or_tau:=1;
  uu:=0.060{0.030};
  ss:=0.8{0.4};//-uu[1]/Vus;
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure ClearSeries;
begin
  Form14.Series8.Clear;
  Form14.Series9.Clear;
  Form14.Series10.Clear;
  Form14.Series11.Clear;
  Form14.Series12.Clear;
  Form14.Series13.Clear;
  Form14.Series15.Clear;
end;

procedure CorrectAnalysingPoint(j :integer; x,y :double);
begin
    { Find number of the analyzed point }
//    j:=1;  while (T_FC[j]<>Tg_FC[NgoodPts])and(j<=n_FC) do j:=j+1;
    { Correct analysing point }
//    n_FC:=1;
    F_FC[j]:=F_FC[j]-x;
    G_FC[j]:=G_FC[j]-y;
    U_FC[j]:=U_FC[j];
    S_FC[j]:=S_FC[j];
    T_FC[j]:=T_FC[j];
    Ua_FC[j]:=Ua_FC[j];
    Sa_FC[j]:=Sa_FC[j];
end;

function IfGood(u0,s0,delta_freq,delta_Vav :double) :boolean;
var d_freq,d_Vav :double;
begin
  IntegrateWithoutNoiseToGet_V_freq_Vav(u0,s0,5);
  CalcDisturbancesOf_V;
  CalcDisturbancesOf_InputCurrent(u0,s0);
  d_freq   :=Convolution_Of(Z_freq,I_dstb, nZ_freq,n_dstb,freq_no/91.5,'UnderThr');
  d_Vav    :=Convolution_Of(Z_Vav, I_dstb, nZ_Vav, n_dstb,freq_no/91.5,'UnderThr');
  IfGood:=((abs(delta_freq)>abs(d_freq))and(abs(delta_Vav)>abs(d_Vav)));
end;

{*********************************************************************}
procedure TForm14.Button1Click(Sender: TObject);
var delta_freq,delta_freq_no,delta_Vav,delta_Vav_no,
    u0,s0,u1,s1,Kern2,    freq_ex,Vav_ex,
    err_u0,err_s0,err_u1,err_s1
                                                        :double;
    t1  :string;
    i   :integer;
label bad;
begin
  ClearSeries;
//  { Calculate exact deterministic V(t) }
//  IntegrateWithoutNoiseToGet_V_freq_Vav(uu[1],ss[1],5);
//  freq_ex:=1/ISI[0];
//  Vav_ex:=Vav_prev;
  i:=0;  err_u0:=0; err_s0:=0; err_u1:=0; err_s1:=0;
  repeat i:=i+1;
    { Calculate noisy V(t) }
    IntegrateWithNoise(5);
    Remember_V_freq_Vav_noisy;
    { Approximately find (u,s) }
    AnalyzeByFiringClamp(n_FC,F_FC,G_FC,H_FC,U_FC,S_FC,T_FC,Ua_FC,Sa_FC,
                                                      Tg_FC,gE_FC,gI_FC);
    if n_FC=0 then goto bad;
    gE_gI_to_U_S(gE_FC[n_FC],gI_FC[n_FC],0,0, u0,s0);
    { Calculate deterministic V(t) }
    IntegrateWithoutNoiseToGet_V_freq_Vav(u0,s0,5);
    { Calculate disturbed V'(t), i'(t) }
    CalcDisturbancesOf_V;
    CalcDisturbancesOf_InputCurrent(u0,s0);
    { Convolutions }
    delta_freq_no:=Convolution_Of(Z_freq,I_no_mean, nZ_freq,n_dstb,1,'UnderThr');
    delta_freq   :=Convolution_Of(Z_freq,I_dstb,    nZ_freq,n_dstb,1,'UnderThr');
    if Form14.RadioGroup1.ItemIndex=0 then begin
       delta_freq_no:=freq_no*delta_freq_no;
       delta_freq   :=freq_no*delta_freq;
    end;
    delta_Vav_no :=Convolution_Of(Z_Vav, I_no_mean, nZ_Vav, n_dstb,1,'UnderThr');
    delta_Vav    :=Convolution_Of(Z_Vav, I_dstb,    nZ_Vav, n_dstb,1,'UnderThr');
    Kern2        :=SecondKernel  (Z_freq,I_no_mean, nZ_freq,n_dstb,'UnderThr');
    { Output }
    str(delta_freq_no:6:1,t1);
    Form14.Label1.Caption:='delta_freq ='+t1;
    Form14.Series8. AddXY(freq_no-freq_det,delta_freq_no);
    Form14.Series10.AddXY(freq_no-freq_det,delta_freq);
    Form14.Series9. AddXY(freq_no-freq_det-delta_freq_no, Kern2);
    Form14.Series15.AddXY((Vav_no- Vav_det)*1e3,delta_Vav*1e3);
    { Correct analysing point }
    CorrectAnalysingPoint(n_FC, delta_freq_no, delta_Vav_no);
    { Find corrected (u,s) }
    AnalyzeByFiringClamp(n_FC,F_FC,G_FC,H_FC,U_FC,S_FC,T_FC,Ua_FC,Sa_FC, Tg_FC,gE_FC,gI_FC);
    if n_FC=0 then goto bad;
    gE_gI_to_U_S(gE_FC[n_FC],gI_FC[n_FC],0,0, u1,s1);
    { Drawing }
    Form14.Series13.AddXY(u0,s0);
    Form14.Series11.AddXY(u1,s1);
    Form14.Series12.AddXY(uu,ss);
    err_u0:=(err_u0*(i-1)+abs(u0-uu))/i;
    err_s0:=(err_s0*(i-1)+abs(s0-ss))/i;
    err_u1:=(err_u1*(i-1)+abs(u1-uu))/i;
    err_s1:=(err_s1*(i-1)+abs(s1-ss))/i;
    Form14.Series18.X0:=uu-err_u0;       Form14.Series19.X0:=uu-err_u1;
    Form14.Series18.X1:=uu+err_u0;       Form14.Series19.X1:=uu+err_u1;
    Form14.Series18.Y0:=ss-err_s0;       Form14.Series19.Y0:=ss-err_s1;
    Form14.Series18.Y1:=ss+err_s0;       Form14.Series19.Y1:=ss+err_s1;
    Application.ProcessMessages;
    bad: {exit for the current realisation};
  until i=trunc(Form14.DDSpinEdit1.Value);
end;

{*********************************************************************}
procedure CorrectByWienerKernel(t1,t2 :double; var u0,s0 :double);
var
     indicat                                            :integer;
     delta_freq,delta_Vav, u1,s1, gE1,gI1               :double;
begin
  { *** Calculate noisy V(t) *** }
  AssignFile(fff,'V(t).dat');  Reset(fff);
  { Read till t1 }
  repeat
    NV0.Vold:=NV0.V;
    readln(fff,t,NV0.V);  t:=t/1e3;  NV0.V:=NV0.V/1e3;
  until abs(t-t1)<1e-8;
  indicat:=2;  NV0.tAP:=t1;
  { Read on interspike interval }
  repeat
    NV0.Vold:=NV0.V;
    readln(fff,t,NV0.V);  t:=t/1e3;  NV0.V:=NV0.V/1e3;
    FrequencyAmplitude(NP0,NV0,indicat);
    RememberInCircularArray(NV0.V,0,0);
  until (t>t2+1e-8)or eof(fff);
  Remember_V_freq_Vav_noisy;

  { *** Calculate deterministic V(t) *** }
  IntegrateWithoutNoiseToGet_V_freq_Vav(u0,s0,5);
  { Calculate disturbed V'(t), i'(t) }
  CalcDisturbancesOf_V;
  CalcDisturbancesOf_InputCurrent(u0,s0);

  { *** Convolutions with Wiener kernels *** }
  delta_freq   :=Convolution_Of(Z_freq,I_dstb, nZ_freq,n_dstb,freq_no/91.5,'UnderThr');
  delta_Vav    :=Convolution_Of(Z_Vav, I_dstb, nZ_Vav, n_dstb,freq_no/91.5,'UnderThr');

  { *** Find corrected (u,s) *** }
  u1:=u0;  s1:=s0;
  Find_u_s_from_2Plots(freq_no-delta_freq,Vav_no-delta_Vav, u1,s1);
  if abs(u1-25/1000)>1e-6 then
{     if IfGood(u1,s1,delta_freq,delta_Vav) then} begin u0:=u1; s0:=s1; end;
  CloseFile(fff);
end;

procedure TForm14.Chart2ClickSeries(Sender: TCustomChart;
  Series: TChartSeries; ValueIndex: Integer; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Series.Active:=not(Series.Active);
end;

procedure TForm14.Chart2DblClick(Sender: TObject);
var i:integer;
begin
  for i:=0 to Chart2.SeriesCount-1 do  Chart2.Series[i].Active:=true;
end;

end.
