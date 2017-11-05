unit FC_control;

interface
uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Init,t_dtO,MathMyO,Unit1,Unit8,Unit9,Unit16,Noise,{Hodgkin,}HH_canal,
     FiringClamp,ControlNrn;

procedure IAHP_IKM_by_SpTrain(indicat:integer; F_FC,nu_H :double;
                                   var un_Adapt,sn_Adapt :double);
procedure Define_FC_Current(indicat:integer);
procedure ResetVoltageOnDescendingWayOfSpike(indicat :integer; var V :double);
procedure ArtificielSpikes;

implementation

var
     dw,dn,tau_AHP,tau_KM,w8,n8,
     wAP1,wAP2,nAP1,nAP2,
     ws,ns, w,n                                 :double;
     IfSurgery                                  :integer;

{ Form1.ComboBox1.ItemIndex:
  0- Adjust  u and s
  1- Adjust  u
  2- Adjust  s
  3- Add adaptation
  4- Nothing
  5- Extract adaptation
  6- Estimate lack of adapt
  7- FC for adapted nu(u,s)
  8- Add adapt. to freq_H
  9- Adaptation and FC
  10-Extract adapt. and FC
  11-Estimate adaptation
  12-Estimate ad., do FC
}

procedure IAHP_IKM_by_SpTrain(indicat:integer; F_FC,nu_H :double;
                                   var un_Adapt,sn_Adapt :double);
{ The equations of the AHP and KM currents:
IAHP=gAHP*w  *(V-VK),   dw/dt=(w8-w)/tau_AHP,   reset at spike:  w=w+dw*(1-w),
IKM =gKM *n^2*(V-VK),   dn/dt=(n8-n)/tau_KM,                     n=n+dn*(1-n).}
var
   e1,e2,e3,e4, tau_w,w_inf,
   wo,no                                        :double;
begin
  { Parameters & Initial conditions }
  if nt<=1 then begin
     { Parameters }
     tau_AHP:=400 /1000{s};
     tau_KM := 90 /1000{s};
     w8:=0.0444;
     n8:=0.00934;
     case Form1.ComboBox2.ItemIndex of
       0:   begin dw:=0.0177; dn:=0.175; end;    {Nothing}
       1:   begin dw:=0.012;  dn:=0.15;  end;    {Reset voltage}
       2,3: begin                                {Current-pulse reset}
              if abs(Form1.DDSpinEdit18.Value)>=20 then begin
                 dw:=0.012;  dn:=0.175;
              end else begin
                 dw:=0.011;  dn:=0.15;
              end;
            end;
     end;
     { Initial conditions }
     w:=w8; n:=n8; ws:=w8; ns:=n8;
     un_Adapt:=0; sn_Adapt:=0; u0_Adapt:=0; s0_Adapt:=0;
     { Approx. w and n at the first 2 spikes }
     wAP1:=w8+dw*(1-w8);  wAP2:=wAP1+dw*(1-wAP1);
     nAP1:=n8+dn*(1-n8);  nAP2:=nAP1+dn*(1-nAP1);
     { Drawing }
     Form16.Series5.Clear;
     Form16.Series6.Clear;
     Form16.Series7.Clear;
     Form16.Series8.Clear;
     Form16.Series9.Clear;
     Form16.Series10.Clear;
     Form16.Series11.Clear;
     Form16.Series12.Clear;
     exit;
  end;
  wo:=w; no:=n;
  { New step }
  w:=w+dt/tau_AHP*(w8-w);
  n:=n+dt/tau_KM *(n8-n);
  { Spike }
  if indicat=2 then begin
     w:=w+dw*(1-w);
     n:=n+dn*(1-n);
     { Steady-state solution }
     if nu_H=0 then exit;
     e3:=dexp(-1/nu_H/tau_AHP);
     e4:=dexp(-1/nu_H/tau_KM);
     if Form1.ComboBox1.ItemIndex in [6,11,12,3,5] then begin {6,11,12=Estimate, 3=Add adaptation }
        e3:=dexp(-1/F_FC/tau_AHP);
        e4:=dexp(-1/F_FC/tau_KM);
     end;
     ws:=(w8*(1-dw)*(1-e3)+dw)/(1-(1-dw)*e3);
     ns:=(n8*(1-dn)*(1-e4)+dn)/(1-(1-dn)*e4);
  end;
  { Increment to control parameters }
  u0_Adapt:=-NP0.gKM*(sqr(ns)-sqr(n8))*(NP0.VKM-NP0.VK);
  s0_Adapt:=-NP0.gKM*(sqr(ns)-sqr(n8)) - NP0.gAHP*(ws-w8);
  un_Adapt:= NP0.gKM*max(0,sqr(ns)-sqr(n))*(NP0.VKM-NP0.VK);
  sn_Adapt:= NP0.gKM*max(0,sqr(ns)-sqr(n)) + NP0.gAHP*max(0,(ws-w));
  {!}
