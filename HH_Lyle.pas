unit HH_Lyle;

interface
function Na_cond_Lyle(x,y :double):double;
function Na_current_Lyle:double;
function NaR_current_Lyle:double;
procedure tau_inf_K_Lyle(v2 :double; var tau_n,n_inf,tau_yK,yK_inf :double);
function K_cond_Lyle(x,y :double):double;
function K_current_Lyle:double;
procedure tau_inf_KA_Lyle(v2 :double; var tau_n,n_inf,tau_l,l_inf :double);
function KA_cond_Lyle(x,y :double):double;
function KA_current_Lyle:double;
procedure tau_inf_KM_Lyle(v2 :double; var tau_n,n_inf :double);
function KM_cond_Lyle(x :double):double;
function KM_current_Lyle:double;
procedure tau_inf_KD_Lyle(v2 :double; var tau_x,x_inf,tau_y,y_inf :double);
function KD_cond_Lyle(x,y :double):double;
function KD_current_Lyle:double;
procedure tau_inf_H_Lyle(v2 :double; var tau_y,y_inf :double);
function H_cond_Lyle(y :double):double;
function H_current_Lyle:double;
{ Initial conductances for Na and K }
procedure InitialCanalConductances_Lyle;

type arr4x4=array[1..4,1..4] of double;
     arr4x1=array[1..4] of double;
var
    XNa :arr4x1;

implementation
uses MyTypes,Init,t_dtO,MathMyO,HH_canal;

{-------- Na - Markov model -----------------------}
function TransitionRate(v2,t_max,k,V12,t_min :double) :double;
{ Calculate rate for Markov model, according to eq.(4)
  [Lyle, Interpretations..., p.78] }
var a,ex_ :double;
begin
  if t_max=888 then a:=0 else a:=1/(t_max-t_min);
  ex_:=dexp((v2-V12-NP0.NaThreshShift)/k);
  if a+ex_=0 then  TransitionRate:=0
             else  TransitionRate:=1/(t_min+1/(a+ex_));
end;

procedure alphas_Na_Lyle(v2 :double; var A :arr4x4);
var i,j :integer;
{ States: 1-O, 2-I, 3-C1, 4-C2 as in [Lyle, Interpretations..., p.92] }
begin
  for i:=1 to 4 do
      for j:=1 to 4 do  A[i,j]:=0;
  A[4,1]:=TransitionRate(v2,888, 1,-51,1/3);
  A[1,4]:=TransitionRate(v2,888,-2,-57,1/3);
  A[3,1]:=TransitionRate(v2,888, 1,-42,1/3);
  A[1,3]:=TransitionRate(v2,888,-2,-51,1/3);
  A[1,2]:=3;
  A[2,3]:=TransitionRate(v2,100,-1,-53,  1);
  A[3,4]:=TransitionRate(v2,100,-1,-60,  1);
end;

function gNa_inf_Lyle:double;
{ Calculates stationary solution for Na-conductance }
var
     A          :arr4x4;
     L          :matr;
     X,B        :vect;
     S          :double;
     i,j        :integer;
begin
  alphas_Na_Lyle(NV0.V*1000, A);
  for i:=1 to 4 do for j:=1 to 4 do  L[i,j]:=A[j,i];
  for i:=1 to 3 do begin
      S:=0;
      for j:=1 to 4 do  S:=S+A[i,j];
      L[i,i]:= -S;
      B[i]:=0;
  end;
  B[4]:=1;   L[4,1]:=1; L[4,2]:=1; L[4,3]:=1; L[4,4]:=1; {Normalization}
  LinearSistem(4, L, B, X);
  for i:=1 to 4 do  XNa[i]:=X[i];
  NV0.mm:=XNa[1];  NV0.hh:=1;
  gNa_inf_Lyle:=NP0.gNa*NV0.mm*(1-NP0.IfBlockNa);
end;

function Na_cond_Lyle(x,y :double):double;
begin
  Na_cond_Lyle:=x*(1-NP0.IfBlockNa);
