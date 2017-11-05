unit Clamp;

interface
uses Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
     Math,
     MyTypes,Init,t_dtO,MathMyO,Other,Graph,ControlNrn,
     Unit1,Unit3,Unit4,Unit7,Unit10,Unit17,
     Reader,Threads,Threshold,ReducedEq,Noise,function_Z,
     CreateNrnO,SetNrnParsO,typeNrnParsO,Electrode;

procedure CorrespondParametersToTheForm;
procedure CalcParameters;
procedure CommonParametersFrom_ParFile;
procedure DefaultParameters;
function DefineAskedCurve:double;
procedure Read_Params_from_File_or_Procedure;
procedure InitialConditions;
procedure DefineStimulation(NP_:NeuronProperties; var uu_,ss_,u_soma_,s_soma_,
                                                      tt_,Iind_,Vh_ :double);
{***********************************************************}
FUNCTION Calc_Functional :double;
procedure VoltageOrCurrentClamp(u,s :double);
procedure CommonParametersFromFile;

implementation
uses Unit18,Unit20;

{I E:\Anton\HODGKIN\(u_s)\v(u_s)2HH.id }
{I v(u_s)_Lyle.id } {01.02.2006, 14.01.2008, 16.02.2010, 24.10.2011}
{I Axon_Mainen.id } {06.02.2013}
{I ramp.id } {11.11.2011, 26.09.2012}
{I VC_steps.id } {24.01.2013}
{I Tolya.id  14.04.2009}
{$I v(t)_LIF.id }  {03.04.2010}
{I GammaRythm_Chow.id } { 06.04.2010 }
{I Ali_I_2p.id }
{I Ali_I.id }
{I Japon_I.id }     {15.11.2005, 01.02.2006}
{I Japon_P.id }
{I Ali.id }
{I AP.id }
{I AP_Krylov.id }
{I Bursts.id }
{I Na_V10&S12.id }
{I Na_Schmidt.id }
{I K_Schmidt.id }
{I e:\Anton\Hodgkin\full_current\full_current.id }
{I e:\Anton\Hodgkin\full_current\firstAppr.id }
{I Na_slow.id }
{I Na_slow_ina.id }
{I Na_Kandel.id }
{I K_Kandel.id }
{I Na&K_Kandel.id } {23.11.2007, 27.06.2008, 04.02.2009}

{ Hierarchy of parameters:
             On Activation - Default
             On Form - Manual
             FromFile
             Simplex
}

