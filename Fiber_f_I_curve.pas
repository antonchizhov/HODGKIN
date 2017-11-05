unit Fiber_f_I_curve;

interface
uses Forms,Math,
     MyTypes,Init,t_dtO,MathMyO,Graph,Hodgkin_old,Other,FiringClamp,
     NeuronO,CreateNrnO,typeNrnParsO,FiberO,
     Unit7,Clamp,Threshold,RunFiber,Noise;

procedure Plot_nu_IindO_Fiber;
procedure PlotForControlParameters_FiberO;


implementation
uses Unit1,Unit5,Unit9,Unit20;


procedure Plot_nu_IindO_Fiber;
{ ********************************************************************
  Calculates plot for frequency etc. depending on Iind.
**********************************************************************}
var ni,nIind,If_I_V_or_g_o,i                            :integer;
    Iind_o,t_Iind_o,sgm_V,gL0,tt_,Noise_,u_soma_,s_soma_,Iind_  :double;
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
  {---------------}
  nIind:=Trunc(Iind_max/dIind);
  FOR ni:=0 to nIind DO BEGIN
    Iind:=dIind*ni {pA};
    CorrespondParametersToTheForm;
   {d} PreliminaryProceduresOfOneCompartmentalModel;
   {d} PreliminaryProceduresOfDistributedNeuron;
    if WriteOrNot=1 then InitiateWriting;
   {d} AFiber.InitialConditions;
    IIspike:=0;
    nt:=0;
    REPEAT  nt:=nt+1;  t:=nt*dt; { time step }
      { Distribute stimulation }
      {d} for i:=0 to Space.N do begin
      {d}     AFiber.uu[i]:=0; AFiber.ss[i]:=0; AFiber.Iind_mA[i]:=0;
      {d} end;
      { Stimulation at soma and axon }
      {d} DefineStimulation(NP0,AFiber.uu[0],AFiber.ss[0],u_soma_,s_soma_,
                                tt_,Iind_,AFiber.FP.Vh);
          AFiber.Iind_mA[0]:=Iind_*NP0.Square;
      {******* One step of integration ********}
      {d} AFiber.MembranePotential(t);
      {****************************************}
      {d} NV0:=AFiber.Nrn[0].NV;
      { Drawing and writing }
      {d} if (Form20.DDSpinEdit18.Value>0) and
             (nt mod trunc(Form20.DDSpinEdit18.Value)=0) then  AFiber.Draw;
      {d} FrequencyAmplitudeO(AFiber.Nrn[0]);
      if (NV0.indic=2)and not(IfNoise) then begin
          freq:=LimRev(ISI[0],1e-6);
      end;
      if (NV0.V>0.100)or(NV0.V<-0.150)or((IIspike=0)and(t>0.2)) then begin
          nt:=nt_end; freq:=0;
      end;
      { Drawing }
      if (NV0.V>0.150) or (NV0.V<-0.150) then begin nt:=nt_end; freq:=0; end;
    UNTIL (nt=nt_end) or ((IIspike=Form5.DDSpinEdit6.Value)and(NV0.indic=3));
    case Form5.ComboBox1.ItemIndex of
    0: freq:=IISpike/(nt_end+1)/dt;
    1: if IIspike>1 then freq:=LimRev(ISI[0],1e-6) else freq:=0;
    end;
    writeln(ddd,Iind:9:3,' ',freq:9:5,' ',Iind/NP0.Square*NP0.tau_m0/NP0.C_membr/1e6:9:3);
    Form5.Series1.AddXY(Iind,freq);
    {d} AFiber.Free;
    if WriteOrNot=1 then close(ccc);
  END;
  { Remember current values }
  Iind:=Iind_o;
  t_Iind:=t_Iind_o;
  NP0.If_I_V_or_g:=If_I_V_or_g_o;
  {---------------}
  close(ddd);
END;

