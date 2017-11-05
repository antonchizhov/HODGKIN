unit Unit4;   {Form4 - Parameters}

interface

uses
{  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DDSpinEdit,Init;}
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, {sgr_def, sgr_data, sgr_mark,} ComCtrls, Menus,
  ExtCtrls, Spin, DDSpinEdit,
  Unit2,Unit3,
  MyTypes,Init,t_dtO,CreateNrnO,typeNrnParsO,Electrode;

type
  TForm4 = class(TForm)
    DDSpinEdit5: TDDSpinEdit;
    StaticText5: TStaticText;
    StaticText8: TStaticText;
    DDSpinEdit6: TDDSpinEdit;
    StaticText15: TStaticText;
    DDSpinEdit13: TDDSpinEdit;
    StaticText20: TStaticText;
    DDSpinEdit18: TDDSpinEdit;
    DDSpinEdit19: TDDSpinEdit;
    StaticText21: TStaticText;
    DDSpinEdit20: TDDSpinEdit;
    StaticText22: TStaticText;
    Button2: TButton;
    DDSpinEdit34: TDDSpinEdit;
    StaticText37: TStaticText;
    StaticText45: TStaticText;
    DDSpinEdit42: TDDSpinEdit;
    StaticText28: TStaticText;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    StaticText10: TStaticText;
    StaticText11: TStaticText;
    StaticText12: TStaticText;
    StaticText13: TStaticText;
    DDSpinEdit8: TDDSpinEdit;
    DDSpinEdit9: TDDSpinEdit;
    DDSpinEdit10: TDDSpinEdit;
    DDSpinEdit11: TDDSpinEdit;
    StaticText29: TStaticText;
    DDSpinEdit26: TDDSpinEdit;
    DDSpinEdit35: TDDSpinEdit;
    StaticText38: TStaticText;
    CheckBox1: TCheckBox;
    StaticText44: TStaticText;
    DDSpinEdit41: TDDSpinEdit;
    StaticText49: TStaticText;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    StaticText50: TStaticText;
    CheckBox3: TCheckBox;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    StaticText51: TStaticText;
    StaticText52: TStaticText;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    DDSpinEdit24: TDDSpinEdit;
    StaticText26: TStaticText;
    StaticText30: TStaticText;
    DDSpinEdit27: TDDSpinEdit;
    StaticText31: TStaticText;
    DDSpinEdit28: TDDSpinEdit;
    StaticText32: TStaticText;
    DDSpinEdit29: TDDSpinEdit;
    DDSpinEdit31: TDDSpinEdit;
    StaticText34: TStaticText;
    StaticText40: TStaticText;
    DDSpinEdit37: TDDSpinEdit;
    StaticText33: TStaticText;
    StaticText35: TStaticText;
    StaticText42: TStaticText;
    StaticText39: TStaticText;
    StaticText43: TStaticText;
    CheckBox2: TCheckBox;
    DDSpinEdit43: TDDSpinEdit;
    StaticText46: TStaticText;
    DDSpinEdit44: TDDSpinEdit;
    StaticText47: TStaticText;
    DDSpinEdit30: TDDSpinEdit;
    DDSpinEdit32: TDDSpinEdit;
    DDSpinEdit39: TDDSpinEdit;
    DDSpinEdit40: TDDSpinEdit;
    DDSpinEdit36: TDDSpinEdit;
    Button1: TButton;
    GroupBox5: TGroupBox;
    StaticText6: TStaticText;
    SpinEdit1: TSpinEdit;
    StaticText7: TStaticText;
    SpinEdit2: TSpinEdit;
    GroupBox4: TGroupBox;
    StaticText48: TStaticText;
    DDSpinEdit45: TDDSpinEdit;
    GroupBox3: TGroupBox;
    DDSpinEdit47: TDDSpinEdit;
    DDSpinEdit48: TDDSpinEdit;
    StaticText54: TStaticText;
    StaticText55: TStaticText;
    RadioGroup1: TRadioGroup;
    GroupBox6: TGroupBox;
    DDSpinEdit49: TDDSpinEdit;
    StaticText56: TStaticText;
    StaticText57: TStaticText;
    DDSpinEdit50: TDDSpinEdit;
    DDSpinEdit51: TDDSpinEdit;
    DDSpinEdit52: TDDSpinEdit;
    StaticText58: TStaticText;
    StaticText59: TStaticText;
    DDSpinEdit53: TDDSpinEdit;
    StaticText60: TStaticText;
    Button3: TButton;
    Button4: TButton;
    CheckBox4: TCheckBox;
    GroupBox7: TGroupBox;
    DDSpinEdit46: TDDSpinEdit;
    StaticText53: TStaticText;
    GroupBox8: TGroupBox;
    Label3: TLabel;
    StaticText14: TStaticText;
    StaticText36: TStaticText;
    StaticText18: TStaticText;
    StaticText17: TStaticText;
    StaticText23: TStaticText;
    StaticText41: TStaticText;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText16: TStaticText;
    StaticText19: TStaticText;
    StaticText24: TStaticText;
    StaticText25: TStaticText;
    StaticText27: TStaticText;
    DDSpinEdit1: TDDSpinEdit;
    DDSpinEdit2: TDDSpinEdit;
    DDSpinEdit3: TDDSpinEdit;
    DDSpinEdit4: TDDSpinEdit;
    DDSpinEdit14: TDDSpinEdit;
    DDSpinEdit25: TDDSpinEdit;
    DDSpinEdit21: TDDSpinEdit;
    DDSpinEdit15: TDDSpinEdit;
    DDSpinEdit16: TDDSpinEdit;
    DDSpinEdit33: TDDSpinEdit;
    DDSpinEdit38: TDDSpinEdit;
    DDSpinEdit17: TDDSpinEdit;
    DDSpinEdit22: TDDSpinEdit;
    DDSpinEdit23: TDDSpinEdit;
    DDSpinEdit12: TDDSpinEdit;
    GroupBox9: TGroupBox;
    StaticText9: TStaticText;
    DDSpinEdit7: TDDSpinEdit;
    procedure DDSpinEdit1Change(Sender: TObject);
    procedure DDSpinEdit2Change(Sender: TObject);
    procedure DDSpinEdit3Change(Sender: TObject);
    procedure DDSpinEdit4Change(Sender: TObject);
    procedure DDSpinEdit5Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure DDSpinEdit6Change(Sender: TObject);
    procedure DDSpinEdit7Change(Sender: TObject);
    procedure DDSpinEdit8Change(Sender: TObject);
    procedure DDSpinEdit9Change(Sender: TObject);
    procedure DDSpinEdit10Change(Sender: TObject);
    procedure DDSpinEdit11Change(Sender: TObject);
    procedure DDSpinEdit12Change(Sender: TObject);
    procedure DDSpinEdit13Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DDSpinEdit14Change(Sender: TObject);
    procedure DDSpinEdit15Change(Sender: TObject);
    procedure DDSpinEdit16Change(Sender: TObject);
    procedure DDSpinEdit17Change(Sender: TObject);
    procedure DDSpinEdit18Change(Sender: TObject);
    procedure DDSpinEdit19Change(Sender: TObject);
    procedure DDSpinEdit20Change(Sender: TObject);
    procedure DDSpinEdit21Change(Sender: TObject);
    procedure DDSpinEdit22Change(Sender: TObject);
    procedure DDSpinEdit23Change(Sender: TObject);
    procedure DDSpinEdit24Change(Sender: TObject);
    procedure DDSpinEdit25Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DDSpinEdit26Change(Sender: TObject);
    procedure DDSpinEdit27Change(Sender: TObject);
    procedure DDSpinEdit28Change(Sender: TObject);
    procedure DDSpinEdit29Change(Sender: TObject);
    procedure DDSpinEdit30Change(Sender: TObject);
    procedure DDSpinEdit31Change(Sender: TObject);
    procedure DDSpinEdit33Change(Sender: TObject);
    procedure DDSpinEdit32Change(Sender: TObject);
    procedure DDSpinEdit34Change(Sender: TObject);
    procedure DDSpinEdit17DblClick(Sender: TObject);
    procedure DDSpinEdit4DblClick(Sender: TObject);
    procedure DDSpinEdit35Change(Sender: TObject);
    procedure DDSpinEdit36Change(Sender: TObject);
    procedure DDSpinEdit37Change(Sender: TObject);
    procedure DDSpinEdit38Change(Sender: TObject);
    procedure DDSpinEdit39Change(Sender: TObject);
    procedure DDSpinEdit38DblClick(Sender: TObject);
    procedure DDSpinEdit40Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure DDSpinEdit41Change(Sender: TObject);
    procedure DDSpinEdit42Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure DDSpinEdit43Change(Sender: TObject);
    procedure DDSpinEdit44Change(Sender: TObject);
    procedure DDSpinEdit45Change(Sender: TObject);
    procedure DDSpinEdit2DblClick(Sender: TObject);
    procedure DDSpinEdit1DblClick(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure DDSpinEdit3DblClick(Sender: TObject);
    procedure DDSpinEdit14DblClick(Sender: TObject);
    procedure DDSpinEdit25DblClick(Sender: TObject);
    procedure DDSpinEdit33DblClick(Sender: TObject);
    procedure DDSpinEdit5DblClick(Sender: TObject);
    procedure DDSpinEdit46Change(Sender: TObject);
    procedure DDSpinEdit48Change(Sender: TObject);
    procedure DDSpinEdit47Change(Sender: TObject);
    procedure DDSpinEdit48DblClick(Sender: TObject);
    procedure DDSpinEdit47DblClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure DDSpinEdit49Change(Sender: TObject);
    procedure DDSpinEdit50Change(Sender: TObject);
    procedure DDSpinEdit51Change(Sender: TObject);
    procedure DDSpinEdit52Change(Sender: TObject);
    procedure DDSpinEdit53Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function CaptionPlusValue(Value :double; Caption: string) :string;

var
  Form4: TForm4;

implementation

uses MathMyO,Other,Graph,Coeff,Hodgkin,SetNrnParsO,Clamp,Simplex,
     Reader,Act_Inact,Threshold,Unit11,Unit12,Unit5;

{$R *.DFM}

function CaptionPlusValue(Value :double; Caption: string) :string;
var t1 :String;
    l :integer;
begin
  str(Value:7:2,t1);
  t1:=t1;//+' nS';
//  l:=Length(Caption)-10;
  l:=47;
  SetLength(Caption, l);
  CaptionPlusValue:=Caption+t1;
end;

procedure TForm4.DDSpinEdit1Change(Sender: TObject);
begin
  NP0.gNaR  :=Form4.DDSpinEdit1.Value;
  Form4.StaticText1.Caption:=CaptionPlusValue(NP0.gNaR*NP0.Square*1e6, Form4.StaticText1.Caption);
end;

procedure TForm4.DDSpinEdit2Change(Sender: TObject);
begin
  NP0.gNa:=Form4.DDSpinEdit2.Value;
  Form4.StaticText2 .Caption:=CaptionPlusValue(NP0.gNa*NP0.Square*1e6, Form4.StaticText2 .Caption);
end;

procedure TForm4.DDSpinEdit3Change(Sender: TObject);
begin
  NP0.gK    :=Form4.DDSpinEdit3.Value;
  Form4.StaticText3 .Caption:=CaptionPlusValue(NP0.gK    *NP0.Square*1e6, Form4.StaticText3 .Caption);
end;

procedure TForm4.DDSpinEdit4Change(Sender: TObject);
begin
  NP0.gKM   :=Form4.DDSpinEdit4.Value;
  Form4.StaticText4 .Caption:=CaptionPlusValue(NP0.gKM   *NP0.Square*1e6, Form4.StaticText4 .Caption);
end;

procedure TForm4.DDSpinEdit5Change(Sender: TObject);
begin
  NP0.Square:=Form4.DDSpinEdit5.Value/1e5;
end;

procedure TForm4.DDSpinEdit14Change(Sender: TObject);
begin
  NP0.gKA   :=Form4.DDSpinEdit14.Value;
  Form4.StaticText16.Caption:=CaptionPlusValue(NP0.gKA   *NP0.Square*1e6, Form4.StaticText16.Caption);
end;

procedure TForm4.DDSpinEdit15Change(Sender: TObject);
begin
  NP0.gCaH  :=Form4.DDSpinEdit15.Value;
  Form4.StaticText17.Caption:=CaptionPlusValue(NP0.gCaH  *NP0.Square*1e6, Form4.StaticText17.Caption);
end;

procedure TForm4.DDSpinEdit16Change(Sender: TObject);
begin
  NP0.gKCa  :=Form4.DDSpinEdit16.Value;
  Form4.StaticText18.Caption:=CaptionPlusValue(NP0.gKCa  *NP0.Square*1e6, Form4.StaticText18.Caption);
end;

procedure TForm4.DDSpinEdit33Change(Sender: TObject);
begin
  NP0.gH  :=Form4.DDSpinEdit33.Value;
  Form4.StaticText36.Caption:=CaptionPlusValue(NP0.gH    *NP0.Square*1e6, Form4.StaticText36.Caption);
end;

procedure TForm4.DDSpinEdit17Change(Sender: TObject);
begin
  NP0.gAHP  :=Form4.DDSpinEdit17.Value;
  Form4.StaticText19.Caption:=CaptionPlusValue(NP0.gAHP  *NP0.Square*1e6, Form4.StaticText19.Caption);
end;

procedure TForm4.DDSpinEdit21Change(Sender: TObject);
begin
  NP0.gCaT  :=Form4.DDSpinEdit21.Value;
  Form4.StaticText23.Caption:=CaptionPlusValue(NP0.gCaT  *NP0.Square*1e6, Form4.StaticText23.Caption);
end;

procedure TForm4.DDSpinEdit22Change(Sender: TObject);
begin
  NP0.gBst  :=Form4.DDSpinEdit22.Value;
  Form4.StaticText24.Caption:=CaptionPlusValue(NP0.gBst  *NP0.Square*1e6, Form4.StaticText24.Caption);
end;

procedure TForm4.DDSpinEdit23Change(Sender: TObject);
begin
  NP0.gNaP  :=Form4.DDSpinEdit23.Value;
  Form4.StaticText25.Caption:=CaptionPlusValue(NP0.gNaP  *NP0.Square*1e6, Form4.StaticText25.Caption);
end;

procedure TForm4.DDSpinEdit24Change(Sender: TObject);
begin
  tau1  :=Form4.DDSpinEdit24.Value;
end;

procedure TForm4.DDSpinEdit25Change(Sender: TObject);
begin
  NP0.gKD   :=Form4.DDSpinEdit25.Value;
  Form4.StaticText27.Caption:=CaptionPlusValue(NP0.gKD   *NP0.Square*1e6, Form4.StaticText27.Caption);
end;

procedure TForm4.DDSpinEdit26Change(Sender: TObject);
begin
  NP0.NaThreshShift:=Form4.DDSpinEdit26.Value;
end;

procedure TForm4.DDSpinEdit27Change(Sender: TObject);
begin
  NP0.n_AP:=Form4.DDSpinEdit27.Value;
end;

procedure TForm4.DDSpinEdit28Change(Sender: TObject);
begin
  NP0.Vreset:=Form4.DDSpinEdit28.Value/1000;
end;

procedure TForm4.DDSpinEdit29Change(Sender: TObject);
begin
  NP0.ThrShift:=Form4.DDSpinEdit29.Value/1000;
end;

procedure TForm4.DDSpinEdit30Change(Sender: TObject);
begin
  NP0.tau_abs:=Form4.DDSpinEdit30.Value/1000;
end;

procedure TForm4.DDSpinEdit42Change(Sender: TObject);
var l :integer;
    t1 :string;
begin
  NP0.C_membr  :=Form4.DDSpinEdit42.Value/1e3;  {mF/cm^2}
  t1:=Form4.StaticText45.Caption;
  t1:=CaptionPlusValue(NP0.C_membr*NP0.Square*1e9, t1);
//  l:=55;
//  SetLength(t1,l);
  Form4.StaticText45.Caption:=t1+' pF';
end;

procedure TForm4.SpinEdit1Change(Sender: TObject);
begin
  if Form4.SpinEdit1.Value<=0 then Form4.SpinEdit1.Value:=1;
  n_Draw:=Form4.SpinEdit1.Value;
end;

procedure TForm4.SpinEdit2Change(Sender: TObject);
begin
  n_Write:=Form4.SpinEdit2.Value;
end;

procedure TForm4.DDSpinEdit7Change(Sender: TObject);
begin
  //if Form4.DDSpinEdit7.Value<=0 then Form4.DDSpinEdit7.Value:=0.001;
  if Form4.DDSpinEdit7.Value>0 then  dt  :=Form4.DDSpinEdit7.Value/1000;
  nt_end:=imin(trunc(t_end/dt), MaxNT);
end;

procedure TForm4.DDSpinEdit8Change(Sender: TObject);
begin
  NP0.a3NaR  :=Form4.DDSpinEdit8.Value;
end;

procedure TForm4.DDSpinEdit9Change(Sender: TObject);
begin
  NP0.b3NaR  :=Form4.DDSpinEdit9.Value;
end;

procedure TForm4.DDSpinEdit10Change(Sender: TObject);
begin
  NP0.c3NaR  :=Form4.DDSpinEdit10.Value;
end;

procedure TForm4.DDSpinEdit11Change(Sender: TObject);
begin
  NP0.d3NaR  :=Form4.DDSpinEdit11.Value;
end;

procedure TForm4.DDSpinEdit12Change(Sender: TObject);
begin
  NP0.gL  :=Form4.DDSpinEdit12.Value;
  {tau_m[1]:=C_membr/gL[1];}
  Form4.StaticText14.Caption:=CaptionPlusValue(NP0.gL *NP0.Square*1e6, Form4.StaticText14.Caption);
end;

procedure TForm4.DDSpinEdit13Change(Sender: TObject);
begin
  NP0.VNa    :=Form4.DDSpinEdit13.Value/1000;
end;

procedure TForm4.DDSpinEdit19Change(Sender: TObject);
begin
  NP0.VK     :=Form4.DDSpinEdit19.Value/1000;
end;

procedure TForm4.DDSpinEdit18Change(Sender: TObject);
begin
//  VLo    :=VL[1];
  NP0.VL  :=Form4.DDSpinEdit18.Value/1000;
//  Vrest[1]:=Vrest[1]+VL[1]-VLo;
//  Form4.DDSpinEdit6.Value:=Vrest[1]*1000;
end;

procedure TForm4.DDSpinEdit6Change(Sender: TObject);
begin
  NP0.Vrest:=Form4.DDSpinEdit6.Value/1000;
//  Form4.DDSpinEdit18.Value:=VL[1]*1000;
end;

procedure TForm4.DDSpinEdit20Change(Sender: TObject);
begin
  NP0.tau_m0:=Form4.DDSpinEdit20.Value/1000;
end;

procedure TForm4.Button1Click(Sender: TObject);
var Dir :string;
begin
  Form4.GroupBox1.Visible:=not(Form4.GroupBox1.Visible);
  Form4.GroupBox2.Visible:=not(Form4.GroupBox2.Visible);
  GetDir(0,Dir);
  Application.HelpFile :=Dir+'\Help\MyHelp.hlp';
  Application.HelpJump('Parameters');
end;

procedure TForm4.ComboBox1Change(Sender: TObject);
begin
  NP0.NaR_type:=Form4.ComboBox1.Items[Form4.ComboBox1.ItemIndex];
  if NP0.NaR_type='Milescu' then NP0.NaR_subtype:='Milescu-26';
  if NP0.NaR_type='Lyle'    then NP0.NaR_subtype:='Lyle-4';
  SetParamsForNaR(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm4.ComboBox2Change(Sender: TObject);
begin
  NP0.NaR_subtype:=Form4.ComboBox2.Items[Form4.ComboBox2.ItemIndex];
  SetParamsForNaR(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm4.ComboBox3Change(Sender: TObject);
begin
  NP0.Na_type:=Form4.ComboBox3.Items[Form4.ComboBox3.ItemIndex];
  if NP0.Na_type='Milescu' then NP0.Na_subtype:='Milescu-26';
  if NP0.Na_type='Lyle'    then NP0.Na_subtype:='Lyle-4';
  CorrespondParametersToTheForm;
end;

procedure TForm4.ComboBox4Change(Sender: TObject);
begin
  NP0.Na_subtype:=Form4.ComboBox4.Items[Form4.ComboBox4.ItemIndex];
  CorrespondParametersToTheForm;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
  CreateNeuronByTypeO(NP0,ANrn);
  ANrn.InitialConditions;   NP0:=ANrn.NP;
  ANrn.Free;
//  InitialConditions;
  CorrespondParametersToTheForm;
end;

procedure TForm4.DDSpinEdit31Change(Sender: TObject);
begin
  NP0.FixThr:=Form4.DDSpinEdit31.Value/1000;
end;

procedure TForm4.DDSpinEdit32Change(Sender: TObject);
begin
  NP0.dwAHP:=Form4.DDSpinEdit32.Value;
end;

procedure TForm4.DDSpinEdit34Change(Sender: TObject);
begin
  NP0.ro:=Form4.DDSpinEdit34.Value;
end;

procedure TForm4.DDSpinEdit17DblClick(Sender: TObject);
begin
  Form4.DDSpinEdit17.Value:=0;
end;

procedure TForm4.DDSpinEdit4DblClick(Sender: TObject);
begin
  Form4.DDSpinEdit4.Value:=0;
end;

procedure TForm4.DDSpinEdit35Change(Sender: TObject);
begin
  NP0.VNaR:=Form4.DDSpinEdit35.Value/1000;
end;

procedure TForm4.DDSpinEdit36Change(Sender: TObject);
begin
  NP0.dT_AP:=Form4.DDSpinEdit36.Value/1000;
end;

procedure TForm4.DDSpinEdit37Change(Sender: TObject);
begin
  NP0.dThr_dts:=Form4.DDSpinEdit37.Value/1000;
end;

procedure TForm4.DDSpinEdit38Change(Sender: TObject);
begin
  NP0.gADP  :=Form4.DDSpinEdit38.Value;
  Form4.StaticText41.Caption:=CaptionPlusValue(NP0.gADP  *NP0.Square*1e6, Form4.StaticText41.Caption);
end;

procedure TForm4.DDSpinEdit39Change(Sender: TObject);
begin
  NP0.dwADP:=Form4.DDSpinEdit39.Value;
end;

procedure TForm4.DDSpinEdit38DblClick(Sender: TObject);
begin
  Form4.DDSpinEdit38.Value:=0;
end;

procedure TForm4.DDSpinEdit40Change(Sender: TObject);
begin
 NP0.tADP:=Form4.DDSpinEdit40.Value/1000;
end;

procedure TForm4.CheckBox1Click(Sender: TObject);
begin
 NP0.If_Slow_Na_inactivation:=IfTrue(Form4.CheckBox1.Checked);
end;

procedure TForm4.CheckBox3Click(Sender: TObject);
begin
 NP0.If_Slow_NaR_inactivation:=IfTrue(Form4.CheckBox3.Checked);
end;

procedure TForm4.DDSpinEdit41Change(Sender: TObject);
begin
  NP0.KJ_NaCooperativity:=Form4.DDSpinEdit41.Value;
end;

procedure TForm4.CheckBox2Click(Sender: TObject);
begin
  Form4.DDSpinEdit43.Enabled:=Form4.CheckBox2.Checked;
  NP0.IfBretteThreshold:=IfTrue(Form4.CheckBox2.Checked);
end;

procedure TForm4.DDSpinEdit43Change(Sender: TObject);
begin
  NP0.k_a_Brette:=Form4.DDSpinEdit43.Value/1000;
end;

procedure TForm4.DDSpinEdit44Change(Sender: TObject);
begin
  NP0.dVTdV_Brette:=Form4.DDSpinEdit44.Value;
end;

procedure TForm4.DDSpinEdit45Change(Sender: TObject);
begin
  Vus:=Form4.DDSpinEdit45.Value/1000;
end;

procedure TForm4.DDSpinEdit2DblClick(Sender: TObject);
begin
  Form4.DDSpinEdit2.Value:=0;
  NP0.gNa:=Form4.DDSpinEdit2.Value;
end;

procedure TForm4.DDSpinEdit1DblClick(Sender: TObject);
begin
  Form4.DDSpinEdit1.Value:=0;
  NP0.gNaR  :=Form4.DDSpinEdit1.Value;
end;

procedure TForm4.DDSpinEdit3DblClick(Sender: TObject);
begin
  Form4.DDSpinEdit3.Value:=0;
end;

procedure TForm4.DDSpinEdit14DblClick(Sender: TObject);
begin
  Form4.DDSpinEdit14.Value:=0;
end;

procedure TForm4.DDSpinEdit25DblClick(Sender: TObject);
begin
  Form4.DDSpinEdit25.Value:=0;
end;

procedure TForm4.DDSpinEdit33DblClick(Sender: TObject);
begin
  Form4.DDSpinEdit33.Value:=0;
end;

procedure TForm4.DDSpinEdit5DblClick(Sender: TObject);
begin
  Form4.DDSpinEdit5.Value:=0;
  NP0.Square:=0;
end;

procedure TForm4.DDSpinEdit46Change(Sender: TObject);
begin
  NP0.Temperature:=Form4.DDSpinEdit46.Value+273;
end;

procedure TForm4.DDSpinEdit48Change(Sender: TObject);
begin
  Pip.G1:=Form4.DDSpinEdit48.Value;
  if (Pip.G1 =0)and(NP0.If_I_V_or_g=4) then NP0.If_I_V_or_g:=5;
  if (Pip.G1<>0)and(NP0.If_I_V_or_g=5) then NP0.If_I_V_or_g:=4;
end;

procedure TForm4.DDSpinEdit47Change(Sender: TObject);
begin
  Pip.C1:=Form4.DDSpinEdit47.Value/1e3;  {mF/cm^2}
end;

procedure TForm4.DDSpinEdit48DblClick(Sender: TObject);
begin
  Form4.DDSpinEdit48.Value:=0;
  Pip.G1:=0;
  if (Pip.G1 =0)and(NP0.If_I_V_or_g=4) then NP0.If_I_V_or_g:=5;
  if (Pip.G1<>0)and(NP0.If_I_V_or_g=5) then NP0.If_I_V_or_g:=4;
end;

procedure TForm4.DDSpinEdit47DblClick(Sender: TObject);
begin
  Form4.DDSpinEdit47.Value:=0;
  Pip.C1:=0;
end;

procedure TForm4.RadioGroup1Click(Sender: TObject);
begin
  case Form4.RadioGroup1.ItemIndex of
  0: begin
       Form4.PageControl1.Left:=290;
       Form4.PageControl1.Top:=50;
       Form11.Top:=530;
       Form12.Top:=29;
       Form5.Top:=241;
     end;
  1: begin
       Form4.PageControl1.Left:=0;
       Form4.PageControl1.Top:=560;
       Form11.Top:=730;
       Form12.Top:=269;
       Form5.Top:=741;
     end;
  end;
end;

procedure TForm4.DDSpinEdit49Change(Sender: TObject);
begin
  NP0.EIF_deltaT:=Form4.DDSpinEdit49.Value/1e3; {V}
end;

procedure TForm4.DDSpinEdit50Change(Sender: TObject);
begin
  NP0.EIF_tauw:=Form4.DDSpinEdit50.Value/1e3; {s}
end;

procedure TForm4.DDSpinEdit51Change(Sender: TObject);
begin
  NP0.EIF_a:=Form4.DDSpinEdit51.Value{nS}/NP0.Square/1e6; {mS/cm^2}
end;

procedure TForm4.DDSpinEdit52Change(Sender: TObject);
begin
  NP0.EIF_dw:=Form4.DDSpinEdit52.Value{nA}/NP0.Square/1e6;   {mA/cm^2}
end;

procedure TForm4.DDSpinEdit53Change(Sender: TObject);
begin
  NP0.EIF_VT:=Form4.DDSpinEdit53.Value/1e3; {V}
  if NP0.EIF_VT<>0 then begin
     NP0.FixThr:=0.080; {V}
     NP0.EIF_deltaT:=0.002; {V}
  end else NP0.FixThr:=0;
  Form4.DDSpinEdit31.Value:=NP0.FixThr*1000;
  Form4.DDSpinEdit49.Value:=NP0.EIF_deltaT*1e3;
end;

procedure TForm4.Button3Click(Sender: TObject);
{ defaults [Brette 2005] }
begin
  NP0.IfSpikeDependentEIF:=0;
  NP0.EIF_VT:=-0.0504; {V}
  NP0.FixThr:=0.080; {V}
  NP0.EIF_deltaT:=0.002; {V}
  NP0.EIF_tauw:=0.144; {s}
  NP0.EIF_a:=4{nS}/NP0.Square/1e6; {mS/cm^2}
  NP0.EIF_dw:=0.0805{nA}/NP0.Square/1e6;   {mA/cm^2}
  Form4.CheckBox4.Checked:=(NP0.IfSpikeDependentEIF=1);
  Form4.DDSpinEdit31.Value:=NP0.FixThr*1000;
  Form4.DDSpinEdit49.Value:=NP0.EIF_deltaT*1e3;
  Form4.DDSpinEdit50.Value:=NP0.EIF_tauw*1e3;
  Form4.DDSpinEdit51.Value{nS}:=NP0.EIF_a  {mS/cm^2}*NP0.Square*1e6;
  Form4.DDSpinEdit52.Value{nA}:=NP0.EIF_dw{muA/cm^2}*NP0.Square*1e6;
  Form4.DDSpinEdit53.Value:=NP0.EIF_VT*1e3;
end;

procedure TForm4.Button4Click(Sender: TObject);
{ defaults [Badel 2008] }
begin
  NP0.IfSpikeDependentEIF:=1;
  NP0.Square:=260{pF}/NP0.C_membr{mF/cm^2}/1e9; {cm^2}
  NP0.Vrest:=-0.057; {V}
  NP0.tau_m0:=0.0172; {s}
  NP0.EIF_VT:=-0.042; {V}
  NP0.FixThr:=0.080; {V}
  NP0.EIF_deltaT:=0.00151; {V}
  NP0.EIF_tauw:=0;
  NP0.EIF_a:=0;
  NP0.EIF_dw:=0;
  Form4.CheckBox4.Checked:=(NP0.IfSpikeDependentEIF=1);
  Form4.DDSpinEdit5.Value:=NP0.Square*1e5;
  Form4.DDSpinEdit6.Value:=NP0.Vrest*1000;
  Form4.DDSpinEdit20.Value:=NP0.tau_m0*1000;
  Form4.DDSpinEdit31.Value:=NP0.FixThr*1000;
  Form4.DDSpinEdit49.Value:=NP0.EIF_deltaT*1e3;
  Form4.DDSpinEdit50.Value:=NP0.EIF_tauw*1e3;
  Form4.DDSpinEdit51.Value{nS}:=NP0.EIF_a  {mS/cm^2}*NP0.Square*1e6;
  Form4.DDSpinEdit52.Value{nA}:=NP0.EIF_dw{muA/cm^2}*NP0.Square*1e6;
  Form4.DDSpinEdit53.Value:=NP0.EIF_VT*1e3;
end;

end.
