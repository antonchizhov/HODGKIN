unit RateOfGaussian;

interface
procedure RateWithNoise;
procedure RateOfGaussianEnsemble;
procedure RateOfEnsembleWithGaussianConductances;


implementation
uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Math,MyTypes,Init,t_dtO,MathMyO,Graph,Clamp,Hodgkin,
     Unit1,Unit3,Unit7,Unit8,
     Other,Threshold,ReducedEq,FiringClamp,Noise;

{------------------------- I -----------------------------------------}
procedure RateWithNoise;
{ ********************************************************************
  Calculates rate as sum of realisations of single neuron dynamics
  with input noise-current or noise-conductance.
**********************************************************************}
var
    i,j,je,indicat,Nrate                                :integer;
    ddd,eee                                             :text;
    t1                                                  :string;
    Vrest_mem,Iind_mem,u_mem,s_mem,
    sgm_V,Thr,sgmV_,meanV_,w,Ampl_Noise,s_gL
                                                        :double;
    rate                              :array[0..1000] of double;
BEGIN
  { Parameters }
  Iind_mem:=Iind; Iind:=0;  u_mem:=uu; uu:=0;  s_mem:=ss; ss:=0;
  Vrest_mem:=NP0.Vrest;
  Smpl:=0;
  Form1.FitPictureToExpData1.Checked:=false;
  NP0.IfSet_VL_or_Vrest:=2;
  dt       :=Form7.DDSpinEdit2.Value/1e3; //0.000015{s};
  t_end    :=Form7.DDSpinEdit3.Value/1e3; //0.220{s};
  t_Iind   :=Form7.DDSpinEdit4.Value/1e3; //0.200{s};
  Iind     :=Form7.DDSpinEdit5.Value;     //200{pA};
  Freq_Iind:=Form7.DDSpinEdit15.Value;    //0{Hz};
  nt_end:=imin(trunc(t_end/dt), MaxNT);
  Nrate :=trunc(Form7.DDSpinEdit6.Value);//220; {Mesh in time to discretize rate(t)}
  for i:=0 to Nrate do rate[i]:=0;
  je   :=trunc(Form7.DDSpinEdit7.Value);//4000;
  { For noise }
  sgm_V :=      Form7.DDSpinEdit13.Value/1000;
  NoiseToSignal:=1;
  tau_Noise:=Form7.DDSpinEdit16.Value/1e3; //0.003 {s};
  Ampl_Noise:=sgm_V*(NP0.C_membr/NP0.tau_m0);
  if tau_Noise>0 then  Ampl_Noise:=Ampl_Noise*sqrt(1+NP0.tau_m0/tau_Noise);
  s_gL:=ss/(NP0.C_membr/NP0.tau_m0);
  InitialConditions;
  InitialPicture;
  CorrespondParametersToTheForm;
  { Loop for realizations of noise }
  sgmV_:=0;  meanV_:=0;
  j:=-1;
  REPEAT j:=j+1;
    str(j:10,t1);   Form7.Label15.Caption:='j='+t1;
    InitialConditions;
    { Randomize initial voltage }
    NV0.V:=NP0.Vrest+sgm_V*randG(0,1);
    NV0.VatE:=NV0.V;  NV0.Vold:=NV0.V;
    ThrNeuron.V:=NV0.V; ThrNeuron.VE:=NV0.V;
    indicat:=0;
    nt:=0;
    REPEAT  nt:=nt+1;  t:=nt*dt; { time step }
        { Color Noise-current }
        if tau_Noise=0 then begin
           uu:=Ampl_Noise*sqrt(2*NP0.tau_m0  {/(1+s_gL)} /dt)*randG(0,1) //commented on 20.09.2012
        end else begin
           SynCurrentOnNewStep(Ampl_Noise,0, uu);
        end;
        { Voltage }
        MembranePotential;
        IfSpikeOccurs(NV0.V,NV0.DVDt,NV0.ddV,NP0.Vrest+NV0.Thr,NV0.tAP,indicat);
        { Rate }
        if indicat=2 then begin
           i:=round(t/t_end*Nrate);
           w:=1;  if i=je then w:=2;
           rate[i]:=rate[i] + w/(t_end/Nrate)/(je+1);
        end;
        { Calc. sgmV at certain time moment }
        if trunc(Form7.DDSpinEdit14.Value/1000/dt)=nt then begin
           sgmV_ :=(sgmV_ *j+NV0.V*NV0.V)/(j+1);
           meanV_:=(meanV_*j+NV0.V     )/(j+1);
        end;
        { Draw and write one curve }
        if j=0 then begin
           if nt=1 then begin
              Form7.Series10.Clear;
              Form8.Series14.Clear;
              Form8.Series12.Clear;
              assign(eee,'OneCurve(t).dat'); rewrite(eee);
           end;
           Form7.Series10.AddXY(t*1000, NV0.V*1000);
           if trunc(nt/n_Draw)=nt/n_Draw then Form8.Series14.AddXY(t*1e3,uu*1000);
           writeln(eee,t*1000:9:3,' ',NV0.V*1000:9:3);
           if nt=nt_end then close(eee);
        end;
    UNTIL (nt=nt_end);
    { Drawing }
    Form7.Series9.Clear;
    for i:=0 to Nrate do begin
        Form7.Series9.AddXY(t_end/Nrate*i*1000, rate[i]);
    end;
    str(sqrt(max(0,(sgmV_-sqr(meanV_))))*1000:7:3,t1);
    Form7.Label18.Caption:='sgmV at t=               ='+t1;
    Application.ProcessMessages;
  UNTIL j>=trunc(Form7.DDSpinEdit7.Value);
  { Results }
  assign(ddd,'RateNoise(t).dat'); rewrite(ddd);
  for i:=0 to Nrate do  writeln(ddd,t_end/Nrate*i*1000:9:3,' ',rate[i]:9:5);
  close(ddd);
  NP0.Vrest:=Vrest_mem;
  uu:=u_mem;  ss:=s_mem;  Iind:=Iind_mem;
  NP0.IfBlockNa:=0;