procedure CorrespondParametersToTheForm;
var i :integer;
begin
  Form1.Calmar1  .Checked:=(NP0.HH_type='Calmar'  );
  Form1.Passive1 .Checked:=(NP0.HH_type='Passive' );
  Form1.Destexhe1.Checked:=(NP0.HH_type='Destexhe');
  Form1.Migliore1.Checked:=(NP0.HH_type='Migliore');
  Form1.Cummins1 .Checked:=(NP0.HH_type='Cummins' );
  Form1.Chow1    .Checked:=(NP0.HH_type='Chow');
  Form1.Lyle1    .Checked:=(NP0.HH_type='Lyle');
  Form1.Naundorf1.Checked:=(NP0.HH_type='Naundorf');
  Form1.White1   .Checked:=(NP0.HH_type='White');
  Form1.White21  .Checked:=(NP0.HH_type='White2');
  Form1.Shu1     .Checked:=(NP0.HH_type='Shu');
  Form1.N1point1 .Checked:=(NP0.HH_order='1-point');
  Form1.N2points1.Checked:=(NP0.HH_order='2-points');
  Form1.N2pMainenSejn1.Checked:=(NP0.HH_order='2-p-MainenSejn');
  Form1.N2pActiveDend1.Checked:=(NP0.HH_order='2-p-ActiveDend');
  Form1.ThrModel.Checked:=(NP0.IfThrModel=1);
  Form1.LIFmodel.Checked:=(NP0.IfLIF=1);
  for i:=0 to Form4.ComboBox1.Items.Count do
      if Form4.ComboBox1.Items[i]=NP0.NaR_type    then Form4.ComboBox1.ItemIndex:=i;
  for i:=0 to Form4.ComboBox2.Items.Count do
      if Form4.ComboBox2.Items[i]=NP0.NaR_subtype then Form4.ComboBox2.ItemIndex:=i;
  for i:=0 to Form4.ComboBox3.Items.Count do
      if Form4.ComboBox3.Items[i]=NP0.Na_type     then Form4.ComboBox3.ItemIndex:=i;
  for i:=0 to Form4.ComboBox4.Items.Count do
      if Form4.ComboBox4.Items[i]=NP0.Na_subtype  then Form4.ComboBox4.ItemIndex:=i;
  Form4.ComboBox2.Enabled:=(NP0.NaR_type='Milescu')or(NP0.NaR_type='Lyle');
  Form4.ComboBox4.Enabled:=(NP0.Na_type='Milescu')or(NP0.Na_type='Lyle');
  Form1.INaR1 .Checked:=(NP0.IfBlockNaR=1);
  Form1.INa1  .Checked:=(NP0.IfBlockNa=1);
  Form1.IK1   .Checked:=(NP0.IfBlockK =1);
  Form1.IKM1  .Checked:=(NP0.IfBlockKM=1);
  Form1.IKA1  .Checked:=(NP0.IfBlockKA=1);
  Form1.IPass1.Checked:=(NP0.IfBlockPass=1);
  Form4.DDSpinEdit1.Enabled:=(NP0.IfBlockNaR=0);
  Form4.DDSpinEdit2.Enabled:=(NP0.IfBlockNa=0)or(NP0.HH_type='White2');
  Form4.DDSpinEdit3.Enabled:=(NP0.IfBlockK=0);
  Form4.DDSpinEdit4.Enabled:=(NP0.IfBlockKM=0);
  Form4.DDSpinEdit14.Enabled:=(NP0.IfBlockKA=0);
  Form4.DDSpinEdit12.Enabled:=(NP0.IfBlockPass=0);
  Form4.DDSpinEdit20.Enabled:=(NP0.IfBlockPass=0);
  Form4.DDSpinEdit56.Enabled:=(NP0.HH_order='2-p-MainenSejn');
  Form4.DDSpinEdit57.Enabled:=(NP0.HH_order='2-p-MainenSejn');
  Form1.Smpl1 .Checked:=(Smpl=1);
  Form1.Smpl2 .Checked:=(Smpl=2);
  Form1.Smpl3 .Checked:=(Smpl=3);
  Form1.Smpl4 .Checked:=(Smpl=4);
  Form1.Smpl5 .Checked:=(Smpl=5);
  Form1.Smpl6 .Checked:=(Smpl=6);
  Form1.Smpl7 .Checked:=(Smpl=7);
  Form1.Smpl8 .Checked:=(Smpl=8);
  Form1.Smpl9 .Checked:=(Smpl=9);
  Form1.Smpl10.Checked:=(Smpl=10);
  Form1.Smpl11.Checked:=(Smpl=11);
  Form1.Smpl12.Checked:=(Smpl=12);
  Form1.Smpl13.Checked:=(Smpl=13);
  Form1.Smpl14.Checked:=(Smpl=14);
  Form1.Smpl15.Checked:=(Smpl=15);
  Form1.Smpl16.Checked:=(Smpl=16);
  Form1.Smpl17.Checked:=(Smpl=17);
  Form1.Smpl18.Checked:=(Smpl=18);
  Form1.Smpl19.Checked:=(Smpl=19);
  Form1.Smpl20.Checked:=(Smpl=20);
  Form1.Smpl1_.Checked:=(Smpl=1);
  Form1.Smpl2_.Checked:=(Smpl=2);
  Form1.Smpl3_.Checked:=(Smpl=3);
  Form1.Smpl4_.Checked:=(Smpl=4);
  Form1.Smpl5_.Checked:=(Smpl=5);
  Form1.Smpl6_.Checked:=(Smpl=6);
  Form1.Smpl7_.Checked:=(Smpl=7);
  Form1.Smpl8_.Checked:=(Smpl=8);
  Form1.Smpl9_.Checked:=(Smpl=9);
  Form1.Smpl10_.Checked:=(Smpl=10);
  Form1.Smpl11_.Checked:=(Smpl=11);
  Form1.Smpl12_.Checked:=(Smpl=12);
  Form1.Smpl13_.Checked:=(Smpl=13);
  Form1.Smpl14_.Checked:=(Smpl=14);
  Form1.Smpl15_.Checked:=(Smpl=15);
  Form1.Smpl16_.Checked:=(Smpl=16);
  Form1.Smpl17_.Checked:=(Smpl=17);
  Form1.Smpl18_.Checked:=(Smpl=18);
  Form1.Smpl19_.Checked:=(Smpl=19);
  Form1.Smpl20_.Checked:=(Smpl=20);
  Form1.Smpl1_.Enabled:=(NSmpls>=1);
  Form1.Smpl2_.Enabled:=(NSmpls>=2);
  Form1.Smpl3_.Enabled:=(NSmpls>=3);
  Form1.Smpl4_.Enabled:=(NSmpls>=4);
  Form1.Smpl5_.Enabled:=(NSmpls>=5);
  Form1.Smpl6_.Enabled:=(NSmpls>=6);
  Form1.Smpl7_.Enabled:=(NSmpls>=7);
  Form1.Smpl8_.Enabled:=(NSmpls>=8);
  Form1.Smpl9_.Enabled:=(NSmpls>=9);
  Form1.Smpl10_.Enabled:=(NSmpls>=10);
  Form1.Smpl11_.Enabled:=(NSmpls>=11);
  Form1.Smpl12_.Enabled:=(NSmpls>=12);
  Form1.Smpl13_.Enabled:=(NSmpls>=13);
  Form1.Smpl14_.Enabled:=(NSmpls>=14);
  Form1.Smpl15_.Enabled:=(NSmpls>=15);
  Form1.Smpl16_.Enabled:=(NSmpls>=16);
  Form1.Smpl17_.Enabled:=(NSmpls>=17);
  Form1.Smpl18_.Enabled:=(NSmpls>=18);
  Form1.Smpl19_.Enabled:=(NSmpls>=19);
  Form1.Smpl20_.Enabled:=(NSmpls>=20);
  Form1.Smpl1.Enabled :=Form1.Smpl1_.Enabled ;
  Form1.Smpl2.Enabled :=Form1.Smpl2_.Enabled ;
  Form1.Smpl3.Enabled :=Form1.Smpl3_.Enabled ;
  Form1.Smpl4.Enabled :=Form1.Smpl4_.Enabled ;
  Form1.Smpl5.Enabled :=Form1.Smpl5_.Enabled ;
  Form1.Smpl6.Enabled :=Form1.Smpl6_.Enabled ;
  Form1.Smpl7.Enabled :=Form1.Smpl7_.Enabled ;
  Form1.Smpl8.Enabled :=Form1.Smpl8_.Enabled ;
  Form1.Smpl9.Enabled :=Form1.Smpl9_.Enabled ;
  Form1.Smpl10.Enabled:=Form1.Smpl10_.Enabled;
  Form1.Smpl11.Enabled:=Form1.Smpl11_.Enabled;
  Form1.Smpl12.Enabled:=Form1.Smpl12_.Enabled;
  Form1.Smpl13.Enabled:=Form1.Smpl13_.Enabled;
  Form1.Smpl14.Enabled:=Form1.Smpl14_.Enabled;
  Form1.Smpl15.Enabled:=Form1.Smpl15_.Enabled;
  Form1.Smpl16.Enabled:=Form1.Smpl16_.Enabled;
  Form1.Smpl17.Enabled:=Form1.Smpl17_.Enabled;
  Form1.Smpl18.Enabled:=Form1.Smpl18_.Enabled;
  Form1.Smpl19.Enabled:=Form1.Smpl19_.Enabled;
  Form1.Smpl20.Enabled:=Form1.Smpl20_.Enabled;
  if NP0.If_I_V_or_g in [2,6,7] then begin
     Form1.CurrentClamp1.Checked:=True;
     Form1.DDSpinEdit1.Visible:=true;
     Form1.DDSpinEdit4.Visible:=false;
     Form1.StaticText1.Visible:=true;
     Form1.StaticText4.Visible:=false;
     case NP0.If_I_V_or_g of
     2: Form1.CC1.Checked:=true;
     6: Form1.Iind1.Checked:=true;
     7: Form1.IindVexp1.Checked:=true;
     end;
  end;
  if NP0.If_I_V_or_g in [1,3,4,5] then begin
     Form1.VoltageClamp1.Checked:=True;
     Form1.DDSpinEdit1.Visible:=false;
     Form1.DDSpinEdit4.Visible:=true;
     Form1.StaticText1.Visible:=false;
     Form1.StaticText4.Visible:=true;
     case NP0.If_I_V_or_g of
     1: Form1.VC1.Checked:=true;
     3: Form1.forgNa1.Checked:=True;
     4: Form1.VCwithpipette1.Checked:=true;
     5: Form1.VCatVexp1.Checked:=true;
     end;
  end;
  if NP0.IfSet_gL_or_tau=2 then begin
     Form1.tauisfixed1.Checked:=true;
     Form4.DDSpinEdit12.Enabled:=false;
     Form4.DDSpinEdit20.Enabled:=true;
  end else begin
     Form1. gLisfixed1.Checked:=true;
     Form4.DDSpinEdit12.Enabled:=true;
     Form4.DDSpinEdit20.Enabled:=false;
  end;
  if NP0.IfSet_VL_or_Vrest=2 then begin
     Form1.Vrestisfixed1.Checked:=true;
     Form4.DDSpinEdit18.Enabled:=false;
     Form4.DDSpinEdit6 .Enabled:=true;
  end else begin
     Form1.   VLisfixed1.Checked:=true;
     Form4.DDSpinEdit18.Enabled:=true;
     Form4.DDSpinEdit6 .Enabled:=false;
  end;
  {Form4.ComboBox1.Enabled:=((NP0.HH_type='Calmar')or
                            (NP0.HH_type='Cummins')or
                            (NP0.HH_type='Destexhe'));}
  if NP0.HH_order='1-point' then Form4.DDSpinEdit34.Enabled:=false
                            else Form4.DDSpinEdit34.Enabled:=true;
  Form1.DDSpinEdit18.Enabled:=(Form1.ComboBox2.ItemIndex=2)
                            or(Form1.ComboBox2.ItemIndex in[3,4]);
  Form4.DDSpinEdit43.Enabled:=(Form4.ComboBox5.ItemIndex=1);
  Form4.DDSpinEdit44.Enabled:=(Form4.ComboBox5.ItemIndex=1);
  Form4.DDSpinEdit59.Enabled:=(Form4.ComboBox5.ItemIndex=2);
  {***}
  Form1.DDSpinEdit1.Value:=Iind;
  Form1.DDSpinEdit2.Value:=t_Iind*1e3;
  Form1.DDSpinEdit3.Value:=t_end*1e3;
  Form1.DDSpinEdit4.Value:=(Vh-NP0.Vrest)*1e3;
  Form1.DDSpinEdit5.Value:=uu*1e3;
  Form1.DDSpinEdit6.Value:=ss;
  Form1.DDSpinEdit7.Value:=NoiseToSignal;
  Form1.DDSpinEdit8.Value:=FC_freq;
  Form1.DDSpinEdit9.Value:=FC_dFdu;
  Form1.DDSpinEdit10.Value:=tau_E*1e3;
  Form1.DDSpinEdit11.Value:=tau_I*1e3;
  Form1.DDSpinEdit12.Value:=tau_Noise*1e3;
  Form1.DDSpinEdit13.Value:=dt*1e3;
  Form1.DDSpinEdit14.Value:=Freq_Iind;
  Form1.DDSpinEdit15.Value:=FC_I0*1000;
  Form1.DDSpinEdit20.Value:=t_IindShift*1e3;
  Form1.DDSpinEdit22.Value:=tt;
  Form1.DDSpinEdit23.Value:=s_soma;
  Form4.DDSpinEdit1.Value:=NP0.gNaR;
  Form4.DDSpinEdit2.Value:=NP0.gNa;
  Form4.DDSpinEdit3.Value:=NP0.gK;
  Form4.DDSpinEdit4.Value:=NP0.gKM;
  Form4.DDSpinEdit5.Value:=NP0.Square*1e5;
  Form4.DDSpinEdit6.Value:=NP0.Vrest*1000;
  Form4.DDSpinEdit7.Value:=dt*1000;
  Form4.DDSpinEdit8 .Value:=NP0.a3NaR;
  Form4.DDSpinEdit9 .Value:=NP0.b3NaR;
  Form4.DDSpinEdit10.Value:=NP0.c3NaR;
  Form4.DDSpinEdit11.Value:=NP0.d3NaR;
  Form4.DDSpinEdit12.Value:=NP0.gL;
  Form4.DDSpinEdit13.Value:=NP0.VNa*1000;
  Form4.DDSpinEdit14.Value:=NP0.gKA;
  Form4.DDSpinEdit15.Value:=NP0.gCaH;
  Form4.DDSpinEdit16.Value:=NP0.gKCa;
  Form4.DDSpinEdit17.Value:=NP0.gAHP;
  Form4.DDSpinEdit18.Value:=NP0.VL*1000;
  Form4.DDSpinEdit19.Value:=NP0.VK*1000;
  Form4.DDSpinEdit20.Value:=NP0.tau_m0*1000;
  Form4.DDSpinEdit21.Value:=NP0.gCaT;
  Form4.DDSpinEdit22.Value:=NP0.gBst;
  Form4.DDSpinEdit23.Value:=NP0.gNaP;
  Form4.DDSpinEdit24.Value:=tau1;
  Form4.DDSpinEdit25.Value:=NP0.gKD;
  Form4.DDSpinEdit26.Value:=NP0.NaThreshShift;
  Form4.DDSpinEdit27.Value:=NP0.n_AP;
  Form4.DDSpinEdit28.Value:=NP0.Vreset*1000;
  Form4.DDSpinEdit29.Value:=NP0.ThrShift*1000;
  Form4.DDSpinEdit30.Value:=NP0.tau_abs*1000;
  Form4.DDSpinEdit31.Value:=NP0.FixThr*1000;
  Form4.DDSpinEdit32.Value:=NP0.dwAHP;
  Form4.DDSpinEdit33.Value:=NP0.gH;
  Form4.DDSpinEdit34.Value:=NP0.ro;
  Form4.DDSpinEdit35.Value:=NP0.VNaR*1000;
  Form4.DDSpinEdit36.Value:=NP0.dT_AP*1000;
  Form4.DDSpinEdit37.Value:=NP0.dThr_dts*1000;
  Form4.DDSpinEdit38.Value:=NP0.gADP;
  Form4.DDSpinEdit39.Value:=NP0.dwADP;
  Form4.DDSpinEdit40.Value:=NP0.tADP*1000;
  Form4.DDSpinEdit41.Value:=NP0.KJ_NaCooperativity;
  Form4.DDSpinEdit42.Value:=NP0.C_membr*1000;
  Form4.DDSpinEdit43.Value:=NP0.k_a_Brette*1000;
  Form4.DDSpinEdit44.Value:=NP0.dVTdV_Brette;
  Form4.DDSpinEdit45.Value:=Vus*1000;
  Form4.DDSpinEdit46.Value:=NP0.Temperature-273;
  Form4.DDSpinEdit47.Value:=Pip.C1*1000;
  Form4.DDSpinEdit48.Value:=Pip.G1;
  Form4.DDSpinEdit49.Value:=NP0.EIF_deltaT*1e3;
  Form4.DDSpinEdit50.Value:=NP0.EIF_tauw*1e3;
  Form4.DDSpinEdit51.Value{nS}:=NP0.EIF_a  {mS/cm^2}*NP0.Square*1e6;
  Form4.DDSpinEdit52.Value{nA}:=NP0.EIF_dw{muA/cm^2}*NP0.Square*1e6;
  Form4.DDSpinEdit53.Value:=NP0.EIF_VT*1e3;
  Form4.DDSpinEdit56.Value:=NP0.gLd;
  Form4.DDSpinEdit57.Value:=NP0.VLd*1e3;
  Form4.DDSpinEdit58.Value:=NP0.l;
  Form4.DDSpinEdit59.Value:=NP0.DepBlock_limit;
  Form4.  SpinEdit1.Value:=n_Draw;
  Form4.  SpinEdit2.Value:=n_Write;
  Form4.CheckBox4.Checked:=(NP0.IfSpikeDependentEIF=1);
  {=============}
  Form4.StaticText1 .Caption:=CaptionPlusValue(NP0.gNaR  *NP0.Square*1e6, Form4.StaticText1 .Caption);
  Form4.StaticText2 .Caption:=CaptionPlusValue(NP0.gNa   *NP0.Square*1e6, Form4.StaticText2 .Caption);
  Form4.StaticText3 .Caption:=CaptionPlusValue(NP0.gK    *NP0.Square*1e6, Form4.StaticText3 .Caption);
  Form4.StaticText4 .Caption:=CaptionPlusValue(NP0.gKM   *NP0.Square*1e6, Form4.StaticText4 .Caption);
  Form4.StaticText16.Caption:=CaptionPlusValue(NP0.gKA   *NP0.Square*1e6, Form4.StaticText16.Caption);
  Form4.StaticText27.Caption:=CaptionPlusValue(NP0.gKD   *NP0.Square*1e6, Form4.StaticText27.Caption);
  Form4.StaticText23.Caption:=CaptionPlusValue(NP0.gCaT  *NP0.Square*1e6, Form4.StaticText23.Caption);
  Form4.StaticText17.Caption:=CaptionPlusValue(NP0.gCaH  *NP0.Square*1e6, Form4.StaticText17.Caption);
  Form4.StaticText18.Caption:=CaptionPlusValue(NP0.gKCa  *NP0.Square*1e6, Form4.StaticText18.Caption);
  Form4.StaticText41.Caption:=CaptionPlusValue(NP0.gADP  *NP0.Square*1e6, Form4.StaticText41.Caption);
  Form4.StaticText19.Caption:=CaptionPlusValue(NP0.gAHP  *NP0.Square*1e6, Form4.StaticText19.Caption);
  Form4.StaticText24.Caption:=CaptionPlusValue(NP0.gBst  *NP0.Square*1e6, Form4.StaticText24.Caption);
  Form4.StaticText25.Caption:=CaptionPlusValue(NP0.gNaP  *NP0.Square*1e6, Form4.StaticText25.Caption);
  Form4.StaticText14.Caption:=CaptionPlusValue(NP0.gL    *NP0.Square*1e6, Form4.StaticText14.Caption);
  Form4.StaticText28.Caption:='HH_type="'+NP0.HH_type+'"';
  Form4.StaticText65.Caption:='"'+NP0.HH_order+'"';
  {=============}
  Form1.Naslowid1.Checked   :=(ParFile='Na_slow.id');
  Form1.Naslowinaid1.Checked:=(ParFile='Na_slow_ina.id');
  Form1.NaV10S12id1.Checked :=(ParFile='Na_V10&S12.id');
  Form1.APKrylovid1.Checked :=(ParFile='AP_Krylov.id');
  Form1.APid1.Checked       :=(ParFile='AP.id');
  Form1.Aliid1.Checked      :=(ParFile='Ali.id');
  Form1.AliIid1.Checked     :=(ParFile='Ali_I.id');
  Form1.Default1.Checked    :=(ParFile='');
  Application.ProcessMessages;
