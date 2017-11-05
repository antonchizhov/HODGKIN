unit HH_canal;

interface
function vtrap(x,y :double):double;
function alphabeta(x,y,a4 :double):double;
function alphabeta_h(x,y,a4 :double):double;
function NaR_current_Calmar:double;
function Na_current_CalmDest:double;
function K_current_CalmDest:double;
procedure tau_inf_KM_CalmDest(v2 :double; var tau_n,n_inf :double);
function KM_current:double;
function VCa(Ca :double) :double;
function CaH_current_CalmDest:double;
procedure Ca_concentration(ICa:double);
function KCa_current:double;
procedure tau_inf_AHP(v2 :double; var tau_w,w_inf :double);
function AHP_cond(v2 :double):double;
function AHP_current:double;
function CaT_current_CalmDest:double;
function Bst_current:double;
function NaP_current:double;
procedure InitialCanalConductances_CalmDest;
procedure CaT_Init_CalmDest;
procedure CaH_Init_CalmDest;
{*******************************************}
procedure InitialCanalConductances;
procedure InitialCanalExtraConductances;
procedure CalculateActiveConductance;
function NaR_current:double;
function Na_current:double;
function K_current:double;
function KA_current:double;
function KD_current:double;
function CaH_current:double;
function CaH_Cond:double;
function CaT_current:double;
function CaT_Cond:double;

implementation
uses Unit1,Unit4,Init,t_dtO,MathMyO,
     HH_migli,HH_Cummins,HH_Chow,HH_Lyle,Threshold;
{
}

function vtrap(x,y :double):double;
begin
  if (abs(x/y) < 1e-6) then
    vtrap:= y*(1 - x/y/2)
  else
    vtrap:= x/(dexp(x/y)-1);
end;

function alphabeta(x,y,a4 :double):double;
{ alphabeta(V) = x/(exp(x/y) - a4) }
begin
       if a4=1 then  alphabeta:=vtrap(x,y)
  else if a4=0 then  alphabeta:= dexp(x/y)
               else  alphabeta:= x/(dexp(x/y)-a4);
end;

function alphabeta_h(x,y,a4 :double):double;
{ alphabeta_h(V) = 1/( exp(x/y) - a4) }
begin
  alphabeta_h   := 1/(dexp(x/y) - a4);
end;

{ a(V) = a1*(a2-V)/(exp((a2-V)/a3) - a4) }

{--------------------------------------------------------------}
function NaR_current_Calmar:double;
var  v2,a,b,tau_m,m_inf,m_exp,m3,tau_h,h_inf,h_exp :double;
begin
  v2:= NV0.V*1000 - NP0.Tr_NaR;
  a:= NP0.a1NaR * alphabeta(NP0.a2NaR-v2, NP0.a3NaR,NP0.a4NaR);
  b:= NP0.b1NaR * alphabeta(NP0.b2NaR-v2, NP0.b3NaR,NP0.b4NaR);
  tau_m:= 1 / (a + b);
  m_inf:= a / (a + b);
  m_exp:= 1 - dexp(-dt*1000/tau_m);
  NV0.mmR:=NV0.mmR+m_exp*(m_inf-NV0.mmR);
  m3:=istep(NV0.mmR,3);
  a:= NP0.c1NaR * alphabeta  (NP0.c2NaR-v2, NP0.c3NaR,NP0.c4NaR);
  b:= NP0.d1NaR * alphabeta_h(NP0.d2NaR-v2, NP0.d3NaR,NP0.d4NaR);
  tau_h:= 1 / (a + b);
  h_inf:= a / (a + b);
  h_exp:= 1 - dexp(-dt*1000/tau_h);
  NV0.hhR:=NV0.hhR+h_exp*(h_inf-NV0.hhR);
  NaR_current_Calmar:=NP0.gNaR*m3*NV0.hhR*(NV0.V-NP0.VNaR)*(1-NP0.IfBlockNaR);      { Current }
end;

