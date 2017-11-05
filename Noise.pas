unit Noise;

interface
uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Math,MyTypes,Init,t_dtO,MathMyO,Other,Graph,ControlNrn,
     Hodgkin_old,
     Unit1,Unit3,Unit4,Unit10,Unit14,Unit16,
     Threads,Threshold,FiringClamp,Statistics,function_Z;

function FromRadioGroup2 :double;
function FromRadioGroup3 :double;
procedure MeanSynConductances(t :double; var gE0,gI0 :double);
procedure SynConductancesOnNewStep;
procedure SynCurrentOnNewStep(Ampl_,mean_,tau_Noise_ :double; var Curr :double);
procedure IntegrateWithNoise(MaxNOfSpikes :integer);
procedure IntegrateWithoutNoiseToGet_V_freq_Vav(u,s :double; MaxNOfSpikes :integer);
procedure StatisticsOfConductanceEstimations;

var
    F_FC,G_FC,H_FC,U_FC,S_FC,T_FC,Ua_FC,Sa_FC,Tg_FC,gE_FC,gI_FC :vecFC;
    n_FC                                                        :integer;
    FC_Ua,FC_Sa, FC_Uint,FC_Sint, FC_Uint_prev,FC_Sint_prev,
    FC_dFdu,FC_freq,FC_I0,
    du_FC,ds_FC, u0_Adapt,s0_Adapt, u_Adapt,s_Adapt, un_Adapt,sn_Adapt,
    u_Adapt_prev,s_Adapt_prev,
    Ampl_u,Ampl_s,Ampl_gE,Ampl_gI,gE,gI,mean_gE,mean_gI         :double;
    ppp                                                         :text;

implementation
uses Unit8,Clamp,Thread_FC,HH_canal,FC_control,
     typeNrnParsO;

function FromRadioGroup2 :double;
var ooo:double;
begin
      case Form1.RadioGroup2.ItemIndex of
               1: ooo:=Vav_prev;   {average voltage}
               2: ooo:=Vmin_prev;  {minimum}
               3: ooo:=Vmax;       {maximum}
               4: ooo:=V_Conv;     {Convolution with parabola}
               5: ooo:=VxZ;        {Convolution of V and Z}
               6: ooo:=IxZ;        {Convolution of I and Z}
      else
                  ooo:=avPSC_prev; {slope}
      end;
      FromRadioGroup2:=ooo;
end;

function FromRadioGroup3 :double;
var ooo:double;
begin
      case Form1.RadioGroup3.ItemIndex of
               1: ooo:=VxZ;        {Convolution of V and Z}
               2: ooo:=WidthAP;    {width of AP}
               3: ooo:=Vmin_prev;  {minimum}
               4: ooo:=Vmax-Vmin_prev;  {Vmax-Vmin}
               5: ooo:=VT_1ms;     {VT_1ms}
               6: ooo:=Th;         {Th}
      else
                  ooo:=freq{LimRev(ISI[0],1e-6)}; {Frequency}
      end;
      FromRadioGroup3:=ooo;
end;

procedure PrepareForAnalysisByFiringClamp(indicat:integer);
var u0,s0 :double;
begin
  if (indicat=3)and(n_FC<MaxVC) then begin
      n_FC:=n_FC+1;
      F_FC[n_FC]:=FromRadioGroup3;
      G_FC[n_FC]:=FromRadioGroup2;
      H_FC[n_FC]:=Vmin_prev;
      U_FC[n_FC]:=uu;
      S_FC[n_FC]:=ss;
      T_FC[n_FC]:=NV0.tAP;
      Ua_FC[n_FC]:=FC_Uint_prev;
      Sa_FC[n_FC]:=FC_Sint_prev;
      if Form1.ComboBox1.ItemIndex in [6,11,12] then begin { Estimate adaptation }
         Ua_FC[n_FC]:=Ua_FC[n_FC] - u_Adapt_prev;
         Sa_FC[n_FC]:=Sa_FC[n_FC] - s_Adapt_prev;
      end;
      if Form1.ComboBox1.ItemIndex in [5,10] then begin { Extract adapt. and FC }
         Ua_FC[n_FC]:=Ua_FC[n_FC] - u_Adapt + u0_Adapt;
         Sa_FC[n_FC]:=Sa_FC[n_FC] - s_Adapt + s0_Adapt;
      end;
      { Drawing }
      Form8.Series7.AddXY(T_FC[n_FC]*1e3,F_FC[n_FC]);
      Form8.Series8.AddXY(T_FC[n_FC]*1e3,G_FC[n_FC]*1e3);
      Application.ProcessMessages;
      { Writing }
      if n_FC=1 {not(FileExists('map_u_s.dat'))} then begin
         AssignFile(ppp,'map_u_s.dat'); rewrite(ppp);  close(ppp);
      end;
      append(ppp);
      { V1=t, (V2,V3)=(u,s)original, (V4,V5)=(u,s)afterFC, (V6,V7)=(du,ds)adaptation }
      write  (ppp,T_FC[n_FC]*1e3:8:3);
      write  (ppp,' ',(uu+Current_Iind-FC_Ua)*1000:8:3,' ',ss-FC_Sa:8:3);
      write  (ppp,' ',FC_Uint_prev*1000:8:3,' ',FC_Sint_prev:8:3);
      writeln(ppp,' ',Ua_FC[n_FC]*1000:8:3,' ',Sa_FC[n_FC]:8:3);
      close(ppp);
  end;
