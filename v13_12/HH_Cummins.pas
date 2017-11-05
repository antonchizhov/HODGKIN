unit HH_Cummins;

interface
function NaR_current_Cum:double;
function Na_current_Cum:double;
function K_current_Cum:double;
function KA_current_Cum:double;
function KD_current_Cum:double;
{ Ca -currents }
function CaT_Cond_Cum:double;
function CaT_current_Cum:double;
procedure CaT_Init_Cum;
function CaH_Cond_Cum:double;
function CaH_current_Cum:double;
procedure CaH_Init_Cum;
{ Initial conductances for Na and K }
procedure InitialCanalConductances_Cum;

implementation
uses Init,t_dtO,MathMyO,HH_canal;

{--------------------------------------------------------------}
function NaR_current_Cum:double;
var  v2,a,b,tau_m,m_inf,m_exp,m3,tau_h,h_inf,h_exp :double;
begin
  v2:= NV0.V*1000 - NP0.Tr_NaR;
  a:= NP0.a1NaR * alphabeta_h(NP0.a2NaR-v2, NP0.a3NaR,NP0.a4NaR);
  b:= NP0.b1NaR * alphabeta_h(NP0.b2NaR-v2, NP0.b3NaR,NP0.b4NaR);
  tau_m:= 1 / (a + b);
  m_inf:= a / (a + b);
  m_exp:= 1 - dexp(-dt*1000/tau_m);
  NV0.mmR:=NV0.mmR+m_exp*(m_inf-NV0.mmR);
  a:= NP0.c1NaR * alphabeta_h(NP0.c2NaR-v2, NP0.c3NaR,NP0.c4NaR);
  b:= NP0.d1NaR * alphabeta_h(NP0.d2NaR-v2, NP0.d3NaR,NP0.d4NaR);
  tau_h:= 1 / (a + b);
  h_inf:= a / (a + b);
  h_exp:= 1 - dexp(-dt*1000/tau_h);
  NV0.hhR:=NV0.hhR+h_exp*(h_inf-NV0.hhR);
  NaR_current_Cum:=NP0.gNaR*NV0.mmR*NV0.hhR*(NV0.V-NP0.VNaR)*(1-NP0.IfBlockNaR);      { Current }
end;

function Na_current_Cum:double;
var  v2,v3,a,b,tau_m,m_inf,m_exp,m3,
               tau_h,h_inf,h_exp,
               tau_i,i_inf,i_exp        :double;
begin
  v2:= NV0.V*1000;  v3:= v2 - NP0.NaThreshShift;
  tau_m:= 0.75*dexp(-sqr(0.0635*(v3+40.35)))+0.12;
  tau_h:= 6.5 *dexp(-sqr(0.0295*(v2+75)))   +0.55;
  tau_i:= 25/(1+dexp( (v2-20)   /4.5 )) + 0.01;
  m_inf:=  1/(1+dexp(-(v3+41.35)/4.75));
  h_inf:=  1/(1+dexp( (v2+62)   /4.5 ));
  i_inf:=  1/(1+dexp( (v2+40)   /1.5 ));
  m_exp:= 1 - dexp(-dt*1000/tau_m);
  h_exp:= 1 - dexp(-dt*1000/tau_h);
  i_exp:= 1 - dexp(-dt*1000/tau_i);
  NV0.mm:=NV0.mm+m_exp*(m_inf-NV0.mm);
  NV0.hh:=NV0.hh+h_exp*(h_inf-NV0.hh);
  NV0.ii:=NV0.ii+i_exp*(i_inf-NV0.ii);
  if NP0.IfReduced=1 then NV0.mm:=m_inf;
  m3:=istep(NV0.mm,3);
  Na_current_Cum:=NP0.gNa*m3*NV0.hh*NV0.ii*(NV0.V-NP0.VNa)*(1-NP0.IfBlockNa);
end;

function K_current_Cum:double;
var  v2,a,b,tau_n,n_inf,n_exp,n4 :double;
begin
  v2:= NV0.V*1000;
  a:= 0.001265*(v2+14.273)/(1-dexp(-(v2+14.273)/10));
  b:= 0.125*dexp(-(v2+55)/2.5);
  tau_n:= 1 / (a + b) + 1;
  n_inf:= 1/(1+dexp(-(v2+14.62)/18.38));
  n_exp:= 1 - dexp(-dt*1000/tau_n);
  NV0.nn:=NV0.nn+n_exp*(n_inf-NV0.nn);
  K_current_Cum :=NP0.gK*NV0.nn*(NV0.V-NP0.VKDr)*(1-NP0.IfBlockK);
end;

function KA_current_Cum:double;
var  v2,a,b,tau_m,tau_h,
     m_inf,h_inf,m3,m_exp,h_exp :double;
begin
  v2:= NV0.V*1000;
  tau_m:=   5*dexp(-sqr(0.022*(v2+65)))+ 2.5;
  tau_h:= 100*dexp(-sqr(0.035*(v2+30)))+10.5;
  m_inf:= 1/(1+dexp(-(v2+28)/28));
  h_inf:= 1/(1+dexp( (v2+58)/ 7));
  m_exp:= 1 - dexp(-dt*1000/tau_m);
  h_exp:= 1 - dexp(-dt*1000/tau_h);
  NV0.nA:=NV0.nA+m_exp*(m_inf-NV0.nA);
  NV0.lA:=NV0.lA+h_exp*(h_inf-NV0.lA);
  m3:=istep(NV0.nA,3);
  KA_current_Cum :=NP0.gKA*m3*NV0.lA*(NV0.V-NP0.VK)*(1-NP0.IfBlockKA);
end;

function KD_current_Cum:double;
var  v2,a,b,tau_x,tau_y,
     x_inf,y_inf,x3,x_exp,y_exp :double;