end;

function DefineAskedCurve:double;
begin
  case Form1.RadioGroup1.ItemIndex of
    0: DefineAskedCurve:=NV0.mm;
    1: DefineAskedCurve:=NV0.hh;
    2: DefineAskedCurve:=NV0.ii;
    3: DefineAskedCurve:=NV0.mmR;
    4: DefineAskedCurve:=NV0.hhR;
    5: {if NP0.IfThrModel=1 then DefineAskedCurve:=ThrNeuron.nn else} DefineAskedCurve:=NV0.nn;
    6: {if NP0.IfThrModel=1 then DefineAskedCurve:=ThrNeuron.nA else} DefineAskedCurve:=NV0.nA;
    7: {if NP0.IfThrModel=1 then DefineAskedCurve:=ThrNeuron.lA else} DefineAskedCurve:=NV0.lA;
    8: {if NP0.IfThrModel=1 then DefineAskedCurve:=ThrNeuron.xD else} DefineAskedCurve:=NV0.xD;
    9: {if NP0.IfThrModel=1 then DefineAskedCurve:=ThrNeuron.yD else} DefineAskedCurve:=NV0.yD;
   10: DefineAskedCurve:=NV0.mCaT;
   11: DefineAskedCurve:=NV0.hCaT;
   12: DefineAskedCurve:=NV0.mCaH;
   13: DefineAskedCurve:=NV0.hCaH;
   14: DefineAskedCurve:=NV0.kCaH;
   15: {if NP0.IfThrModel=1 then DefineAskedCurve:=ThrNeuron.nM else} DefineAskedCurve:=NV0.nM;
   16: DefineAskedCurve:=NV0.Ca;
   17: DefineAskedCurve:=NV0.nKCa;
   18: DefineAskedCurve:=NV0.mBst;
   19: DefineAskedCurve:=NV0.mNaP;
   20: {if NP0.IfThrModel=1 then DefineAskedCurve:=ThrNeuron.wAHP else} DefineAskedCurve:=NV0.wAHP;
   21: DefineAskedCurve:=NV0.V*1000;
   22: DefineAskedCurve:=Vexp[nt,Smpl]*1000;
   23: DefineAskedCurve:=NV0.PSC;
   24: DefineAskedCurve:=avPSC;
   25: DefineAskedCurve:=Vav*1000;
   26: DefineAskedCurve:=NV0.INa;
   27: DefineAskedCurve:=NV0.IK;
   28: DefineAskedCurve:=NV0.IKA;
   29: DefineAskedCurve:=NV0.IKM;
   30: DefineAskedCurve:=NV0.IH;
   31: DefineAskedCurve:=NV0.IAHP;
   32: DefineAskedCurve:=-NV0.Im;
   33: DefineAskedCurve:=-NV0.Im-NV0.INa;
   34: DefineAskedCurve:=NV0.Vd*1000;
   35: {if NP0.IfThrModel=1 then DefineAskedCurve:=ThrNeuron.yK else} DefineAskedCurve:=NV0.yK;
   36: DefineAskedCurve:=du_Reset;
   37: DefineAskedCurve:=NV0.wADP;
   38: DefineAskedCurve:=Vr;
   39: if (t<t_IindShift)or(t>t_Iind+t_IindShift) then DefineAskedCurve:=0 else DefineAskedCurve:=uu;
   40: DefineAskedCurve:=NV0.iiR;
   41: DefineAskedCurve:=NV0.Iind;
  end;
