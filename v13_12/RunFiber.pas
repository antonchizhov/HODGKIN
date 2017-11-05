unit RunFiber;

interface
uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
     Dialogs, StdCtrls, DDSpinEdit,
     t_dtO,MyTypes,FiberO,typeNrnParsO,Unit1,Unit12,Unit20,math,MathMyO,Clamp,
     Init,Other,CreateNrnO;

type
  TSpace=record
    N                                 :integer;
    L,Gs_R,diam,ri,RL,lamda
                                      :double;
  end;

var  Space                            :TSpace;
     AFiber                           :TFiber;


procedure PreliminaryProceduresOfOneCompartmentalModel;
procedure PreliminaryProceduresOfDistributedNeuron;
procedure VisualizeMaxConductances;
procedure VoltageOrCurrentClamp_ActiveFiber;

implementation

var
    ri_S,wNa,wK,t,
    Iind_Left,Iind_Right,alpha_Hz,
    Ampl_gE,Ampl_gI,mean_gE,mean_gI,tau_Noise,gE,gI
                                                        :double;
    iz_Draw                                             :integer;


function AlphaF(t :double) :double;
begin
  AlphaF:=alpha_Hz*t*exp(1-alpha_Hz*t)
end;

procedure gE_gI_to_U_S(gE,gI, Ua,Sa :double; var u,s :double);
begin
  u:=gE*(-Vus)+Ua;
  s:=gE+gI+Sa;
end;

procedure SynConductancesOnNewStep(var uu,ss :double);
var xE,xI :double;
begin
  xE:=Ampl_gE*randG(0,1);
  xI:=Ampl_gI*randG(0,1);
  if tau_Noise=0 then begin
     gE:= sgn(mean_gE)*min(abs(mean_gE + xE),10*abs(Ampl_gE));
     gI:= sgn(mean_gI)*min(abs(mean_gI + xI),10*abs(Ampl_gI));
  end else begin
     gE:=gE + (mean_gE-gE)/tau_Noise*dt + xE*sqrt(2*dt/tau_Noise);
     gI:=gI + (mean_gI-gI)/tau_Noise*dt + xI*sqrt(2*dt/tau_Noise);
     gE:= sgn(mean_gE)*max(abs(gE),0);
     gI:= sgn(mean_gI)*max(abs(gI),0);
  end;
  gE_gI_to_U_S(gE,gI, 0,0, uu,ss);
end;