begin
  v2:= NV0.V*1000;
  tau_x:=   5*dexp(-sqr(0.022*(v2+65)))+ 2.5;
  tau_y:= 7500;
  x_inf:= 1/(1+dexp(-(v2+39.59)/14.68));
  y_inf:= 1/(1+dexp( (v2+48)/ 7));
  x_exp:= 1 - dexp(-dt*1000/tau_x);
  y_exp:= 1 - dexp(-dt*1000/tau_y);
  NV0.xD:=NV0.xD+x_exp*(x_inf-NV0.xD);
  NV0.yD:=NV0.yD+y_exp*(y_inf-NV0.yD);
  x3:=istep(NV0.xD,3);
  KD_current_Cum :=NP0.gKD*x3*NV0.yD*(NV0.V-NP0.VK);
end;

  { *** CaT  ***}

function CaT_Cond_Cum:double;
begin
  CaT_Cond_Cum :=NP0.gCaT*NV0.mCaT*NV0.hCaT;
end;
function CaT_current_Cum:double;
var  v2,tau_m,tau_h,m_inf,h_inf,m_exp,h_exp :double;
begin
  v2:= NV0.V*1000;
  tau_m:= 22*dexp(-sqr(0.052*(v2+68))) +  2.5;
  tau_h:=103*dexp(-sqr(0.050*(v2+58))) + 12.5;
  m_inf:= 1 / (1+dexp(-(v2+54)/5.75));
  h_inf:= 1 / (1+dexp( (v2+68)/6));
  m_exp:= 1 - dexp(-dt*1000/tau_m);
  h_exp:= 1 - dexp(-dt*1000/tau_h);
  NV0.mCaT:=NV0.mCaT+m_exp*(m_inf-NV0.mCaT);
  NV0.hCaT:=NV0.hCaT+h_exp*(h_inf-NV0.hCaT);
  CaT_current_Cum :=CaT_Cond_Cum*(NV0.V-0.120);  { Current }
end;
procedure CaT_Init_Cum;
var  v2 :double;
begin
      v2:= NV0.V*1000;
      { mCaT,hCaT - for CaT }
      NV0.mCaT:= 1 / (1+dexp(-(v2+54)/5.75));
      NV0.hCaT:= 1 / (1+dexp( (v2+68)/6));
end;

  { *** CaH  ***}

function CaH_Cond_Cum:double;
begin
  CaH_Cond_Cum :=NP0.gCaH*NV0.mCaH*NV0.hCaH*NV0.kCaH;
end;
function CaH_current_Cum:double;
var  v2,a,b,tau_m,m_inf,m_exp,
            tau_h,h_inf,h_exp,
            tau_k,k_inf,k_exp :double;
begin
  v2:= NV0.V*1000;
  tau_m:=3.25*dexp(-sqr(0.042 *(v2+31))) +  0.395;
  tau_h:=33.5*dexp(-sqr(0.0395*(v2+30))) +  5;
  tau_k:=225 *dexp(-sqr(0.0275*(v2+40))) + 75;
  m_inf:= 1 / (1+dexp(-(v2+20)/4.5));
  h_inf:= 1 / (1+dexp( (v2+20)/25));
  k_inf:= 1 / (1+dexp( (v2+40)/10)) + 0.2/(1+dexp(-(v2+5)/10));
  m_exp:= 1 - dexp(-dt*1000/tau_m);
  h_exp:= 1 - dexp(-dt*1000/tau_h);
  k_exp:= 1 - dexp(-dt*1000/tau_k);
  NV0.mCaH:=NV0.mCaH+m_exp*(m_inf-NV0.mCaH);
  NV0.hCaH:=NV0.hCaH+h_exp*(h_inf-NV0.hCaH);
  NV0.kCaH:=NV0.kCaH+k_exp*(k_inf-NV0.kCaH);
  CaH_current_Cum:=CaH_Cond_Cum*(NV0.V-0.120);  { Current }
end;
procedure CaH_Init_Cum;
var  v2 :double;
begin
      v2:= NV0.V*1000;
      { mCaH,hCaH,kCaH - for CaH }
      NV0.mCaH:= 1 / (1+dexp(-(v2+20)/4.5));
      NV0.hCaH:= 1 / (1+dexp( (v2+20)/25));
      NV0.kCaH:= 1 / (1+dexp( (v2+40)/10)) + 0.2/(1+dexp(-(v2+5)/10));
end;

{*********************************************************************}

procedure InitialCanalConductances_Cum;
var
     v2,v3,a,b :double;
begin
      v2:= NV0.V*1000;     v3:= v2 - NP0.NaThreshShift;
      { mm,hh,ii - for Na }
      NV0.mm:=  1/(1+dexp(-(v3-NP0.NaThreshShift+41.35)/4.75));
      NV0.hh:=  1/(1+dexp( (v2+62)   /4.5 ));
      NV0.ii:=  1/(1+dexp( (v2+40)   /1.5 ));
      tau_mm:= 0.75*dexp(-sqr(0.0635*(v3+40.35)))+0.12;
      tau_hh:= 6.5 *dexp(-sqr(0.0295*(v2+75)))   +0.55;
      tau_ii:= 25/(1+dexp( (v2-20)   /4.5 )) + 0.01;
      { nn - for K }
      NV0.nn:= 1/(1+dexp(-(v2+14.62)/18.38));
      { nA,lA - for KA }
      NV0.nA:= 1/(1+dexp(-(v2+28)/28));
      NV0.lA:= 1/(1+dexp( (v2+58)/ 7));
      { xD,yD - for KD }
      NV0.xD:= 1/(1+dexp(-(v2+39.59)/14.68));
      NV0.yD:= 1/(1+dexp( (v2+48)/ 7));
end;

{*********************************************************************}

end.
