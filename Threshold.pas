unit Threshold;

interface
uses Forms,Math,
     MyTypes,Init,t_dtO,MathMyO,Graph,Other,FiringClamp,Hodgkin_old,
     NeuronO,CreateNrnO,typeNrnParsO,Electrode;

procedure IfSpikeOccursO(ANrn :TNeuron);
procedure IfSpikeOccurs(V_,dVdt_,ddV_,VT_:double; var tAP_:double; var indic_:integer);
procedure FrequencyAmplitudeO(ANrn :TNeuron);
procedure FrequencyAmplitude(NP_:NeuronProperties; var NV :NeuronVariables; var indicat :integer);
procedure FindThresholdO;
procedure PlotForControlParametersO;
procedure Plot_nu_IindO;
procedure Plot_Adaptaion;

var
    Th,DVDt_Th,Th1,DVDt_Th1,Th_Curv,DVDt_Curv,tAP_Curv,tAP1,tAP2,
    hh_Th,hh_Th1,hh_slow_Th,hh_slow_Th1                             :double;

implementation
uses Clamp,ReducedEq,
     Unit1,Unit3,Unit4,Unit5,Unit6,Unit9,Unit7,
     Thread_u_s,function_Z,Noise,FC_control,ControlNrn;

var
        n_av,n_Iav                              :integer;
        Vpeak                                   :double;


function TimeFromThePeak(V0,V1,V2 :double; var Vpeak :double) :double;
{ V0,V1,V2 are values corresponding to moments 0,-dt,-2*dt }
var  b,tp :double;
begin
  TimeFromThePeak:=0;
  if (V1>V0)and(V1>V2) then begin
      tp:=-dt/2*((V2-V0)-(V1-V0)*4)/((V2-V0)-(V1-V0)*2);
      b:= ((V2-V0)-(V1-V0)*4)/2/dt;
      Vpeak:=V0+b/2*tp;
      TimeFromThePeak:=tp;
  end;
end;

procedure IfSpikeOccursO(ANrn :TNeuron);
{Defines if a spike occurs for V_.
 'indic_' = 0 - after spike
            1 - on ascending way
            2 - at spike               }
var t_peak,Vprev_,Vpprev_,VSpikeCrit :double;
begin
  WITH ANrn DO BEGIN
    IF (NP.IfThrModel=1)or(NP.IfLIF=1) THEN BEGIN
//       ANrn.IfSpikeOccursInThrModel;
       ISI[0]:=NV.ISI0;
       exit;
    END;
    VSpikeCrit:=Form9.DDSpinEdit12.Value/1e3{-30mV};
    if (NV.indic=2)or(t<NV.tAP+0.001) then NV.indic:=0;  { after spike }
    if NV.V>VSpikeCrit then begin
       { Find local maximum }
       Vprev_:=NV.V-NV.dVdt*dt;
       Vpprev_:=dt*dt*NV.ddV-NV.V+2*Vprev_;
       if NV.V>Vprev_ then begin
          NV.indic:=1;            { on ascending way }
       end else begin
           if NV.indic=1 then begin
              NV.indic:=2;        { at spike }
              t_peak:=t+TimeFromThePeak(NV.V,Vprev_,Vpprev_, Vpeak);
              NV.ISI0:=min(t_peak-NV.tAP,t_peak);
              ISI[0]:=NV.ISI0;
              NV.tAP:=t_peak;
           end;
       end;
    end;
  END;
end;

procedure IfSpikeOccurs(V_,dVdt_,ddV_,VT_:double; var tAP_:double; var indic_:integer);
{Defines if a spike occurs for V_.
 'indic_' = 0 - after spike
            1 - on ascending way
            2 - at spike               }