END;

{------------------------- II ----------------------------------------}
procedure RateOfGaussianEnsemble;
{ ********************************************************************
  Calculates rate as function of time when thresholds
  (or rest potentials) are distributed by Gaussian.
**********************************************************************}
var
    i,j,je,indicat,Nrate                              :integer;
    ddd                                                 :text;
    t1                                                  :string;
    Vrest_mem,sgm_V,sgm,fGauss,Thr,gL_mem
                                                        :double;
    rate                              :array[0..1000] of double;
BEGIN
  assign(ddd,'rate(t).dat'); rewrite(ddd);
  { Parameters }
  Smpl:=0;
  Form1.FitPictureToExpData1.Checked:=false;
  InitialPicture;
  NP0.IfSet_VL_or_Vrest:=2;
  dt       :=Form7.DDSpinEdit2.Value/1e3; //0.000015;
  t_end    :=Form7.DDSpinEdit3.Value/1e3; //0.220{s};
  t_Iind   :=Form7.DDSpinEdit4.Value/1e3; //0.200{s};
  Iind     :=Form7.DDSpinEdit5.Value;     //200{pA};
  Freq_Iind:=Form7.DDSpinEdit15.Value;    //0{Hz};
  nt_end:=imin(trunc(t_end/dt), MaxNT);
  Vrest_mem:=NP0.Vrest;  gL_mem:=NP0.gL;
  Nrate :=trunc(Form7.DDSpinEdit6.Value);//220; {Mesh in time to discretize rate(t)}
  for i:=0 to Nrate do rate[i]:=0;
  { Loop for Vrest }
  je   :=trunc(Form7.DDSpinEdit7.Value);//4000;
  sgm_V :=      Form7.DDSpinEdit13.Value;
  if Form7.ComboBox1.ItemIndex=0 then  sgm_V:=sgm_V/1000;
  j:=-1;
  REPEAT j:=j+1;
    NP0.NaThreshShift:=0;
    if Form7.ComboBox2.ItemIndex in [1,2] then
       NP0.gL:=max(0.001,gL_mem*(1+sgm_V*randG(0,1)));
    InitialConditions;
    if Form7.ComboBox2.ItemIndex in [0,2] then
       NP0.NaThreshShift:=sgm_V*randG(0,1);
    str(j:10,t1);   Form7.Label15.Caption:='j='+t1;
    indicat:=0;
    nt:=0;
    REPEAT  nt:=nt+1;  t:=nt*dt; { time step }
        {****************}
        MembranePotential;
        IfSpikeOccurs(NV0.V,NV0.DVDt,NV0.ddV,NP0.Vrest+NV0.Thr,NV0.tAP,indicat);
        {****************}
        if (indicat=2) then begin
           i:=round(t/t_end*Nrate);
           fGauss:=1/(je+1);
           rate[i]:=rate[i]+fGauss/(t_end/Nrate);
           { Threshold Renewal }
           if Form7.CheckBox3.Checked then NP0.NaThreshShift:=sgm_V*randG(0,1);
        end;
        { Draw one curve }
        if (j=trunc(je/2))and(trunc(nt/n_Draw)=nt/n_Draw) then begin
           if nt=1 then Form7.Series10.Clear;
           Form7.Series10.AddXY(t*1000, NV0.V*1000);
        end;
    UNTIL (nt=nt_end);
    { Drawing }
    Form7.Series9.Clear;
    for i:=0 to Nrate do begin
        Form7.Series9.AddXY(t_end/Nrate*i*1000, rate[i]);
    end;
    Application.ProcessMessages;
  UNTIL j>=trunc(Form7.DDSpinEdit7.Value);
  { Results }
  for i:=0 to Nrate do  writeln(ddd,t_end/Nrate*i*1000:9:3,' ',rate[i]:9:5);
  NP0.Vrest:=Vrest_mem;   NP0.gL:=gL_mem;
  NP0.IfBlockNa:=0;
  close(ddd);
