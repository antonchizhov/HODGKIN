unit HH_Migli;

interface
function Na_current_Migli:double;
function K_current_Migli:double;
function KA_current_Migli:double;
procedure InitialCanalConductances_Migli;

implementation
uses Init,t_dtO,MathMyO,HH_canal;
{
}

{--------------------------------------------------------------}
function Na_current_Migli:double;
var  v2,v3,a,b,tau,m_inf,m_exp,m3,h_inf,h_exp,i_inf,i_exp,bi :double;
begin
  { *          vtrap(x,y) = x/( Exp(x/y)-1 )            * }
  v2:= NV0.V*1000;  v3:= v2 - NP0.NaThreshShift;
  { Eq. for 'm' }
  a:= 0.4   * vtrap(-(v3+30), 7.2);
  b:= 0.124 * vtrap( (v3+30), 7.2);
  tau:= 0.5 / (a + b);
  if tau<0.02 then  tau:=0.02;
  m_inf:=   a / (a + b);
  m_exp:= 1 - dexp(-dt*1000/tau);
  NV0.mm:=NV0.mm+m_exp*(m_inf-NV0.mm);
  if NP0.IfReduced=1 then NV0.mm:=m_inf;
  m3:=istep(NV0.mm,3);
  { Eq. for 'h' }
  a:= 0.03 * vtrap(-(v2+45), 1.5);
  b:= 0.01 * vtrap( (v2+45), 1.5);
  tau:= 0.5 / (a + b);
  if tau<0.5 then  tau:=0.5;
  h_inf:= 1 / (1 + dexp((v2+50)/4));
  h_exp:= 1 - dexp(-dt*1000/tau);
  NV0.hh:=NV0.hh+h_exp*(h_inf-NV0.hh);
  { Eq. for 'i' }
  bi:=0.5;
  a:= dexp(0.45*(v2+60));
  b:= dexp(0.09*(v2+60));
  tau:= 3000*b / (1 + a);
  if tau<10 then  tau:=10;
  i_inf:= (1 + bi * dexp((v2+58)/2))/(1 + dexp((v2+58)/2));
  i_exp:= 1 - dexp(-dt*1000/tau);
  NV0.ii:=NV0.ii+i_exp*(i_inf-NV0.ii);
  Na_current_Migli:=NP0.gNa*m3*NV0.hh{*NV.ii}*(NV0.V-NP0.VNa)*(1-NP0.IfBlockNa);      { Current }
end;

function K_current_Migli:double;
var  v2,a,b,tau,n_inf,n_exp :double;
begin
  v2:= NV0.V*1000;
  { Eq. for 'n' }
  a:= dexp(-0.11*(v2-13));
  b:= dexp(-0.08*(v2-13));
  tau:= 50*b / (1 + a);
  if tau<2 then  tau:=2;
  n_inf:= 1 / (1 + a);
  n_exp:= 1 - dexp(-dt*1000/tau);
  NV0.nn:=NV0.nn+n_exp*(n_inf-NV0.nn);
  K_current_Migli :=NP0.gK*NV0.nn*(NV0.V-NP0.VKDr)*(1-NP0.IfBlockK);              { Current }
end;

function KA_current_Migli:double;
var  v2,a,b,tau,n_inf,n_exp,l_inf,l_exp :double;
begin
  v2:= NV0.V*1000;
  { Eq. for 'n' }
  a:=dexp( -0.038*( 1.5  +1/(1+dexp((v2+40)/5)) )*(v2-11) );
  b:=dexp( -0.038*( 0.825+1/(1+dexp((v2+40)/5)) )*(v2-11) );
  tau:= 4*b / (1 + a);
  if tau<0.1 then  tau:=0.1;
  n_inf:= 1 / (1 + a);
  n_exp:= 1 - dexp(-dt*1000/tau);
  NV0.nA:=NV0.nA+n_exp*(n_inf-NV0.nA);
  { Eq. for 'l' }
  a:= dexp(0.11*(v2+56));
  tau:= 0.26 * (v2+50);
  if tau<2 then  tau:=2;
  l_inf:= 1 / (1 + a);
  l_exp:= 1 - dexp(-dt*1000/tau);
  NV0.lA:=NV0.lA+l_exp*(l_inf-NV0.lA);
  KA_current_Migli :=NP0.gKA*NV0.nA*NV0.lA*(NV0.V-NP0.VK)*(1-NP0.IfBlockKA);              { Current }
end;

{*********************************************************************}

procedure InitialCanalConductances_Migli;
var
     v2,v3,a,b,ICaH,m2,bi :double;
begin
      v2:= NV0.V*1000;   v3:= v2 - NP0.NaThreshShift;
      { mm - for Na }
      a:= 0.4   * vtrap(-(v3+30), 7.2);
      b:= 0.124 * vtrap( (v3+30), 7.2);
      tau_mm:= 0.5 / (a + b);    if tau_mm<0.02 then  tau_mm:=0.02;
      NV0.mm:= a / (a + b);
      { hh - for Na }
      a:= 0.03 * vtrap(-(v2+45), 1.5);
      b:= 0.01 * vtrap( (v2+45), 1.5);
      tau_hh:= 0.5 / (a + b);  if tau_hh<0.5 then  tau_hh:=0.5;
      NV0.hh:= 1 / (1 + dexp((v2+50)/4));
      { ii - for Na }
      bi:=0.8;
      a:= dexp(0.45*(v2+60));
      b:= dexp(0.09*(v2+60));
      tau_ii:= 3000*b / (1 + a);  if tau_ii<10 then  tau_ii:=10;
      NV0.ii:= (1 + bi * dexp((v2+58)/2))/(1 + dexp((v2+58)/2));
      { nn - for K }
      a:= dexp(-0.11*(v2-13));
      b:= dexp(-0.08*(v2-13));
      NV0.nn:= 1 / (1 + a);
end;

end.
 