var t_peak,Vprev_,Vpprev_ :double;
begin
  IF (NP0.IfThrModel=1)or(NP0.IfLIF=1) THEN BEGIN
     IfSpikeOccursInThrModel(V_,VT_{NP.Vrest+NV.Thr},ddV_,tAP_,indic_);
     exit;
  END;
  if (indic_=2)or(t<tAP_+0.001) then indic_:=0;  { after spike }
  if V_>Form9.DDSpinEdit12.Value/1e3{-30mV} then begin
     { Find local maximum }
     Vprev_:=V_-dVdt_*dt;
     Vpprev_:=dt*dt*ddV_-V_+2*Vprev_;
     if V_>Vprev_ then begin
        indic_:=1;            { on ascending way }
     end else begin
         if indic_=1 then begin
            indic_:=2;        { at spike }
            t_peak:=t+TimeFromThePeak(V_,Vprev_,Vpprev_,Vpeak);
            ISI[0]:=min(t_peak-tAP_,t_peak);
            tAP_:=t_peak;
         end;
     end;
  end;
end;

procedure FrequencyAmplitudeO(ANrn :TNeuron);
var is0,ooo :double;
begin
  WITH ANrn DO BEGIN
  if NV.indic=3 then NV.indic:=0;   { End of spike }
  freq:=freq*(nt-1)/nt;
  IfSpikeOccursO(ANrn);
  { if spike }
  if NV.indic=2 then begin
     freq:=(freq*t+1)/t;
     avVmax:=(avVmax*freq*t+NV.Vold)/(freq*t+1);
     Vmax:=Vpeak;
     n_av:=0;  n_Iav:=0;
     if Vav<>0    then  Vav_prev   :=Vav;    Vav:=0;
     if Vweigh<>0 then  Vweigh_prev:=Vweigh; Vweigh:=NP.Vrest;
     if avPSC<>0  then  avPSC_prev :=avPSC;  avPSC:=0;
     if Vmin<>1e6 then  avVmin:=(avVmin*freq*t+Vmin)/(freq*t+1);
     Vmin_prev:=Vmin; Vmin:=1e6;
     Th:=ThrNeuron.V-NP.Vrest;
     IIspike:=IIspike+1;
   end;
  { Measurement Between Spikes }
  if (NV.indic<>2)and(t-NV.tAP>0) then begin
      { Average potential }
      ooo:=Form9.DDSpinEdit5.Value/1e3;   {-15mV }
      if (NV.V<ooo)and(t-NV.tAP>0.002)and(abs(NV.DVDt)<5) then begin
         n_av:=n_av+1;
         Vav  :=(  Vav*(n_av-1)+NV.V )/n_av;
      end;
      Vweigh:=Vweigh + dt/NP.tau_m0*(NV.V-Vweigh);
      { Slope }
      ooo:=Form9.DDSpinEdit10.Value/1e3;  {-40mV}
      if (NV.V>ooo-0.001)and(NV.V<ooo)and(NV.PSC>0) then begin
         n_Iav:=n_Iav+1;
         is0:=NV.PSC/NP.Square/1e9/(NV.V-NP.Vrest)-NP.gL;
         avPSC:=(avPSC*(n_Iav-1)+is0)/n_Iav;
      end;
      { Minimum }
      Vmin:=min(Vmin,NV.V);
  end;
  { Width of AP }
  ooo:=Form9.DDSpinEdit11.Value/1e3;   {-20mV}
  if (NV.indic=1)and(NV.V>ooo)and(NV.Vold<ooo) then begin
      tAP1:=t-dt;
      tAP1:=tAP1+(ooo-NV.Vold)/NV.DVDt;
  end;
  if (NV.indic=0)and(NV.V<ooo)and(NV.Vold>ooo) then begin
      tAP2:=t-dt;
      if NV.DVDt<>0 then
      tAP2:=tAP2+(ooo-NV.Vold)/NV.DVDt;
      WidthAP:=tAP2-tAP1;
      NV.indic:=3;    { End of spike }
  end;
  END;
end;

