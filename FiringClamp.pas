unit FiringClamp;

interface
uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     MyTypes,Init,typeNrnParsO,MathMyO,AMRandom;

procedure Read_f_g_From_File;
procedure Find_u_s_from_2Plots(f0,g0 :double; var u,s :double);
procedure Draw_fm;
procedure Draw_gm;
procedure ReadAndDraw_fm_gm;
procedure CheckFiringClamp;
procedure AnalyzeByFiringClamp(var n:integer; var F,G,H,U,S,T_FC,Ua_FC,Sa_FC :vecFC;
                                              var Tg_FC,gE_FC,gI_FC   :vecFC);
procedure U_S_to_gE_gI(u,s, Ua,Sa :double; var gE,gI :double);
procedure gE_gI_to_U_S(gE,gI, Ua,Sa :double; var u,s :double);

implementation
uses Unit1,Unit8,Unit9,Unit14,Unit16,Graph,Thread_FC;

var
        xm,ym,fm,gm,fm_gEI,gm_gEI,hm            :matr_200x200;
        delta_x,delta_y,delta_gE,delta_gI,
        xm_min,ym_min                           :double;
        ie,je                                   :integer;


{************************************************************}
procedure U_S_to_gE_gI(u,s, Ua,Sa :double; var gE,gI :double);
begin
  gE:=(u-Ua)/(-Vus);
  gI:=(u-Ua)/Vus+(s-Sa);
end;

procedure gE_gI_to_U_S(gE,gI, Ua,Sa :double; var u,s :double);
begin
  u:=gE*(-Vus)+Ua;
  s:=gE+gI+Sa;
end;
{************************************************************}

procedure f_g_From_x_y(x,y :double; var f,g :double);
var
    i,j                                       :longint;
    ix,jy,x0,y0,dx,dy,S,S00,S10,S01,S11       :double;
begin
  i:=trunc_my((x-xm_min)/delta_x);
  j:=trunc_my((y-ym_min)/delta_y);
  if (i<0)or(i>=ie)or(j<0)or(j>=je) then begin
     f:=0; g:=0;
     exit;
  end;
  x0:=delta_x*i+xm_min;
  y0:=delta_y*j+ym_min;
  dx:=x0+delta_x - x;
  dy:=y0+delta_y - y;
  S:=delta_x*delta_y;
  S00:=dx*dy;  S10:=(x-x0)*dy;  S01:=dx*(y-y0);  S11:=(x-x0)*(y-y0);
  f:=(fm[i,j]*S00 + fm[i+1,j]*S10 + fm[i,j+1]*S01 + fm[i+1,j+1]*S11)/S;
  g:=(gm[i,j]*S00 + gm[i+1,j]*S10 + gm[i,j+1]*S01 + gm[i+1,j+1]*S11)/S;
end;

procedure h_From_x_y(x,y :double; var h :double);
var
    i,j                                       :longint;
    ix,jy,x0,y0,dx,dy,S,S00,S10,S01,S11       :double;
begin
  i:=trunc_my((x-xm_min)/delta_x);
  j:=trunc_my((y-ym_min)/delta_y);
  if (i<0)or(i>=ie)or(j<0)or(j>=je) then begin  h:=0; exit;  end;
  x0:=delta_x*i+xm_min;
  y0:=delta_y*j+ym_min;
  dx:=x0+delta_x - x;
  dy:=y0+delta_y - y;
  S:=delta_x*delta_y;
  S00:=dx*dy;  S10:=(x-x0)*dy;  S01:=dx*(y-y0);  S11:=(x-x0)*(y-y0);
  h:=(hm[i,j]*S00 + hm[i+1,j]*S10 + hm[i,j+1]*S01 + hm[i+1,j+1]*S11)/S;
end;

procedure ChangeZerosOf_gm;
var i,j,i_nonzero :integer;
begin
  for j:=0 to je do begin
      i:=-1;
      repeat i:=i+1;
      until (gm[i,j]<>0)or(i=ie);
      i_nonzero:=i;
      for i:=0 to i_nonzero do  gm[i,j]:=gm[i_nonzero,j];
  end;