END;

{------------------------- III ---------------------------------------}
procedure RateOfEnsembleWithGaussianConductances;
{ ********************************************************************
  Calculates rate as function of time when excitatory synaptic
  conductances are distributed by Gauss.
**********************************************************************}
var
    i,nG,nGe,indicat,NCoarse                            :integer;
    ddd                                                 :text;
    Vrest_mem,VT0,nondim_sigma,fGauss,dVT,Thr,
    gE,gI,gE0,gI0,Ampl_gE,sigmaG_nd,dgE,Vr,Dispersion,
    tAPmin,dtC, sgm_gE,sgm_V,mmE,gE_V
                                                        :double;
    Mean,Variance,Unity               :array[0..1000] of double;
    dd1,dd2,dd3,dd4                                     :text;
BEGIN
  assign(dd1,'Gauss(t,V).dat');      rewrite(dd1);
  assign(dd2,'Gauss_Mean_Disp.dat'); rewrite(dd2);
  assign(dd3,'Gauss_V(MeanGE).dat'); rewrite(dd3);
  assign(dd4,'Gauss_bound.dat');     rewrite(dd4);
  { Parameters }
  Smpl:=0;
  Form1.FitPictureToExpData1.Checked:=false;
  InitialPicture;
  Form7.Series1.Clear;
  Form7.Series2.Clear;
  Form7.Series3.Clear;
  Form7.Series4.Clear;
  Form7.Series5.Clear;
  Form7.Series6.Clear;
  Form7.Series7.Clear;
  Form7.Series8.Clear;
  NP0.IfSet_VL_or_Vrest:=2;
  dt       :=Form7.DDSpinEdit2.Value/1e3; //0.000015{s};
  t_end    :=Form7.DDSpinEdit3.Value/1e3; //0.220{s};
  t_Iind   :=Form7.DDSpinEdit4.Value/1e3; //0.200{s};
  Iind     :=Form7.DDSpinEdit11.Value;    //0{pA};
  sigmaG_nd:=Form7.DDSpinEdit10.Value;    //0.2;
  tau_E    :=Form7.DDSpinEdit9.Value/1e3; //0{ms};
  nGe    :=trunc(Form7.DDSpinEdit12.Value);   //4;
  NCoarse:=trunc(Form7.DDSpinEdit6.Value);  //220; {Mesh in time to discretize rate(t)}
  Ampl_gE  :=Form7.DDSpinEdit8.Value;
  nt_end:=imin(trunc(t_end/dt), MaxNT);