procedure FrequencyAmplitude(NP_:NeuronProperties; var NV :NeuronVariables; var indicat :integer);
var is0,ooo :double;
begin
  if indicat=3 then indicat:=0;   { End of spike }
  freq:=freq*(nt-1)/nt;
  IfSpikeOccurs(NV.V,NV.DVDt,NV.ddV,NP_.Vrest+NV.Thr,NV.tAP,indicat);
  { if spike }
  if indicat=2 then begin
     freq:=(freq*t+1)/t;
     avVmax:=(avVmax*freq*t+NV.Vold)/(freq*t+1);
     Vmax:=Vpeak;
     n_av:=0;  n_Iav:=0;
     if Vav<>0    then  Vav_prev   :=Vav;    Vav:=0;
     if Vweigh<>0 then  Vweigh_prev:=Vweigh; Vweigh:=NP_.Vrest;
     if avPSC<>0  then  avPSC_prev :=avPSC;  avPSC:=0;
     if Vmin<>1e6 then  avVmin:=(avVmin*freq*t+Vmin)/(freq*t+1);
     Vmin_prev:=Vmin; Vmin:=1e6;
     Th:=ThrNeuron.V-NP_.Vrest;
     IIspike:=IIspike+1;
   end;
  { Measurement Between Spikes }
  if (indicat<>2)and(t-NV.tAP>0) then begin
      { Average potential }
      ooo:=Form9.DDSpinEdit5.Value/1e3;   {-15mV }
      if (NV.V<ooo)and(t-NV.tAP>0.002)and(abs(NV.DVDt)<5) then begin
         n_av:=n_av+1;
         Vav  :=(  Vav*(n_av-1)+NV.V )/n_av;
      end;
      Vweigh:=Vweigh + dt/NP_.tau_m0*(NV.V-Vweigh);
      { Slope }
      ooo:=Form9.DDSpinEdit10.Value/1e3;  {-40mV}
      if (NV.V>ooo-0.001)and(NV.V<ooo)and(NV.PSC>0) then begin
         n_Iav:=n_Iav+1;
         is0:=NV.PSC/NP_.Square/1e9/(NV.V-NP_.Vrest)-NP_.gL;
         avPSC:=(avPSC*(n_Iav-1)+is0)/n_Iav;
      end;
      { Minimum }
      Vmin:=min(Vmin,NV.V);
  end;
  { Width of AP }
  ooo:=Form9.DDSpinEdit11.Value/1e3;   {-20mV}
  if (indicat=1)and(NV.V>ooo)and(NV.Vold<ooo) then begin
      tAP1:=t-dt;
      tAP1:=tAP1+(ooo-NV.Vold)/NV.DVDt;
  end;
  if (indicat=0)and(NV.V<ooo)and(NV.Vold>ooo) then begin
      tAP2:=t-dt;
      tAP2:=tAP2+(ooo-NV.Vold)/NV.DVDt;
      WidthAP:=tAP2-tAP1;
      indicat:=3;    { End of spike }
  end;
  NV.indic:=indicat;
end;

{-----------------------------------------------------------------------}
procedure FindThresholdO;
{ ********************************************************************
  Calculates Threshold 'VTh' and time of AP 'tAP'
  for different induced current 'Iind'.
  So, we will find the dependence 'VTh=VTh(tAP)'.
  VTh is for nonspiking model (Destexhe with INa=0)
  at the spike moments for complete model.
**********************************************************************}
var ni,nIind{,indicat }                         :integer;
    hhh                                         :text;
    Iind_mem,u_mem,s_mem,sgm_V,gL0,Noise_,V12_  :double;
    ANrnF,ANrnT                                 :TNeuron;
BEGIN
  assign(ddd,'VTh(tAP).dat'); rewrite(ddd);
  if WriteOrNot=1 then begin  assign(hhh,'V_Vlin(t).dat'); rewrite(hhh); end;
  { Parameters }
  Smpl:=0;
  Iind_mem:=Iind; Iind:=0;  u_mem:=uu; uu:=0;  s_mem:=ss;
  ss:=Form3.DDSpinEdit5.Value;
  Form1.FitPictureToExpData1.Checked:=false;
  dt:=0.000015;
  t_end:=0.40{s}; t_Iind:=2.000{s};
  Freq_Iind:=Form3.DDSpinEdit2.Value;
  sgm_V :=   Form3.DDSpinEdit3.Value/1000;
  nt_end:=imin(trunc(t_end/dt), MaxNT);
  { Initiate 2 neurons: full and threshold ones }
