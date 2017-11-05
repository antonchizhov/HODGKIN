unit function_Z;

interface
uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Init,t_dtO,MathMyO,Unit1,Unit14,Threshold,HH_canal,Hodgkin_old,
     typeNrnParsO;

const maxZZ=1000;
type  vecZZ=array[0..maxZZ] of double;

procedure Calculate_Z(X,Y :double; indicat :integer);
procedure Write_Z;
procedure Read_Z_for_Freq_and_Vav;
procedure RememberInCircularArray(x1,x2,x3 :double);
procedure ResortCircularArray;
procedure Remember_V_freq_Vav_deterministic;
procedure Draw_V_freq_Vav_deterministic;
procedure RememberAndDraw_V_freq_Vav_deterministic;
procedure Remember_V_freq_Vav_noisy;
function Convolution_Of(ZZC,X :vecZZ; nZZC,nX:integer; scale:double; Note:string) :double;
function SecondKernel  (ZZC,X :vecZZ; nZZC,nX:integer; Note:string) :double;
function Convolution_Of_V_With_Parabola:double;
procedure CalculateConvolutions;
procedure CalcDisturbancesOf_V;
procedure CalcDisturbancesOf_InputCurrent(u,s :double);

var
      n_det,n_no,n_dstb,n_no_hist,
      nZ_freq,nZ_Vav,nZ_Unit            :integer;
      freq_det, Vav_det, {deterministic}
      freq_no,  Vav_no,  {noisy}
      freq_dstb,Vav_dstb {disturbing}   :double;
      V_det,V_no,V_dstb,V_no_hist,
      I_det,I_no,I_dstb,
      g_det,g_no, I_no_mean,DVav,
      Z_freq,Z_Vav,Z_Unit               :vecZZ;

implementation
uses Unit9;

var
      n0,nZ,ISImin,IIspike              :integer;
      ZZ,tmpZ                           :vecZZ;

procedure Calculate_Z(X,Y :double; indicat :integer);
var  i :integer;
begin
  { n0 - time-step of AP;
    ISImax - maximum of time-steps in one ISI
    nZ - number of averaged ISIs in ZZ }
  { Initial conditions }
  if nt<=1 then begin
     n0:=0; nZ:=0; {tAP:=0;} ISImin:=maxZZ;
     IIspike:=0;
     for i:=0 to maxZZ do begin ZZ[i]:=0; tmpZ[i]:=0; end;
  end;
  { if spike }
  if indicat=2 then begin
     IIspike:=IIspike+1;
     { write tmpZ in ZZ }
     if (nt-n0<=maxZZ)and(IIspike>1) then begin
        nZ:=nZ+1;
        for i:=0 to nt-n0 do begin
            {***********************************************}
            ZZ[nt-n0-i]:=(ZZ[nt-n0-i]*(nZ-1) + tmpZ[i]*Y)/nZ;
            {***********************************************}
        end;
        if n0<>0 then  ISImin:=imin(ISImin,nt-n0);
        { Drawing }
        Form14.Series7.Clear;
        for i:=0 to ISImin do begin
            Form14.Series7.AddXY(-i*dt*1e3,ZZ[i]);
        end;
        Application.ProcessMessages;
     end;
     n0:=nt;
  end;
  { Remember the signal incorporating in ZZ }
  {**********************************}
  if nt-n0<maxZZ then  tmpZ[nt-n0]:=X;
  {**********************************}
end;

procedure Write_Z;
var  i :integer;
begin
  AssignFile(zzz,'func_Z.dat'); rewrite(zzz);
  for i:=0 to ISImin do begin
      writeln(zzz,-i*dt*1e3:10:3,' ',ZZ[i]:13);
  end;
  close(zzz);
end;

{ ================== Circullar array and Convolution =================== }
var
      iCirc,iabsC                       :integer;
      xCirc1,xCirc2,xCirc3              :vecZZ;