end;

procedure CalcParameters;
begin
  dt:=0.00005 {s};
  NSmpls:=1;
  IfInSyn_al_EQ_beta:=0;
  nt_end:=imin(trunc(t_end/dt), MaxNT);
  { For Exp. data }
  scx_Smpl:=0.001 {s};   shift_Smp:=0;
  scy_Smpl:=-1{pA};
end;

procedure DefaultParameters;
begin
  n_Draw :=5;
  n_Write:=5;
  { Voltage - in 'mV'. }
  Smpl:=1;
  { Electrode-pipette properties }
  Pip.G1:=0;
  Pip.C1:=0;
  { Neuron properties }
  NP0.HH_type:='Migliore';  NP0.HH_order:='1-point';
  NP0.NaR_type:='Calmar';   NP0.NaR_subtype:='Milescu-26';
  NP0.If_I_V_or_g:=2;  { 1-VC; 2-CC; 3-measure g; 4-VC with pipette;
                         5-VC with Vh=Vexp; 6-CC with recorded Iind;
                         7-CC with Iind=Vexp }
  NP0.IfReduced:=0;   NP0.n_AP:=0.5;
  Iind:=100{pA};  du_Reset:=0{mA/cm^2};
  ss:=0{mS/cm^2};  uu:=0{mA/cm^2};  tt:=0;
  NoiseToSignal:=0;
  FC_dFdu:=700;//30{Hz}/0.004{mA/cm^2};
  FC_I0:=0.010; {mA/cm^2}
  FC_freq:=0;//250{Hz};
  tau_E:=0.020{s};   tau_I:=0.050{s};
  t_Iind:=0.050 {s}; t_IindShift:=0 {s};
  t_end:=0.020 {s};
  sc_Simplex:=1;
  WriteOrNot:=0;
  KeepParams:=0;
  NP0.IfBlockNaR:=1; NP0.IfBlockNa:=0; NP0.IfBlockK:=0; NP0.IfBlockPass:=0;
  NP0.Thr_type:='Default-2';
  { Phys and Calc Parameters }
  HodgkinPhysParameters(NP0);
  CalcParameters;
  { Specific parameters from file }
{  if ParFile='' then begin
     CommonParametersFromFile;
  end else begin
     CommonParametersFrom_ParFile;
  end;
  CorrespondParametersToTheForm;}