//  n:=nM[1]; w:=wAHP[1]; // if (indicat=2)and(IIspike=2) then nAP1:=n;
  {!}
  if Form1.ComboBox1.ItemIndex in [5,10] then begin { Extract adaptation }
     un_Adapt := -NP0.gKM*(sqr(n)-sqr(n8))*(NP0.VKM-NP0.VK);
     sn_Adapt := -NP0.gKM*(sqr(n)-sqr(n8)) - NP0.gAHP*(w-w8);
  end;
  if Form1.ComboBox1.ItemIndex in [11,12]   then begin { Estimate adaptation }
     un_Adapt:= -NP0.gKM*(sqr(n)-sqr(nAP1))*(NP0.VKM-NP0.VK);
     sn_Adapt:= -NP0.gKM*(sqr(n)-sqr(nAP1)) - NP0.gAHP*(w-wAP1);
  end;
  { Drawing }
  if (trunc(nt/40)=nt/40) then begin
      Form16.Series5.AddXY(t*1000,NV0.nM);
      Form16.Series6.AddXY(t*1000,NV0.wAHP);
  end;
  if indicat=2 then begin
     Form16.Series7.AddXY(t*1000,no);
     Form16.Series7.AddXY(t*1000,n);
     Form16.Series8.AddXY(t*1000,wo);
     Form16.Series8.AddXY(t*1000,w);
     Form16.Series9.AddXY(t*1000,ns);
     Form16.Series10.AddXY(t*1000,ws);
     Application.ProcessMessages;
     Application.ProcessMessages;
  end;
end;

{*************************************************************************}
procedure Define_FC_Current(indicat:integer);
{*************************************************************************}
var  gL_,nu_H, du,ds, u0,s0,tau_FC,nu_now,max_ISI :double;
begin
  { Exit if the option is turned off }
  if Form1.ComboBox1.ItemIndex<0 then exit;
  if not((FC_freq>0)and(FC_dFdu<>0)) then exit;
  nu_now:=LimRev(ISI[0],1e-6);
  { *** Adaptation *****************************************************}
  IAHP_IKM_by_SpTrain(indicat,nu_now,FC_freq, un_Adapt,sn_Adapt);
  { *** Correction by linear F-I-curve **********************************}
  if nt<=1 then begin  du_FC:=0; ds_FC:=0;  end;   { Initial conditions }
  IF indicat=2 THEN BEGIN     { at spikes }
    u_Adapt_prev:=u_Adapt;
    s_Adapt_prev:=s_Adapt;
    if (IIspike<=1) then begin