procedure Read_Z(FileName :string; var ZZC :vecZZ; var nZZC :integer);
var  i,j        :integer;
     t_,dt_     :double;
     tmpZC      :vecZZ;
begin
  if FileExists(FileName)=false then exit;
  AssignFile(zzz,FileName); reset(zzz);
  i:=-1;
  repeat  i:=i+1;
    readln(zzz,t_, ZZC[i]);
  until (eof(zzz))or(i=maxZZ-1);
  dt_:=-t_/i/1e3;
  nZZC:=i;
  { Remeshing }
  if abs(dt_-dt)/dt>1e-2 then begin
     for i:=0 to nZZC do tmpZC[i]:=ZZC[i];
     nZZC:=trunc(nZZC*dt_/dt);
     for i:=0 to nZZC do begin
         j:=trunc(i*dt/dt_);
         ZZC[i]:=tmpZC[j];
     end;
  end;
  close(zzz);
end;

procedure Read_Z_for_Freq_and_Vav;
var i :integer;
    S :string;
begin
  if Form14.Visible=false then exit;
  GetDir(0,S);
  Read_Z({E:\Anton\HODGKIN\}'set_func_Z.dat',     Z_freq,nZ_freq);
  Read_Z({E:\Anton\HODGKIN\}'set_func_Z_Vav.dat', Z_Vav, nZ_Vav);
  Read_Z({E:\Anton\HODGKIN\}'set_func_Z_Unit.dat',Z_Unit,nZ_Unit);
  { Draw }
  Form14.Series7.Clear;
  Form14.Series16.Clear;
  Form14.Series24.Clear;
  for i:=0 to nZ_Unit do begin
      Form14.Series7. AddXY(-i*dt*1e3,       Z_freq[i]);
      Form14.Series16.AddXY(-i*dt*1e3,       Z_Vav[i]);
      Form14.Series24.AddXY(-i*dt*1e3,       Z_Unit[i]);
  end;
  Application.ProcessMessages;
end;

procedure RememberInCircularArray(x1,x2,x3 :double);
begin
  if nt<=1   then iabsC:=0;
  if iabsC=0 then iCirc:=-1;
  iabsC:=iabsC+1;
  iCirc:=iCirc+1;  if iCirc>maxZZ then iCirc:=0;
  xCirc1[iCirc]:=x1;
  xCirc2[iCirc]:=x2;
  xCirc3[iCirc]:=x3;
end;

procedure ResortCircularArray;
{ The result is the array with the end "maxZZ" at spike }
var
    xTMP1,xTMP2,xTMP3   :vecZZ;
    i,j                 :integer;
begin
  if iCirc=maxZZ then Exit;
  for i:=0 to maxZZ do begin
      xTMP1[i]:=xCirc1[i];
      xTMP2[i]:=xCirc2[i];
      xTMP3[i]:=xCirc3[i];
  end;
  j:=iCirc;    { current last element }
  for i:=0 to maxZZ do begin
      j:=j+1; if j=maxZZ+1 then j:=0;
      xCirc1[i]:=xTMP1[j];
      xCirc2[i]:=xTMP2[j];
      xCirc3[i]:=xTMP3[j];
  end;
  iCirc:=maxZZ;
  iabsC{Circ}:=imin(maxZZ,iabsC);   { length of the curve since the end }
end;

procedure Remember_V_freq_Vav_deterministic;
var  nt_ISI,i,i_stp     :integer;
     stp,dnt_           :double;