procedure DisbalanceOf_Na_K_and_Adapt_channels;
var i :integer;
begin
  wNa:=Form20.DDSpinEdit3.Value; //w is from [0,1] so that we have 1-w at left and 1+w at right
  wK :=Form20.DDSpinEdit7.Value; //w is from [0,1] so that we have 1-w at left and 1+w at right
  for i:=0 to Space.N do begin
      { Sodium }
      if Form20.CheckBox2.Checked then begin  //homogeneous distribution
         if wNa=0 then AFiber.Nrn[0].NP.gNa:=0 else
         if i>0   then AFiber.Nrn[i].NP.gNa:=AFiber.Nrn[i].NP.gNa*wNa;
      end else begin
          if wNa<=1 then begin               //linear distribution with mean=1
             AFiber.Nrn[i].NP.gNa:=AFiber.Nrn[i].NP.gNa*(1-wNa+i/Space.N*2*wNa);
          end else begin                     //quadratic distribution
             AFiber.Nrn[i].NP.gNa:=AFiber.Nrn[i].NP.gNa*(1/wNa+wNa*sqr(i/Space.N));
          end;
      end;
      { Potassium }
      if Form20.CheckBox2.Checked then begin  //homogeneous distribution
         if wK=0 then AFiber.Nrn[0].NP.gK:=0 else
         if i>0  then AFiber.Nrn[i].NP.gK :=AFiber.Nrn[i].NP.gK *wK;
         if i>0  then AFiber.Nrn[i].NP.gKM:=AFiber.Nrn[i].NP.gKM*wK;
         if i>0  then AFiber.Nrn[i].NP.gKA:=AFiber.Nrn[i].NP.gKA*wK;
         if i>0  then AFiber.Nrn[i].NP.gKD:=AFiber.Nrn[i].NP.gKD*wK;
      end else begin
         if wK<=1 then begin                 //linear distribution with mean=1
            AFiber.Nrn[i].NP.gK :=AFiber.Nrn[i].NP.gK *(1-wK+i/Space.N*2*wK);
            AFiber.Nrn[i].NP.gKM:=AFiber.Nrn[i].NP.gKM*(1-wK+i/Space.N*2*wK);
            AFiber.Nrn[i].NP.gKA:=AFiber.Nrn[i].NP.gKA*(1-wK+i/Space.N*2*wK);
            AFiber.Nrn[i].NP.gKD:=AFiber.Nrn[i].NP.gKD*(1-wK+i/Space.N*2*wK);
         end else begin                      //quadratic distribution
            AFiber.Nrn[i].NP.gK :=AFiber.Nrn[i].NP.gK *(1/wK+wK*sqr(i/Space.N));
            AFiber.Nrn[i].NP.gKM:=AFiber.Nrn[i].NP.gKM*(1/wK+wK*sqr(i/Space.N));
            AFiber.Nrn[i].NP.gKA:=AFiber.Nrn[i].NP.gKA*(1/wK+wK*sqr(i/Space.N));
            AFiber.Nrn[i].NP.gKD:=AFiber.Nrn[i].NP.gKD*(1/wK+wK*sqr(i/Space.N));
         end;
      end;
      if Form20.CheckBox5.Checked then begin  //Right half of axon is passive
         if i>Space.N/2 then AFiber.Nrn[i].NP.gNa:=0;
         if i>Space.N/2 then AFiber.Nrn[i].NP.gK :=0;
         if i>Space.N/2 then AFiber.Nrn[i].NP.gKM:=0;
         if i>Space.N/2 then AFiber.Nrn[i].NP.gKA:=0;
         if i>Space.N/2 then AFiber.Nrn[i].NP.gKD:=0;
      end;
      { Adaptation }
      if (Form20.CheckBox1.Checked)and(i>0) then begin
         AFiber.Nrn[i].NP.gAHP:=0;
         AFiber.Nrn[i].NP.gKM:=0;
      end;
      { Sodium activation and inactivation curve shift }
      case Form20.ComboBox1.ItemIndex of
      0: begin //linear: gNa-decrease; gNaR-increase
           AFiber.Nrn[i].NP.gNaR:=   i/Space.N *AFiber.Nrn[Space.N].NP.gNaR;
           AFiber.Nrn[i].NP.gNa :=(1-i/Space.N)*AFiber.Nrn[0].NP.gNa;
           AFiber.Nrn[i].NP.NaThreshShift:=AFiber.Nrn[0].NP.NaThreshShift;
         end;
      1: begin //NaThreshShift is linear
           AFiber.Nrn[i].NP.NaThreshShift:=(1-i/Space.N)
                                          *AFiber.Nrn[0].NP.NaThreshShift;
         end;
      2: begin //homogeneous
         end;
      3: begin //Na-soma, NaR-right half of axon
           if i<Space.N/2 then AFiber.Nrn[i].NP.gNaR:=0;
           if i>0 then AFiber.Nrn[i].NP.gNa:=0;
         end;
      4: begin //fiber is passive
           if i>0 then begin
              AFiber.Nrn[i].NP.gNaR:=0;
              AFiber.Nrn[i].NP.gNa:=0;
              AFiber.Nrn[i].NP.gK :=0;
              AFiber.Nrn[i].NP.gKM:=0;
              AFiber.Nrn[i].NP.gKA:=0;
              AFiber.Nrn[i].NP.gKD:=0;
              AFiber.Nrn[i].NP.gH :=0;
              AFiber.Nrn[i].NP.gADP:=0;
              AFiber.Nrn[i].NP.gAHP:=0;
           end;
         end;
      5: begin // AHP and KM grows up to z=L
           AFiber.Nrn[i].NP.gAHP :=AFiber.Nrn[i].NP.gAHP*i/Space.N*AFiber.Nrn[Space.N].NP.gAHP;
           AFiber.Nrn[i].NP.gKM  :=AFiber.Nrn[i].NP.gKM *i/Space.N*AFiber.Nrn[Space.N].NP.gKM;
         end;
      end;
  end;