end;

procedure LinearizeFG;
var f0,g0,dfdi,dfdj,dgdi,dgdj   :double;
    i,j,i1,i2,j1,j2             :integer;
begin
  i1:=trunc(ie/3); i2:=i1*2;
  j1:=trunc(je/3); j2:=j1*2;
  f0:=fm[i1,j1];
  dfdi:=(fm[i2,j1]-f0)/(i2-i1);
  dfdj:=(fm[i1,j2]-f0)/(j2-j1);
  g0:=gm[i1,j1];
  dgdi:=(gm[i2,j1]-g0)/(i2-i1);
  dgdj:=(gm[i1,j2]-g0)/(j2-j1);
  for j:=0 to je do begin
      for i:=0 to ie do begin
          fm[i,j]:=f0+dfdi*(i-i1)+dfdj*(j-j1);
          gm[i,j]:=g0+dgdi*(i-i1)+dgdj*(j-j1);
      end;
  end;
  { Writing }
  assign(vvv,'v(u_s)_Linear.dat'); rewrite(vvv);
  writeln(vvv,'ZONE T="ZONE1"');
  writeln(vvv,'I=', ie+1:3,' ,J=',je+1:3,' ,K=1,F=POINT');
  for j:=0 to je do begin
      for i:=0 to ie do begin
          write  (vvv,xm[i,j]*1000:7:3,' ',ym[i,j]:9:5,' ');
          writeln(vvv,fm[i,j]*1000:9:5,' ',gm[i,j]*1000:9:5);
      end;
  end;
  close(vvv);
end;

procedure Read_f_g_From_File;
var  i,j                                        :integer;
     dum4,dum5,dum6,dum7,dum8,dum9,dum10,dum11,
     dum_x,dum_y,dum12,dum13,dum14,dum15,dum16  :double;
     t1,t2,t3,t4,t5,t6,t7,t8                    :char;
begin
  { Read functions f,g from file }
  if File_u_s='' then  File_u_s:='v(u_s).dat';
  assign(vvv,File_u_s); reset(vvv);
  readln(vvv);
  readln(vvv, t2,t3, ie, t4,t5,t6,t7,t8, je);
  ie:=ie-1;
  je:=je-1;
  FOR j:=0 to je DO BEGIN
      FOR i:=0 to ie DO BEGIN
          read  (vvv,xm[i,j],ym[i,j],fm[i,j],dum4,dum5,dum6,dum7,dum8);
          read  (vvv,dum9,dum10,dum11,dum12,dum13,dum14,dum15);
          if not(eoln(vvv)) then readln(vvv,dum16) else readln(vvv);
          xm[i,j]:=xm[i,j]/1000;
//          if fm[i,j]<5 then fm[i,j]:=0;
          case Form1.RadioGroup3.ItemIndex of
               1: fm[i,j]:=dum12/1e3;{VxZ}
               2: fm[i,j]:=dum14/1e3;{width of AP}
               3: fm[i,j]:=dum10/1e3;{minimum}
               4: fm[i,j]:=(dum4-dum10)/1e3;{Vmax-Vmin}
               5: fm[i,j]:=dum15/1e3;{VT_1ms}
               6: fm[i,j]:=dum16/1e3;{Th}
          end;
          case Form1.RadioGroup2.ItemIndex of
               1: gm[i,j]:=dum6 /1e3;{average voltage}
               2: gm[i,j]:=dum10/1e3;{minimum}
               3: gm[i,j]:=dum4 /1e3;{maximum}
               4: gm[i,j]:=dum11/1e3;{Convolution}
               5: gm[i,j]:=dum12;    {VxZ}
               6: gm[i,j]:=dum13;    {IxZ}
          else
                  gm[i,j]:=dum7; {slope}
          end;
          hm[i,j]:=dum10/1e3; {memorise Vmin to treat unsteadiness}
      END;
  END;
  delta_x:=xm[1,0]-xm[0,0];//dum_x/ie/1000;
  delta_y:=ym[0,1]-ym[0,0];//dum_y/je;
  xm_min:=xm[0,0];
  ym_min:=ym[0,0];
  close(vvv);
  ChangeZerosOf_gm;
  if Form1.Button10.Caption ='Undo linear F,G' then LinearizeFG;