begin
  { Reorder the array }
  ResortCircularArray;
  { Remember }
  nt_ISI:=trunc(ISI[0]/dt);
  n_det:=imin(imin(iabsC,nt_ISI),maxZZ);
  for i:=0 to n_det do begin
      V_det[i]:=xCirc1[maxZZ-n_det+i];
      I_det[i]:=xCirc2[maxZZ-n_det+i];
      g_det[i]:=xCirc3[maxZZ-n_det+i];
  end;
  freq_det:=1/ISI[0];
  Vav_det:=Vav_prev;
  { Voltage at 1.5ms before the peak at spike }
  stp:=Form9.DDSpinEdit14.Value/1e3/dt;
  i_stp:=trunc_my(stp);  i_stp:=imin(i_stp,n_det-1);  i_stp:=imax(i_stp,0);
  dnt_:=stp-i_stp;
  VT_1ms:=V_det[n_det-i_stp]*(1-dnt_) + V_det[n_det-i_stp-1]*dnt_;
end;

procedure Draw_V_freq_Vav_deterministic;
var  i :integer;
begin
  Form14.Series1. Clear;
  Form14.Series6. Clear;
  Form14.Series23.Clear;
  for i:=0 to n_det do begin
      Form14.Series1. AddXY((i-n_det)*dt*1e3, V_det[i]*1e3);
      Form14.Series23.AddXY((i-n_det)*dt*1e3, I_det[i]);
      if g_det[i]<>0 then
      Form14.Series6. AddXY((i-n_det)*dt*1e3, 1/g_det[i]);
  end;
  Application.ProcessMessages;
end;

procedure RememberAndDraw_V_freq_Vav_deterministic;
begin
  Remember_V_freq_Vav_deterministic;
  Draw_V_freq_Vav_deterministic;
end;

procedure Remember_V_freq_Vav_noisy;
var  nt_ISI,i   :integer;
     u_av,s_av  :double;
begin
  { Reorder the array }
  ResortCircularArray;
  { Remember }
  nt_ISI:=trunc(ISI[0]/dt);
  n_no:=imin(iabsC,nt_ISI);
  Form14.Series2.Clear;
  Form14.Series20.Clear;
  Form14.Series22.Clear;
  u_av:=0; s_av:=0;
  for i:=0 to n_no do begin
      V_no[i]:=xCirc1[maxZZ-n_no+i];
      I_no[i]:=xCirc2[maxZZ-n_no+i];
      g_no[i]:=xCirc3[maxZZ-n_no+i];
      Form14.Series2. AddXY((i-n_no)*dt*1e3, V_no[i]*1e3);
      Form14.Series20.AddXY((i-n_no)*dt*1e3, 1/max(g_no[i],1e-8));
      u_av:=u_av+I_no[i]/(n_no+1);
      s_av:=s_av+g_no[i]/(n_no+1);
  end;
//  Form14.Series22.AddXY(u_av,s_av);
  for i:=0 to iabsC do begin
      V_no_hist[i]:=xCirc1[maxZZ-iabsC+i];
  end;
  n_no_hist:=iabsC;
  Application.ProcessMessages;
  freq_no:=1/ISI[0];
  Vav_no:=Vav_prev;
end;

function Convolution_Of(ZZC,X :vecZZ; nZZC,nX:integer; scale:double; Note:string) :double;
{ Calculates integral of X(t(nX)-t) ZZC(t) dt }
var  i,ie,j :integer;
     S,S1   :double;
begin
  { Integrate }
  ie:=imin(nX,round(nZZC/scale));
  S:=0;  S1:=0;
  for i:=0 to ie do begin
      if (Note<>'UnderThr') or
         ((V_det[nX-i]<-0.040{V})and(V_no[nX-i]<-0.040{V})) then begin
         j:=round(i*scale);
         S :=S  + X[nX-i]*ZZC[j]*dt;
         S1:=S1 +         ZZC[j]*dt;
      end;
  end;
  if Note='Normalized' then if S1<>0 then S:=S/S1 else S:=0;
  Convolution_Of:=S;
end;

function SecondKernel  (ZZC,X :vecZZ; nZZC,nX:integer; Note:string) :double;
{ Calculates double integral of X(t(nX)-t1) X(t(nX)-t2) Z(t1) Z(t2) dt1 dt2 }
var  i,j,ie     :integer;
     S,S1       :double;
