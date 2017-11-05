unit Net;

interface
procedure RunNet;

implementation
uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Math,
     MyTypes,Init,t_dtO,MathMyO,CreateNrnO,NeuronO,typeNrnParsO,
     Graph,Clamp,ControlNrn,HH_Lyle,
     Unit1,Unit3,Unit7,Unit15,
     Other,Threshold,ReducedEq,FiringClamp,Noise,Statistics;

var
    delay,dtr,
    alGABA,beGABA,gGABA,VGABA,mGABA,UGABA,WGABA
                                                        :double;
    NaShiftj,Vj,Vdj,Voldj,tAPj,XNa1j,XNa2j,XNa3j,XNa4j,
    mmRj,hhRj,iiRj,mmj,hhj,nnj,yKj,nMj,nAj,lAj,xDj,yDj,mCaHj,hCaHj,kCaHj,
    mCaTj,hCaTj,Caj,nKCaj,yHj,wADPj,wAHPj,mBstj,mNaPj
                                                        :vecNrns;
    indicj                                              :veciNrns;
    rate                              :array[0..1000] of double;
    AANrn                             :array[1..MaxNrns] of TNeuron;

procedure AppropriateStateVariablesFrom(j :integer);
begin
        NP0.NaThreshShift:=NaShiftj[j];
        NV0.indic   := indicj[j];
        NV0.V       := Vj[j]    ;
        NV0.Vd      := Vdj[j] ;
        NV0.Vold    := Voldj[j];
        NV0.tAP     := tAPj[j]  ;
        XNa[1]  := XNa1j[j] ;
        XNa[2]  := XNa2j[j] ;
        XNa[3]  := XNa3j[j] ;
        XNa[4]  := XNa4j[j] ;
        NV0.mmR     := mmRj[j]  ;
        NV0.hhR     := hhRj[j]  ;
        NV0.iiR     := iiRj[j]  ;
        NV0.mm      := mmj[j]   ;
        NV0.hh      := hhj[j]   ;
        NV0.nn      := nnj[j]   ;
        NV0.yK      := yKj[j]   ;
        NV0.nM      := nMj[j]   ;
        NV0.nA      := nAj[j]   ;
        NV0.lA      := lAj[j]   ;
        NV0.xD      := xDj[j]   ;
        NV0.yD      := yDj[j]   ;
        NV0.mCaH    := mCaHj[j] ;
        NV0.hCaH    := hCaHj[j] ;
        NV0.kCaH    := kCaHj[j] ;
        NV0.mCaT    := mCaTj[j] ;
        NV0.hCaT    := hCaTj[j] ;
        NV0.Ca      := Caj[j]   ;
        NV0.nKCa    := nKCaj[j] ;
        NV0.yH      := yHj[j]   ;
        NV0.wADP    := wADPj[j] ;
        NV0.wAHP    := wAHPj[j] ;
        NV0.mBst    := mBstj[j] ;
        NV0.mNaP    := mNaPj[j] ;
end;

procedure AppropriateStateVariablesTo(j :integer);
begin
        NaShiftj[j]:=NP0.NaThreshShift;
        indicj[j]  :=NV0.indic   ;
        Vj[j]      :=NV0.V       ;
        Vdj[j]     :=NV0.Vd      ;
        Voldj[j]   :=NV0.Vold    ;
        tAPj[j]    :=NV0.tAP     ;
        XNa1j[j]   :=XNa[1]  ;
        XNa2j[j]   :=XNa[2]  ;
        XNa3j[j]   :=XNa[3]  ;
        XNa4j[j]   :=XNa[4]  ;
        mmRj[j]    :=NV0.mmR     ;
        hhRj[j]    :=NV0.hhR     ;
        iiRj[j]    :=NV0.iiR     ;
        mmj[j]     :=NV0.mm      ;
        hhj[j]     :=NV0.hh      ;
        nnj[j]     :=NV0.nn      ;
        yKj[j]     :=NV0.yK      ;
        nMj[j]     :=NV0.nM      ;
        nAj[j]     :=NV0.nA      ;
        lAj[j]     :=NV0.lA      ;
        xDj[j]     :=NV0.xD      ;
        yDj[j]     :=NV0.yD      ;
        mCaHj[j]   :=NV0.mCaH    ;
        hCaHj[j]   :=NV0.hCaH    ;
        kCaHj[j]   :=NV0.kCaH    ;
        mCaTj[j]   :=NV0.mCaT    ;
        hCaTj[j]   :=NV0.hCaT    ;
        Caj[j]     :=NV0.Ca      ;
        nKCaj[j]   :=NV0.nKCa    ;
        yHj[j]     :=NV0.yH      ;
        wADPj[j]   :=NV0.wADP    ;
        wAHPj[j]   :=NV0.wAHP    ;
        mBstj[j]   :=NV0.mBst    ;
        mNaPj[j]   :=NV0.mNaP    ;