function Na_current_CalmDest:double;
var  v2,v3,a,b,tau_m,m_inf,m_exp,m3,tau_h,h_inf,h_exp :double;
begin
  v2:= NV0.V*1000 - NP0.Tr;  v3:= v2 - NP0.NaThreshShift;
  { Eq. 3.8 for 'm' }
{ if          HH_type='Destexhe' then begin
//     a = 0.32 * (13-v2) / ( Exp((13-v2)/4) - 1)
//     b = 0.28 * (v2-40) / ( Exp((v2-40)/5) - 1)
     a:= 0.32 * vtrap(13-v2, 4);
     b:= 0.28 * vtrap(v2-40, 5);
  end else if HH_type='Calmar' then begin
     a:= a1Na * vtrap(25-v2, 10);
     b:= 4   * dexp(-v2/18);
  end;}
  a:= NP0.a1Na * alphabeta(NP0.a2Na-v3, NP0.a3Na,NP0.a4Na);
  b:= NP0.b1Na * alphabeta(NP0.b2Na-v3, NP0.b3Na,NP0.b4Na);
  tau_m:= 1 / (a + b);
  m_inf:= a / (a + b);
  m_exp:= 1 - dexp(-dt*1000/tau_m);
  NV0.mm:=NV0.mm+m_exp*(m_inf-NV0.mm);
  if NP0.IfReduced=1 then NV0.mm:=m_inf;
  m3:=istep(NV0.mm,3);
  { Eq. 3.9 for 'h' }
{  if          HH_type='Destexhe' then begin
     a:= 0.128 * dexp((17-v2)/18);
     b:= 4 / ( 1 + dexp((40-v2)/5) );
  end else if HH_type='Calmar' then begin
     a:= 0.07 * dexp(-v2/20);
     b:= 1 / ( 1 + dexp((30-v2)/10) );
  end;}
  a:= NP0.c1Na * alphabeta  (NP0.c2Na-v2, NP0.c3Na,NP0.c4Na);
  b:= NP0.d1Na * alphabeta_h(NP0.d2Na-v2, NP0.d3Na,NP0.d4Na);
  tau_h:= 1 / (a + b);
  h_inf:= a / (a + b);
  h_exp:= 1 - dexp(-dt*1000/tau_h);
  NV0.hh:=NV0.hh+h_exp*(h_inf-NV0.hh);
  Na_current_CalmDest:= NP0.gNa*m3*NV0.hh*(NV0.V-NP0.VNa)*(1-NP0.IfBlockNa);
end;

function K_current_CalmDest:double;
var  v2,a,b,tau_n,n_inf,n_exp,n4 :double;
begin
  v2:= NV0.V*1000 - NP0.Tr;
  { Eq. 3.4 for 'n' }
  if          NP0.HH_type='Destexhe' then begin
     { a = 0.032 * (15-v2) / ( Exp((15-v2)/5) - 1) }
     a:= 0.032 * vtrap(15-v2, 5);
     b:= 0.5 * dexp((10-v2)/40);
  end else if NP0.HH_type='Calmar' then begin
     a:= 0.01 * vtrap(10-v2, 10);
     b:= 0.125 * dexp(-v2/80);
  end;
  tau_n:= 1 / (a + b);
  n_inf:= a / (a + b);
  n_exp:= 1 - dexp(-dt*1000/tau_n);
  NV0.nn:=NV0.nn+n_exp*(n_inf-NV0.nn);
  n4:=istep(NV0.nn,4);
  K_current_CalmDest:= NP0.gK*n4*(NV0.V-NP0.VK)*(1-NP0.IfBlockK);
end;

procedure tau_inf_KM_CalmDest(v2 :double; var tau_n,n_inf :double);
var a,b :double;
begin
  a:= 0.0001 * vtrap(-v2-30, 9);
  b:= 0.0001 * vtrap( v2+30, 9);
  tau_n:= 1 / (a + b);
  n_inf:= a / (a + b);
end;

function KM_current_CalmDest:double;
var  v2,a,b,tau_n,n_inf :double;
begin
  tau_inf_KM_CalmDest(NV0.V*1000,tau_n,n_inf);
  NV0.nM:=NV0.nM+E_exp(dt,tau_n)*(n_inf-NV0.nM);
  KM_current_CalmDest :=NP0.gKM*NV0.nM*(NV0.V-NP0.VKM)*(1-NP0.IfBlockKM);            { Current }
end;