begin
  { Integrate }
  ie:=imin(nX,nZZC);
  S:=0;  S1:=0;
  for i:=0 to ie do begin
      for j:=0 to ie do begin
        if (V_det[nX-i]<-0.040{V})and(V_no[nX-i]<-0.040{V}) then begin
          S :=S  + X[nX-i]*X[nX-j]*ZZC[i]*ZZC[j]*dt*dt;
          S1:=S1 +                 ZZC[i]*ZZC[j]*dt*dt;
        end;
      end;
  end;
  if Note='Normalized' then S:=S/S1;
  SecondKernel:=S;
end;

function Convolution_Of_V_With_Parabola:double;
{ Calculates integral of V(t)*P(x) dx,
  where P(t)=-k*(t-t1)*(x-t2),  k=...to be normalized }
var  i,nt_ISI                           :integer;
     S,S1,k,x,y,t0,t1,t2,t12,t22        :double;
begin
  { Extract V(t) from "xCirc1" }
  Remember_V_freq_Vav_deterministic;
  { Define intervals of integation }
  t0:=t-ISI[0];
  if NP0.HH_type='Calmar' then begin
     t1:=t0+0.002;  t2:=t-0.001;
  end else begin
     t1:=t0+0.0008; t2:=t-0.0008;
  end;
  { If ISI is too small ... }
  if   t2<t1+dt+1e-8 then
     if t>t0+dt+1e-8 then begin t1:=(t+t0)/2; t2:=t1+dt+1e-8; end else exit;
  { Calculate normalizing coefficient k }
  t22:=t2*t2; t12:=t1*t1;
  k:=1/(-(t22*t2-t12*t1)/3 + (t1+t2)*(t22-t12)/2 - t1*t2*(t2-t1));
  { Integrate }
  S:=0; S1:=0;
  for i:=0 to n_det do begin
      x:=i*dt+t0;
      if (x>=t1)and(x<=t2) then begin
         y:=-k*(x-t1)*(x-t2);
         S :=S  + V_det[i]*y*dt;
         S1:=S1 +          y*dt;
      end;
  end;
  Convolution_Of_V_With_Parabola:=S/S1;
end;

procedure CalculateConvolutions;
var w :double;
begin
//  if IIspike>=2 then begin
  w:=1;// /(IIspike-1);
  V_Conv:=V_Conv*(1-w)+w*Convolution_Of_V_With_Parabola;
  VxZ   :=   VxZ*(1-w)+w*Convolution_Of(Z_Unit,V_det, nZ_Unit,n_det,1,'Normalized');
  IxZ   :=   IxZ*(1-w)+w*Convolution_Of(Z_Unit,I_det, nZ_Unit,n_det,1,'Normalized');
//  end;
end;

procedure CalcDisturbancesOf_V;
var  i :integer;
begin
  { Disturbed V(t) }
  n_dstb:=imin(n_det,n_no);
  Form14.Series3.Clear;
  for i:=0 to n_dstb do begin
      V_dstb[i]:=V_no[n_no-n_dstb+i]-V_det[n_det-n_dstb+i];
//      Form14.Series3.AddXY((i-n_dstb)*dt*1e3, V_dstb[i]*1e3);
  end;
  Application.ProcessMessages;
  freq_dstb:=freq_no - freq_det;
  Vav_dstb := Vav_no -  Vav_det;
end;

{************************************************************************}

function CurrentByVoltageClamp(Vnew_,Vold_ :double):double;
var    DV,Im,INa,IK,Ipass        :double;
begin
      NV0.V:=Vold_;
      INa :=  Na_current;
      IK  :=   K_current;
      Ipass:=NP0.gL*(NV0.V-NP0.VL)*(1-NP0.IfBlockPass);
      Im:= -INa -IK -Ipass;
      DV:=(Vnew_-Vold_)/dt;
      CurrentByVoltageClamp:=NP0.C_membr*DV - Im;