end;

procedure MeanSynConductances(t :double; var gE0,gI0 :double);
begin
  if tau_E>0 then  gE0:=Ampl_gE*(1+sin(2*pi*t/tau_E-pi/2)) else gE0:=Ampl_gE;
  if tau_I>0 then  gI0:=Ampl_gI*(1+sin(2*pi*t/tau_I-pi/2)) else gI0:=Ampl_gI;
  if (t<t_IindShift) or (t>t_Iind+t_IindShift) then begin gE0:=0; gI0:=0; end;
end;

procedure SynConductancesOnNewStep;
var xE,xI :double;
begin
  xE:=Ampl_gE*NoiseToSignal*randG(0,1);
  xI:=Ampl_gI*NoiseToSignal*randG(0,1);
  if tau_Noise=0 then begin
     gE:= sgn(mean_gE)*min(abs(mean_gE + xE),10*abs(Ampl_gE));
     gI:= sgn(mean_gI)*min(abs(mean_gI + xI),10*abs(Ampl_gI));
  end else begin
     gE:=gE + (mean_gE-gE)/tau_Noise*dt + xE*sqrt(2*dt/tau_Noise);
     gI:=gI + (mean_gI-gI)/tau_Noise*dt + xI*sqrt(2*dt/tau_Noise);
     gE:= sgn(mean_gE)*max(abs(gE),0);
     gI:= sgn(mean_gI)*max(abs(gI),0);
  end;
end;

procedure SynCurrentOnNewStep(Ampl_,mean_,tau_Noise_ :double; var Curr :double);
var x :double;
begin
  x:=Ampl_*randG(0,1);
  if tau_Noise_=0 then begin
     Curr:= mean_+max(-10*Ampl_,min(x,10*Ampl_));
  end else begin
     Curr:= Curr + (mean_-Curr)/tau_Noise_*dt + x*sqrt(2*dt/tau_Noise_);
  end;
end;

var VforDisp,currDispV :double;
    iDisp :integer;

procedure CurrentDispersion(Vnew_,Vold_:double);
var  tau1,DV :double;
begin
      if t>0.4 then exit;
      tau1:=Form8.DDSpinEdit2.Value/1e3;
      if t<=tau1 then begin VforDisp:=NP0.Vrest; DispV:=0; iDisp:=0; end;
      VforDisp:=VforDisp+dt/tau1*(Vnew_-VforDisp);
      DV:=abs(min(0,Vnew_-Vold_));
//      DV:=sqr(Vnew_-VforDisp{Vold_});
      iDisp:=iDisp+1;
      currDispV:=currDispV*(iDisp-1)/iDisp+DV/iDisp;
      if abs(trunc(t/tau1)*tau1-t)<=dt then begin
//         DispV:=currDispV;
         iDisp:=0;
      end;
      DispV:=DispV + dt/tau1*(DV -DispV);
//      Form8.Series11.AddXY(nt*dt*1e3, DispV*1e3);
//      Form8.Series12.AddXY(nt*dt*1e3, (gL[1]+mean_gE+mean_gI));
//      Form8.Series13.AddXY(nt*dt*1e3, (VforDisp-Vrest[1])*1e3);
end;

procedure WienerKernel(indicat :integer);
var  X,Y,P :double;
begin
//  if n_FC<2 then exit;
  { Input signal }
  if tau_Noise<>0    then  P:=sqr(NoiseToSignal*Ampl_u)*tau_Noise
  else                     P:=sqr(NoiseToSignal*Ampl_u)*dt;//tau_m[1];
  if abs(P)<1e-10    then  P:=1;
  case Form14.RadioGroup2.ItemIndex of
    0: X:=(uu-Ampl_u - (ss-Ampl_s)*(NV0.Vold-Vus)){Isyn}/P;// /1e6;
    1: begin
         X:=(NV0.V-V_det[trunc((t-NV0.tAP)/dt)])/P;
         if NV0.V>-0.04 then X:=0;
       end;
  end;
  { Output signal }
  if indicat=2 then
  case Form14.RadioGroup1.ItemIndex of
    0: Y:=1;
    1: Y:=1/ISI[0] -freq_det;
    2: Y:=Vav_prev - Vav_det;
  end;
  Calculate_Z(X,Y, indicat);
  { Write }
  if nt=nt_end then  Write_Z;