function VCa(Ca :double) :double;
var x :double;
begin
  Ca:=max(Ca,NP0.Ca8);
  x:=NP0.Rgas*NP0.Temperature/2/NP0.Faraday*ln(NP0.Ca0/Ca);
  VCa:=x{0.120} {V};
end;

  { *** CaH  ***}

function CaH_Cond_CalmDest:double;
begin
  CaH_Cond_CalmDest :=NP0.gCaH*sqr(NV0.mCaH)*NV0.hCaH;
end;
function CaH_current_CalmDest:double;
var  v2,a,b,tau_m,m_inf,m_exp,
            tau_h,h_inf,h_exp :double;
begin
  v2:= NV0.V*1000;
  a:=0.055 * vtrap(-v2-27, 3.8);
  b:=0.940 * dexp(-(v2+75)/17);
  tau_m:= 1 / (a + b);
  m_inf:= a / (a + b);
  m_exp:= 1 - dexp(-dt*1000/tau_m);
  NV0.mCaH:=NV0.mCaH+m_exp*(m_inf-NV0.mCaH);
  { Eq. for 'h' }
  a:= 0.000457* dexp(-(v2+13)/50);
  b:= 0.0065 / (1 + dexp(-(v2+15)/28));
  tau_h:= 1 / (a + b);
  h_inf:= a / (a + b);
  h_exp:= 1 - dexp(-dt*1000/tau_h);
  NV0.hCaH:=NV0.hCaH+h_exp*(h_inf-NV0.hCaH);
  CaH_current_CalmDest:=CaH_Cond_CalmDest*(NV0.V-VCa(NV0.Ca));      { Current }
end;
procedure CaH_Init_CalmDest;
var  v2,a,b :double;
begin
      v2:= NV0.V*1000;
      { mCaH - for CaH }
      a:= 55 * vtrap(-v2-27, 3.8);
      b:=940 * dexp(-(v2+75)/17);
      NV0.mCaH:= a / (a + b);
      { hCaH - for CaH }
      a:= 0.457* dexp(-(v2+13)/50);
      b:= 6.5 / (1 + dexp(-(v2+15)/28));
      NV0.hCaH:= a / (a + b);
end;

procedure Ca_concentration(ICa:double);
begin
  NV0.Ca:=NV0.Ca + dt*(-ICa/2/NP0.Faraday/NP0.d_Ca*1e6
                     - (NV0.Ca-NP0.Ca8)/NP0.tauCa); {mM=mmol/m^3}
end;

function KCa_current:double;
var  v2,a,b,tau_n,n_inf,n_exp :double;
begin
  { from [Destexhe]: }
  a := 2000 {1/mM^2/ms} * sqr(NV0.Ca);
  b := 0.002 {1/ms};
  tau_n:= 1 / (a + b);
  n_inf:= a / (a + b);
  n_exp:= 1 - dexp(-dt*1000/tau_n);
  NV0.nKCa:=NV0.nKCa+n_exp*(n_inf-NV0.nKCa);
  KCa_current :=NP0.gKCa*sqr(NV0.nKCa)*(NV0.V-NP0.VK);              { Current }
  { from [Abbott]: }
//  tauCa:=0.2 {s};
//  d_Ca:=200e-4 {cm};
//  n_inf:=(Ca/(Ca+0.003{mM}))
//        /(1+dexp(-(V*1e3+28.3)/12.6));
//  tau_n:=90.3-75.1/(1+dexp(-(V*1e3+46)/22.7));
//  n_exp:= 1 - dexp(-dt*1000/tau_n);
//  nKCa:=nKCa+n_exp*(n_inf-nKCa);
//  KCa_current :=gKCa*sqr(sqr(nKCa))*(V-VK);              { Current }
  { from [Kepecs,Wang]: }
  v2:= NV0.V*1000;
  n_inf:=1/(1+dexp(-(v2+35)/6.5));
  tau_n:=200/(dexp(-(v2+55)/30)+dexp((v2+55)/30));
  n_exp:= 1 - dexp(-dt*1000/tau_n);
  NV0.nKCa:=NV0.nKCa+n_exp*(n_inf-NV0.nKCa);
  KCa_current :=NP0.gKCa *NV0.nKCa *(NV0.V-NP0.VK);              { Current }
end;

  { *** AHP  ***}