end;

function Na_current_Lyle:double;
var
     A          :arr4x4;
     Sp,Sm      :double;
     i,j        :integer;
begin
  alphas_Na_Lyle(NV0.V*1000, A);
  for i:=1 to 3 do begin
      Sp:=0; Sm:=0;
      for j:=1 to 4 do  if i<>j then begin
          Sp:=Sp + dt*1000*A[j,i]*XNa[j];
          Sm:=Sm + dt*1000*A[i,j];
      end;
      XNa[i]:=XNa[i] + Sp - Sm*XNa[i];
  end;
  XNa[4]:=1 - XNa[1] - XNa[2] - XNa[3];      {Normalization}
  NV0.mm:=XNa[1];  NV0.hh:=1;
  Na_current_Lyle:=NP0.gNa*Na_cond_Lyle(NV0.mm,1)*(NV0.V-NP0.VNa);
end;

{---------------- K - DR -----------------}
procedure tau_inf_K_Lyle(v2 :double; var tau_n,n_inf,tau_yK,yK_inf :double);
var a,b :double;
begin
  { Eq. for 'n' }
  a:=0.17*dexp( (v2+5)*0.8*3*NP0.FRT);
  b:=0.17*dexp(-(v2+5)*0.2*3*NP0.FRT);
  tau_n:= 1 / (a + b) + 0.8;
  n_inf:= a / (a + b);
  { Eq. for 'yK' }
  tau_yK:= 300;
  yK_inf:= 1 / (1 + dexp(-(v2+68)*(-1)*NP0.FRT));
end;

function K_cond_Lyle(x,y :double):double;
begin
  K_cond_Lyle :=x*y*(1-NP0.IfBlockK);
end;

function K_current_Lyle:double;
var  v2,tau_n,n_inf,tau_yK,yK_inf :double;
begin
  tau_inf_K_Lyle(NV0.V*1000, tau_n,n_inf,tau_yK,yK_inf);
  NV0.nn:=NV0.nn+E_exp(dt,tau_n )*( n_inf-NV0.nn);
  NV0.yK:=NV0.yK+E_exp(dt,tau_yK)*(yK_inf-NV0.yK);
  K_current_Lyle :=NP0.gK*K_cond_Lyle(NV0.nn,NV0.yK)*(NV0.V-NP0.VKDr);
end;

{---------------- KA -----------------}
procedure tau_inf_KA_Lyle(v2 :double; var tau_n,n_inf,tau_l,l_inf :double);
var a,b :double;
begin
  { Eq. for 'nA' }
  a:=0.08*dexp( (v2+41)*0.85*2.8*NP0.FRT);
  b:=0.08*dexp(-(v2+41)*0.15*2.8*NP0.FRT);
  tau_n:= 1 / (a + b) + 1.0;
  n_inf:= a / (a + b);
  { Eq. for 'lA' }
  a:=0.04*dexp( (v2+49)*1*(-3)*NP0.FRT);
  b:=0.04;
  tau_l:= 1 / (a + b) + 2.0;
  l_inf:= a / (a + b);
end;

function KA_cond_Lyle(x,y :double):double;
begin
  KA_cond_Lyle :=istep(x,4)*istep(y,3)*(1-NP0.IfBlockKA);
end;

function KA_current_Lyle:double;
var  tau_n,n_inf,tau_l,l_inf :double;
begin
  tau_inf_KA_Lyle(NV0.V*1000, tau_n,n_inf,tau_l,l_inf);
  NV0.nA:=NV0.nA+E_exp(dt,tau_n)*(n_inf-NV0.nA);
  NV0.lA:=NV0.lA+E_exp(dt,tau_l)*(l_inf-NV0.lA);
  KA_current_Lyle :=NP0.gKA*KA_cond_Lyle(NV0.nA,NV0.lA)*(NV0.V-NP0.VK);              { Current }
end;