//  InitialConditions;
  CreateNeuronByTypeO(NP0,ANrnF);
  //NP.IfReduced:=0;
  NP0.IfThrModel:=1;
  NP0.ThrShift:=0.100{V};
  NP0.Vreset:=-0.040{V};
  CreateNeuronByTypeO(NP0,ANrnT);
  NP0.IfThrModel:=0;
  gL0:=NP0.C_membr/NP0.tau_m0;
  { Loop for induced current }
  nIind:=Trunc(Form3.DDSpinEdit1.Value/Form3.DDSpinEdit4.Value);
  FOR ni:=1 to nIind DO BEGIN
    Iind:=Form3.DDSpinEdit4.Value*ni {pA};
    //InitialConditions;
    ANrnF.InitialConditions;
    ANrnT.InitialConditions;
    InitialPicture;
    Clear_Th_V;
    IIspike:=0;
    //indicat:=0;
    Th:=0;  DVDt_Th:=0;  Th_Curv:=0;  tAP1:=0;  tAP2:=0;
    repeat
      nt:=0;
      REPEAT  nt:=nt+1;  t:=nt*dt; { time step }
        { Noise }
        Noise_:=0;
        if IfNoise then
        Noise_:=sgm_V*gL0*sqrt(2*NP0.tau_m0  {/(1+ss/gL0)} /dt)*randG(0,1); //commented on 20.09.2012 and changed from uu to Noise_
        //if NP.IfReduced=1 then ReducedEquations
        //                  else MembranePotential;
        ANrnF.MembranePotential(uu,ss,0,s_soma,0,Current_Iind+du_Reset+Noise_,Vhold(t));
        if Form3.CheckBox1.Checked then uu:=0; {if NoNoiseInT-neuron}
        ANrnT.MembranePotential(uu,ss,0,s_soma,0,Current_Iind+du_Reset,Vhold(t));
        //NoSpikePotential(t-NV.tAP,ThrNeuron,NV.DVDt,NV.ddV);
        NV0:=ANrnF.NV;
        FrequencyAmplitudeO(ANrnF);

        { Threshold before spike }
        if (ANrnF.NV.DVDt>Form3.DDSpinEdit6.Value)and(Th_Curv=0) then begin
           Th_Curv  :=ANrnF.NV.V - ANrnT.NP.Vrest;
           DVDt_Curv:=ANrnT.NV.DVDt;
           tAP_Curv :=t;
        end;
        { Drawing }
//        if (nt=1)or(trunc(nt/n_Draw)=nt/n_Draw)  then Evolution;
        if (nt=1)or(trunc(nt/10)=nt/10) then begin
           Form3.Series3.AddXY(t*1000,ANrnF.NV.V*1000);
           Form3.Series4.AddXY(t*1000,ANrnT.NV.V*1000);
           V12_:=-55 + {30}20*ANrnF.NV.XNa[13]; {mV}    // from Lyle_NaO.pas
           Form3.Series14.AddXY(t*1000,V12_);
        end;
        if (WriteOrNot=1) and (trunc(nt/2)=nt/2) then
            writeln(hhh,t*1000:8:3,' ',ANrnF.NV.V*1000:11,' ',ANrnT.NV.V*1000:12);
      UNTIL (nt=nt_end) or (ANrnF.NV.indic{indicat}=2);
      Form3.Series2. AddXY(t*1000,ANrnT.NV.V*1000);
      Form3.Series10.AddXY(tAP_Curv*1000,(Th_Curv+ANrnT.NP.Vrest)*1000);
      if (IIspike=2)and(ANrnF.NV.indic{indicat}=2) then begin
         Th :=ANrnT.NV.V - ANrnT.NP.Vrest;
         DVDt_Th :=ANrnT.NV.DVDt;
         hh_Th     :=ANrnF.NV.hh;
         hh_slow_Th:=ANrnF.NV.XNa[13];
         tAP2:=t;
      end;
      if (IIspike=1)and(ANrnF.NV.indic{indicat}=2) then begin
         ANrnT.NV.tAP:=0;
         Th1:=ANrnT.NV.V - ANrnT.NP.Vrest;
         DVDt_Th1:=ANrnT.NV.DVDt;
         hh_Th1     :=ANrnF.NV.hh;
         hh_slow_Th1:=ANrnF.NV.XNa[13];
         tAP1:=t;
      end;
      ANrnT.ConditionsAtSpike(0);
    until (nt=nt_end) or (IIspike=2);
    if (ANrnF.NV.V<-0.050{V}) or (nt=nt_end) then ANrnT.NV.V:=0;
    { Drawing }
    if NV0.tAP>0 then  Plot_Th_tAP;
    { Results }
    write  (ddd,Th*1000:9:3,' ',ANrnF.NV.tAP*1000:9:5,' ',Iind:9:5,' ');
    writeln(ddd,DVDt_Th:9:5,' ',Th1*1000:9:5,' ',DVDt_Th1:9:5,' ',LimRev(tAP2,1e-6));
    Application.ProcessMessages;
  END;
  close(ddd);
  if WriteOrNot=1 then close(hhh);
  uu:=u_mem;  ss:=s_mem;  Iind:=Iind_mem;
  ANrnF.Free;
  ANrnT.Free;