procedure PlotForControlParameters_FiberO;
{ ********************************************************************
  Calculates plot for frequency etc. depending on control parameters.
**********************************************************************}
var i,ns,nu,nt_end_rem,imem                       :integer;
    dum,gE1,gI1,gE_max,gI_max,
    t_end_rem,Iind_mem,u_mem,s_mem,x,y,fmem,
    u_soma_,s_soma_,tt_,Iind_
                                                  :double;
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
  FOR ns:=0 to nse DO BEGIN
  FOR nu:=0 to nue DO BEGIN
    if If_u_s_or_Ge_Gi=1 then begin    { for (u,s)-plot }
       uu:=((u_max-u_min)/nue*nu + u_min)/1000;
       ss:= (s_max-s_min)/nse*ns + s_min;
       U_S_to_gE_gI(uu,ss, 0,0, gE1,gI1);
       x:=uu*1000;  y:=ss;
    end else begin                     { for (Ge,Gi)-plot }
       gE_max:=u_max/1000/(-Vus);
       gI_max:=s_max/2;
       gE1:=gE_max/nue*nu;
       gI1:=gI_max/nse*ns;
       gE_gI_to_U_S(gE1,gI1, 0,0, uu,ss);
       x:=gE1;      y:=gI1;
    end;
    if IfNoise then begin  { Noise }
       Ampl_u:=uu;  Ampl_s:=ss;
       U_S_to_gE_gI(Ampl_u,Ampl_s, 0,0, Ampl_gE,Ampl_gI);
       mean_gE:=Ampl_gE; mean_gI:=Ampl_gI;
       gE     :=Ampl_gE;      gI:=Ampl_gI;
    end;
    { Initial conditions }
   {d} PreliminaryProceduresOfOneCompartmentalModel;
   {d} PreliminaryProceduresOfDistributedNeuron;
   {d} AFiber.InitialConditions;
    IIspike:=0; ISI[0]:=0;  V_Conv:=0;  VxZ:=0;  IxZ:=0;
    nt:=0;
    REPEAT  nt:=nt+1;  t:=nt*dt; { time step }
      case Form9.RadioGroup1.ItemIndex of     { Noise }
      1: SynCurrentOnNewStep(Ampl_u,Ampl_u,tau_Noise, uu);
      2: begin SynConductancesOnNewStep; gE_gI_to_U_S(gE,gI, 0,0, uu,ss); end;
      end;
      { Distribute stimulation }
      {d} for i:=0 to Space.N do begin
      {d}     AFiber.uu[i]:=0; AFiber.ss[i]:=0; AFiber.Iind_mA[i]:=0;
      {d} end;
      { Stimulation at soma and axon }
      {d} DefineStimulation(NP0,AFiber.uu[0],AFiber.ss[0],u_soma_,s_soma_,
                                tt_,Iind_,AFiber.FP.Vh);
          AFiber.Iind_mA[0]:=Iind_*NP0.Square;
      {******* One step of integration ********}
      {d} AFiber.MembranePotential(t);
      {****************************************}
      {d} NV0:=AFiber.Nrn[0].NV;
      { Drawing and writing }
      {d} if (Form20.DDSpinEdit18.Value>0) and
             (nt mod trunc(Form20.DDSpinEdit18.Value)=0) then  AFiber.Draw;
      {d} FrequencyAmplitudeO(AFiber.Nrn[0]);
      {****************}
      if (NV0.indic=2)and not(IfNoise) then begin
          freq:=LimRev(ISI[0],1e-6);
      end;
      if (NV0.V>0.100)or(NV0.V<-0.150)or((IIspike=0)and(t>0.2)) then begin
          nt:=nt_end; freq:=0;
      end;
    UNTIL (nt>=imin(trunc(Form9.DDSpinEdit4.Value/1000/dt), MaxNT))or
          ((IIspike=Form9.DDSpinEdit6.Value)and(NV0.indic{indicat}=3));
    if IfNoise then begin  uu:=Ampl_u;  ss:=Ampl_s;  end;
    if freq>10 then NV0.V:=0;
    if freq< 5 then begin  Vav_prev:=0; avPSC_prev:=0; VxZ:=0; IxZ:=0;
                           Vmin_prev:=0; Vmax:=0; Vweigh_prev:=0; V_Conv:=0;
                           VT_1ms:=0; end;
    Draw_nu_u_s(x,y,freq,Vav_prev,avPSC_prev);
    Application.ProcessMessages;
    { Drawing }
    {           1                  2                                 }
    write  (ddd,uu*1000:7:3,' ',ss:9:5,' ');
    {           3                           4                        }
    write  (ddd,freq{LimRev(ISI[0],1e-6)}:9:5,' ',Vmax*1000:7:3,' ');
    {           5                        6                     7     }
    write  (ddd,Vweigh_prev*1000:7:3,' ',Vav_prev*1000:7:3,' ',avPSC_prev:9:5,' ');
    {           8           9           10                           }
    write  (ddd,gE1:9:5,' ',gI1:9:5,' ',Vmin_prev*1000:7:3,' ');
    {           11                  12               13              }
    write  (ddd,V_Conv*1000:7:3,' ',VxZ*1000:7:3,' ',IxZ:9:5,' ');
    {           14                          15                  16   }
    writeln(ddd,max(0,WidthAP)*1000:9:5,' ',VT_1ms*1000:7:3,' ',Th*1000:7:3);
    {d} AFiber.Free;
  END;
  END;
  close(ddd);
  t_end:=t_end_rem;   nt_end:=nt_end_rem;
  uu:=u_mem;  ss:=s_mem;  Iind:=Iind_mem;
  ANrnF.Free;
  ANrnT.Free;
END;

end.