end;

procedure PrepareVoltageClamp;
var i :integer;
    Isyn :double;
begin
  NV0.V:=NP0.Vrest;
  InitialConditionsHodgkin;
  for i:=1{imax(1,iabsC-2*n_no)} to n_no_hist-n_no do begin
      Isyn:=CurrentByVoltageClamp(V_no_hist[i],V_no_hist[i-1]);
  end;
//  for i:=1 to n_no do begin
//      Isyn:=CurrentByVoltageClamp(V_no[i],V_no[i-1]);
//  end;
{  mm[1]:=0.900882;
  hh[1]:=0.2208298;
  nn[1]:=0.57702568;}
end;

procedure CalcDisturbancesOf_InputCurrent(u,s :double);
var  i,id,io,j                            :integer;
     DV,gT_,gL_,I_mean,tau1,Vav_l       :double;
begin
  Form14.Series4 .Clear;
  Form14.Series5 .Clear;
  Form14.Series14.Clear;
  Form14.Series17.Clear;
  Form14.Series21.Clear;
  { *** Disturbed i(t) }
  for i:=0 to n_dstb-1 do begin
      id:=round(n_det/n_dstb*i);
      io:=round(n_no /n_dstb*i);
      gT_:=g_det[id];
      DV :=(V_dstb[i+1]-V_dstb[i])/dt;
      I_dstb[i] := NP0.C_membr*DV + (gT_+s)*V_dstb[i];
      if abs(V_det[id+1]-V_det[id])/dt > 20{mV/ms} then I_dstb[i]:=0;
  end;
  I_dstb[n_dstb]:=0;

  { *** Current By Voltage-Clamp }
  PrepareVoltageClamp;
  I_dstb[0]:=0;
  for i:=1 to n_no do begin
      {**********************************************************************}
      I_dstb[i] :=CurrentByVoltageClamp(V_no[i],V_no[i-1])+s*(V_no[i-1]-Vus)-u;
      {**********************************************************************}
      id:=round(n_det/n_no*i);
      if (id=n_no)or(abs(V_det[id+1]-V_det[id])/dt>20{mV/ms}) then I_dstb[i]:=0;
//      Form14.Series4. AddXY((i-n_no)*dt*1e3, I_dstb[i]);
  end;
  I_mean:=0;  j:=0;
  for i:=0 to n_no do {if V_no[i]<-0.04 then} begin
      j:=j+1;
      I_mean:=I_mean*(j-1)/j+I_dstb[i]/j;
  end;
  for i:=0 to n_no do begin
      I_dstb[i]:=I_dstb[i] - I_mean;
      Form14.Series4. AddXY((i-n_no)*dt*1e3, I_dstb[i]);
  end;

  { *** Exact noise-current }
  I_mean:=0; for i:=0 to n_no do I_mean:=I_mean+I_no[i]/(n_no+1);
  for i:=0 to n_no do begin
      I_no_mean[i]:=I_no[i];// - I_mean;
      Form14.Series5. AddXY((i-n_no)*dt*1e3, I_no_mean[i]);
  end;
  Form14.Series17.AddXY((0-n_no)*dt*1e3, I_no_mean[0]);
  { *** Current dispersion }
  DVav[0]:=0;
  Vav_l:=V_no[0];
  for i:=1 to n_no-1 do begin
      tau1:=0.001{s};
      Vav_l    :=Vav_l   + dt/tau1*(V_no[i]-Vav_l);
//      DV  :=sqr(V_dstb[i]);
      DV:=sqr(V_dstb[i]{V_no[i]-Vav_l});
      DV:=abs(min(0,V_dstb[i]-V_dstb[i-1]));
      DVav[i+1]:=DVav[i] + dt/tau1*(DV     -DVav[i]);
      Form14.Series14.AddXY((i-n_no)*dt*1e3, DVav[i+1]*1e3);
  end;
  Application.ProcessMessages;
end;

end.