end;


{***********************************************************}
procedure IntegrateWithNoise(MaxNOfSpikes :integer);
{***********************************************************}
var
     indicat                                    :integer;
     rnd,Convolution                            :double;
BEGIN
  IntegrateWithoutNoiseToGet_V_freq_Vav(uu,ss,5);
  n_FC:=0;  FC_Uint_prev:=0; FC_Sint_prev:=0;  FC_Uint:=0; FC_Sint:=0;
  du_FC:=0; ds_FC:=0;  u_Adapt:=0;  s_Adapt:=0;
  FC_Ua:=0; FC_Sa:=0; un_Adapt:=0; sn_Adapt:=0;
//  dt:=0.000015;
  { Parameters special for Smpl }
  Read_Params_from_File_or_Procedure;
  if WriteOrNot=1 then begin assign(nnn,'gE_gI_Noisy(t).dat'); rewrite(nnn); end;
  if WriteOrNot=1 then InitiateWriting;
  if IfWriteInFFF<>0 then Rewrite(fff);
  InitialConditions;
  InitialPicture;
  Form8.ClearAll;
  CorrespondParametersToTheForm;
  IIspike:=0;   indicat:=0;
  Ampl_u:=uu;
  Ampl_s:=ss;
  U_S_to_gE_gI(Ampl_u,Ampl_s, 0,0, Ampl_gE,Ampl_gI);
  MeanSynConductances(t,gE,gI);
  REPEAT  nt:=nt+1;  t:=nt*dt; { time step }
      { Input }
      MeanSynConductances(t,mean_gE,mean_gI);
      SynConductancesOnNewStep;
      if t<1.0 then Form8.Series1.AddXY(t*1e3,gE);
      if t<1.0 then Form8.Series2.AddXY(t*1e3,gI);
      { (gE,gI) to (u,s) }
      gE_gI_to_U_S(gE,gI, 0,0, uu,ss);
      uu:=uu+FC_Ua;
      ss:=ss+FC_Sa;
      if (t<1)and(trunc(nt/n_Draw)=nt/n_Draw) then Form8.Series14.AddXY(t*1e3,uu*1000);
      if (t<1)and(trunc(nt/n_Draw)=nt/n_Draw) then Form8.Series12.AddXY(t*1e3,ss);
      if (t<1)and(trunc(nt/n_Draw)=nt/n_Draw) then Form8.Series15.AddXY(t*1e3,FC_Ua*1000);
      if (t<1)and(trunc(nt/n_Draw)=nt/n_Draw) then Form8.Series16.AddXY(t*1e3,FC_Sa);
      { Integration }
      MembranePotential;
      { Measurement }
      case NP0.If_I_V_or_g of
        1: Vr:=NV0.PSC;
        2: Vr:=NV0.V-NP0.Vrest;
        3: Vr:=NV0.INa/(NV0.V-NP0.VNa);
        4: Vr:=NV0.PSC;
        5: Vr:=NV0.PSC;
        6: Vr:=NV0.PSC;
        7: Vr:=NV0.V-NP0.Vrest;
      end;
      { Writing and Drawing }
      if (nt=1)or(trunc(nt/n_Draw)=nt/n_Draw)  then Evolution;
      if (WriteOrNot=1) and (trunc(nt/n_Write)=nt/n_Write) then  Writing;
      if (WriteOrNot=1) then  writeln(nnn, t*1e3:9:3,' ',gE:9:4,' ',gI:9:4);
      if Form1.CheckBox1.Checked then AnalyseStatistics(NV0.V*1e3{Iadd[1]*Square[1]*1e9});
      CurrentDispersion(NV0.V,NV0.Vold);
      case IfWriteInFFF of
      1: writeln(fff, t*1e3:9:3,' ',NV0.V*1e3:9:3);
      2: writeln(fff, t*1e3:9:3,' ', Vexp[nt,Smpl]:9:3,' ', Vr:9:3);
      3: writeln(fff, t*1e3:9:3,' ',NV0.mmR:9:3,' ',NV0.hhR:9:3);
      4: writeln(fff, t*1e3:9:3,' ',DefineAskedCurve:9:3);
      end;
      if ((IfWriteInFFF=4)or(IfDrawAskedCurve=1))and
         (trunc(nt/n_Draw)=nt/n_Draw) then DrawAskedCurve(t*1000,DefineAskedCurve);
      FrequencyAmplitude(NP0,NV0,indicat);
      ResetVoltageOnDescendingWayOfSpike(indicat, NV0.V);
      { Convolution }
      WienerKernel(indicat);
      CalculateActiveConductance;
      RememberInCircularArray(NV0.V, Isyn+Current_Iind{-(ss[1]-Ampl_s)*(Vold[1]-Vus)+uu[1]-Ampl_u},{Conductance+}ss);
      if indicat=2 then  CalculateConvolutions;
      { FiringClamp }
      PrepareForAnalysisByFiringClamp(indicat);
      Define_FC_Current(indicat);
      Pause;
  UNTIL (nt>=nt_end)or((IIspike=MaxNOfSpikes)and(indicat=3));
  uu:=Ampl_u;
  ss:=Ampl_s;
  if WriteOrNot=1 then close(ccc);
  if WriteOrNot=1 then close(nnn);
  CloseFFF;