procedure tau_inf_AHP(v2 :double; var tau_w,w_inf :double);
begin
  tau_w:= 400*5/(3.3*dexp((v2+35)/20)+dexp(-(v2+35)/20));
  w_inf:=      1 / (1+dexp(-(v2            +35)/10));
end;

function AHP_cond(v2 :double):double;
var  tau_w,w_inf,w_exp,w_inf_rest :double;
begin
  tau_inf_AHP(v2,tau_w,w_inf);
//  w_inf_rest:= 1 / (1+dexp(-(Vrest*1000+35)/10));
//  wAHPthr:=wAHPthr + dt*210*0.028
//    - dt*1000*wAHPthr/(400/(3.3*dexp((-64+35)/20)+dexp(-(-64+35)/20)));
  NV0.wAHP:=NV0.wAHP + dt*1000/tau_w*(w_inf-NV0.wAHP);
  AHP_cond:=NV0.wAHP{-w_inf_rest};
end;

function AHP_current:double;
var  v2,a,b,tau_w,w_inf,w_exp :double;
begin
  AHP_current :=NP0.gAHP*AHP_cond(NV0.V*1000)*(NV0.V-NP0.VK);     { Current }
end;

  { *** CaT  ***}

function CaT_Cond_CalmDest:double;
begin
  CaT_Cond_CalmDest :=NP0.gCaT*NV0.mCaT*NV0.mCaT*NV0.hCaT;
end;
function CaT_current_CalmDest:double;
var  v2,tau_m,tau_h,m_inf,h_inf,m_exp,h_exp :double;
begin
  v2:= NV0.V*1000;
  tau_m:= 0.612+1/(dexp(-(v2+132)/16.7)+dexp((v2+16.8)/18.2));
{  if v2<-80 then  tau_h:=dexp((v2+467)/66.6)
            else}  tau_h:=28+dexp(-(v2+22)/10.5);
  m_inf:= 1 / (1+dexp(-(v2+57)/6.2));
  h_inf:= 1 / (1+dexp( (v2+81)/4));
  m_exp:= 1 - dexp(-dt*1000/tau_m);
  h_exp:= 1 - dexp(-dt*1000/tau_h);
  NV0.mCaT:=NV0.mCaT+m_exp*(m_inf-NV0.mCaT);
  NV0.hCaT:=NV0.hCaT+h_exp*(h_inf-NV0.hCaT);
  CaT_current_CalmDest :=CaT_Cond_CalmDest*(NV0.V-0.120);  { Current }
end;
procedure CaT_Init_CalmDest;
var  v2 :double;
begin
      v2:= NV0.V*1000;
      NV0.mCaT:= 1 / (1+dexp(-(v2+57)/6.2));
      NV0.hCaT:= 1 / (1+dexp( (v2+81)/4));
end;

  { *** Bst *** }

function Bst_current:double;
{ slow spike-dependent current for bursts }
var  tau2,m_inf,m_exp :double;
begin
  if tau1=0 then  tau1:= 100 {ms}; { activation time }
  tau2:= 100 {ms}; { deactivation time }
//  ifSpikeOccurs(V,Vprev,tAP,indic);
  m_inf:=0;  if NV0.indic=2 then m_inf:=tau1;
  m_exp:= 1 - dexp(-dt*1000/tau2);
  NV0.mBst:=NV0.mBst+m_exp*(m_inf-NV0.mBst);
  Bst_current :=NP0.gBst*zBst(NV0.mBst)*(NV0.V-NP0.VK);
end;

function NaP_current:double;
var  v2 :double;
begin
  v2:= NV0.V*1000;
//  if V2>-62 then V2:=-62;
  NV0.mNaP:=1 / (1+dexp(-(v2+57.7)/7.7));
  NaP_current :=NP0.gNaP*istep(NV0.mNaP,3)*(NV0.V-NP0.VNa);
end;

{*********************************************************************}

procedure InitialCanalConductances_CalmDest;
var
     v2,v3,a,b,ICaH,m2     :double;
     s                  :string;