end;

procedure InitialSynapticCurrent;
begin
  gGABA :=Form15.DDSpinEdit1.Value;
  alGABA:=Form15.DDSpinEdit2.Value;
  beGABA:=Form15.DDSpinEdit3.Value;
  VGABA :=Form15.DDSpinEdit4.Value/1000;
  delay :=Form15.DDSpinEdit5.Value/1000;
  mGABA:=0;
  UGABA:=0;
//  Form15.Chart1.BottomAxis.Maximum:=t_end*1000;
end;

procedure SynapticCurrent(t :double; var u_syn,s_syn :double);
{  Calculate the control variables 'uu' and 'ss'. }
var  Q,w,gtGABA      :double;
     ir,i1           :integer;
begin
  { Presynaptic Rate }
  ir:=round(t/dtr);
  i1:=imin(trunc((t-delay)/dtr),ir-1);
  i1:=imax(0,i1);
  w:=(t-delay)/dtr-i1;  if i1=imax(0,ir-1) then w:=0;
  Q:=rate[i1]*(1-w)+rate[i1+1]*w;
  { Synaptic conductance }
  New_m2(0,alGABA,beGABA,dt,Q, mGABA,UGABA);
  gtGABA:= gGABA*mGABA;
  { Control variables }
  u_syn:=-gtGABA*(Vus-VGABA);
  s_syn:= gtGABA;
end;

procedure RunNet;
{ ********************************************************************
  Calculates population rate as for a network of interconnected
  neurons with thresholds distributed by Gaussian.
**********************************************************************}
var
    ir,j,nNrns,Nrate                                    :integer;
    ddd,eee                                             :text;
    t1                                                  :string;
    Vrest_mem,Iind_mem,u_mem,s_mem,sgm_V,Thr,
    u_syn,s_syn,gL0,Noise_
                                                        :double;