//        { Initial conditions }   du_FC:=0;   ds_FC:=0;
    end else begin
        if NP0.IfSet_gL_or_tau=2 then  gL_:=NP0.C_membr/NP0.tau_m0  else  gL_:=NP0.gL;
        nu_H:=FC_freq;
        case Form1.ComboBox1.ItemIndex of
          7,9: nu_H:=nu_H - FC_dFdu*u_Adapt + FC_dFdu*FC_I0/gL_*s_Adapt;
        end;
        du:=(nu_H-nu_now)/FC_dFdu/2;
        ds:=-du/FC_I0*gL_;
        case Form1.ComboBox1.ItemIndex of
          0:                             {Adjust u and s};
          1,12: ds:=0;                   {Adjust u}
          2:    du:=0;                   {Adjust s}
          3..6,8,11: begin du:=0; ds:=0; end;
        end;
        if IfSurgery>0 then begin    { Recovery from surgery }
           {du:=0; ds:=0;} IfSurgery:=0;
        end;
        du_FC := du_FC + du;
        ds_FC := ds_FC + ds;
    end;
  END ELSE BEGIN                     { between the spikes }
    { Relaxation of F-I-curve correction:  tau_FC*du/dt=-u, tau_FC:=3/FC_freq. }
    tau_FC:=Form8.DDSpinEdit2.Value{10}/FC_freq;
    du_FC:=du_FC*(1-dt/tau_FC);
    ds_FC:=ds_FC*(1-dt/tau_FC);
    u_Adapt:=u_Adapt+{Sigmoid((t-tAP)}(dt*FC_freq/0.3)*(un_Adapt-u_Adapt);
    s_Adapt:=s_Adapt+{Sigmoid((t-tAP)}(dt*FC_freq/0.3)*(sn_Adapt-s_Adapt);
    { Urgent surgery }
    max_ISI:=Form1.DDSpinEdit16.Value/FC_freq;
    if (trunc((t-max(NV0.tAP,0))/max_ISI)>IfSurgery)and
       (Form1.ComboBox1.ItemIndex in [0,1,12]) then begin
        IfSurgery:=IfSurgery+1;
        du_FC := du_FC + Form1.DDSpinEdit17.Value/1e3;
        Form8.Series17.AddXY(t*1e3,FC_Ua*1000);
        Form1.Series2.AddXY(t*1e3,NV0.V*1e3);
    end;
  END;
  { *** Total correction ******************************************** }
  FC_Ua:=du_FC + u_Adapt*IfTrue(Form1.ComboBox1.ItemIndex in [5,3,8,9,10]); {5=Extract adaptation}
  FC_Sa:=ds_FC + s_Adapt*IfTrue(Form1.ComboBox1.ItemIndex in [5,3,8,9,10]);
  { Integrate the control signals between spikes }
  FC_Uint:=FC_Uint + dt/NP0.tau_m0*(FC_Ua+Current_Iind - FC_Uint);
  FC_Sint:=FC_Sint + dt/NP0.tau_m0*(FC_Sa              - FC_Sint);
  if indicat=2 then begin     { at spikes }
     FC_Uint_prev:=FC_Uint;   FC_Uint:=FC_Ua;
     FC_Sint_prev:=FC_Sint;   FC_Sint:=FC_Sa;
  end;
  { *** Drawing ***************************************************** }
  if (trunc(nt/40)=nt/40) then begin
      Form16.Series11.AddXY(t*1000,s_Adapt);
      Form16.Series12.AddXY(t*1000,-NP0.gKM*NV0.nM*NV0.nM - NP0.gAHP*NV0.wAHP);
  end;
  if indicat=3 then begin     { at spikes }
    { Clear }
    if (IIspike=1)then begin
        Form16.Series2.Clear;
        Form16.Series3.Clear;
        Form16.Series4.Clear;
        Form16.Series13.Clear;
    end;
    { Draw not-corrected trajectory }
    u0:=uu+Current_Iind-FC_Uint_prev;
    s0:=ss             -FC_Sint_prev;
    Form16.Series2.AddXY(u0*1000,s0);
    Form16.Series3.AddXY(u0*1000,s0);
    { Draw corrected trajectory }
    Form16.Series3.AddXY( uu*1000,ss);
    Form16.Series4.AddXY( uu*1000,ss);
    Form16.Series4.AddXY((uu-u_Adapt_prev)*1000,  ss-s_Adapt_prev);
    gE_gI_to_U_S(gE,gI, 0,0, u0,s0);
    Form16.Series13.AddXY(u0*1000,s0);
    Application.ProcessMessages;
    Application.ProcessMessages;
  end;
end;
{*************************************************************************}

var IfDesc :integer;
    Vp_D :double;

procedure ResetVoltageOnDescendingWayOfSpike(indicat :integer; var V :double);
begin
  if Form1.ComboBox2.ItemIndex=0 then exit;
  if indicat=2 then begin      { Start of descending way }
     IfDesc:=1;
     Vp_D:=V;
  end;
  if IfDesc=1 then begin       { On descending way }
//     if V<=Vp_D then begin     { if it has not finished }
        Vp_D:=V;
        if V<Form1.DDSpinEdit21.Value/1e3 {-15mV} then begin    { Reset }
           { Reset by voltage-clamp }
           if Form1.ComboBox2.ItemIndex=1 then begin
              V:=-0.060{mV};
              IfDesc:=0;       { Turn off the resetting }
           end;
           { Current pulse }
           if Form1.ComboBox2.ItemIndex=2 then begin
              if V>Form1.DDSpinEdit19.Value/1e3 {-70mV} then begin
                 du_Reset:=Form1.DDSpinEdit18.Value/1e3 {mA/cm^2};
              end else begin
                 du_Reset:=0;
                 IfDesc:=0;    { Turn off the resetting }
              end;
           end;
        end;
//     end else IfDesc:=0;
  end;
end;

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

{*************************************************************************}

end.
