unit Hodgkin;

interface
procedure CorrectPassiveParameters;
procedure InitialConditionsHodgkin;
procedure MembranePotential;

implementation
uses Unit1,Unit4,Unit9,Init,t_dtO,MathMyO,ReducedEq,LIF,Noise,ControlNrn,
     HH_canal,HH_migli,HH_Cummins,HH_Chow,HH_Lyle,Graph,SetNrnParsO;


procedure ArtificielSpikes;
{ Applies positive-negative current pulses of a set duration at FC-frequency. }
var  dnt,dntUP   :integer;
     TOK,ooo     :double;
begin
  { Meanders }
  if (Form1.ComboBox2.ItemIndex in [3,4])and(Form1.DDSpinEdit8.Value>0) then begin
      dnt:=trunc(1/Form1.DDSpinEdit8.Value/dt);  { number of steps between APs }
      dntUP:=trunc(0.001{s}/dt);                 { half-duration of "AP" }
      TOK:=-Form1.DDSpinEdit18.Value/1e3 {mA/cm^2};
      if trunc( nt         /dnt)= nt         /dnt then begin
         du_Reset:= TOK
      end else
      if trunc((nt-  dntUP)/dnt)=(nt-  dntUP)/dnt then begin
         du_Reset:=-TOK
      end else
      { End of meander }
      if (NV0.V<Form1.DDSpinEdit19.Value/1e3{-70mV})and(du_Reset*TOK<0) then
         du_Reset:=0;
      { Turn off the meander at the tops of spikes, i.e. "except apexes" }
      ooo:=Form9.DDSpinEdit12.Value/1e3;   {-30mV }
      if (Form1.ComboBox2.ItemIndex=3)and(NV0.V>max(NV0.Vold,ooo)) then begin
         if NV0.Vold<ooo then begin
            if du_reset=TOK then begin
               du_Reset:=TOK*(ooo-NV0.Vold)/(NV0.V-NV0.Vold) {for discrete time-step}
            end;
         end else begin
            du_Reset:=0;
         end;
      end;
//      if trunc((nt-2*dntUP)/dnt)=(nt-2*dntUP)/dnt then  du_Reset:=0;
      { Skip the first spike}
      if nt<dnt then du_Reset:=0;
  end;
end;

procedure Calc_RHP_and_Cond_if_given_V(var RHP,g :double);
//var  INa,IK,IKM,IKA,IKD,ICaH,IKCa,IAHP,ICaT,IBst,INaP,IH :double;
begin
  if (NP0.HH_type='Passive')or(NP0.IfLIF=1) then begin
      g:= 0;
      RHP:=0;
  end else begin
      NV0.INaR:=NaR_current;
      NV0.INa:=Na_current;
      NV0.IK := K_current;
      NV0.IKM:=KM_current;
      NV0.IKA:=KA_current;
      NV0.IKD:=KD_current;
      NV0.ICaH:=CaH_current;
      NV0.ICaT:=CaT_current;
      Ca_concentration(NV0.ICaT+NV0.ICaH);
      NV0.IKCa:= KCa_current;
      NV0.IH  :=   H_current_Lyle;
      NV0.IAHP:= AHP_current;
      NV0.IBst:= Bst_current;
      NV0.INaP:= NaP_current;
      RHP:= -NV0.INaR -NV0.INa -NV0.IK -NV0.IKM -NV0.IKA -NV0.IKD
            -NV0.ICaH -NV0.IKCa -NV0.IH
            -NV0.IAHP -NV0.ICaT -NV0.IBst -NV0.INaP;
      CalculateActiveConductance;
      g:=NV0.gActive;
  end;
end;

procedure CorrectPassiveParameters;
{ see p.148 }
var  RHP,g      :double;
     i          :integer;
begin
 with NV0,NP0 do BEGIN
  Calc_RHP_and_Cond_if_given_V(RHP,g);
  {-------------------------------}
  if IfSet_gL_or_tau  =2 then begin
     gL       :=C_membr/tau_m0 - g;
  end else begin
     tau_m0   :=C_membr/(g+gL)
  end;
  {-------------------------------}
  if IfSet_VL_or_Vrest=2 then begin
     VL:=Vrest - RHP/gL
  end else begin
     i:=0;
     repeat i:=i+1;
       V:=Vrest;
       InitialCanalExtraConductances;
       InitialCanalConductances;
       Calc_RHP_and_Cond_if_given_V(RHP,g);
       Vrest:=Vrest + dt/C_membr*(RHP-gL*(Vrest-VL));
       if IfSet_gL_or_tau  =2 then  gL    :=C_membr/tau_m0 - g
                              else  tau_m0:=C_membr/(g+gL);
     until ((abs(V-Vrest)<0.0000001)and(i>1000)) or (i=10000);
     V:=Vrest;
  end;
 END; 
