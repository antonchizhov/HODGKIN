unit HH_Chow;

interface
function Na_current_Chow:double;
function K_current_Chow:double;
procedure InitialCanalConductances_Chow;

implementation
uses Init,t_dtO,MathMyO,HH_canal;

{--------------------------------------------------------------}
function Na_current_Chow:double;
var  v2,v3,a,b,tau_m,m_inf,m_exp,m3,
            tau_h,h_inf,h_exp :double;
begin
  v2:= NV0.V*1000 ;  v3:= v2 - NP0.NaThreshShift;
  tau_h:= 0.6/(1+dexp(-0.12*(v2+67)));
  m_inf:=   1/(1+dexp(-0.17{08}*(v3+26)));
  h_inf:=   1/(1+dexp( 0.13*(v2+38)));
  h_exp:= 1 - dexp(-dt*1000/tau_h);
  NV0.hh:=NV0.hh+h_exp*(h_inf-NV0.hh);
  NV0.mm:=m_inf;
  m3:=istep(NV0.mm,3);
  Na_current_Chow:=NP0.gNa*m3*NV0.hh*(NV0.V-NP0.VNa)*(1-NP0.IfBlockNa);
end;

function K_current_Chow:double;
var  v2,tau_n,n_inf,n_exp,n4 :double;
begin
  v2:= NV0.V*1000;
  tau_n:= (0.5 + 2.0/(1+dexp(0.045*(v2-50))));   // !!!!Znak-OK!
  n_inf:= 1/(1+dexp(-0.045*(v2+10)));
  n_exp:= 1 - dexp(-dt*1000/tau_n);
  NV0.nn:=NV0.nn+n_exp*(n_inf-NV0.nn);
  n4:=istep(NV0.nn,4);
  K_current_Chow :=NP0.gK*n4*(NV0.V-NP0.VKDr)*(1-NP0.IfBlockK);
end;

{*********************************************************************}

procedure InitialCanalConductances_Chow;
var
     v2,v3 :double;
begin
      v2:= NV0.V*1000;   v3:= v2 - NP0.NaThreshShift;
      { mm,hh - for Na }
      NV0.mm:=  1/(1+dexp(-0.08*(v3+26)));
      NV0.hh:=  1/(1+dexp( 0.13*(v2+38)));
      tau_mm:= 0;
      tau_hh:= 0.6/(1+dexp(-0.12*(v2+67)));
      { nn - for K }
      NV0.nn:= 1/(1+dexp(-0.045*(v2+10)));
end;

{*********************************************************************}

end.