end;

procedure CommonParametersFrom_ParFile;
{ Specific parameters to read from file }
begin
  DefaultParameters;
  ReadParamsFromFile(ParFile,'CommonParametersFromFile','HodgkinPhysParameters');
  HodgkinPhysParameters(NP0);
  ReadParamsFromFile(ParFile,'HodgkinPhysParameters','KeepParams=0');
  nt_end:=imin(trunc(t_end/dt), MaxNT);
  ReadParamsFromFile(ParFile,'KeepParams=0','ParametersFromFile');
end;

procedure Read_Params_from_File_or_Procedure;
begin
  if ParFile='' then begin
     case Smpl of
     0: ;
     1: ParametersFromFile;
     2: ParametersFromFile2;
     3: ParametersFromFile3;
     4: ParametersFromFile4;
     5: ParametersFromFile5;
     6: ParametersFromFile6;
     7: ParametersFromFile7;
     8: ParametersFromFile8;
     9: ParametersFromFile9;
     10: ParametersFromFile10;
     11: ParametersFromFile11;
     12: ParametersFromFile12;
     13: ParametersFromFile13;
     14: ParametersFromFile14;
     15: ParametersFromFile15;
     16: ParametersFromFile16;
     17: ParametersFromFile17;
     18: ParametersFromFile18;
     19: ParametersFromFile19;
     end;
  end else begin
     case Smpl of
     0: ;
     1:  ReadParamsFromFile(ParFile,'ParametersFromFile','ParametersFromFile2');
     2:  ReadParamsFromFile(ParFile,'ParametersFromFile2','ParametersFromFile3');
     3:  ReadParamsFromFile(ParFile,'ParametersFromFile3','ParametersFromFile4');
     4:  ReadParamsFromFile(ParFile,'ParametersFromFile4','ParametersFromFile5');
     5:  ReadParamsFromFile(ParFile,'ParametersFromFile5','ParametersFromFile6');
     6:  ReadParamsFromFile(ParFile,'ParametersFromFile6','ParametersFromFile7');
     7:  ReadParamsFromFile(ParFile,'ParametersFromFile7','ParametersFromFile8');
     8:  ReadParamsFromFile(ParFile,'ParametersFromFile8','ParametersFromFile9');
     9:  ReadParamsFromFile(ParFile,'ParametersFromFile9','ParametersFromFile10');
     10: ReadParamsFromFile(ParFile,'ParametersFromFile10','ParametersFromFile11');
     11: ReadParamsFromFile(ParFile,'ParametersFromFile11','ParametersFromFile12');
     12: ReadParamsFromFile(ParFile,'ParametersFromFile12','ParametersFromFile13');
     13: ReadParamsFromFile(ParFile,'ParametersFromFile13','ParametersFromFile14');
     14: ReadParamsFromFile(ParFile,'ParametersFromFile14','ParametersFromFile15');
     15: ReadParamsFromFile(ParFile,'ParametersFromFile15','ParametersFromFile16');
     16: ReadParamsFromFile(ParFile,'ParametersFromFile16','ParametersFromFile17');
     17: ReadParamsFromFile(ParFile,'ParametersFromFile17','ParametersFromFile18');
     18: ReadParamsFromFile(ParFile,'ParametersFromFile18','ParametersFromFile19');
     19: ReadParamsFromFile(ParFile,'ParametersFromFile19','end.');
     end;
  end;