end;

procedure InitialConditionsHodgkin;
begin
  NP0.FRT:=NP0.Faraday/NP0.Rgas/NP0.Temperature/1000;
  { Blockage of Na-channels }
  if NP0.IfThrModel=1 then  NP0.IfBlockNa:=1;
  { Voltage-gated canals and passive parameters ---------------}
  InitialCanalExtraConductances;
  InitialCanalConductances;
  CorrectPassiveParameters;   {! depend on ss}
end;

{-----------------------------------------------------------------------}

procedure MembranePotential;
var
     i,indic_                       :integer;
     VL_,Ipass,DVDt_old,
     IatE,DIsynE,V_E,V_0,gs,gdE     :double;
BEGIN
 with NV0,NP0 do BEGIN
  i:=1;
  Vold:=V;
  DVDt_old:=DVDt;
  IF          IfThrModel=1 THEN BEGIN
     ThrNeuron.V:=V;
     NoSpikePotential(t-tAP, ThrNeuron,DVDt,ddV);
     V:=ThrNeuron.V;
     Thr:=VThreshold2(DVDt,ThrShift,t-tAP);
     IfSpikeOccursInThrModel;//(V,Vrest+Thr,ddV, tAP,indic);
     exit;
  END ELSE IF IfLIF=1      THEN BEGIN
     indic_:=0;  if V>Vrest+Thr then begin indic_:=2; tAP:=t; end;
     LIF_potential(indic_, V,DVDt);
     Thr:=VThreshold2(DVDt,0,t-tAP);
     exit;
  END;
  { ---------------- Currents ----------------------------------- }
      INa:=0;  IK:=0;  IKM:=0;  IKA:=0;  IKD:=0;  IH:=0;
      ICaH:=0;  IKCa:=0; IAHP:=0; ICaT:=0; IBst:=0; INaP:=0;
      if HH_type='Passive' then begin
         VL_:=Vrest;
      end else begin
         INaR:= NaR_current;
         INa :=  Na_current;
         IK  :=   K_current;
         IKM :=  KM_current;
         IKA :=  KA_current;
         IKD :=  KD_current;
         ICaH:= CaH_current;
         ICaT:= CaT_current;
         Ca_concentration(ICaT+ICaH);
         IKCa:= KCa_current;
         IH  :=H_current_Lyle;
         IAHP:= AHP_current;
         IBst:= Bst_current;
         INaP:= NaP_current;
         VL_:=VL;
      end;
      Ipass:=gL*(V-VL_)*(1-IfBlockPass);
      Im:= -INaR -INa -IK -IKM -IKA -IKD -IH
              -ICaH -IKCa -IAHP -ICaT -IBst -INaP -Ipass;
      Im :=  Im + Current_Iind + du_Reset;
      Isyn:= -ss*(V-VK) + uu - tt*sqr(V-Vrest);
  { ---------------- Ohm's law ---------------------------------- }
  if          HH_order='1-point'  then begin
      V:=V + dt/C_membr*(Im+Isyn);
  end else if HH_order='2-points' then begin
      IsynE_old:=IsynE;
      IsynE:=Isyn;  IsynI:=0;
      DIsynE:=(IsynE-IsynE_old)/dt;
      IatE:=1/2*tau_m0*DIsynE + 3/2*IsynE;
      V_0:=V;  V_E:=VatE;
      gs:=C_membr/tau_m0;
      gdE:=gs*ro;//3.7{nS}/1.3{nS};
      {----------}
      VatE:=V_E + dt/tau_m0*(-(V_E  -Vrest)
                   - (2+gdE/gs)*(V_E -V_0)
                   + 2/gdE*IatE -IsynI/gs);
      {----------}
      V   :=V_0 + dt/tau_m0*(
                   +    gdE/gs *(V_E -V_0)
                   +  Im/gs+IsynI/gs);
  end;

  If If_I_V_or_g in [1,3,4,5] then  V:=Vhold(t);
  NV0.DVDt:=(NV0.V-NV0.Vold)/dt;
  NV0.ddV:=(NV0.DVDt-DVDt_old)/dt;
  PSC:=(Isyn + Im{Current_Iind}) *Square*1e9; {pA}
 END;
END;

end.