end;

procedure PreliminaryProceduresOfOneCompartmentalModel;
begin
  { Parameters special for Smpl }
  Read_Params_from_File_or_Procedure;
  { Exp. data }
  if (Smpl=0)or(SmplFile[Smpl]='NoFile')
             then DontReadExpData
             else     ReadExpData;
  InitialConditions;
  CreateNeuronByTypeO(NP0,ANrn);
  ANrn.InitialConditions;   NP0:=ANrn.NP;
  CorrespondParametersToTheForm;
end;

procedure PreliminaryProceduresOfDistributedNeuron;
var    IfVoltageClamp :integer;
begin
  NP0.HH_order:='1-point';
//  Initiate_NP_ForFiber_O(NP0.HH_type,'1-point',NP0);
  Space.L    :=Form20.DDSpinEdit5.Value/1e4;  {cm}
  Space.N:=trunc(Form20.DDSpinEdit19.Value);//50;
//  Space.Gs_R :=Form20.DDSpinEdit17.Value;
  Space.RL:=Form20.DDSpinEdit17.Value/1000; {kOhm*cm}   // intracellular resistivity
//  Space.lamda:=Form20.DDSpinEdit4.Value/1e4; //0.02; {cm}
//  Space.diam:=sqr(Space.lamda)*4*(NP0.C_membr/NP0.tau_m0)*Space.RL;  {cm}
  Space.diam:=Form20.DDSpinEdit4.Value/1e4; {cm}
  Space.lamda:=sqrt(Space.diam/4/(NP0.C_membr/NP0.tau_m0)/Space.RL);  {cm}
  Space.ri:=Space.RL/(pi*sqr(Space.diam)/4); {kOhm/cm}  // intracell. resistance per unit length
  Space.Gs_R:=Space.ri*Space.lamda*(NP0.C_membr/NP0.tau_m0)*NP0.Square;     //0.3
  ri_S:=Space.Gs_R/Space.lamda/(NP0.C_membr/NP0.tau_m0);      {cm/mS}
  Iind_Left :=Form20.DDSpinEdit1.Value/1e9; //R_Ip/lamda/ri;       {mA}
  Iind_Right:=Form20.DDSpinEdit2.Value/1e9; //R_Ip/lamda/ri;       {mA}
  alpha_Hz  :=Form20.DDSpinEdit6.Value;//alpha/NP_.tau_m;                   {Hz}
  tau_Noise :=Form20.DDSpinEdit8.Value/1000; {s}
  Ampl_gE   :=Form20.DDSpinEdit9.Value;  {mS/cm^2}
  Ampl_gI   :=Form20.DDSpinEdit10.Value; {mS/cm^2}
  mean_gE   :=Form20.DDSpinEdit11.Value; {mS/cm^2}
  mean_gI   :=Form20.DDSpinEdit12.Value; {mS/cm^2}
  iz_Draw   :=trunc(Form20.DDSpinEdit13.Value*Space.N);
  if NP0.If_I_V_or_g in [1,3,4,5] then IfVoltageClamp:=1 else IfVoltageClamp:=0;
  CreateFiberBy_NP_O('Axon', Space.N,IfVoltageClamp,
           dt,Space.L,NP0.Vrest,Space.lamda,Space.RL,
           NP0, AFiber);
  { Disbalance of channel distribution }
  DisbalanceOf_Na_K_and_Adapt_channels;
end;