end;

procedure InitialConditions;
begin
  NV0.V:=NP0.Vrest;  NV0.Vd:=NP0.Vrest; NV0.IsynE_old:=0;
  du_Reset:=0{mA/cm^2};
  DispV:=0;  NV0.Thr:=100;
  t:=0;   nt:=0;
  freq:=0; NV0.Vold:=NP0.Vrest; NV0.DVDt:=0; NV0.ddV:=0; avVmax:=0;
  ISI[0]:=0; NV0.tAP:=-888; WidthAP:=0; NV0.indic:=0;
//  @NP.IfSpikeOccursInThrModel := @IfSpikeOccursInThrModel;
//  @NP.VThreshold2             := @VThreshold2;
//  InitialConditionsHodgkin;
  Read_Threshold_from_File;
  { Initialize ThrNeuron }
  ThrNeuron.V :=NV0.V;          NV0.DVDt:=0;
  ThrNeuron.VE:=NV0.Vd;
  ThrNeuron.nn:=NV0.nn; ThrNeuron.yK:=NV0.yK;
  ThrNeuron.nA:=NV0.nA; ThrNeuron.lA:=NV0.lA;
  ThrNeuron.xD:=NV0.xD; ThrNeuron.yD:=NV0.yD; ThrNeuron.yH:=NV0.yH;
  ThrNeuron.wAHP:=NV0.wAHP; ThrNeuron.nM:=NV0.nM;
  Pip.V1:=NV0.V;
  Pip.V1old:=NV0.V;