//  Form7.Chart1.BottomAxis.Maximum:=t_end*1000;
  Vrest_mem:=NP0.Vrest;
  for i:=0 to NCoarse do begin  Unity[i]:=0; Mean[i]:=0; Variance[i]:=0;  end;
  tAPmin:=t_end;
  dtC:=t_end/NCoarse;
  { Loop for Conductance }
  dgE:=6*sigmaG_nd*Ampl_gE/nGe;
  FOR nG:=0 to nGe DO BEGIN
    { Set dispersed Synaptic conductances }
    gE0:=max(Ampl_gE*(1-3*sigmaG_nd)+dgE*nG,0);
    InitialConditions;
    indicat:=0;
    nt:=0;
    REPEAT  nt:=nt+1;  t:=nt*dt; { time step }
        { Input - Synaptic conductances }
        if tau_E>0 then  mmE:=sqr(sin(t/tau_E)) else mmE:=1;
        gE:=gE0*mmE;     gI:=0;
        gE_gI_to_U_S(gE,gI,0,0, uu,ss);
        {****************}
        MembranePotential;
        IfSpikeOccurs(NV0.V,NV0.DVDt,NV0.ddV,NP0.Vrest+NV0.Thr,NV0.tAP,indicat);
        {****************}
        Vr:=NV0.V;
        { Mean and Variance }
        i:=trunc(t/dtC);
        if abs(t-i*dtC)<dt then begin
           fGauss:=Gauss(gE0-Ampl_gE,sigmaG_nd*Ampl_gE)*dgE;
           Unity[i]   :=Unity[i]    +         fGauss;
           Mean[i]    :=Mean[i]     +     Vr *fGauss;
           Variance[i]:=Variance[i] + sqr(Vr)*fGauss;
           writeln(dd1,t*1e3:9:3,' ',Vr*1e3:10:3,' ',fGauss:10:4);
        end;
        { Drawing }
        Form7.Series1.AddXY(t*1000, Vr*1e3);
        { Eq. for sgm_V }
        if nG=trunc(nGe/2) then begin
           sgm_gE:=Ampl_gE*sigmaG_nd;
           CorrectMeanV(mmE,sgm_gE,sgm_V, Vr);
           EqForDispersion(indicat, Vr,NP0.gL,mmE,gE,sgm_gE, sgm_V,gE_V);
           Form7.Series6.AddXY(t*1000,  Vr*1e3);
           Form7.Series7.AddXY(t*1000, (Vr+sgm_V)*1e3);
           Form7.Series8.AddXY(t*1000, (Vr-sgm_V)*1e3);
           write  (dd2,t*1e3:9:3,' ',Vr*1e3:10:3,' ');
           writeln(dd2,(Vr+sgm_V)*1e3:10:3,' ',(Vr-sgm_V)*1e3:10:3);
        end;
        if nG=nGe then  writeln(dd4,t*1e3:9:3,' ',Vr*1e3:10:3);
    UNTIL (nt=nt_end)or(indicat=2);
    tAPmin:=min(tAPmin,t);
    { Drawing }
    Form7.Series2.AddXY(t*1000, Vr*1e3);
    Application.ProcessMessages;
  END;
  { Drawing }
//  Form7.Chart1.LeftAxis.Automatic:=false;
  for i:=1 to NCoarse do  if i*dtC<=tAPmin then begin
      Dispersion:=sqrt(max(Variance[i]/Unity[i]-sqr(Mean[i]/Unity[i]),0));
      Form7.Series3.AddXY(dtC*i*1000,  Mean[i]/Unity[i]*1e3);
      Form7.Series4.AddXY(dtC*i*1000, (Mean[i]+Dispersion)/Unity[i]*1e3);
      Form7.Series5.AddXY(dtC*i*1000, (Mean[i]-Dispersion)/Unity[i]*1e3);
      write  (dd3,dtC*i*1e3:9:3,' ',Mean[i]/Unity[i]*1e3:10:3,' ');
      write  (dd3,     (Mean[i]+Dispersion)/Unity[i]*1e3:10:3,' ');
      writeln(dd3,     (Mean[i]-Dispersion)/Unity[i]*1e3:10:3);
  end;
  Application.ProcessMessages;
  { Results }
  NP0.Vrest:=Vrest_mem;
  NP0.IfBlockNa:=0;
  close(dd1);
  close(dd2);
  close(dd3);
  close(dd4);
END;

end.