end;

procedure Find_u_s_from_2Plots(f0,g0 :double; var u,s :double);
{ ********************************************************************
  Calculates (u,s) from frequency "freq" and dV/dt.
**********************************************************************}
var j,i,iter
                                                        :integer;
    fi,gi, xi,yi, dx,dy,
    fi_dx,gi_dx, fi_dy,gi_dy, xn,yn, coe
                                                        :double;
    A                   :matr_2x2;
    B,dXi               :vect_2;
label bad;

BEGIN
  { Solve the system    f(x,y)=f0
                        g(x,y)=g0
    by Newton's method
    X(n)=X(n-1) + (dF/dX)^(-1) * (F0-F(X(n-1)))         }
  xi:=u;         yi:=s;
  iter:=0;
  repeat  iter:=iter+1;
    dx:=delta_x*1e-3;  dy:=delta_y*1e-3;    //dx:=0.100*1e-3;  dy:=1e-3;
    f_g_From_x_y(xi,yi, fi,gi);
    f_g_From_x_y(xi+dx,yi, fi_dx,gi_dx);
    f_g_From_x_y(xi,yi+dy, fi_dy,gi_dy);
    A[1,1]:=(fi_dx-fi)/dx;
    A[1,2]:=(fi_dy-fi)/dy;
    A[2,1]:=(gi_dx-gi)/dx;
    A[2,2]:=(gi_dy-gi)/dy;
    B[1]:=f0-fi;
    B[2]:=g0-gi;
    LinearSistem_2x2(A,B, dXi);
    if (dXi[1]=-13) and (dXi[2]=-13) then goto bad;
    B[1]:=B[1]-A[1,1]*dXi[1]-A[1,2]*dXi[2];
    B[2]:=B[2]-A[2,1]*dXi[1]-A[2,2]*dXi[2];
    xn:=xi+0.5*dXi[1];
    yn:=yi+0.5*dXi[2];
    { Check if the point is in the firing region }
    xn:=max(xn,xm_min);  xn:=min(xn,delta_x*ie+xm_min);
    yn:=max(yn,ym_min);  yn:=min(yn,delta_y*je+ym_min);
    f_g_From_x_y(xn,yn, fi,gi);
    if fi=0{<10} then begin
       xn:=xi+0.001*dXi[1];
       yn:=yi+0.001*dXi[2];
    end;
    xi:=xn;  yi:=yn;
    if Form8.CheckBox3.Checked then begin
       Form8.Series26.AddXY(xi*1e3,yi);
       Application.ProcessMessages;
    end;
    f_g_From_x_y(xi,yi, fi,gi);
    if IfActive1 then AnalyzeByFiringClamp_In_Thread    .Synchronize;
    if IfActive2 then AnalyzeSetsByFiringClamp_In_Thread.Synchronize;
    if Form1.RadioGroup3.ItemIndex=0 then coe:=10 else coe:=1;
  until ((sqr((f0-fi)/f0)+sqr((g0-gi)/g0*coe))<1e-8)or(fi=0{<10})or(iter>200);
  if (fi=0{<10})or(iter>200) then begin
      bad:  xn:=u; yn:=s;
  end else
  Form8.Series26.Clear;
  u:=xn;         s:=yn;
END;

procedure Transform_fm_gm_from_u_s_to_gE_gI(Ia,Sa :double);
var i,j                 :integer;
    gE1,gI1,u1,s1       :double;