begin
      v2:= NV0.V*1000 - NP0.Tr;  v3:= v2 - NP0.NaThreshShift;
      { mm - for Na }
      a:= NP0.a1Na * alphabeta(NP0.a2Na-v3, NP0.a3Na,NP0.a4Na);
      b:= NP0.b1Na * alphabeta(NP0.b2Na-v3, NP0.b3Na,NP0.b4Na);
      tau_mm:= 1 / (a + b);
      NV0.mm:= a / (a + b);
      { hh - for Na }
      a:= NP0.c1Na * alphabeta  (NP0.c2Na-v2, NP0.c3Na,NP0.c4Na);
      b:= NP0.d1Na * alphabeta_h(NP0.d2Na-v2, NP0.d3Na,NP0.d4Na);
      tau_hh:= 1 / (a + b);
      NV0.hh:= a / (a + b);
      { nn - for K }
      if          NP0.HH_type='Destexhe' then begin
         a:= 0.032 * vtrap(15-v2, 5);
         b:= 0.5 * dexp((10-v2)/40);
      end else if NP0.HH_type='Calmar' then begin
         a:= 0.01 * vtrap(10-v2, 10);
         b:= 0.125 * dexp(-v2/80);
      end;
      NV0.nn:= a / (a + b);
end;

{----------- for all approximations ---------------------------}

procedure InitialCanalConductances;
var
     v2,a,b,ICaH,m2     :double;
     s                  :string;
begin
  { NaR }
  v2:= NV0.V*1000 - NP0.Tr_NaR;
  if NP0.NaR_type='Cummins' then begin
      { mmR - for NaR }
      a:= NP0.a1NaR * alphabeta_h(NP0.a2NaR-v2, NP0.a3NaR,NP0.a4NaR);
      b:= NP0.b1NaR * alphabeta_h(NP0.b2NaR-v2, NP0.b3NaR,NP0.b4NaR);
      NV0.mmR:= a / (a + b);
      { hhR - for NaR }
      a:= NP0.c1NaR * alphabeta_h(NP0.c2NaR-v2, NP0.c3NaR,NP0.c4NaR);
      b:= NP0.d1NaR * alphabeta_h(NP0.d2NaR-v2, NP0.d3NaR,NP0.d4NaR);
      NV0.hhR:= a / (a + b);
  end else if NP0.HH_type<>'Lyle' then begin
      { mmR - for NaR }
      a:= NP0.a1NaR * alphabeta  (NP0.a2NaR-v2, NP0.a3NaR,NP0.a4NaR);
      b:= NP0.b1NaR * alphabeta  (NP0.b2NaR-v2, NP0.b3NaR,NP0.b4NaR);
      NV0.mmR:= a / (a + b);
      { hhR - for NaR }
      a:= NP0.c1NaR * alphabeta  (NP0.c2NaR-v2, NP0.c3NaR,NP0.c4NaR);
      b:= NP0.d1NaR * alphabeta_h(NP0.d2NaR-v2, NP0.d3NaR,NP0.d4NaR);
      NV0.hhR:= a / (a + b);
  end;
  { Na & K }
  if (NP0.HH_type='Destexhe') or (NP0.HH_type='Calmar') then begin
              InitialCanalConductances_CalmDest;
  end else if NP0.HH_type='Migliore' then begin
              InitialCanalConductances_Migli;
  end else if NP0.HH_type='Cummins'  then begin
              InitialCanalConductances_Cum;
  end else if NP0.HH_type='Chow'  then begin
              InitialCanalConductances_Chow;
  end else if NP0.HH_type='Lyle'  then begin
              InitialCanalConductances_Lyle;
  end else begin
      NV0.mmR:=0; NV0.hhR:=0;
      NV0.mm:=0;  NV0.hh:=0;
      NV0.nn:=0;
  end;
end;

procedure InitialCanalExtraConductances;
var
     v2,a,b,ICaH,tau_w :double;