END;

{***********************************************************}
procedure IntegrateWithoutNoiseToGet_V_freq_Vav(u,s :double;
                                                MaxNOfSpikes :integer);
var
     indicat,IIspike  :integer;
     u_mem,s_mem      :double;
BEGIN
  u_mem:=uu;  uu:=u;
  s_mem:=ss;  ss:=s;
  { Parameters special for Smpl }
  Read_Params_from_File_or_Procedure;
  InitialConditions;
//  InitialPicture;
  CorrespondParametersToTheForm;
  IIspike:=0;
  REPEAT  nt:=nt+1;  t:=nt*dt; { time step }
      { Integration }
      MembranePotential;
      { Writing and Drawing }
//      if (nt=1)or(trunc(nt/n_Draw)=nt/n_Draw)  then Evolution;
      if (IfWriteInFFF=4)or(IfDrawAskedCurve=1) then
          DrawAskedCurve(t*1000,DefineAskedCurve);
      FrequencyAmplitude(NP0,NV0,indicat);
      { Circular Array }
      CalculateActiveConductance;
      RememberInCircularArray(NV0.V, uu{Isyn},NV0.gActive{+ss[1]});
      if indicat=2 then  IIspike:=IIspike+1;
  UNTIL (nt=nt_end)or(IIspike=MaxNOfSpikes);
  if IIspike=MaxNOfSpikes then  RememberAndDraw_V_freq_Vav_deterministic;
  uu:=u_mem;
  ss:=s_mem;
  CorrespondParametersToTheForm;
//  if WriteOrNot=1 then close(ccc);
END;

{********************************************************************}
procedure StatisticsOfConductanceEstimations;
  { Record voltage with noisy conductance-input
    and find the conductances by Firing-Clamp }
var
    i,j,N_prev,nt                      :integer;
    mean_gE,mean_gI,dt,t,u1,s1         :double;
begin
  { Write exact solution }
  U_S_to_gE_gI(uu,ss, 0,0, Ampl_gE,Ampl_gI);
  assign(ddd,'mean_gE_gI(t).dat'); rewrite(ddd);
  dt:=0.001;
  t:=-dt;
  REPEAT  t:=t+dt; { time step }
          MeanSynConductances(t,mean_gE,mean_gI);
          writeln(ddd,t*1e3:9:3,' ',mean_gE:9:4,' ',mean_gI:9:4);
  UNTIL t>t_end;
  close(ddd);
  { Prepare file for Firing-Clamp estimations }
  assign(ddd,'gE_gI(t).dat'); rewrite(ddd);  close(ddd);
  N_prev:=0;
  n_FC:=0;
  for i:=1 to trunc(Form8.DDSpinEdit1.Value) do begin
      { Record frequency and potential slope }
      IntegrateWithNoise(MaxVC);
      { Estimate conductances by Firing-Clamp }
      AnalyzeByFiringClamp(n_FC,F_FC,G_FC,H_FC,U_FC,S_FC,T_FC,Ua_FC,Sa_FC,
                                                        Tg_FC,gE_FC,gI_FC);
      { Write the results of estimations }
      append(ddd);
      for j:=N_prev+1 to n_FC do begin
          gE_gI_to_U_S(gE_FC[j],gI_FC[j], 0,0, u1,s1);
          write  (ddd,Tg_FC[j]*1e3:9:3,' ',gE_FC[j]:9:4,' ',gI_FC[j]:9:4);
          writeln(ddd,' ',u1*1000:9:4,' ',s1:9:4);
      end;
      close(ddd);
      N_prev:=n_FC;
  end;
end;

end.