begin
  { Calculate mesh-functions 'fm_gEI', 'gm_gEI' for (gE,gI)-plane }
  U_S_to_gE_gI(delta_x,delta_y, Ia,Sa, delta_gE,delta_gI);
  for i:=0 to ie do begin
      for j:=0 to je do begin
          gE1:=i*delta_gE;
          gI1:=j*delta_gI;
          gE_gI_to_U_S(gE1,gI1, Ia,Sa, u1,s1);
          f_g_From_x_y(u1,s1, fm_gEI[i,j],gm_gEI[i,j]);
      end;
  end;
end;

procedure Draw_fm;
begin
  Form16.Draw_f_in_Chart(fm,ie,je,delta_x*1000,delta_y, xm_min*1000,ym_min);
end;

procedure Draw_gm;
begin
  Form16.Draw_f_in_Chart(gm,ie,je,delta_x*1000,delta_y, xm_min*1000,ym_min);
end;

procedure ReadAndDraw_fm_gm;
begin
  Read_f_g_From_File;
  Draw_fm;
  Form8. Draw_f_in_Chart(fm,ie,je,delta_x*1000,delta_y, xm_min*1000,ym_min);
  Form8. Draw_g_in_Chart(gm,ie,je,delta_x*1000,delta_y, xm_min*1000,ym_min);
  Transform_fm_gm_from_u_s_to_gE_gI(0,0);
//  Draw_Square(fm_gEI,ie,je, 20,400);
//  Draw_Square(gm_gEI,ie,je,220,400);
end;

procedure CorrectionToUnsteadiness(f0,g0,h0 :double; var u0,s0 :double);
var u1,s1,Vmin_st,dT_,gL_,dfreq_,dVav_ :double;
begin
  h_From_x_y(u0,s0, Vmin_st);
  gL_:=NP0.C_membr/NP0.tau_m0;
  dT_:=NP0.C_membr*(h0-Vmin_st)/(-gL_*(h0-NP0.Vrest)-s0*(h0-Vus)+u0);
  dfreq_:=f0*f0*dT_;
  dVav_ :=h0*f0*dT_;
  u1:=u0;  s1:=s0;
  {*********************************************}
  Find_u_s_from_2Plots(f0+dfreq_,g0+dVav_,u1,s1);
  {*********************************************}
  if abs(u1-25/1000)>1e-6 then begin  u0:=u1; s0:=s1;  end;
end;

{*************************************************************************}
procedure InitialValues(var xmc,ymc :double);
{ Find mass-centre of the "tongue" }
var  i,j,n      :integer;
     x1,y1      :double;
begin
  xmc:=0;
  ymc:=0;
  n:=0;
  FOR j:=0 to je DO BEGIN
      y1:=j*delta_y+ym_min;
      FOR i:=0 to ie DO BEGIN
          x1:=i*delta_x+xm_min;
          if (fm[i,j]<>0)and(x1>0)and(y1>0) then begin
             n:=n+1;
             xmc:=xmc*(n-1)/n + x1/n;
             ymc:=ymc*(n-1)/n + y1/n;
          end;
      END;
  END;
end;

{***********************************************************************}
procedure CheckFiringClamp;
var
    i,Nfi                                       :integer;
    R,fi                                        :double;
    uC,sC,fC,gC,hC,tC,dIC,dsC, TgC,gEC,gIC      :vecFC;
begin
  { Reading and drawing }
   ReadAndDraw_fm_gm;

  { Set trajectory-circle on the plot (u,s) }
  R:=0.5;
  Nfi:=20;
  for i:=1 to Nfi do begin
      fi:=pi/2/(Nfi-1)*(i-1);
      uC[i]:=R*cos(fi)*0.100;
      sC[i]:=R*sin(fi)*1.5;
  end;

  { Calculate (f,g) corresponding to trajectory (u,s) }
  for i:=1 to Nfi do begin
      f_g_From_x_y(uC[i],sC[i], fC[i],gC[i]);
      h_From_x_y(uC[i],sC[i], hC[i]);
      tC[i]:=0;
      dIC[i]:=0;
      dsC[i]:=0;
  end;

  { *** Analyze *** }
  AnalyzeByFiringClamp(Nfi, fC,gC,hC,uC,sC,tC,dIC,dsC, TgC,gEC,gIC);
  { *************** }