{---------------- KM -----------------}
procedure tau_inf_KM_Lyle(v2 :double; var tau_n,n_inf :double);
var a,b :double;
begin
  { Eq. for 'nM' }
  a:=0.003*dexp( (v2+45)*0.6*6*NP0.FRT);
  b:=0.003*dexp(-(v2+45)*0.4*6*NP0.FRT);
  tau_n:= 1 / (a + b) + 8;
  n_inf:= a / (a + b);
end;

function KM_cond_Lyle(x :double):double;
begin
  KM_cond_Lyle :=x*x*(1-NP0.IfBlockKM);
end;

function KM_current_Lyle:double;
var  tau_n,n_inf :double;
begin
  tau_inf_KM_Lyle(NV0.V*1000, tau_n,n_inf);
  NV0.nM:=NV0.nM+E_exp(dt,tau_n)*(n_inf-NV0.nM);
  KM_current_Lyle :=NP0.gKM*KM_cond_Lyle(NV0.nM)*(NV0.V-NP0.VKM);              { Current }
end;

{---------------- KD -----------------}
procedure tau_inf_KD_Lyle(v2 :double; var tau_x,x_inf,tau_y,y_inf :double);
var a,b :double;
begin
  { Eq. for 'xD' }
  tau_x:= 1;
  x_inf:= 1 / (1 + dexp(-(v2+63)*3*NP0.FRT));
  { Eq. for 'yD' }
  a:=2e-4;
  b:=2e-4*dexp(-(v2+73)*1*(-2.5)*NP0.FRT);
  tau_y:= 1 / (a + b);
  y_inf:= a / (a + b);
end;

function KD_cond_Lyle(x,y :double):double;
begin
  KD_cond_Lyle :=istep(x*y,4);
end;

function KD_current_Lyle:double;
var  tau_x,x_inf,tau_y,y_inf :double;
begin
  tau_inf_KD_Lyle(NV0.V*1000, tau_x,x_inf,tau_y,y_inf);
  NV0.xD:=NV0.xD+E_exp(dt,tau_x)*(x_inf-NV0.xD);
  NV0.yD:=NV0.yD+E_exp(dt,tau_y)*(y_inf-NV0.yD);
  KD_current_Lyle :=NP0.gKD*KD_cond_Lyle(NV0.xD,NV0.yD)*(NV0.V-NP0.VKD);              { Current }
end;

{---------------- H -----------------}
procedure tau_inf_H_Lyle(v2 :double; var tau_y,y_inf :double);
var a,b :double;
begin
  { Eq. for 'yH' }
  tau_y:= 180;
  y_inf:= 1 / (1 + dexp(-(v2+98)*(-2)*NP0.FRT));
end;

function H_cond_Lyle(y :double):double;
begin
  H_cond_Lyle :=y;
end;

function H_current_Lyle:double;
var  tau_y,y_inf :double;
begin
  tau_inf_H_Lyle(NV0.V*1000, tau_y,y_inf);
  NV0.yH:=NV0.yH+E_exp(dt,tau_y)*(y_inf-NV0.yH);
  H_current_Lyle :=NP0.gH*H_cond_Lyle(NV0.yH)*(NV0.V-NP0.V12H);              { Current }
end;

{-------- Na - trig -----------------------}
procedure tau_inf_Na_Lyle(v2 :double; var tau_m,m_inf,tau_h,h_inf :double);
var a,b :double;
begin
  { Eq. for 'm' }
  a:=0.3*dexp( (v2+47-NP0.NaThreshShift)*0.5*20*NP0.FRT);
  b:=0.3*dexp(-(v2+47-NP0.NaThreshShift)*0.5*20*NP0.FRT);
  tau_m:= 1 / (a + b);  tau_m:=max(tau_m,0.5);
  m_inf:= a / (a + b);
  { Eq. for 'h' }
  a:=0.003*dexp( (v2+54)*0.2*(-30)*NP0.FRT);
  b:=0.003*dexp(-(v2+54)*0.8*(-30)*NP0.FRT);
  tau_h:= 1 / (a + b);  tau_h:=max(tau_h,2.0);
  h_inf:= a / (a + b);
