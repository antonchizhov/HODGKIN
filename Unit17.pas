unit Unit17;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, ComCtrls, StdCtrls,
  Coeff, Simplex, Unit1,Unit4,Unit2, Init,SetNrnParsO,MyTypes,t_dtO,MathMyO,
  TeEngine, Series, DDSpinEdit,
  TeeProcs, Chart, Spin;

type
  TForm17 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    PageControl2: TPageControl;
    TabSheet2: TTabSheet;
    Image1: TImage;
    TabSheet3: TTabSheet;
    Image2: TImage;
    TabSheet4: TTabSheet;
    Image3: TImage;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    Button2: TButton;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    DDSpinEdit1: TDDSpinEdit;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    DDSpinEdit2: TDDSpinEdit;
    DDSpinEdit3: TDDSpinEdit;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    DDSpinEdit4: TDDSpinEdit;
    DDSpinEdit5: TDDSpinEdit;
    DDSpinEdit6: TDDSpinEdit;
    DDSpinEdit7: TDDSpinEdit;
    DDSpinEdit8: TDDSpinEdit;
    DDSpinEdit9: TDDSpinEdit;
    DDSpinEdit10: TDDSpinEdit;
    CheckBox11: TCheckBox;
    DDSpinEdit11: TDDSpinEdit;
    CheckBox12: TCheckBox;
    DDSpinEdit12: TDDSpinEdit;
    Button1: TButton;
    Button3: TButton;
    Label1: TLabel;
    Chart3: TChart;
    Series10: TLineSeries;
    Series11: TLineSeries;
    SpinEdit1: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    TabSheet7: TTabSheet;
    Button4: TButton;
    Chart1: TChart;
    Series1: TFastLineSeries;
    DDSpinEdit13: TDDSpinEdit;
    StaticText4: TStaticText;
    RadioGroup1: TRadioGroup;
    GroupBox2: TGroupBox;
    CheckBox13: TCheckBox;
    DDSpinEdit14: TDDSpinEdit;
    CheckBox14: TCheckBox;
    CheckBox15: TCheckBox;
    DDSpinEdit15: TDDSpinEdit;
    DDSpinEdit16: TDDSpinEdit;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox18: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox20: TCheckBox;
    DDSpinEdit17: TDDSpinEdit;
    DDSpinEdit18: TDDSpinEdit;
    DDSpinEdit19: TDDSpinEdit;
    DDSpinEdit20: TDDSpinEdit;
    DDSpinEdit21: TDDSpinEdit;
    DDSpinEdit22: TDDSpinEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    DDSpinEdit23: TDDSpinEdit;
    PageControl3: TPageControl;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    Image6: TImage;
    Button5: TButton;
    Button6: TButton;
    Button8: TButton;
    Label4: TLabel;
    DDSpinEdit24: TDDSpinEdit;
    DDSpinEdit25: TDDSpinEdit;
    StaticText3: TStaticText;
    Chart4: TChart;
    Series12: TLineSeries;
    Series13: TLineSeries;
    Series15: TLineSeries;
    Image7: TImage;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    DDSpinEdit26: TDDSpinEdit;
    DDSpinEdit27: TDDSpinEdit;
    TabSheet10: TTabSheet;
    Image8: TImage;
    Image4: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DDSpinEdit1Change(Sender: TObject);
    procedure DDSpinEdit2Change(Sender: TObject);
    procedure DDSpinEdit3Change(Sender: TObject);
    procedure DDSpinEdit4Change(Sender: TObject);
    procedure DDSpinEdit5Change(Sender: TObject);
    procedure DDSpinEdit6Change(Sender: TObject);
    procedure DDSpinEdit7Change(Sender: TObject);
    procedure DDSpinEdit8Change(Sender: TObject);
    procedure DDSpinEdit9Change(Sender: TObject);
    procedure DDSpinEdit10Change(Sender: TObject);
    procedure DDSpinEdit11Change(Sender: TObject);
    procedure DDSpinEdit12Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DDSpinEdit13Change(Sender: TObject);
    procedure DDSpinEdit14Change(Sender: TObject);
    procedure DDSpinEdit15Change(Sender: TObject);
    procedure DDSpinEdit16Change(Sender: TObject);
    procedure DDSpinEdit17Change(Sender: TObject);
    procedure DDSpinEdit18Change(Sender: TObject);
    procedure DDSpinEdit19Change(Sender: TObject);
    procedure DDSpinEdit20Change(Sender: TObject);
    procedure DDSpinEdit21Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure DDSpinEdit22Change(Sender: TObject);
    procedure DDSpinEdit23Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure DDSpinEdit25Change(Sender: TObject);
    procedure DDSpinEdit26Change(Sender: TObject);
    procedure DDSpinEdit27Change(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TabSheet6Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form17: TForm17;

procedure FromCoeffsToForm17DDSpinEdits;

implementation
uses Clamp;

{$R *.dfm}

procedure FromCoeffsToForm17DDSpinEdits;
begin
  Form17.DDSpinEdit1.Value :=NP0.a1NaR;
  Form17.DDSpinEdit2.Value :=NP0.a2NaR;
  Form17.DDSpinEdit3.Value :=NP0.a3NaR;
  Form17.DDSpinEdit4.Value :=NP0.b1NaR;
  Form17.DDSpinEdit5.Value :=NP0.b3NaR;
  Form17.DDSpinEdit6.Value :=NP0.c1NaR;
  Form17.DDSpinEdit7.Value :=NP0.c3NaR;
  Form17.DDSpinEdit8.Value :=NP0.d1NaR;
  Form17.DDSpinEdit9.Value :=NP0.d2NaR;
  Form17.DDSpinEdit10.Value:=NP0.d3NaR;
  Form17.DDSpinEdit11.Value:=NP0.VNaR *1000;
  Form17.DDSpinEdit12.Value:=NP0.gNaR ;
  Form17.DDSpinEdit14.Value:= NP0.a1K;
  Form17.DDSpinEdit15.Value:= NP0.a2K;
  Form17.DDSpinEdit16.Value:= NP0.a3K;
  Form17.DDSpinEdit17.Value:= NP0.b1K;
  Form17.DDSpinEdit18.Value:= NP0.b2K;
  Form17.DDSpinEdit19.Value:= NP0.b3K;
  Form17.DDSpinEdit20.Value:= NP0.VK *1000;
  Form17.DDSpinEdit21.Value:= NP0.gK ;
  Form17.DDSpinEdit13.Value:=Iind/NP0.Square/1e6;
  Form17.DDSpinEdit22.Value:=NP0.gNaR;
  Form17.DDSpinEdit23.Value:=NP0.gK  ;
  Form17.DDSpinEdit25.Value:=t_end*1000;
  Form17.DDSpinEdit26.Value:=NP0.gL;
  Form17.DDSpinEdit27.Value:=NP0.VL*1000;
end;

procedure DisableDDSpinEdits;
begin
  Form17.DDSpinEdit1.Enabled :=Form17.CheckBox1.Checked ;
  Form17.DDSpinEdit2.Enabled :=Form17.CheckBox2.Checked ;
  Form17.DDSpinEdit3.Enabled :=Form17.CheckBox3.Checked ;
  Form17.DDSpinEdit4.Enabled :=Form17.CheckBox4.Checked ;
  Form17.DDSpinEdit5.Enabled :=Form17.CheckBox5.Checked ;
  Form17.DDSpinEdit6.Enabled :=Form17.CheckBox6.Checked ;
  Form17.DDSpinEdit7.Enabled :=Form17.CheckBox7.Checked ;
  Form17.DDSpinEdit8.Enabled :=Form17.CheckBox8.Checked ;
  Form17.DDSpinEdit9.Enabled :=Form17.CheckBox9.Checked ;
  Form17.DDSpinEdit10.Enabled:=Form17.CheckBox10.Checked;
  Form17.DDSpinEdit11.Enabled:=Form17.CheckBox11.Checked;
  Form17.DDSpinEdit12.Enabled:=Form17.CheckBox12.Checked;
  Form17.DDSpinEdit14.Enabled:=Form17.CheckBox13.Checked;
  Form17.DDSpinEdit15.Enabled:=Form17.CheckBox14.Checked;
  Form17.DDSpinEdit16.Enabled:=Form17.CheckBox15.Checked;
  Form17.DDSpinEdit17.Enabled:=Form17.CheckBox16.Checked;
  Form17.DDSpinEdit18.Enabled:=Form17.CheckBox17.Checked;
  Form17.DDSpinEdit19.Enabled:=Form17.CheckBox18.Checked;
  Form17.DDSpinEdit20.Enabled:=Form17.CheckBox19.Checked;
  Form17.DDSpinEdit21.Enabled:=Form17.CheckBox20.Checked;
end;

procedure FromForm17ToForm1;
begin
  {Na}
  Form1.a1NaR.Checked:=Form17.CheckBox1.Checked ;
  Form1.a2NaR.Checked:=Form17.CheckBox2.Checked ;
  Form1.a3NaR.Checked:=Form17.CheckBox3.Checked ;
  Form1.b1NaR.Checked:=Form17.CheckBox4.Checked ;
  Form1.b3NaR.Checked:=Form17.CheckBox5.Checked ;
  Form1.c1NaR.Checked:=Form17.CheckBox6.Checked ;
  Form1.c3NaR.Checked:=Form17.CheckBox7.Checked ;
  Form1.d1NaR.Checked:=Form17.CheckBox8.Checked ;
  Form1.d2NaR.Checked:=Form17.CheckBox9.Checked ;
  Form1.d3NaR.Checked:=Form17.CheckBox10.Checked;
  Form1. VNaR.Checked:=Form17.CheckBox11.Checked;
  Form1.gNaR1.Checked:=Form17.CheckBox12.Checked;
  NP0.a1NaR:=Form17.DDSpinEdit1.Value ;
  NP0.a2NaR:=Form17.DDSpinEdit2.Value ;
  NP0.a3NaR:=Form17.DDSpinEdit3.Value ;
  NP0.b1NaR:=Form17.DDSpinEdit4.Value ;
  NP0.b3NaR:=Form17.DDSpinEdit5.Value ;
  NP0.c1NaR:=Form17.DDSpinEdit6.Value ;
  NP0.c3NaR:=Form17.DDSpinEdit7.Value ;
  NP0.d1NaR:=Form17.DDSpinEdit8.Value ;
  NP0.d2NaR:=Form17.DDSpinEdit9.Value ;
  NP0.d3NaR:=Form17.DDSpinEdit10.Value;
  NP0.VNaR :=Form17.DDSpinEdit11.Value/1000;
  NP0.gNaR :=Form17.DDSpinEdit12.Value;
  {K}
  Form1.a1K.Checked:=Form17.CheckBox13.Checked ;
  Form1.a2K.Checked:=Form17.CheckBox14.Checked ;
  Form1.a3K.Checked:=Form17.CheckBox15.Checked ;
  Form1.b1K.Checked:=Form17.CheckBox16.Checked ;
  Form1.b2K.Checked:=Form17.CheckBox17.Checked ;
  Form1.b3K.Checked:=Form17.CheckBox18.Checked ;
  Form1.VK .Checked:=Form17.CheckBox19.Checked ;
  Form1.gK1.Checked:=Form17.CheckBox20.Checked ;
  NP0.a1K:=Form17.DDSpinEdit14.Value ;
  NP0.a2K:=Form17.DDSpinEdit15.Value ;
  NP0.a3K:=Form17.DDSpinEdit16.Value ;
  NP0.b1K:=Form17.DDSpinEdit17.Value ;
  NP0.b2K:=Form17.DDSpinEdit18.Value ;
  NP0.b3K:=Form17.DDSpinEdit19.Value ;
  NP0.VK:=Form17.DDSpinEdit20.Value/1000;
  NP0.gK:=Form17.DDSpinEdit21.Value ;
  Iind   :=Form17.DDSpinEdit13.Value*NP0.Square*1e6;
  NP0.gNaR:=Form17.DDSpinEdit22.Value;
  NP0.gK  :=Form17.DDSpinEdit23.Value;
  t_end  :=Form17.DDSpinEdit25.Value/1000; nt_end:=imin(trunc(t_end/dt), MaxNT);
  NP0.gL:=Form17.DDSpinEdit26.Value;
  NP0.VL:=Form17.DDSpinEdit27.Value/1000;
  DisableDDSpinEdits;
end;

procedure TForm17.DDSpinEdit1Change(Sender: TObject);
begin
  NP0.a1NaR:=Form17.DDSpinEdit1.Value ;
end;

procedure TForm17.DDSpinEdit2Change(Sender: TObject);
begin
  NP0.a2NaR:=Form17.DDSpinEdit2.Value ;
end;

procedure TForm17.DDSpinEdit3Change(Sender: TObject);
begin
  NP0.a3NaR:=Form17.DDSpinEdit3.Value ;
end;

procedure TForm17.DDSpinEdit4Change(Sender: TObject);
begin
  NP0.b1NaR:=Form17.DDSpinEdit4.Value ;
end;

procedure TForm17.DDSpinEdit5Change(Sender: TObject);
begin
  NP0.b3NaR:=Form17.DDSpinEdit5.Value ;
end;

procedure TForm17.DDSpinEdit6Change(Sender: TObject);
begin
  NP0.c1NaR:=Form17.DDSpinEdit6.Value ;
end;

procedure TForm17.DDSpinEdit7Change(Sender: TObject);
begin
  NP0.c3NaR:=Form17.DDSpinEdit7.Value ;
end;

procedure TForm17.DDSpinEdit8Change(Sender: TObject);
begin
  NP0.d1NaR:=Form17.DDSpinEdit8.Value ;
end;

procedure TForm17.DDSpinEdit9Change(Sender: TObject);
begin
  NP0.d2NaR:=Form17.DDSpinEdit9.Value ;
end;

procedure TForm17.DDSpinEdit10Change(Sender: TObject);
begin
  NP0.d3NaR:=Form17.DDSpinEdit10.Value;
end;

procedure TForm17.DDSpinEdit11Change(Sender: TObject);
begin
  NP0.VNaR :=Form17.DDSpinEdit11.Value/1000;
end;

procedure TForm17.DDSpinEdit12Change(Sender: TObject);
begin
  NP0.gNaR :=Form17.DDSpinEdit12.Value;
end;

procedure TForm17.DDSpinEdit13Change(Sender: TObject);
begin
  Iind:=Form17.DDSpinEdit13.Value*NP0.Square*1e6;
end;

procedure TForm17.DDSpinEdit14Change(Sender: TObject);
begin
  NP0.a1K:=Form17.DDSpinEdit14.Value ;
end;

procedure TForm17.DDSpinEdit15Change(Sender: TObject);
begin
  NP0.a2K:=Form17.DDSpinEdit15.Value ;
end;

procedure TForm17.DDSpinEdit16Change(Sender: TObject);
begin
  NP0.a3K:=Form17.DDSpinEdit16.Value ;
end;

procedure TForm17.DDSpinEdit17Change(Sender: TObject);
begin
  NP0.b1K:=Form17.DDSpinEdit17.Value ;
end;

procedure TForm17.DDSpinEdit18Change(Sender: TObject);
begin
  NP0.b2K:=Form17.DDSpinEdit18.Value ;
end;

procedure TForm17.DDSpinEdit19Change(Sender: TObject);
begin
  NP0.b3K:=Form17.DDSpinEdit19.Value ;
end;

procedure TForm17.DDSpinEdit20Change(Sender: TObject);
begin
  NP0.VK:=Form17.DDSpinEdit20.Value/1000 ;
end;

procedure TForm17.DDSpinEdit21Change(Sender: TObject);
begin
  NP0.gK:=Form17.DDSpinEdit21.Value ;
end;

procedure TForm17.CheckBox1Click(Sender: TObject);
begin FromForm17ToForm1; end;

procedure TForm17.CheckBox2Click(Sender: TObject);
begin FromForm17ToForm1; end;

procedure TForm17.CheckBox3Click(Sender: TObject);
begin FromForm17ToForm1; end;

procedure TForm17.CheckBox4Click(Sender: TObject);
begin FromForm17ToForm1; end;

procedure TForm17.CheckBox5Click(Sender: TObject);
begin FromForm17ToForm1; end;

procedure TForm17.CheckBox6Click(Sender: TObject);
begin FromForm17ToForm1; end;

procedure TForm17.CheckBox7Click(Sender: TObject);
begin FromForm17ToForm1; end;

procedure TForm17.CheckBox8Click(Sender: TObject);
begin FromForm17ToForm1; end;

procedure TForm17.CheckBox9Click(Sender: TObject);
begin FromForm17ToForm1; end;

procedure TForm17.CheckBox10Click(Sender: TObject);
begin FromForm17ToForm1; end;

procedure TForm17.CheckBox11Click(Sender: TObject);
begin FromForm17ToForm1; end;

procedure TForm17.CheckBox12Click(Sender: TObject);
begin FromForm17ToForm1; end;

{-----------------------------------------------------------------}
procedure TForm17.Button1Click(Sender: TObject);
{ SIMPLEX }
begin
  Form1.SimplexMemo.Visible:=True;
  Form1.    CoeMemo.Visible:=True;
  Form1.Chart5.Visible:=False;
  Form1.Chart4.Visible:=False;
  Form1.Chart1.Visible:=false;
  Form1.Chart2.Visible:=false;
  AssignCoeffToChange;

  Form17.Button1.Caption:='In process';
  Run_Simplex;
  Form17.Button1.Caption:='Run';
  FromCoeffsToForm17DDSpinEdits;
end;

procedure TForm17.Button2Click(Sender: TObject);
{ Hide detailed information }
begin
  if Form17.Button2.Caption ='Show detailed information' then begin
     if Form1.Left>1000 then Form1.Left:=Form1.Left-1000;
     Form4.Visible:=true;
     Form17.Button2.Caption:='Hide detailed information';
  end else begin
     Form1.Left:=Form1.Left+1000;
     Form4.Visible:=false;
     Form17.Button2.Caption:='Show detailed information';
  end;
end;

procedure TForm17.Button3Click(Sender: TObject);
{ STOP }
begin
  istop:=1;
  nt_end:=1;  nt_end:=imin(trunc(t_end/dt), MaxNT);
  Form17.DDSpinEdit24.Value:=1;
end;

procedure TForm17.Button4Click(Sender: TObject);
{ RUN }
begin
{  Smpl:=Form17.SpinEdit1.Value;
  NSmpls:=11;
  if Smpl<>0 then Smpl:=11;}
  n_Draw:=2;
  Calc_Functional;
{  Form17.DDSpinEdit13.Value:=Iind/NP.Square/1e6;
  Form17.DDSpinEdit22.Value:=NP.gNaR;
  Form17.DDSpinEdit23.Value:=NP.gK;}
end;

procedure TForm17.Button5Click(Sender: TObject);
{ Set parameters from file "Na_K_Kandel.id" }
begin
  KeepParams:=0;
  CommonParametersFromFile;
  Smpl:=0;
  FromCoeffsToForm17DDSpinEdits;
end;

procedure TForm17.Button6Click(Sender: TObject);
{ Set parameters from Hodgkin-Huxley model }
begin
  KeepParams:=1;                 //13.02.2009
  CommonParametersFromFile;      //13.02.2009
  NSmpls:=17;
//  CalcParameters;              //commented on 13.02.2009
//  NP0.HH_type:='Calmar';       //commented on 13.02.2009
//  HodgkinPhysParameters(NP0);  //commented on 13.02.2009
  with NP0 do begin
  a1NaR:= a1Na;  a2NaR:=a2Na;   a3NaR:=a3Na;   a4NaR:=a4Na;
  b1NaR:= b1Na;  b2NaR:=b2Na;   b3NaR:=b3Na;   b4NaR:=b4Na;
  c1NaR:= c1Na;  c2NaR:=c2Na;   c3NaR:=c3Na;   c4NaR:=c4Na;
  d1NaR:= d1Na;  d2NaR:=d2Na;   d3NaR:=d3Na;   d4NaR:=d4Na;
  VNaR:=VNa;
  gNaR:=gNa;
  end;                            
  InitialConditions;
  Smpl:=0;
  FromCoeffsToForm17DDSpinEdits;
  CorrespondParametersToTheForm;
end;

procedure TForm17.Button8Click(Sender: TObject);
{ Set parameters from file "Na_K_Kandel.id" in SIMULATE SPIKES }
begin
  Smpl:=11;
  Read_Params_from_File_or_Procedure;
  InitialConditions;
  Smpl:=0;
  FromCoeffsToForm17DDSpinEdits;
end;
{-----------------------------------------------------------------}

procedure TForm17.SpinEdit1Change(Sender: TObject);
begin
  if (Form17.SpinEdit1.Value>0)and(Form17.SpinEdit1.Value<=NSmpls) then begin
      Smpl:=Form17.SpinEdit1.Value;
      Calc_Functional;
      Form17.Label3.Caption:='File name: '+SmplFile[Smpl];
  end else  Form17.SpinEdit1.Value:=Smpl;
end;

procedure TForm17.RadioGroup1Click(Sender: TObject);
var OK :boolean;
begin
  case Form17.RadioGroup1.ItemIndex of
  0: begin    {Na}
       OK:=true;
       NSmpls:=10;
       NP0.IfBlockNaR:=0; NP0.IfBlockK:=1;
       Vrev_for_g:=NP0.VNaR;
     end;
  1: begin    {K}
       OK:=false;
       NSmpls:=7;
       if Form17.SpinEdit1.Value>NSmpls then Form17.SpinEdit1.Value:=NSmpls; 
       NP0.IfBlockNaR:=1; NP0.IfBlockK:=0;
       Vrev_for_g:=NP0.VK;
     end;
  end;
  Form17.CheckBox1.Checked :=OK;
  Form17.CheckBox2.Checked :=OK;
  Form17.CheckBox3.Checked :=OK;
  Form17.CheckBox4.Checked :=OK;
  Form17.CheckBox5.Checked :=OK;
  Form17.CheckBox6.Checked :=OK;
  Form17.CheckBox7.Checked :=OK;
  Form17.CheckBox8.Checked :=OK;
  Form17.CheckBox9.Checked :=OK;
  Form17.CheckBox10.Checked:=OK;
  Form17.CheckBox11.Checked:=OK;
  Form17.CheckBox12.Checked:=OK;
  Form17.CheckBox13.Checked:=not(OK);
  Form17.CheckBox14.Checked:=not(OK);
  Form17.CheckBox15.Checked:=not(OK);
  Form17.CheckBox16.Checked:=not(OK);
  Form17.CheckBox17.Checked:=false;
  Form17.CheckBox18.Checked:=not(OK);
  Form17.CheckBox19.Checked:=not(OK);
  Form17.CheckBox20.Checked:=not(OK);
end;
{-----------------------------------------------------------------}

procedure TForm17.DDSpinEdit22Change(Sender: TObject);
begin
//  Smpl:=0;
  NP0.gNaR:=Form17.DDSpinEdit22.Value;
end;

procedure TForm17.DDSpinEdit23Change(Sender: TObject);
begin
//  Smpl:=0;
  NP0.gK:=Form17.DDSpinEdit23.Value;
end;

procedure TForm17.DDSpinEdit25Change(Sender: TObject);
begin
  t_end:=Form17.DDSpinEdit25.Value/1000;
  nt_end:=imin(trunc(t_end/dt), MaxNT);
end;

procedure TForm17.DDSpinEdit26Change(Sender: TObject);
begin
  NP0.gL:=Form17.DDSpinEdit26.Value;
end;

procedure TForm17.DDSpinEdit27Change(Sender: TObject);
begin
  NP0.VL:=Form17.DDSpinEdit27.Value/1000;
end;

procedure TForm17.PageControl1Change(Sender: TObject);
begin
  case Form17.PageControl1.ActivePageIndex of
  2: begin  { Opens "Reverse Problem" page }
//     CalcParameters;
//     KeepParams:=0;
//     CommonParametersFromFile;
     FromCoeffsToForm17DDSpinEdits;
     Smpl:=1;
     Form17.SpinEdit1.Value:=Smpl;
     end;
  3: begin  { Opens "Simulate Spikes" page }
//     Smpl:=11;
//     CalcParameters;
//     KeepParams:=0;
//     CommonParametersFromFile;
//     Read_Params_from_File_or_Procedure;
//     InitialConditions;
     NP0.If_I_V_or_g:=2;
     NP0.IfBlockK:=0;
     NP0.IfBlockPass:=0;
     t_end:=0.050 {s};     nt_end:=imin(trunc(t_end/dt), MaxNT);
     t_Iind:=0.1;{s}
     if Iind=0 then Iind:=300 {pA};
     Smpl:=0;
     Freq_Iind:=0;
     Form17.DDSpinEdit13.Value:=Iind/NP0.Square/1e6;
     Form17.DDSpinEdit22.Value:=NP0.gNaR;
     Form17.DDSpinEdit23.Value:=NP0.gK;
     Form17.DDSpinEdit25.Value:=t_end*1000;
     Form17.DDSpinEdit26.Value:=NP0.gL;
     Form17.DDSpinEdit27.Value:=NP0.VL*1000;
     end;
  end;
  CorrespondParametersToTheForm;
end;

procedure TForm17.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Close;
end;

procedure TForm17.TabSheet6Exit(Sender: TObject);
begin
  FromForm17ToForm1;
end;

end.