END;

procedure PlotForControlParametersO;
{ ********************************************************************
  Calculates plot for frequency etc. depending on control parameters.
**********************************************************************}
var ns,nu,nt_end_rem,imem                         :integer;
    dum,gE1,gI1,gE_max,gI_max,
    t_end_rem,Iind_mem,u_mem,s_mem,
    uu,ss,x,y,fmem,u_soma_,s_soma_,u_soma__,s_soma__,
    Iind_,Vh_,gtot_                               :double;
    IfNoise                                       :boolean;
    ANrnF,ANrnT                                   :TNeuron;
BEGIN
  IfNoise:=(Form9.RadioGroup1.ItemIndex<>0);
  Iind_mem:=Iind; Iind:=0;  u_mem:=uu; uu:=0;  s_mem:=ss; ss:=0;
  t_end_rem:=t_end;   nt_end_rem:=nt_end;
  t_end:=Form9.DDSpinEdit4.Value/1000;
  nt_end:=imin(trunc(t_end/dt), MaxNT);
  WriteOrNot:=0;  Form1.Writing1.Checked:=false;
  assign(ddd,'v(u_s).dat'); rewrite(ddd);
  writeln(ddd,'ZONE T="ZONE1"');
  writeln(ddd,'I=', nue+1:3,' ,J=',nse+1:3,' ,K=1,F=POINT');
  { Initiate 2 neurons: full and threshold ones }
  InitialConditions;
  CreateNeuronByTypeO(NP0,ANrnF);
  imem:=NP0.IfThrModel; fmem:=NP0.ThrShift; NP0.IfThrModel:=1; NP0.ThrShift:=0.100{V};
  CreateNeuronByTypeO(NP0,ANrnT);  NP0.IfThrModel:=imem; NP0.ThrShift:=fmem;
  CorrespondParametersToTheForm;
  FOR ns:=0 to nse DO BEGIN
  FOR nu:=0 to nue DO BEGIN
    if If_u_s_or_Ge_Gi=1 then begin    { for (u,s)-plot }
       u_soma_:=((u_max-u_min)/nue*nu + u_min)/1000;
       s_soma_:= (s_max-s_min)/nse*ns + s_min;
       U_S_to_gE_gI(u_soma_,s_soma_, 0,0, gE1,gI1);
       x:=u_soma_*1000;  y:=s_soma_;
    end else begin                     { for (Ge,Gi)-plot }
//       U_S_to_gE_gI(u_max/1000,s_max, 0,0, gE_max,gI_max);
       gE_max:=u_max/1000/(-Vus);
       gI_max:=s_max/2;//max(0,s_max-gE_max);
       gE1:=gE_max/nue*nu;
       gI1:=gI_max/nse*ns;
       gE_gI_to_U_S(gE1,gI1, 0,0, u_soma_,s_soma_);
       x:=gE1;      y:=gI1;
    end;
    { Initial conditions }