end;

procedure DefineStimulation(NP_:NeuronProperties; var uu_,ss_,u_soma_,s_soma_,
                                                      tt_,Iind_,Vh_ :double);
var gL0 :double;
begin
  uu_:=uu;
  ss_:=ss;
  tt_:=tt;
  u_soma_:=0;
  s_soma_:=s_soma;
  Iind_:=Current_Iind+du_Reset;
  Vh_:=Vhold(t);
  if (t<t_IindShift)or(t>t_Iind+t_IindShift) then begin
     uu_:=0;     ss_:=0;     tt_:=0;    s_soma_:=0;
  end;
  { Noise }
  if IfNoise then begin
     gL0:=NP_.C_membr/NP_.tau_m0;
     if sgm_V=0 then  sgm_V :=Form7.DDSpinEdit13.Value/1000;
     Iind_:=Iind_ + sgm_V*gL0     // changed from uu_ to Iind_ on 23.09.2012
                *sqrt(2*NP_.tau_m0  {/(1+ss_/gL0)} /dt)*randG(0,1); //commented on 20.09.2012
  end;
  if (NoiseP.Ampl>0) then begin
      SynCurrentOnNewStep(NoiseP.Ampl,0,NoiseP.tau, NoiseP.I);
      Iind_:=Iind_ + NoiseP.I;
  end;