procedure VisualizeMaxConductances;
var i :integer;
begin
  { Re-initialize parameters }
  PreliminaryProceduresOfOneCompartmentalModel;
  PreliminaryProceduresOfDistributedNeuron;
  { Clean }
  Form12.Series2.Clear;
  Form12.Series10.Clear;
  Form12.Series3.Clear;
  Form12.Series4.Clear;
  Form12.Series9.Clear;
  { Draw }
  for i:=0 to Space.N do begin
      Form12.Series2.AddXY(i,AFiber.Nrn[i].NP.gNa);
      Form12.Series10.AddXY(i,AFiber.Nrn[i].NP.gNaR);
      Form12.Series3.AddXY(i,AFiber.Nrn[i].NP.gK);
      Form12.Series4.AddXY(i,AFiber.Nrn[i].NP.gKM);
      Form12.Series9.AddXY(i,AFiber.Nrn[i].NP.gAHP);
  end;
  { Labels }
  Form12.Label1.Caption:='lamda='+IntToStr(round(Space.lamda*1e4))+' mum';
  Form12.Label2.Caption:='Gs_R='+FloatToStr(Space.Gs_R);
  Form12.Label3.Caption:='ri='+IntToStr(round(Space.ri))+' kOhm/cm';
  Form12.Shape1.Visible:=(NP0.Square<>0);
  Application.ProcessMessages;
end;

{******************************************************************************}

{******************************************}
procedure VoltageOrCurrentClamp_ActiveFiber;
{******************************************}
var
    i                              :integer;
    tt_,u_soma_,s_soma_,Iind_      :double;
begin
  PreliminaryProceduresOfOneCompartmentalModel;
  PreliminaryProceduresOfDistributedNeuron;
  if WriteOrNot=1 then InitiateWriting;
  { Set initial conditions to variables }
  AFiber.InitialConditions;
  nt:=0;
  REPEAT  nt:=nt+1;  { time step }
    t:=nt*dt;
    { Distribute stimulation }
    for i:=0 to Space.N do begin
        AFiber.uu[i]:=0; AFiber.ss[i]:=0; AFiber.Iind_mA[i]:=0;
    end;
    { Stimulation at soma and axon }
    case Form20.ComboBox2.ItemIndex of
    0: begin { stimulation at soma from 1-comp. model }
         if NP0.Square>0 then
         DefineStimulation(NP0,AFiber.uu[0],AFiber.ss[0],u_soma_,s_soma_,
                               tt_,Iind_,AFiber.FP.Vh);
         AFiber.Iind_mA[0]:=Iind_*NP0.Square;
       end;
    1: begin { steps at both ends }
         AFiber.Iind_mA[0]      :=Iind_Left;
         AFiber.Iind_mA[Space.N]:=Iind_Right;
       end;
    2: begin { alpha-functions at both ends }
         AFiber.Iind_mA[0]      :=Iind_Left *AlphaF(t);
         AFiber.Iind_mA[Space.N]:=Iind_Right*AlphaF(t);
       end;
    3: begin { noise for gE, gI at soma }
         SynConductancesOnNewStep(AFiber.uu[0],AFiber.ss[0]);
       end;
    end;
    {******* One step of integration ********}
    AFiber.MembranePotential(t);
    {****************************************}
    { Measurement }
    NV0:=AFiber.Nrn[0].NV;
    case NP0.If_I_V_or_g of
      1: Vr:=AFiber.I_soma*1e9;{pA}
      2: Vr:=AFiber.Nrn[iz_Draw].NV.V - AFiber.Nrn[iz_Draw].NP.Vrest;
      3: Vr:=AFiber.I_soma*1e9;{pA}
      4: Vr:=AFiber.I_soma*1e9;{pA}
      5: Vr:=AFiber.I_soma*1e9;{pA}
    end;
    if nt<=MaxExp then Vmod[nt,Smpl]:=Vr;
    { Drawing and writing }
    if (Form20.DDSpinEdit18.Value>0)and((nt=1)or
       (nt mod trunc(Form20.DDSpinEdit18.Value)=0)) then  AFiber.Draw;
    if (WriteOrNot=1) and (trunc(nt/n_Write)=nt/n_Write) then Writing;
    Pause;
  UNTIL nt>=nt_end;
  if WriteOrNot=1 then close(ccc);
  AFiber.Free;
end;

end.