//    InitialConditions;
    ANrnF.InitialConditions;
    ANrnT.InitialConditions;
//    InitialPicture;
    if IfNoise then begin  { Noise }
       Ampl_u:=u_soma_;  Ampl_s:=s_soma_;
       U_S_to_gE_gI(Ampl_u,Ampl_s, 0,0, Ampl_gE,Ampl_gI);
       mean_gE:=Ampl_gE; mean_gI:=Ampl_gI;
       gE     :=Ampl_gE;      gI:=Ampl_gI;
    end;
    IIspike:=0; ISI[0]:=0;  V_Conv:=0;  VxZ:=0;  IxZ:=0;
    nt:=0;
    REPEAT  nt:=nt+1;  t:=nt*dt; { time step }
//      PrintTime;
      case Form9.RadioGroup1.ItemIndex of     { Noise }
      1: SynCurrentOnNewStep(NoiseP.Ampl,Ampl_u,NoiseP.tau, u_soma_);
      2: begin SynConductancesOnNewStep; gE_gI_to_U_S(gE,gI, 0,0, u_soma_,s_soma_); end;
      end;
      Iind_:=0;
      u_soma__:=u_soma_;  s_soma__:=s_soma_;
      ElectrodePotential(ANrnF,uu,ss,u_soma__,s_soma__,  Iind_,Vh_);
      {****************}
      ANrnF.MembranePotential(0,0,u_soma_,s_soma_,tt,Iind_,0);
      ANrnT.MembranePotential(0,0,u_soma_,s_soma_,tt,Iind_,0);
      NV0:=ANrnF.NV;   ThrNeuron.V:=ANrnT.NV.V;
      {****************}
      FrequencyAmplitudeO(ANrnF);
      ResetVoltageOnDescendingWayOfSpike(NV0.indic{indicat}, NV0.V);
      if (NV0.indic{indicat}=2)and not(IfNoise) then begin
         freq:=LimRev(ISI[0],1e-6);
      end;
      if (NV0.V>0.100)or(NV0.V<-0.150)or((IIspike=0)and(t>0.1)) then begin
          nt:=nt_end; freq:=0;
      end;
      { Convolution }
      RememberInCircularArray(NV0.V,Isyn,0);
      if NV0.indic{indicat}=2 then CalculateConvolutions;
      { Drawing }
//      if (nt=1)or(trunc(nt/n_Draw)=nt/n_Draw)  then Evolution;
    UNTIL (nt>=imin(trunc(Form9.DDSpinEdit4.Value/1000/dt), MaxNT))or
          ((IIspike=Form9.DDSpinEdit6.Value)and(NV0.indic{indicat}=3));
    if IfNoise then begin  u_soma_:=Ampl_u;  s_soma_:=Ampl_s;  end;
    if freq>10 then NV0.V:=0;
    Plot_for_u_s_In_Thread.Synchronize;
    if freq< 5 then begin  Vav_prev:=0; avPSC_prev:=0; VxZ:=0; IxZ:=0;
                           Vmin_prev:=0; Vmax:=0; Vweigh_prev:=0; V_Conv:=0;
                           VT_1ms:=0; end;
    Draw_nu_u_s(x,y,freq,Vav_prev,avPSC_prev);
    Application.ProcessMessages;
    { Drawing }
    gtot_:=NP0.C_membr/NP0.tau_m0;
    {           1                    2                               }
    write  (ddd,u_soma_*1000:6:2,' ',s_soma_:8:4,' ');
    {           3                           4                        }
    write  (ddd,freq{LimRev(ISI[0],1e-6)}:6:2,' ',Vmax*1000:6:2,' ');
    {           5                        6                     7     }
    write  (ddd,Vweigh_prev*1000:6:2,' ',Vav_prev*1000:6:2,' ',avPSC_prev:8:4,' ');
    {           8           9           10                           }
    write  (ddd,gE1:8:4,' ',gI1:8:4,' ',Vmin_prev*1000:6:2,' ');
    {           11                  12               13              }
    write  (ddd,V_Conv*1000:6:2,' ',VxZ*1000:6:2,' ',IxZ:8:4,' ');
    {           14                          15                  16   }
    write  (ddd,max(0,WidthAP)*1000:8:4,' ',VT_1ms*1000:6:2,' ',Th*1000:6:2,' ');
    {           17                          18                       }
    writeln(ddd,u_soma_*1000/gtot_ :6:2,' ',s_soma_/gtot_:6:2);
  END;
  END;
  close(ddd);
  t_end:=t_end_rem;   nt_end:=nt_end_rem;
  uu:=u_mem;  ss:=s_mem;  Iind:=Iind_mem;
  ANrnF.Free;
  ANrnT.Free;
