unit ReducedEq;

interface
uses Sysutils,MyTypes,Init,t_dtO,typeNrnParsO,MathMyO,
     HH_canal,HH_migli,HH_Lyle,Hodgkin,
     Unit3,Unit4,Unit7,ControlNrn;

procedure ReducedEquations;
procedure Read_Threshold_from_File;
function VThreshold2(DVDt,ThrCorrection,ts :double) :double;
procedure IfSpikeOccursInThrModel(V_,Thr,ddV:double; var tAP_:double; var indic_:integer);
PROCEDURE NoSpikePotential(sinceAP:double; var Neuron:NrnRec; var dVdt,ddV:double);
procedure EqForDispersion(indicat :integer; V,g,mmE,gE,sgmGE :double;
                          var sgm_V,gE_V :double);
procedure CorrectMeanV(mmE,sgm_gE,sgm_V :double; var V :double);


implementation

{==================================================================}
procedure ReducedEquations;
{
  HH-equations reduced by Pokrovskiy and describing spike.
}
var
     i                          :integer;
     RHP,Ipass,VL_,Cond         :double;
BEGIN
  i:=1;
  { ---------------- Currents ----------------------------------- }
      NV0.INa:=0;  NV0.IK:=0;  NV0.IKM:=0;  NV0.IKA:=0;  NV0.ICaH:=0;  NV0.IKCa:=0;
      if          NP0.HH_type='Passive' then begin
         VL_:=NP0.Vrest;
      end else if NP0.HH_type='Calmar' then begin
         NV0.INa:=Na_current;
         NV0.IK := K_current;
         VL_:=NP0.VL;
      end else if NP0.HH_type='Destexhe' then begin
         NV0.INa:=Na_current;
         NV0.IK := K_current;
         NV0.IKM:=KM_current;
{        ICaH:=CaH_current(i);
         Ca_concentration(i,ICaH);
         IKCa:=KCa_current(i);}
         VL_:=NP0.VL;
      end else if NP0.HH_type='Migliore' then begin
         NV0.INa:=Na_current_Migli;
         NV0.IK := K_current_Migli;
         NV0.IKA:=KA_current_Migli;
         VL_:=NP0.VL;
      end;
      NV0.INaR:=NaR_current;
      Isyn:= -ss*(NV0.V-NP0.VK) + uu;
  { ---------------- Ohm's law ---------------------------------- }
//  CalculateActiveConductance(i);
  Cond:= NP0.gNaR   *istep(NV0.mmR,3)*NV0.hhR*(1-NP0.IfBlockNaR)
       + NP0.gNa    *istep(NV0.mm,3) *NV0.hh *(1-NP0.IfBlockNa)
       + NP0.gK     *istep(NV0.nn,4)         *(1-NP0.IfBlockK)
       + NP0.gKM                     *NV0.nM *(1-NP0.IfBlockKM);
  RHP:= Isyn + Current_Iind
      + NP0.gNaR   *istep(NV0.mmR,3)*NV0.hhR*NP0.VNaR*(1-NP0.IfBlockNaR)
      + NP0.gNa    *istep(NV0.mm,3) *NV0.hh *NP0.VNa *(1-NP0.IfBlockNa)
      + NP0.gK     *istep(NV0.nn,4)     *NP0.VK  *(1-NP0.IfBlockK)
      + NP0.gKM                 *NV0.nM *NP0.VK  *(1-NP0.IfBlockKM)
      + NP0.gL                      *        VL_ *(1-NP0.IfBlockPass);
  NV0.V:=RHP/(Cond+NP0.gL*(1-NP0.IfBlockPass));
END;

{---- Threshold --------------------------------------------------}

const
    MaxThr=2000;
type
    vecThr  =array[0..MaxThr]   of double;
var
     Thr_dVdt                   :vecThr;
     nThr_dVdt                  :integer;
     dThr_dVdt,min_tAP_Thr_DVDt :double;

procedure Read_Threshold_from_File;
{  Reads the dependence of the threshold Thr on dV/dt from file.
   File has 2 columns: X[0..MaxThr], Y[0..MaxThr].
   Interpolation (linear) is applied to fill the array 'Thr_dVdt[0..MaxThr]'. }
var
     n,nE,i                     :integer;
     xc,w,dum1,dum2,dum3,dum4,
     dum5,dum6,min_tAP,max_dVdt   :double;
     X,Y                        :vecThr;
     FileName                   :string;
     ttt                        :text;
begin
  if NP0.HH_type='Chow' then FileName:='set_VTh(dVdt)_Chow.dat'
                        else FileName:='set_VTh(dVdt)_Lyle.dat';
  { Reading file }
  if not(FileExists(FileName)) then exit;
  AssignFile(ttt,FileName); reset(ttt);
  min_tAP:=1e6; max_dVdt:=0;
  n:=0;
  repeat  n:=n+1;
    { 1-Th   2-tAP  3-Iind  4-DVDt_Th  5-Th1  6-DVDt_Th1 }
    readln(ttt,dum1,dum2,dum3,dum4,dum5,dum6);
    X[n]:=dum6; Y[n]:=dum5;  {dVdt and Thr of the first spike}
//    X[n]:=dum4; Y[n]:=dum1;    {dVdt and Thr of the second spike}
    if dum2<=0 then n:=n-1 {skip zero-threshold data}
    else begin
         if (dum2<min_tAP)and(dum2>0)  then min_tAP :=dum2;
         if  dum4>=max_dVdt then begin  max_dVdt:=dum4; nE:=n;  end;
    end;
  until (eof(ttt)) or (n=MaxThr);
  close(ttt);
  { Time criterion }
  min_tAP_Thr_DVDt:=min_tAP/1000;
  { Remeshing - Filling array 'Thr_dVdt' }
  nThr_dVdt:=200;
  dThr_dVdt:=X[nE]/sqr(nThr_dVdt);
  i:=-1;
  repeat  i:=i+1;
    xc:=sqr(i)*dThr_dVdt;
    { Finding the nearest right point in array 'Y' }
    n:=1;
    repeat n:=n+1
    until (n=nE) or (X[n]>xc);
    { Linear interpolation }
    if (X[n]-X[n-1]>1e-8)and(Y[n-1]<>0)and(n<nE) then
        w:=(xc-X[n-1])/(X[n]-X[n-1])             else  w:=1;
    Thr_dVdt[i]:= Y[n-1]*(1-w) + Y[n]*w;
  until (i=nThr_dVdt);
end;

function TabulatedThreshold(DVDt :double) :double;
{ Takes threshold from tabulated array 'Thr_dVdt' }
var
     z,w        :double;
     i          :integer;
begin
  i:=trunc(sqrt(max(0,DVDt)/dThr_dVdt));
  if i<=0         then z:=Thr_dVdt[0] else
  if i>=nThr_dVdt then z:=Thr_dVdt[nThr_dVdt] else begin
     w:=(DVDt-sqr(i)*dThr_dVdt)/((sqr(i+1)-sqr(i))*dThr_dVdt);
     z:= Thr_dVdt[i]*(1-w) + Thr_dVdt[i+1]*w;
  end;
  TabulatedThreshold:=z/1000;
end;

function VThreshold2(DVDt,ThrCorrection,ts :double) :double;
var z,x,x2,x3,x4,x5 :double;
begin
  if DVDt<1e-8 then z:=100 {mV} else begin
     if Form7.CheckBox1.Checked then begin
        VThreshold2:=Form7.DDSpinEdit1.Value/1000+ThrCorrection;
        exit;
     end;
     if NP0.FixThr>0 then begin
        VThreshold2:=NP0.FixThr;
        exit;
     end;
     if DVDt<0.00001 then DVDt:=0.00001;
        if NP0.HH_type='Chow' then begin
           {for 'Chow'     fitted to [Japon. paper, Fig.2A], bistratified cell }
           z:=TabulatedThreshold(DVDt)*1000 + ThrCorrection*1000;
           if ts<min_tAP_Thr_DVDt then VThreshold2:=0.050{V};
        end else if NP0.HH_type='Lyle' then begin
           z:=TabulatedThreshold(DVDt)*1000 + ThrCorrection*1000;
           if ts<min_tAP_Thr_DVDt then VThreshold2:=0.050{V};
        end else begin
           {for 'Migliore' fitted to [Ali, Fig1A] }
           z:=7.52+exp( 4.57625E-001*ln(DVDt) +  1.96531E+000)
             +ThrCorrection*1000;
        end;
  end;
  VThreshold2:=z/1000;
end;
{---------------------------------------------------------------------}

procedure IfSpikeOccursInThrModel(V_,Thr,ddV:double; var tAP_:double; var indic_:integer);
{Defines if a spike occurs for V_.
 'indic_' = 0 - after spike
            2 - at spike}
begin
  if indic_=2 then indic_:=0;  { after spike }
  if (V_>Thr) then begin
     if (NP0.HH_type='Passive')or
        (((t-tAP_>NP0.dT_AP)and(ddV<1000{V/s^2}))or(t=tAP_)) then begin { at spike }
        indic_:=2;
        if t<>tAP_ then ISI[0]:=min(t-tAP_,t);
        tAP_:=t;
     end;
  end;
end;

function dV_behind_AP(ie :integer):double;
var Islow :double;
begin
  Islow:=0; //gKM*nM[ie]*(Vrest[ie]-VK)*(1-IfBlockKM);
  dV_behind_AP:=Islow/(NP0.C_membr/NP0.tau_m0);
end;

{==================================================================}
PROCEDURE NoSpikePotential(sinceAP:double; var Neuron:NrnRec; var dVdt,ddV:double);
{
  HH-equations with the only K-current, without spike.
}
var
     ie                               	        :integer;
     a,b,v2,nu,
     tau_n,  n_inf,tau_yK,yK_inf,n4, tau_xD,xD_inf,tau_yD,yD_inf,xyD,
     tau_nA,nA_inf,tau_lA,lA_inf,nlA,tau_yH,yH_inf,tau_w, w_inf,
     tau_nM,nM_inf,nM2,
     dVdt_old,
     RHP,Ipass,VL_,gL_,Cond,Im,VEn,gs,gdE   	:double;
BEGIN
with Neuron do begin {deal with Neuron}
  dVdt_old:=dVdt;
  ie:=1;
  VL_:=NP0.VL;  gL_:=NP0.gL;
  { Conditions at spike }
  IF sinceAP<=NP0.dT_AP THEN BEGIN
     if NP0.HH_type='Passive' then  V:=NP0.Vreset
                              else  V:=-0.040+dV_behind_AP(ie);
     VE:=NP0.Vrest;
     dVdt:=0;  ddV:=0;
     nn:=NP0.n_AP; yK:=NP0.yK_AP; nA:=NP0.nA_AP; lA:=NP0.lA_AP;
     yH:=NP0.yH_AP; xD:=NP0.xD_AP;
     if round(sinceAP/dt)=1 then wAHP:=wAHP + 0.0177*(1-wAHP);//+ dwAHP;
     if round(sinceAP/dt)=1 then nM  :=nM   + 0.175 *(1-nM);//+ 0.155;
     if round(sinceAP/dt)=1 then yD  :=yD   - 0.3 *yD;
  END ELSE BEGIN
     { ---------------- Currents ----------------------------------- }
     if          NP0.HH_type='Destexhe' then begin
        v2:= V*1000 - NP0.Tr;
        a:= 0.032 * vtrap(15-v2, 5);
        b:= 0.5 * dexp((10-v2)/40);
        tau_n:= 1 / (a + b);
        n_inf:= a / (a + b);
        tau_inf_KM_CalmDest(V*1000, tau_nM, nM_inf);
        nM    :=nM    +E_exp(dt,tau_nM)*(nM_inf-nM);
        nn    :=nn    +E_exp(dt,tau_n )*( n_inf-nn);
     end else if NP0.HH_type='Calmar' then begin
        v2:= V*1000 - NP0.Tr;
        a:= 0.01 * vtrap(10-v2, 10);
        b:= 0.125 * dexp(-v2/80);
        tau_n:= 1 / (a + b);
        n_inf:= a / (a + b);
        tau_inf_KM_CalmDest(V*1000, tau_nM, nM_inf);
        nM    :=nM    +E_exp(dt,tau_nM)*(nM_inf-nM);
        nn    :=nn    +E_exp(dt,tau_n )*( n_inf-nn);
     end else if NP0.HH_type='Migliore' then begin
        a:= dexp(-0.11*(V*1000-13));
        b:= dexp(-0.08*(V*1000-13));
        tau_n:= 50*b / (1 + a);  if tau_n<2 then  tau_n:=2;
        n_inf:= 1 / (1 + a);
        nn    :=nn    +E_exp(dt,tau_n )*( n_inf-nn);
     end else if NP0.HH_type='Chow' then begin
        tau_n:= 0.5 + 2.0/(1+dexp(0.045*(V*1000-50)));
        n_inf:= 1/(1+dexp(-0.045*(V*1000+10)));
        nn    :=nn    +E_exp(dt,tau_n )*( n_inf-nn);
     end else if NP0.HH_type='Lyle' then begin
        tau_inf_K_Lyle( V*1000, tau_n, n_inf, tau_yK,yK_inf);
        tau_inf_KA_Lyle(V*1000, tau_nA,nA_inf,tau_lA,lA_inf);
        tau_inf_KD_Lyle(V*1000, tau_xD,xD_inf,tau_yD,yD_inf);
        tau_inf_H_Lyle( V*1000, tau_yH,yH_inf);
        tau_inf_KM_Lyle(V*1000, tau_nM,nM_inf);
        yK    :=yK    +E_exp(dt,tau_yK)*(yK_inf-yK);
        nA    :=nA    +E_exp(dt,tau_nA)*(nA_inf-nA);
        lA    :=lA    +E_exp(dt,tau_lA)*(lA_inf-lA);
        xD    :=xD    +E_exp(dt,tau_xD)*(xD_inf-xD);
        yD    :=yD    +E_exp(dt,tau_yD)*(yD_inf-yD);
        yH    :=yH    +E_exp(dt,tau_yH)*(yH_inf-yH);
        nM    :=nM    +E_exp(dt,tau_nM)*(nM_inf-nM);
        nn    :=nn    +E_exp(dt,tau_n )*( n_inf-nn);
     end else begin
         n_inf:=0;  yK_inf:=0; xD_inf:=0; yD_inf:=0;
         nA_inf:=0; lA_inf:=0; yH_inf:=0; w_inf:=0; nM_inf:=0;
     end;
     tau_inf_AHP(V*1000,tau_w,w_inf);
     wAHP     :=wAHP  +E_exp(dt,tau_w )*( w_inf-wAHP);
     { Initial values }
     if (nt=1)and(NV0.indic<>2) then begin nn:= n_inf;  yK:=yK_inf;
                                       xD:=xD_inf;  yD:=yD_inf;
                                       nA:=nA_inf;  lA:=lA_inf;  yH:=yH_inf;
                                       wAHP:=w_inf; nM:=nM_inf; end;
     { ------------- Currents and conductances --------------------- }
     Isyn:= -ss*(V-NP0.VK) + uu;
     n4:=nn*nn*nn*nn; if NP0.HH_type='Migliore' then n4:=nn;
                      if NP0.HH_type='Lyle'     then n4 := K_cond_Lyle(nn,yK);
     nlA:=0;          if NP0.HH_type='Lyle'     then nlA:=KA_cond_Lyle(nA,lA);
     xyD:=0;          if NP0.HH_type='Lyle'     then xyD:=KD_cond_Lyle(xD,yD);
     nM2:=nM;         if NP0.HH_type='Lyle'     then nM2:=KM_cond_Lyle(nM);
     { ---------------- Ohm's law ---------------------------------- }
     Im:= Isyn -gL_*(V-VL_)
         -NP0.gK *n4 *(V-NP0.VKDr) -NP0.gKA *nlA *(V-NP0.VK) -NP0.gH *yH *(V-NP0.V12H)
         -NP0.gKD*xyD*(V-NP0.VKD)  -NP0.gAHP*wAHP*(V-NP0.VK) -NP0.gKM*nM2*(V-NP0.VKM);
     Im:= Im + Current_Iind;
     if          NP0.HH_order='1-point'  then begin
        dVdt:=1/NP0.C_membr*Im;
        V:=V + dt*dVdt;
     end else if NP0.HH_order='2-points' then begin
        gs:=NP0.gK*n4+gL_;
        gdE:=gs*3.7{nS}/1.3{nS};
        VEn:=VE + dt/NP0.C_membr*(-gs*(VE-NP0.Vrest) - (2*gs+gdE)*(VE-V));
        dVdt:=1/NP0.C_membr*( gdE*(VE -V) + Im);
        V:=V+dt*dVdt;
        VE:=VEn;
     end;
     ddV:=(dVdt-dVdt_old)/dt;
  END;
end; {deal with Neuron}
END;

{==================================================================}
procedure EqForDispersion(indicat :integer; V,g,mmE,gE,sgmGE :double;
                                              var sgm_V,gE_V :double);
begin
  if (nt<=1)or(indicat=2) then begin
      sgm_V:=0; gE_V:=0;
  end else begin
      gE_V:=gE_V + dt/NP0.C_membr*(-(g+(gE+sgmGE)*mmE)*gE_V-mmE*(V-0)*sqr(sgmGE));
//      if sgm_V>0 then begin
         sgm_V:=sgm_V + dt/NP0.C_membr*(
             -(g+(gE+sgmGE)*mmE)*sgm_V - sgmGE*(V-0)*mmE );
//               -(g+(gE+sgmGE)*mmE)*sgm_V + gE_V/sgm_V )
//      end else begin
//         sgm_V:=1e-6//sqrt(gE_V/(g+(gE+sgmGE)*mmE));
//      end;
  end;
end;

procedure CorrectMeanV(mmE,sgm_gE,sgm_V :double; var V :double);
begin
  V:=V - dt/NP0.C_membr*mmE*sgm_gE*sgm_V;
end;

END.