end;

procedure Measure_Vmod;
begin
{ 1-VC; 2-CC; 3-measure g; 4-VC with pipette;
                         5-VC with Vh=Vexp; 6-CC with recorded Iind;
                         7-CC with Iind=Vexp }
      if Pip.G1=0 then begin
         case NP0.If_I_V_or_g of
           1: Vr:= NV0.PSC;
           2: Vr:= NV0.V-NP0.Vrest;
           3: Vr:=-NV0.PSC/(NP0.Square*1e9)/(NV0.Vold-Vrev_for_g);
           4: Vr:= NV0.PSC;
           5: Vr:= NV0.PSC;
           6: Vr:= NV0.Iind;
           7: Vr:= NV0.V-NP0.Vrest;
         end;
      end else begin
         case NP0.If_I_V_or_g of
           1: Vr:=  Pip.i2*NP0.Square*1e9;
           2: Vr:=  Pip.V1-NP0.Vrest;
           3: Vr:= -Pip.i2                 /(NV0.Vold-Vrev_for_g);
           4: Vr:=  Pip.i2*NP0.Square*1e9;
           5: Vr:=  Pip.i2*NP0.Square*1e9;
           6: Vr:=  NV0.Iind;
           7: Vr:=  Pip.V1-NP0.Vrest;
         end;
      end;
      if nt<=MaxExp then Vmod[nt,Smpl]:=Vr;
end;

{***********************************************************}
FUNCTION Calc_Functional :double;
var  Func,uu_,ss_,tt_,u_soma_,s_soma_,Iind_,Vh_ :double;
BEGIN
  { Parameters special for Smpl }
  Read_Params_from_File_or_Procedure;
  CorrespondParametersToTheForm;
  if IfWriteInFFF<>0 then Rewrite(fff);
  if WriteOrNot=1 then InitiateWriting;
  Read_Z_for_Freq_and_Vav;
  { Exp. data }
  if {(Smpl=0)or}(SmplFile[Smpl]='NoFile')or(SmplFile[Smpl]='')
             then DontReadExpData
             else     ReadExpData;
  InitialConditions;
  CreateNeuronByTypeO(NP0,ANrn);
  ANrn.InitialConditions;   NP0:=ANrn.NP;
  InitialPicture;
  CorrespondParametersToTheForm;
  Func:=0;
  REPEAT  nt:=nt+1;  t:=nt*dt; { time step }
      DefineStimulation(ANrn.NP,uu_,ss_,u_soma_,s_soma_,tt_,Iind_,Vh_);
      ElectrodePotential(ANrn,  uu_,ss_,u_soma_,s_soma_,Iind_,Vh_);
      {******************************************************}
      ANrn.MembranePotential(uu_,ss_,0,s_soma_,tt_,Iind_,Vh_);
      {******************************************************}
      IfSpikeOccursO(ANrn);
      NV0:=ANrn.NV;
      { Measurement }
      Measure_Vmod;
      { Residuals }
      if (t>t_IindShift)and(nt<MaxExp) then
      Func :=sqrt(sqr( Func)*(nt-1)/nt+sqr(Vexp[nt,Smpl]-Vr)/nt);
      { Writing and Drawing }
      if NV0.indic=2 then DrawSpike;
      if (nt=1)or(trunc(nt/n_Draw)=nt/n_Draw)  then Evolution;
      if (WriteOrNot=1) and (trunc(nt/n_Write)=nt/n_Write) then Writing;
      if (trunc(nt/n_Write)=nt/n_Write) then
      case IfWriteInFFF of
      1: writeln(fff, t*1e3:9:3,' ',NV0.V*1e3:9:3);
      2: writeln(fff, t*1e3:9:3,' ',Vexp[nt,Smpl]:9:3,' ',Vr:9:3);
      3: writeln(fff, t*1e3:9:3,' ',NV0.mmR:9:3,' ',NV0.hhR:9:3);
      4: writeln(fff, t*1e3:9:3,' ',DefineAskedCurve:13);
      end;
      if ((IfWriteInFFF=4)or(IfDrawAskedCurve=1))and
         (trunc(nt/n_Draw)=nt/n_Draw) then
          DrawAskedCurve(t*1000,DefineAskedCurve);
      FrequencyAmplitudeO(ANrn);
      if nt mod 100*n_Draw = 0 then Application.ProcessMessages;
      Pause;
  UNTIL nt>=nt_end;
  Calc_Functional:=Func;
  if WriteOrNot=1 then close(ccc);
  CloseFFF;
  ANrn.Free;
END;

procedure VoltageOrCurrentClamp(u,s :double);
{ ********************************************************************
  Solve Hodgkin-Huxley equations.
**********************************************************************}
var  dum :double;
BEGIN
  uu:=u;  ss:=s;
  dum:=Calc_Functional;
END;

end.