end;

function Na_current_Lyle2:double;
var  tau_m,m_inf, tau_h,h_inf :double;
begin
  tau_inf_Na_Lyle(NV0.V*1000, tau_m,m_inf,tau_h,h_inf);
  NV0.mm:=NV0.mm+E_exp(dt,tau_m)*(m_inf-NV0.mm);
  NV0.hh:=NV0.hh+E_exp(dt,tau_h)*(h_inf-NV0.hh);
  if NP0.IfReduced=1 then NV0.mm:=m_inf;
  Na_current_Lyle2:=NP0.gNa*NV0.mm*sqr(NV0.hh)*(NV0.V-NP0.VNa)*(1-NP0.IfBlockNa);
end;

{-------- NaR - rep -----------------------}
procedure tau_inf_NaR_Lyle(v2 :double; var tau_m,m_inf,tau_h,h_inf :double);
var a,b :double;
begin
  { Eq. for 'm' }
  a:=0.67*dexp( (v2+34)*0.5*6*NP0.FRT);
  b:=0.67*dexp(-(v2+34)*0.5*6*NP0.FRT);
  tau_m:= 1 / (a + b);    tau_m:=max(tau_m,5.0);
  m_inf:= a / (a + b);
  { Eq. for 'h' }
  a:=0.0023*dexp( (v2+42.5)*0.17*(-30)*NP0.FRT);
  b:=0.0023*dexp(-(v2+42.5)*0.83*(-30)*NP0.FRT);
  tau_h:= 1 / (a + b);    tau_h:=max(tau_h,3.0);
  h_inf:= a / (a + b);
end;

function NaR_current_Lyle:double;
var  tau_m,m_inf, tau_h,h_inf,m2h3 :double;
begin
  tau_inf_NaR_Lyle(NV0.V*1000, tau_m,m_inf,tau_h,h_inf);
  NV0.mmR:=NV0.mmR+E_exp(dt,tau_m)*(m_inf-NV0.mmR);
  NV0.hhR:=NV0.hhR+E_exp(dt,tau_h)*(h_inf-NV0.hhR);
  if NP0.IfReduced=1 then NV0.mmR:=m_inf;
  m2h3:=sqr(NV0.mmR)*istep(NV0.hhR,3);
  NaR_current_Lyle:=NP0.gNaR*m2h3*(NV0.V-NP0.VNa)*(1-NP0.IfBlockNa);
end;

{---------------- K - DR -----------------}
procedure tau_inf_K_Lyle2(v2 :double; var tau_n,n_inf,tau_yK,yK_inf :double);
var a,b :double;
begin
  { Eq. for 'n' }
  a:=0.008*dexp( (v2+28)*0.95*12*NP0.FRT);
  b:=0.008*dexp(-(v2+28)*0.05*12*NP0.FRT);
  tau_n:= 1 / (a + b) + 0.5;
  n_inf:= a / (a + b);
  { Eq. for 'yK' }
  a:=0.0004*dexp( (v2+45)*0.8*(-9)*NP0.FRT);
  b:=0.0004*dexp(-(v2+45)*0.2*(-9)*NP0.FRT);
  tau_yK:= 1 / (a + b) + 6.0;
  yK_inf:= a / (a + b);
end;

function K_cond_Lyle2:double;
begin
  K_cond_Lyle2 :=NP0.gK*istep(NV0.nn,3)*NV0.yK*(1-NP0.IfBlockK);
end;

function K_current_Lyle2:double;
var  v2,tau_n,n_inf,tau_yK,yK_inf :double;
begin
  tau_inf_K_Lyle(NV0.V*1000, tau_n,n_inf,tau_yK,yK_inf);
  NV0.nn:=NV0.nn+E_exp(dt,tau_n )*( n_inf-NV0.nn);
  NV0.yK:=NV0.yK+E_exp(dt,tau_yK)*(yK_inf-NV0.yK);
  K_current_Lyle2 :=K_cond_Lyle2*(NV0.V-NP0.VKDr);