begin
      NV0.Ca:=NP0.Ca8;
      { Other conductances ---------------- }
      v2:= NV0.V*1000;
      { CaH }
      if NP0.HH_type='Cummins' then begin
         CaH_Init_Cum;
         ICaH:=CaH_Cond_Cum*(NV0.V-0.120);
      end else begin
         CaH_Init_CalmDest;
         ICaH:=CaH_Cond_CalmDest*(NV0.V-VCa(NV0.Ca));
      end;
      { CaT }
      if NP0.HH_type='Cummins' then CaT_Init_Cum else
                                CaT_Init_CalmDest;
      { Ca-concentration }
      NV0.Ca:=NP0.Ca8 - NP0.tauCa*ICaH/2/NP0.Faraday/NP0.d_Ca*1e6; {mM=mmol/m^3}
      { nKCa - for KCa }
      a := 2e6 {1/mM^2/s} * sqr(NV0.Ca);
      b := 2 {1/s};
      NV0.nKCa:= a / (a + b);
      { wAHP - for KAHP }
      tau_inf_AHP(v2, tau_w,NV0.wAHP);
      { mBst }
      NV0.mBst:=0;
      { mNaP }
      NV0.mNaP:= 1 / (1+dexp(-(v2+57.7)/7.7));
      { *** from Migliore *** }
      if NP0.HH_type<>'Lyle' then begin
         v2:= NV0.V*1000;
         { nA - for KA }
         a:=dexp( -0.038*( 1.5  +1/(1+dexp(v2+40)/5) )*(v2-11) );
         b:=dexp( -0.038*( 0.825+1/(1+dexp(v2+40)/5) )*(v2-11) );
         NV0.nA:= 1 / (1 + a);
         { lA - for KA }
         a:= dexp(0.11*(v2+56));
         NV0.lA:= 1 / (1 + a);
         { nM - for KM }
         a:= 0.1 * vtrap(-v2-30, 9);
         b:= 0.1 * vtrap( v2+30, 9);
         NV0.nM:= a / (a + b);
      end;
end;

{*********************************************************************}

procedure CalculateActiveConductance;
var  m3,m2,gNaR_,gNa_,gK_,n4,gKM_,gKA_,gKD_,gH_,
     gCaH_,gKCa_,gAHP_,gCaT_,gBst_,gNaP_        :double;
     s                                          :string;
begin
  { NaR }
  if NP0.NaR_type='Cummins' then
     gNaR_:=NP0.gNaR*           NV0.mmR       *NV0.hhR   *(1-NP0.IfBlockNaR)
  else if NP0.HH_type='Lyle' then
          gNaR_:=NP0.gNaR  *sqr(NV0.mmR)*istep(NV0.hhR,3)*(1-NP0.IfBlockNaR)
       else
          gNaR_:=NP0.gNaR*istep(NV0.mmR,3)*  NV0.hhR     *(1-NP0.IfBlockNaR);
  { Na & K }
  if          NP0.HH_type='Migliore' then begin
     m3:=istep(NV0.mm,3);
     gNa_:=NP0.gNa*m3*NV0.hh*NV0.ii*(1-NP0.IfBlockNa);
     gK_ :=NP0.gK*NV0.nn               *(1-NP0.IfBlockK);
  end else if NP0.HH_type='Cummins'  then begin
     m3:=istep(NV0.mm,3);
     gNa_:=NP0.gNa*m3*NV0.hh*(1-NP0.IfBlockNa);
     gK_ :=NP0.gK*NV0.nn        *(1-NP0.IfBlockK);
  end else if NP0.HH_type='Lyle'     then begin
     gNa_:=NP0.gNa*Na_cond_Lyle(NV0.mm,NV0.hh);
     gK_ :=NP0.gK     * K_cond_Lyle(NV0.nn,NV0.yK);
  end else begin
     m3:=istep(NV0.mm,3);
     gNa_:=NP0.gNa*m3*NV0.hh*(1-NP0.IfBlockNa);
     n4:=istep(NV0.nn,4);
     gK_ :=NP0.gK*n4            *(1-NP0.IfBlockK);
  end;
  { KA }
  if NP0.HH_type='Cummins'  then
     gKA_:=NP0.gKA*istep(NV0.nA,3)*NV0.lA*(1-NP0.IfBlockKA)
  else if NP0.HH_type='Lyle' then  gKA_:=NP0.gKA*KA_cond_Lyle(NV0.nA,NV0.lA)
       else                       gKA_:=NP0.gKA*NV0.nA*NV0.lA *(1-NP0.IfBlockKA);
  { Others }
  gH_:=NP0.gH*H_cond_Lyle(NV0.yH);
  if NP0.HH_type='Lyle' then  gKD_:=NP0.gKD*KD_cond_Lyle(NV0.xD,NV0.yD)
                       else  gKD_:=NP0.gKD*istep(NV0.xD,3)*NV0.yD;
  if NP0.HH_type='Lyle' then  gKM_:=NP0.gKM*KM_cond_Lyle(NV0.nM)
                       else  gKM_:=NP0.gKM*NV0.nM       *(1-NP0.IfBlockKM);
  gCaH_:=CaH_Cond;
  gKCa_:=NP0.gKCa*sqr(NV0.nKCa);
  gAHP_:=NP0.gAHP*NV0.wAHP;
  gCaT_:=CaT_Cond;
  gBst_:=NP0.gBst*zBst(NV0.mBst);
  gNaP_:=NP0.gNaP*istep(NV0.mNaP,3);
  if (NP0.HH_type='Passive')or(NP0.IfLIF=1) then begin
      NV0.gActive:=0;
  end else begin
      NV0.gActive:= gNaR_ +gNa_ {+ss} +gK_ +gKM_ +gKA_ +gKD_
                   +gCaH_ +gKCa_ + gAHP_ + gCaT_ + gBst_ +gNaP_;  {mS/cm^2}
  end;