BEGIN
  Iind_mem:=Iind; Iind:=0;  u_mem:=uu; uu:=0;  s_mem:=ss; ss:=0;
  assign(ddd,'rate(t).dat'); rewrite(ddd);
  { Parameters }
  Vrest_mem:=NP0.Vrest;
  Smpl:=0;
  Form1.FitPictureToExpData1.Checked:=false;
  NP0.IfSet_VL_or_Vrest:=2;
  dt       :=Form7.DDSpinEdit2.Value/1e3; //0.000015;
  t_end    :=Form7.DDSpinEdit3.Value/1e3; //0.220{s};
  t_Iind   :=Form7.DDSpinEdit4.Value/1e3; //0.200{s};
  Iind     :=Form7.DDSpinEdit5.Value;     //200{pA};
  Freq_Iind:=Form7.DDSpinEdit15.Value;    //0{Hz};
  nt_end:=imin(trunc(t_end/dt), MaxNT);
  Nrate :=trunc(Form7.DDSpinEdit6.Value);//220; {Mesh in time to discretize rate(t)}
  nNrns :=trunc(Form7.DDSpinEdit7.Value);//4000;
  sgm_V :=      Form7.DDSpinEdit13.Value/1000;
  dtr:=t_end/Nrate;
  { Initial Conditions }
  if Form7.CheckBox2.Checked=false then begin
     Form7 .Series9 .Clear;
     Form7 .Series10.Clear;
     Form15.Series1 .Clear;
  end;
  for ir:=0 to Nrate do rate[ir]:=0;
  NP0.NaThreshShift:=0;
  InitialConditions;
  InitialPicture;
  InitialSynapticCurrent;
  NV0.indic:=0;
  for j:=1 to nNrns do begin
     { Randomize and remember initial voltage }
     if IfNoise then  NV0.V:=NP0.Vrest+sgm_V*randG(0,1);
     NV0.Vd:=NV0.V;   NV0.Vold:=NV0.V;
     ThrNeuron.V:=NV0.V; ThrNeuron.VE:=NV0.V;
     AppropriateStateVariablesTo(j);
     CreateNeuronByTypeO(NP0,AANrn[j]);
     AANrn[j].InitialConditions;
     AANrn[j].NV.V:=NV0.V;  AANrn[j].NV.Vd:=NV0.V;
  end;
  if not(IfNoise) then  for j:=1 to nNrns do  NaShiftj[j]:=sgm_V*randG(0,1);
  nt:=0; t:=0;
  REPEAT  nt:=nt+1;  t:=t+dt; { time step }
    dt       :=Form7.DDSpinEdit2.Value/1e3;
    PrintTime;
    ir:=round(t/dtr);
    { Synaptic Current }
    SynapticCurrent(t, u_syn,s_syn);
    j:=0;
    REPEAT j:=j+1;      { loop for neurons }
        str(j:10,t1);   Form7.Label15.Caption:='j='+t1;
        AppropriateStateVariablesFrom(j);
        uu:=u_syn; ss:=s_syn;
        gL0:=NP0.C_membr/NP0.tau_m0;
        { Noise }
        Noise_:=0;
        if IfNoise then
           Noise_:= sgm_V*gL0*sqrt(2*NP0.tau_m0  {/(1+ss/gL0)} /dt)*randG(0,1); //commented on 20.09.2012  and changed from uu to Noise_ on 23.09.2012
        {****************}
//        MembranePotential;
        AANrn[j].MembranePotential(uu,ss,0,s_soma,tt,Current_Iind+du_Reset+Noise_,Vhold(t));
        NV0:=AANrn[j].NV;
        {****************}
        IfSpikeOccursO(AANrn[j]);
        if (NV0.indic=2) then begin
           { Threshold Renewal }
           if (Form7.CheckBox3.Checked)and(IfNoise) then begin
              NP0.NaThreshShift:=sgm_V*randG(0,1);
              AANrn[j].NP:=NP0;
           end;
           { Firing Rate }
           rate[ir]:=rate[ir]+1/nNrns/dtr;
        end;
        AppropriateStateVariablesTo(j);
        { Treat and draw one curve }
        if j=trunc(nNrns/2) then begin
           if (nt=1)or(trunc(nt/n_Draw)=nt/n_Draw) then begin
               Evolution;
               Form7.Series10.AddXY(t*1000, NV0.V*1000);
           end;
           if Form1.CheckBox1.Checked then AnalyseStatistics(NV0.V*1e3);
           { Draw and write one curve }
           if nt=1 then begin
              Form7.Series10.Clear;
              assign(eee,'OneCurve(t).dat'); rewrite(eee);
           end;
           Form7.Series10.AddXY(t*1000, NV0.V*1000);
           writeln(eee,t*1000:9:3,' ',NV0.V*1000:9:3);
           if nt=imin(trunc(Form7.DDSpinEdit3.Value/1e3/dt), MaxNT) then close(eee);
        end;
    UNTIL j>=trunc(Form7.DDSpinEdit7.Value);
    { Drawing and Writing}
    if ir<>round((nt+1)*dt/dtr) then begin
       Form7 .Series9.AddXY(dtr*ir*1000, rate[ir]);
       Form15.Series1.AddXY(dtr*ir*1000, mGABA);
       Application.ProcessMessages;
       writeln(ddd,t_end/Nrate*ir*1000:9:3,' ',rate[ir]:9:5,' ',mGABA:9:5);
    end;
  UNTIL nt=imin(trunc(Form7.DDSpinEdit3.Value/1e3/dt), MaxNT);
  close(ddd);
  for j:=1 to nNrns do  AANrn[j].Free;
  NP0.Vrest:=Vrest_mem;
  uu:=u_mem;  ss:=s_mem;  Iind:=Iind_mem;
  NP0.IfBlockNa:=0;
END;

end.