end;

{---------------- KA -----------------}
procedure tau_inf_KA_Lyle2(v2 :double; var tau_n,n_inf,tau_l,l_inf :double);
var a,b :double;
begin
  { Eq. for 'nA' }
  a:=0.2*dexp( (v2+52)*0.8*3.5*NP0.FRT);
  b:=0.2*dexp(-(v2+52)*0.2*3.5*NP0.FRT);
  tau_n:= 1 / (a + b) + 1.0;
  n_inf:= a / (a + b);
  { Eq. for 'lA' }
  a:=0.0015*dexp( (v2+72)*0.6*(-7)*NP0.FRT);
  b:=0.0015*dexp(-(v2+72)*0.4*(-7)*NP0.FRT);
  tau_l:= 1 / (a + b) + 24.0;
  l_inf:= a / (a + b);
end;

function KA_cond_Lyle2:double;
begin
  KA_cond_Lyle2 :=NP0.gKA*istep(NV0.nA,3)*NV0.lA*(1-NP0.IfBlockKA);
end;

function KA_current_Lyle2:double;
var  v2,tau_n,n_inf,tau_l,l_inf :double;
begin
  tau_inf_KA_Lyle(NV0.V*1000, tau_n,n_inf,tau_l,l_inf);
  NV0.nA:=NV0.nA+E_exp(dt,tau_n)*(n_inf-NV0.nA);
  NV0.lA:=NV0.lA+E_exp(dt,tau_l)*(l_inf-NV0.lA);
  KA_current_Lyle2 :=KA_cond_Lyle2*(NV0.V-NP0.VK);              { Current }
end;

{*********************************************************************}

procedure WriteStationarySolutionInFile;
var
    A                   :arr4x4;
    Vold,dum,Im,IL      :double;
    i                   :integer;
begin
  Vold:=NV0.V;
  assign(zzz,'Markov.dat'); rewrite(zzz);
  for i:=0 to 300 do begin
      NV0.V:=(-100+i/2)/1000;
      dum:= gNa_inf_Lyle;
      IL:=NP0.gL*(NV0.V+0.07);
      Im:=dum*(NV0.V-NP0.VNa)+IL;
      write  (zzz,NV0.V*1000:9:4,' ',XNa[1]:11:5,' ',XNa[2]:11:5,' ');
      write  (zzz,XNa[3]:11:5,' ',XNa[4]:11:5,' ',Im*1e3:11:5,' ');
      alphas_Na_Lyle(NV0.V*1000, A);
      write  (zzz,A[1,3]:9:4,' ',A[2,3]:9:4,' ',A[3,4]:9:4,' ',A[1,4]:9:4,' ');
      writeln(zzz,A[3,1]:9:4,' ',A[4,1]:9:4,' ',A[1,2]:9:4,' ',IL*1e3:9:4,' ');
  end;
  NV0.V:=Vold;
  close(zzz);
end;

procedure InitialCanalConductances_Lyle;
var
     tau1,tau2, dum :double;
begin
{  WriteStationarySolutionInFile;}
      { mm,hh - for Na, NaR }
//      tau_inf_Na_Lyle (V*1000, tau_m,mm, tau_h,hh);
      dum:= gNa_inf_Lyle;
      tau_inf_NaR_Lyle(NV0.V*1000, tau1,NV0.mmR,tau2,NV0.hhR);
      { nn - for K }
      tau_inf_K_Lyle (NV0.V*1000, tau1,NV0.nn,tau2,NV0.yK);
      tau_inf_KA_Lyle(NV0.V*1000, tau1,NV0.nA,tau2,NV0.lA);
      tau_inf_KM_Lyle(NV0.V*1000, tau1,NV0.nM);
      tau_inf_KD_Lyle(NV0.V*1000, tau1,NV0.xD,tau2,NV0.yD);
      tau_inf_H_Lyle (NV0.V*1000, tau1,NV0.yH);
end;

{*********************************************************************}

end.