end;

function NaR_current:double;
var s :string;
begin
  if          NP0.NaR_type='Cummins' then begin
      NaR_current:=NaR_current_Cum
  end else if NP0.HH_type ='Lyle'    then begin
      NaR_current:=NaR_current_Lyle
  end else begin
      NaR_current:=NaR_current_Calmar;
  end;
end;

function Na_current:double;
begin
  if (NP0.HH_type='Calmar') or (NP0.HH_type='Destexhe') then begin
      Na_current:=Na_current_CalmDest;
  end else if  NP0.HH_type='Migliore'  then begin
      Na_current:=Na_current_Migli;
  end else if  NP0.HH_type='Cummins'  then begin
      Na_current:=Na_current_Cum;
  end else if  NP0.HH_type='Chow'  then begin
      Na_current:=Na_current_Chow;
  end else if  NP0.HH_type='Lyle'  then begin
      Na_current:=Na_current_Lyle;
  end;
end;

function K_current:double;
begin
  if (NP0.HH_type='Calmar') or (NP0.HH_type='Destexhe') then begin
      K_current:=K_current_CalmDest;
  end else if  NP0.HH_type='Migliore'  then begin
      K_current:=K_current_Migli;
  end else if  NP0.HH_type='Cummins'  then begin
      K_current:=K_current_Cum;
  end else if  NP0.HH_type='Chow'  then begin
      K_current:=K_current_Chow;
  end else if  NP0.HH_type='Lyle'  then begin
      K_current:=K_current_Lyle;
  end;
end;

function KA_current:double;
begin
  if          NP0.HH_type='Cummins' then begin
      KA_current:=KA_current_Cum;
  end else if NP0.HH_type='Lyle'    then begin
      KA_current:=KA_current_Lyle
  end else begin
      KA_current:=KA_current_Migli;
  end;
end;

function KM_current:double;
begin
  if          NP0.HH_type='Lyle'    then begin
      KM_current:=KM_current_Lyle
  end else begin
      KM_current:=KM_current_CalmDest;
  end;
end;

function KD_current:double;
begin
  if          NP0.HH_type='Lyle' then begin
      KD_current:=KD_current_Lyle;
  end else {if HH_type='Cummins' then} begin
      KD_current:=KD_current_Cum
  end;
end;

function CaH_current:double;
begin
  if NP0.HH_type='Cummins' then  CaH_current:=CaH_current_Cum
                       else  CaH_current:=CaH_current_CalmDest;
end;
function CaH_Cond:double;
begin
  if NP0.HH_type='Cummins' then  CaH_Cond:=CaH_Cond_Cum
                       else  CaH_Cond:=CaH_Cond_CalmDest;
end;

function CaT_current:double;
begin
  if NP0.HH_type='Cummins' then  CaT_current:=CaT_current_Cum
                       else  CaT_current:=CaT_current_CalmDest;
end;
function CaT_Cond:double;
begin
  if NP0.HH_type='Cummins' then  CaT_Cond:=CaT_Cond_Cum
                       else  CaT_Cond:=CaT_Cond_CalmDest;
end;

end.