END;

procedure Plot_nu_IindO;
{ ********************************************************************
  Calculates plot for frequency etc. depending on Iind.
**********************************************************************}
var ni,nIind,If_I_V_or_g_o,IIspike23                          :integer;
    Iind_,Iind_o,t_Iind_o,sgm_V,tau_Noise,gL0,Noise_,Ampl_,
    u_soma_,s_soma_,Vh_                                       :double;
BEGIN
  sgm_V :=      Form7.DDSpinEdit13.Value/1000;
  assign(ddd,'v(Iind).dat'); rewrite(ddd);
  { Memorize current values }
  Iind_o:=Iind;
  t_Iind_o:=t_Iind;
  t_Iind:=1e8;
  If_I_V_or_g_o:=NP0.If_I_V_or_g;
  NP0.If_I_V_or_g:=2;
  gL0:=NP0.C_membr/NP0.tau_m0;
  sgm_V :=   Form7.DDSpinEdit13.Value/1000;
  tau_Noise:=Form7.DDSpinEdit16.Value/1e3; //0.003 {s};
  {---------------}
  nIind:=Trunc(Iind_max/dIind);
  FOR ni:=0 to nIind DO BEGIN
    Iind:=dIind*ni {pA};
    CorrespondParametersToTheForm;
    InitialConditions;
    CreateNeuronByTypeO(NP0,ANrn);
    ANrn.InitialConditions;
    IIspike:=0;
    Noise_:=0;
    nt:=0;
    REPEAT  nt:=nt+1;  t:=nt*dt; { time step }
      { Noise }
      if IfNoise then begin
        if tau_Noise=0 then begin
           Noise_:=sgm_V*gL0*sqrt(2*NP0.tau_m0  {/(1+ss/gL0)} /dt)*randG(0,1); //commented on 20.09.2012 and changed from uu to Noise_ on 23.09.2012
        end else begin
           Ampl_:=sgm_V*gL0*sqrt(1+NP0.tau_m0/tau_Noise);    { see eq.(17) in [Phys.Rev.E 2008] }
           Noise_:= Noise_ - Noise_/tau_Noise*dt + Ampl_*randG(0,1)*sqrt(2*dt/tau_Noise);
        end;
      end;
      u_soma_:=0;      s_soma_:=s_soma;      Vh_:=Vhold(t);
      Iind_:=Current_Iind+du_Reset+Noise_;
      ElectrodePotential(ANrn,  uu,ss,u_soma_,s_soma_,Iind_,Vh_);
      {************************************************************************}
      ANrn.MembranePotential(uu,ss,0,s_soma_,tt,Iind_,Vh_);
      {************************************************************************}
      NV0:=ANrn.NV;
      FrequencyAmplitudeO(ANrn);
{      if (NV0.indic=2)and not(IfNoise) then begin
          freq:=LimRev(ISI[0],1e-6);
      end;}
      { Speed up }
      if (NV0.V>0.100)or(NV0.V<-0.150)or((IIspike=0)and(t>0.2)) then nt:=nt_end;
      { Drawing }
//      if (nt=1)or(trunc(nt/n_Draw)=nt/n_Draw)  then Evolution;
      if (NV0.V>0.150) or (NV0.V<-0.150) then begin nt:=nt_end; freq:=0; end;
      { Mean for last third of t_end }
      if (Form5.ComboBox1.ItemIndex=2)and(t<2/3*t_end) then IIspike23:=IIspike;
    UNTIL (nt=nt_end) or ((IIspike=Form5.DDSpinEdit6.Value)and(NV0.indic=3));