end;

{***********************************************************************}
procedure AnalyzeByFiringClamp(var n:integer; var F,G,H,U,S,T_FC,Ua_FC,Sa_FC :vecFC;
                                              var Tg_FC,gE_FC,gI_FC   :vecFC);
var
    x1,y1,i,j,NgoodPts                  :integer;
    u1,s1,gE1,gI1,u_start,s_start       :double;
    F_ex,G_ex                           :vecFC;
begin
  { Reading and drawing }
  ReadAndDraw_fm_gm;

  { Draw exact trajectory on the plot (u,s) }
  for i:=1 to n do begin
      Form8.Series18.AddXY(U[i]*1000,S[i]);
      Form8.Series21.AddXY(U[i]*1000,S[i]);
  end;
  Application.ProcessMessages;

  { Calculate (f,g) corresponding to trajectory (u,s) }
  for i:=1 to n do begin
      f_g_From_x_y(U[i],S[i], F_ex[i],G_ex[i]);
//      Form8.Series7.AddXY(T_FC[i]*1e3,F[i]);
//      Form8.Series8.AddXY(T_FC[i]*1e3,G[i]*1e3);
  end;

  { Reverse problem - find (u,s) from (f,g) }
  NgoodPts:=0;
  InitialValues(u_start,s_start); //  u1:=25/1000;  s1:=0.2;
  Form8.Series20.AddXY(u_start*1000,s_start);
  Form8.Series23.AddXY(u_start*1000,s_start);
  for i:=1 to n do begin
      u1:=u_start;  s1:=s_start;
      {************************************}
      Find_u_s_from_2Plots(F[i],G[i],u1,s1);
      {************************************}
      Form8.Series19.AddXY(u1*1000,s1);
      Form8.Series22.AddXY(u1*1000,s1);
      { if success ... }
      if abs(u1-u_start)>1e-6 then begin
         { (u,s) to (gE,gI) }
         U_S_to_gE_gI(u1,s1, Ua_FC[i],Sa_FC[i], gE1,gI1);
         Form8.Series3.AddXY(T_FC[i]*1e3,gE1);
         Form8.Series4.AddXY(T_FC[i]*1e3,gI1);
         {********** Correction to unsteadiness *****}
         if Form8.CheckBox2.Checked then begin
            CorrectionToUnsteadiness(F[i],G[i],H[i],u1,s1);
            U_S_to_gE_gI(u1,s1, Ua_FC[i],Sa_FC[i], gE1,gI1);
            Form8.Series9 .AddXY(T_FC[i]*1e3,gE1);
            Form8.Series10.AddXY(T_FC[i]*1e3,gI1);
         end;
         {********** WienerKernel *******************}
         if Form8.CheckBox1.Checked then begin
            CorrectByWienerKernel(T_FC[i]-1/F[i],T_FC[i],u1,s1);
            U_S_to_gE_gI(u1,s1, Ua_FC[i],Sa_FC[i], gE1,gI1);
            Form8.Series5.AddXY(T_FC[i]*1e3,gE1);
            Form8.Series6.AddXY(T_FC[i]*1e3,gI1);
         end;
         {*******************************************}
         if NgoodPts<MaxVC then  NgoodPts:=NgoodPts+1;
         Tg_FC[NgoodPts]:=T_FC[i];
         gE_FC[NgoodPts]:=gE1;
         gI_FC[NgoodPts]:=gI1;
         { Rewrite measurements }
         F[NgoodPts]:=F[i];
         G[NgoodPts]:=G[i];
         U[NgoodPts]:=U[i];
         S[NgoodPts]:=S[i];
         T_FC[NgoodPts]:=T_FC[i];
         Ua_FC[NgoodPts]:=Ua_FC[i];
         Sa_FC[NgoodPts]:=Sa_FC[i];
      end;
      Application.ProcessMessages;
      if Form8.CheckBox3.Checked then begin StopKey:='P';  Pause; end;
  end;
  n:=NgoodPts;
end;

end.