//    if freq>10 then V:=0;
    case Form5.ComboBox1.ItemIndex of
    { Number of spikes }
    0: freq:=IISpike/(nt_end+1)/dt;
    { Reverse last ISI }
    1: if IIspike>1 then freq:=LimRev(ISI[0],1e-6) else freq:=0;
    { Mean for last third of t_end }
    2: freq:=(IISpike-IIspike23)/(nt_end+1)/dt*3;
    end;
    writeln(ddd,Iind:9:3,' ',freq:9:5,' ',Iind/NP0.Square*NP0.tau_m0/NP0.C_membr/1e6:9:3);
    Form5.Series1.AddXY(Iind,freq);
    ANrn.Free;
  END;
  { Remember current values }
  Iind:=Iind_o;
  t_Iind:=t_Iind_o;
  NP0.If_I_V_or_g:=If_I_V_or_g_o;
  {---------------}
  close(ddd);
END;

procedure CatchAP_for_Adaptation(var indicat :integer);
var  i :integer;
begin
  freq:=freq*(nt-1)/nt;
  IfSpikeOccurs(NV0.V,NV0.DVDt,NV0.ddV,NP0.Vrest+NV0.Thr,NV0.tAP,indicat);
  { if spike }
  if indicat=2 then begin
     IIspike:=IIspike+1;
     if IIspike<=10 then begin
        { Calculate ISI[IISpike] }
        ISI[IIspike]:=t;
        if IIspike>1 then
           for i:=1 to IIspike-1 do
               ISI[IIspike]:=ISI[IIspike]-ISI[i];
     end;
  end;
end;

procedure Plot_Adaptaion;
{ ********************************************************************
  Calculates plot for ISI of the first APs versus on Iind.
**********************************************************************}
var i,ni,nIind,indicat,If_I_V_or_g_o            :integer;
    Iind_o,t_Iind_o                             :double;
BEGIN
  assign(ddd,'adaptation(I).dat'); rewrite(ddd);
  { Memorize current values }
  Iind_o:=Iind;
  t_Iind_o:=t_Iind;
  t_Iind:=1e8;
  If_I_V_or_g_o:=NP0.If_I_V_or_g;
  NP0.If_I_V_or_g:=2;
  {---------------}
  nIind:=Trunc(Iind_max_AD/dIind_AD);
  FOR ni:=0 to nIind DO BEGIN
    Iind:=dIind_AD*ni {pA};
    CorrespondParametersToTheForm;
    InitialConditions;
    indicat:=0;
    IIspike:=0;
    for i:=1 to 10 do  ISI[i]:=0;
    nt:=0;
    REPEAT  nt:=nt+1;  t:=nt*dt; { time step }
      MembranePotential;
      CatchAP_for_Adaptation(indicat);
      if (NV0.V>0.150) or (NV0.V<-0.150) then nt:=nt_end;
    UNTIL nt=nt_end;
    for i:=1 to 10 do if ISI[i]<=0 then ISI[i]:=1e6;
    write  (ddd,Iind:9:3    ,' ',1/ISI[2]:9:5,' ',1/ISI[3]:9:5,' ');
    writeln(ddd,1/ISI[4]:9:5,' ',1/ISI[5]:9:5,' ',1/ISI[6]:9:5);
    Form6.Series5.AddXY(Iind,1/ISI[6]);
    Form6.Series4.AddXY(Iind,1/ISI[5]);
    Form6.Series3.AddXY(Iind,1/ISI[4]);
    Form6.Series2.AddXY(Iind,1/ISI[3]);
    Form6.Series1.AddXY(Iind,1/ISI[2]);
  END;
  { Remember current values }
  Iind:=Iind_o;
  t_Iind:=t_Iind_o;
  NP0.If_I_V_or_g:=If_I_V_or_g_o;
  {---------------}
  close(ddd);
END;

end.
