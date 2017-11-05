unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Menus,
  ExtCtrls, Spin, Unit2,Unit3,Unit4, Series,
  DDSpinEdit, TeEngine, TeeProcs, Chart,MyTypes,Init,t_dtO,
  ActnList,
  Threads;

type
  TForm1 = class(TForm)
    RunClampButton: TButton;
    ThresholdButton: TButton;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    MainMenu1: TMainMenu;
    aaa1: TMenuItem;
    Parameters: TMenuItem;
    Help1: TMenuItem;
    HHtype2: TMenuItem;
    Blockage2: TMenuItem;
    INa1: TMenuItem;
    IK1: TMenuItem;
    IKM1: TMenuItem;
    IPass1: TMenuItem;
    Passive1: TMenuItem;
    Calmar1: TMenuItem;
    Destexhe1: TMenuItem;
    Migliore1: TMenuItem;
    Samples1: TMenuItem;
    Smpl1: TMenuItem;
    Smpl2: TMenuItem;
    Smpl3: TMenuItem;
    Smpl4: TMenuItem;
    Currentclamp1: TMenuItem;
    VoltageClamp1: TMenuItem;
    Simplex1: TMenuItem;
    tau1: TMenuItem;
    ro1: TMenuItem;
    gNaR1: TMenuItem;
    StaticText4: TStaticText;
    VC1: TMenuItem;
    forgNa1: TMenuItem;
    a1NaR: TMenuItem;
    b1NaR: TMenuItem;
    a2NaR: TMenuItem;
    b2NaR: TMenuItem;
    a3NaR: TMenuItem;
    b3NaR: TMenuItem;
    c1NaR: TMenuItem;
    d1NaR: TMenuItem;
    c2NaR: TMenuItem;
    d2NaR: TMenuItem;
    c3NaR: TMenuItem;
    d3NaR: TMenuItem;
    RunClampPopMenu: TPopupMenu;
    Smpl1_: TMenuItem;
    Smpl2_: TMenuItem;
    Smpl3_: TMenuItem;
    Smpl4_: TMenuItem;
    ClearButton: TButton;
    Smpl0: TMenuItem;
    Smpl0_: TMenuItem;
    Plot2DPopMenu: TPopupMenu;
    FrequencynuIind1: TMenuItem;
    VNaR: TMenuItem;
    Smpl5: TMenuItem;
    Smpl6: TMenuItem;
    Smpl5_: TMenuItem;
    Smpl6_: TMenuItem;
    Writing1: TMenuItem;
    FileLabel: TLabel;
    INaR1: TMenuItem;
    NoClear: TMenuItem;
    Naslowid1: TMenuItem;
    Naslowinaid1: TMenuItem;
    APid1: TMenuItem;
    Default1: TMenuItem;
    Enterfromkeyboard1: TMenuItem;
    DDSpinEdit1: TDDSpinEdit;
    DDSpinEdit2: TDDSpinEdit;
    DDSpinEdit3: TDDSpinEdit;
    DDSpinEdit4: TDDSpinEdit;
    Smpl7: TMenuItem;
    Smpl8: TMenuItem;
    Smpl9: TMenuItem;
    Smpl7_: TMenuItem;
    Smpl8_: TMenuItem;
    Smpl9_: TMenuItem;
    NaV10S12id1: TMenuItem;
    Cummins1: TMenuItem;
    HHorder1: TMenuItem;
    N1point1: TMenuItem;
    N2points1: TMenuItem;
    AliIid1: TMenuItem;
    Aliid1: TMenuItem;
    Smpl10: TMenuItem;
    Smpl11: TMenuItem;
    Smpl12: TMenuItem;
    Smpl13: TMenuItem;
    Smpl14: TMenuItem;
    Smpl15: TMenuItem;
    Smpl16: TMenuItem;
    Smpl17: TMenuItem;
    Smpl18: TMenuItem;
    Smpl19: TMenuItem;
    Smpl20: TMenuItem;
    Smpl10_: TMenuItem;
    Smpl11_: TMenuItem;
    Smpl12_: TMenuItem;
    Smpl13_: TMenuItem;
    Smpl14_: TMenuItem;
    Smpl15_: TMenuItem;
    Smpl16_: TMenuItem;
    Smpl17_: TMenuItem;
    Smpl18_: TMenuItem;
    Smpl19_: TMenuItem;
    Smpl20_: TMenuItem;
    IKA1: TMenuItem;
    Label5: TLabel;
    APKrylovid1: TMenuItem;
    Saveallsettings1: TMenuItem;
    Restoreprevioussettings1: TMenuItem;
    FreqButton: TButton;
    Plot2Dnuus1: TMenuItem;
    Button2: TButton;
    PopupMenu3: TPopupMenu;
    Button3: TButton;
    SaveDialog3: TSaveDialog;
    SavemRandhRtofile1: TMenuItem;
    Openidfile1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    OpenDialog1: TOpenDialog;
    gNa1: TMenuItem;
    gK1: TMenuItem;
    N3: TMenuItem;
    gL1: TMenuItem;
    Clearallmarks1: TMenuItem;
    N4: TMenuItem;
    gKA1: TMenuItem;
    gKD1: TMenuItem;
    N5: TMenuItem;
    IfSetglortau1: TMenuItem;
    gLisfixed1: TMenuItem;
    tauisfixed1: TMenuItem;
    IfSetVLorVrest1: TMenuItem;
    VLisfixed1: TMenuItem;
    Vrestisfixed1: TMenuItem;
    Button4: TButton;
    RadioGroup1: TRadioGroup;
    SaveDialog4: TSaveDialog;
    PopupMenu4: TPopupMenu;
    CloseRadioGroup1: TMenuItem;
    AdaptButton: TButton;
    VL11: TMenuItem;
    Chow1: TMenuItem;
    FitPictureToExpData1: TMenuItem;
    JaponIid1: TMenuItem;
    Button5: TButton;
    DDSpinEdit5: TDDSpinEdit;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    DDSpinEdit6: TDDSpinEdit;
    Button7: TButton;
    ThrModel: TMenuItem;
    LIFmodel: TMenuItem;
    Lyle1: TMenuItem;
    U_S_Button: TButton;
    VCatVexp1: TMenuItem;
    Label6: TLabel;
    StaticText12: TStaticText;
    DDSpinEdit14: TDDSpinEdit;
    DDSpinEdit20: TDDSpinEdit;
    StaticText19: TStaticText;
    Button9: TButton;
    NaSchmidtid1: TMenuItem;
    a1K: TMenuItem;
    a2K: TMenuItem;
    a3K: TMenuItem;
    b1K: TMenuItem;
    b2K: TMenuItem;
    b3K: TMenuItem;
    VK: TMenuItem;
    FitKcurrent1: TMenuItem;
    Button6: TButton;
    IindVexp1: TMenuItem;
    Naundorf1: TMenuItem;
    StaticText22: TStaticText;
    DDSpinEdit22: TDDSpinEdit;
    White1: TMenuItem;
    Shu1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Chart4: TChart;
    Series12: TLineSeries;
    Series13: TLineSeries;
    Series14: TLineSeries;
    Series15: TLineSeries;
    Chart5: TChart;
    Series16: TLineSeries;
    Series17: TLineSeries;
    Series18: TLineSeries;
    Series19: TLineSeries;
    PopupMenu2: TPopupMenu;
    Saveexpmodcurvestofile1: TMenuItem;
    SaveDialog2: TSaveDialog;
    TabSheet3: TTabSheet;
    PopupMenu1: TPopupMenu;
    SaveVtofile1: TMenuItem;
    SaveDialog1: TSaveDialog;
    TabSheet4: TTabSheet;
    CoeMemo: TMemo;
    ParamsMemo: TMemo;
    SimplexMemo: TMemo;
    TabSheet5: TTabSheet;
    Panel1: TPanel;
    RadioGroup2: TRadioGroup;
    StaticText11: TStaticText;
    StaticText10: TStaticText;
    StaticText9: TStaticText;
    StaticText8: TStaticText;
    StaticText7: TStaticText;
    DDSpinEdit7: TDDSpinEdit;
    DDSpinEdit8: TDDSpinEdit;
    DDSpinEdit9: TDDSpinEdit;
    CheckBox1: TCheckBox;
    DDSpinEdit13: TDDSpinEdit;
    StaticText14: TStaticText;
    CheckBox2: TCheckBox;
    RadioGroup3: TRadioGroup;
    DDSpinEdit10: TDDSpinEdit;
    DDSpinEdit11: TDDSpinEdit;
    ComboBox1: TComboBox;
    DDSpinEdit15: TDDSpinEdit;
    StaticText15: TStaticText;
    ComboBox2: TComboBox;
    DDSpinEdit16: TDDSpinEdit;
    StaticText16: TStaticText;
    DDSpinEdit17: TDDSpinEdit;
    StaticText17: TStaticText;
    DDSpinEdit18: TDDSpinEdit;
    StaticText18: TStaticText;
    DDSpinEdit19: TDDSpinEdit;
    StaticText20: TStaticText;
    StaticText21: TStaticText;
    DDSpinEdit21: TDDSpinEdit;
    ComboBox3: TComboBox;
    Button10: TButton;
    Chart3: TChart;
    Series10: TLineSeries;
    Series11: TLineSeries;
    Chart1: TChart;
    Series1: TFastLineSeries;
    Series2: TPointSeries;
    Series3: TFastLineSeries;
    Series20: TLineSeries;
    Series21: TPointSeries;
    Chart2: TChart;
    Series4: TFastLineSeries;
    Series5: TFastLineSeries;
    Series6: TFastLineSeries;
    Series7: TFastLineSeries;
    Series8: TFastLineSeries;
    Label4: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    Button18: TButton;
    Series22: TLineSeries;
    Series23: TLineSeries;
    Series24: TLineSeries;
    Series25: TLineSeries;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Enableallseries1: TMenuItem;
    Button24: TButton;
    Button25: TButton;
    White21: TMenuItem;
    Series26: TLineSeries;
    DDSpinEdit23: TDDSpinEdit;
    StaticText23: TStaticText;
    rampid1: TMenuItem;
    Series27: TLineSeries;
    VCstepsid1: TMenuItem;
    VCwithpipette1: TMenuItem;
    TabSheet6: TTabSheet;
    Chart6: TChart;
    Chart7: TChart;
    Series28: TPointSeries;
    Series29: TPointSeries;
    About1: TMenuItem;
    heprogramhasbeenwrittenbyAntonVChizhovforComputationalPhysicsLaboratorypurposes1: TMenuItem;
    DDSpinEdit12: TDDSpinEdit;
    StaticText13: TStaticText;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    asks1: TMenuItem;
    Simplex2: TMenuItem;
    FiringClampandPRC1: TMenuItem;
    ActInact1: TMenuItem;
    N2pMainenSejn1: TMenuItem;
    Bazhenov1: TMenuItem;
    Series9: TPointSeries;
    N9: TMenuItem;
    Iind1: TMenuItem;
    CC1: TMenuItem;
    Setexpdatafile1: TMenuItem;
    OpenDialog2: TOpenDialog;
    N2pActiveDend1: TMenuItem;
    Memo1: TMemo;
    procedure RunClampButtonClick(Sender: TObject);
    procedure ThresholdButtonClick(Sender: TObject);
    procedure Passive1Click(Sender: TObject);
    procedure Calmar1Click(Sender: TObject);
    procedure Destexhe1Click(Sender: TObject);
    procedure Migliore1Click(Sender: TObject);
    procedure INa1Click(Sender: TObject);
    procedure IK1Click(Sender: TObject);
    procedure IKM1Click(Sender: TObject);
    procedure IPass1Click(Sender: TObject);
    procedure Smpl1Click(Sender: TObject);
    procedure Smpl2Click(Sender: TObject);
    procedure Smpl3Click(Sender: TObject);
    procedure Smpl4Click(Sender: TObject);
    procedure Smpl5Click(Sender: TObject);
    procedure Smpl6Click(Sender: TObject);
    procedure Smpl7Click(Sender: TObject);
    procedure Smpl8Click(Sender: TObject);
    procedure Smpl9Click(Sender: TObject);
    procedure Smpl10Click(Sender: TObject);
    procedure Smpl11Click(Sender: TObject);
    procedure Smpl12Click(Sender: TObject);
    procedure Smpl13Click(Sender: TObject);
    procedure Smpl14Click(Sender: TObject);
    procedure Smpl15Click(Sender: TObject);
    procedure Smpl16Click(Sender: TObject);
    procedure Smpl17Click(Sender: TObject);
    procedure Smpl18Click(Sender: TObject);
    procedure Smpl19Click(Sender: TObject);
    procedure Smpl20Click(Sender: TObject);
    procedure Smpl0Click(Sender: TObject);
    procedure Help1Click(Sender: TObject);
    procedure VC1Click(Sender: TObject);
    procedure forgNa1Click(Sender: TObject);
    procedure gNaR1Click(Sender: TObject);
    procedure tau1Click(Sender: TObject);
    procedure ro1Click(Sender: TObject);
    procedure a1NaRClick(Sender: TObject);
    procedure b1NaRClick(Sender: TObject);
    procedure a2NaRClick(Sender: TObject);
    procedure b2NaRClick(Sender: TObject);
    procedure a3NaRClick(Sender: TObject);
    procedure b3NaRClick(Sender: TObject);
    procedure c1NaRClick(Sender: TObject);
    procedure d1NaRClick(Sender: TObject);
    procedure c2NaRClick(Sender: TObject);
    procedure d2NaRClick(Sender: TObject);
    procedure c3NaRClick(Sender: TObject);
    procedure d3NaRClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure VNaRClick(Sender: TObject);
    procedure Writing1Click(Sender: TObject);
    procedure INaR1Click(Sender: TObject);
    procedure NoClearClick(Sender: TObject);
    procedure Naslowid1Click(Sender: TObject);
    procedure Naslowinaid1Click(Sender: TObject);
    procedure APid1Click(Sender: TObject);
    procedure Enterfromkeyboard1Click(Sender: TObject);
    procedure ParamsMemoDblClick(Sender: TObject);
    procedure Default1Click(Sender: TObject);
    procedure DDSpinEdit1Change(Sender: TObject);
    procedure DDSpinEdit2Change(Sender: TObject);
    procedure DDSpinEdit4Change(Sender: TObject);
    procedure DDSpinEdit3Change(Sender: TObject);
    procedure NaV10S12id1Click(Sender: TObject);
    procedure Cummins1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FrequencynuIind1Click(Sender: TObject);
    procedure N2points1Click(Sender: TObject);
    procedure N1point1Click(Sender: TObject);
    procedure AliIid1Click(Sender: TObject);
    procedure Aliid1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure IKA1Click(Sender: TObject);
    procedure aaa1Click(Sender: TObject);
    procedure APKrylovid1Click(Sender: TObject);
    procedure Saveallsettings1Click(Sender: TObject);
    procedure Restoreprevioussettings1Click(Sender: TObject);
    procedure FreqButtonClick(Sender: TObject);
    procedure Plot2Dnuus1Click(Sender: TObject);
    procedure SaveDialog1CanClose(Sender: TObject; var CanClose: Boolean);
    procedure SaveVtofile1Click(Sender: TObject);
    procedure Saveexpmodcurvestofile1Click(Sender: TObject);
    procedure SaveDialog2CanClose(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SaveDialog3CanClose(Sender: TObject; var CanClose: Boolean);
    procedure SavemRandhRtofile1Click(Sender: TObject);
    procedure Openidfile1Click(Sender: TObject);
    procedure OpenDialog1CanClose(Sender: TObject; var CanClose: Boolean);
    procedure gK1Click(Sender: TObject);
    procedure gNa1Click(Sender: TObject);
    procedure gL1Click(Sender: TObject);
    procedure Clearallmarks1Click(Sender: TObject);
    procedure gKA1Click(Sender: TObject);
    procedure gKD1Click(Sender: TObject);
    procedure gLisfixed1Click(Sender: TObject);
    procedure tauisfixed1Click(Sender: TObject);
    procedure VLisfixed1Click(Sender: TObject);
    procedure Vrestisfixed1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SaveDialog4CanClose(Sender: TObject; var CanClose: Boolean);
    procedure RadioGroup1Click(Sender: TObject);
    procedure CloseRadioGroup1Click(Sender: TObject);
    procedure AdaptButtonClick(Sender: TObject);
    procedure VL11Click(Sender: TObject);
    procedure Chow1Click(Sender: TObject);
    procedure FitPictureToExpData1Click(Sender: TObject);
    procedure JaponIid1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure DDSpinEdit5Change(Sender: TObject);
    procedure DDSpinEdit6Change(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Noise1Click(Sender: TObject);
    procedure DDSpinEdit7Change(Sender: TObject);
    procedure Button8MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button9Click(Sender: TObject);
    procedure DDSpinEdit8Change(Sender: TObject);
    procedure DDSpinEdit9Change(Sender: TObject);
    procedure DDSpinEdit10Change(Sender: TObject);
    procedure DDSpinEdit11Change(Sender: TObject);
    procedure DrawminfVhinfV1Click(Sender: TObject);
    procedure DDSpinEdit12Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure DDSpinEdit13Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure ThrModelClick(Sender: TObject);
    procedure LIFmodelClick(Sender: TObject);
    procedure Lyle1Click(Sender: TObject);
    procedure U_S_ButtonClick(Sender: TObject);
    procedure VCatVexp1Click(Sender: TObject);
    procedure DDSpinEdit14Change(Sender: TObject);
    procedure DDSpinEdit15Change(Sender: TObject);
    procedure Panel1DblClick(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure DDSpinEdit20Change(Sender: TObject);
    procedure DDSpinEdit5DblClick(Sender: TObject);
    procedure DDSpinEdit6DblClick(Sender: TObject);
    procedure DDSpinEdit10DblClick(Sender: TObject);
    procedure DDSpinEdit11DblClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Series1DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series2DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series3DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series4DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series5DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series6DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series7DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series8DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series9DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure NaSchmidtid1Click(Sender: TObject);
    procedure a1KClick(Sender: TObject);
    procedure a2KClick(Sender: TObject);
    procedure a3KClick(Sender: TObject);
    procedure b1KClick(Sender: TObject);
    procedure b2KClick(Sender: TObject);
    procedure b3KClick(Sender: TObject);
    procedure VKClick(Sender: TObject);
    procedure FitKcurrent1Click(Sender: TObject);
    procedure IindVexp1Click(Sender: TObject);
    procedure Naundorf1Click(Sender: TObject);
    procedure DDSpinEdit22Change(Sender: TObject);
    procedure White1Click(Sender: TObject);
    procedure Shu1Click(Sender: TObject);
    procedure Series20DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Button17Click(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure Series10DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series11DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series12DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series13DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series14DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series15DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series16DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series17DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series18DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series19DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series21DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series22DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series23DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series24DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series25DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Enableallseries1Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure White21Click(Sender: TObject);
    procedure DDSpinEdit1DblClick(Sender: TObject);
    procedure Series26DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure DDSpinEdit23Change(Sender: TObject);
    procedure DDSpinEdit23DblClick(Sender: TObject);
    procedure rampid1Click(Sender: TObject);
    procedure Series27DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure VCstepsid1Click(Sender: TObject);
    procedure VCwithpipette1Click(Sender: TObject);
    procedure Simplex2Click(Sender: TObject);
    procedure FiringClampandPRC1Click(Sender: TObject);
    procedure ActInact1Click(Sender: TObject);
    procedure N2pMainenSejn1Click(Sender: TObject);
    procedure Bazhenov1Click(Sender: TObject);
    procedure Iind1Click(Sender: TObject);
    procedure CC1Click(Sender: TObject);
    procedure Setexpdatafile1Click(Sender: TObject);
    procedure N2pActiveDend1Click(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

procedure Pause;
procedure ShowNoisePanel(YesOrNo :boolean);

var
  Form1: TForm1;

implementation

uses MathMyO,Other,Graph,Coeff,Hodgkin_old,SetNrnParsO,Clamp,Simplex,
     Reader,Act_Inact,Threshold,RateOfGaussian,Noise,RunFiber,
     FiringClamp,Thread_FC,Statistics, BackUp,
     Unit5, Unit6, Unit7, Unit8, Unit9, Unit12, Unit13,
     Unit14, Unit15, Unit16, Unit17, Unit18, Unit20, Unit31;

{$R *.DFM}

procedure Pause;
begin
  if StopKey='P' then begin
     repeat
       Application.ProcessMessages;
     until StopKey<>'P';
  end;
end;

procedure AssignSmpl;
begin
  if      Form1.Smpl1.Checked                then Smpl:=1
  else if(Form1.Smpl2.Checked)and(NSmpls>=2) then Smpl:=2
  else if(Form1.Smpl3.Checked)and(NSmpls>=3) then Smpl:=3
  else if(Form1.Smpl4.Checked)and(NSmpls>=4) then Smpl:=4
  else if(Form1.Smpl5.Checked)and(NSmpls>=5) then Smpl:=5
  else if(Form1.Smpl6.Checked)and(NSmpls>=6) then Smpl:=6
  else if(Form1.Smpl7.Checked)and(NSmpls>=7) then Smpl:=7
  else if(Form1.Smpl8.Checked)and(NSmpls>=8) then Smpl:=8
  else if(Form1.Smpl9.Checked)and(NSmpls>=9) then Smpl:=9
  else if(Form1.Smpl10.Checked)and(NSmpls>=10) then Smpl:=10
  else if(Form1.Smpl11.Checked)and(NSmpls>=11) then Smpl:=11
  else if(Form1.Smpl12.Checked)and(NSmpls>=12) then Smpl:=12
  else if(Form1.Smpl13.Checked)and(NSmpls>=13) then Smpl:=13
  else if(Form1.Smpl14.Checked)and(NSmpls>=14) then Smpl:=14
  else if(Form1.Smpl15.Checked)and(NSmpls>=15) then Smpl:=15
  else if(Form1.Smpl16.Checked)and(NSmpls>=16) then Smpl:=16
  else if(Form1.Smpl17.Checked)and(NSmpls>=17) then Smpl:=17
  else if(Form1.Smpl18.Checked)and(NSmpls>=18) then Smpl:=18
  else if(Form1.Smpl19.Checked)and(NSmpls>=19) then Smpl:=19
  else if(Form1.Smpl20.Checked)and(NSmpls>=20) then Smpl:=20
  else if(Form1.Smpl0.Checked)               then Smpl:=0
  else                                            Smpl:=1;
end;

{!!!!!!! Activation !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}
procedure TForm1.FormShow(Sender: TObject);
begin
  GetDir(0,MainDir);
  ParFile:='';
  DefaultParameters;
  CommonParametersFromFile;
  CorrespondParametersToTheForm;
  AssignDefaultCoeffToChange;
  Form3.Visible:=False;
  Form4.Visible:=True;
  Form5.Visible:=False;
  Form1.tau1.Checked:=False;
  Form1.ParamsMemo.Visible:=false;
  Form1.FrequencynuIind1.Checked:=True;
  Form1.RadioGroup1.Visible:=false;
  Form1.FitPictureToExpData1.Checked:=false;//true;
  { Disable features, too old for me }
  Form1.AliIid1.Visible:=false;
  Form1.Aliid1.Visible:=false;
  Form1.ComboBox1.ItemIndex:=12;
  Form1.ComboBox2.ItemIndex:=1;
  Form1.ComboBox3.ItemIndex:=0;
  { For Hodgkin-Huxley approximations }
  Form17.Visible:=false;
  exit;
  Form1.Left:=Form1.Left+1000;
  Form4.Visible:=false;
  Form17.Button2.Caption:='Show detailed information';
  { For Lena-Dima }
  exit;
  Form1.ThresholdButton.Visible:=false;
  Form1.AliIid1.Visible:=false;
  Form1.Aliid1.Visible:=false;
  Form1.JaponIid1.Visible:=false;
  Form1.APid1.Visible:=false;
  Form1.Button5.Visible:=false;
  Form1.Plot2DPopMenu.AutoPopup:=false;
  Form1.StaticText5.Visible:=false;
  Form1.StaticText6.Visible:=false;
  Form1.DDSpinEdit5.Visible:=false;
  Form1.DDSpinEdit6.Visible:=false;
  Form1.HHorder1.Visible:=false;
  Form1.forgNa1.Visible:=false;
  Form1.VC1    .Visible:=false;
  Form1.tau1   .Visible:=false;
  Form1.ro1    .Visible:=false;
end;
{!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!}

{ Buttons }

procedure TForm1.RunClampButtonClick(Sender: TObject);
begin
  Form1.RunClampButton.Enabled:=false;
  Form1.Chart5.Visible:=True;
  Form1.Chart4.Visible:=True;
//  ThreadObject.ForExecute:=
  VoltageOrCurrentClamp(uu,ss);
//  RunThread.Start;
  StopKey:='R';
  Form1.RunClampButton.Enabled:=true;
end;

procedure TForm1.ThresholdButtonClick(Sender: TObject);
begin
//  If_I_V_or_g:=2;
//  HH_type:='Destexhe';
{  Form1.APid1.Checked:=true;
  Form1.ParamsMemo.Visible:=true;
  ParFile:='AP.id';
  CommonParametersFrom_ParFile;
  CorrespondParametersToTheForm;}
          { Set Smpl=0 }
{          Form1.Smpl0.Checked:=True;
          Form1.Smpl01.Checked:=True;
          AssignSmpl;
          HodgkinPhysParameters;
          CalcParameters;}
  { Run Calculation }
  Form3.Visible:=true;
  Form3.Chart1.Visible:=true;
//  FindThreshold;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Form7 .Visible:=true;
  Form15.Visible:=true;
//  RateOfGaussianEnsemble;
end;

procedure TForm1.FreqButtonClick(Sender: TObject);
begin
  if  Form1.FrequencynuIind1.Checked then  begin
      Form5.Visible:=true;
  end else begin
      Form9.Visible:=true;
  end;
end;

procedure TForm1.U_S_ButtonClick(Sender: TObject);
begin
  Form9.Visible:=true;
end;

procedure TForm1.AdaptButtonClick(Sender: TObject);
begin
  Form6.Visible:=true;
end;

procedure TForm1.ClearButtonClick(Sender: TObject);
begin
  {DrawT.}ClearAllPlots;
end;
{=== End Buttons ==============================}
{=== Spin Edits ===============================}

procedure TForm1.DDSpinEdit1Change(Sender: TObject);
begin
  Iind   :=Form1.DDSpinEdit1.Value;
end;

procedure TForm1.DDSpinEdit1DblClick(Sender: TObject);
begin
  Form1.DDSpinEdit1.Value:=0;
  Iind   :=Form1.DDSpinEdit1.Value;
end;

procedure TForm1.DDSpinEdit2Change(Sender: TObject);
begin
  t_Iind :=Form1.DDSpinEdit2.Value/1000;
end;

procedure TForm1.DDSpinEdit4Change(Sender: TObject);
begin
  Vh:=NP0.Vrest+Form1.DDSpinEdit4.Value/1000;
end;

procedure TForm1.DDSpinEdit3Change(Sender: TObject);
begin
  t_end  :=Form1.DDSpinEdit3.Value/1000;
  nt_end:=imin(trunc(t_end/dt), MaxNT);
end;

procedure TForm1.DDSpinEdit5Change(Sender: TObject);
begin
  uu:=Form1.DDSpinEdit5.Value/1000;
end;

procedure TForm1.DDSpinEdit6Change(Sender: TObject);
begin
//  ss[1]:=max(Form1.DDSpinEdit6.Value,-(uu[1]-Iind/(Square[1]*1e9))/Vus);
//  Form1.DDSpinEdit6.Value:=ss[1];
  ss:=Form1.DDSpinEdit6.Value;
end;

procedure TForm1.DDSpinEdit22Change(Sender: TObject);
begin
  tt:=Form1.DDSpinEdit22.Value;
end;

procedure TForm1.DDSpinEdit7Change(Sender: TObject);
begin
  NoiseToSignal:=Form1.DDSpinEdit7.Value;
end;

procedure TForm1.DDSpinEdit8Change(Sender: TObject);
begin
  FC_freq:=Form1.DDSpinEdit8.Value;
end;

procedure TForm1.DDSpinEdit9Change(Sender: TObject);
begin
  FC_dFdu:=Form1.DDSpinEdit9.Value;
end;

procedure TForm1.DDSpinEdit10Change(Sender: TObject);
begin
  tau_E:=Form1.DDSpinEdit10.Value/1e3;
end;

procedure TForm1.DDSpinEdit11Change(Sender: TObject);
begin
  tau_I:=Form1.DDSpinEdit11.Value/1e3;
end;

procedure TForm1.DDSpinEdit12Change(Sender: TObject);
begin
  tau_Noise:=Form1.DDSpinEdit12.Value/1e3;
end;

procedure TForm1.DDSpinEdit13Change(Sender: TObject);
begin
  dt:=Form1.DDSpinEdit13.Value/1e3;
end;

procedure TForm1.DDSpinEdit14Change(Sender: TObject);
begin
  Freq_Iind:=Form1.DDSpinEdit14.Value;
end;

procedure TForm1.DDSpinEdit15Change(Sender: TObject);
begin
  FC_I0:=Form1.DDSpinEdit15.Value/1000;
end;

{======== End SpinEdits =======================}
{======== Main Menu ===========================}

{ MainMenu.File:}

procedure TForm1.aaa1Click(Sender: TObject);
begin
  Form1.Chart5.Visible:=False;
  Form1.Chart4.Visible:=False;
  Form1.ParamsMemo.Visible:=True;
end;

procedure TForm1.NaSchmidtid1Click(Sender: TObject);
begin
  ChDir(MainDir);
  Form1.ParamsMemo.Visible:=true;
  ParFile:='Na_Schmidt.id';
  CommonParametersFrom_ParFile;
  CorrespondParametersToTheForm;
end;

procedure TForm1.Naslowid1Click(Sender: TObject);
begin
//  Form1.Naslowid1.Checked:=true;//not(Form1.Naslowid1.Checked);
  ChDir(MainDir);
  Form1.ParamsMemo.Visible:=true;
  ParFile:='Na_slow.id';
  CommonParametersFrom_ParFile;
  CorrespondParametersToTheForm;
end;

procedure TForm1.Naslowinaid1Click(Sender: TObject);
begin
//  Form1.Naslowinaid1.Checked:=true;//not(Form1.Naslowinaid1.Checked);
  ChDir(MainDir);
  Form1.ParamsMemo.Visible:=true;
  ParFile:='Na_slow_ina.id';
  CommonParametersFrom_ParFile;
  CorrespondParametersToTheForm;
end;

procedure TForm1.NaV10S12id1Click(Sender: TObject);
begin
//  Form1.NaV10S12id1.Checked:=true;
  ChDir(MainDir);
  Form1.ParamsMemo.Visible:=true;
  ParFile:='Na_V10&S12.id';
  CommonParametersFrom_ParFile;
  CorrespondParametersToTheForm;
end;

procedure TForm1.APKrylovid1Click(Sender: TObject);
begin
  ChDir(MainDir);
  Form1.ParamsMemo.Visible:=true;
  ParFile:='AP_Krylov.id';
  CommonParametersFrom_ParFile;
  CorrespondParametersToTheForm;
end;

procedure TForm1.APid1Click(Sender: TObject);
begin
//  Form1.APid1.Checked:=true;//not(Form1.APid1.Checked);
  ChDir(MainDir);
  Form1.ParamsMemo.Visible:=true;
  ParFile:='AP.id';
  CommonParametersFrom_ParFile;
  CorrespondParametersToTheForm;
end;

procedure TForm1.Aliid1Click(Sender: TObject);
begin
  ChDir(MainDir);
  Form1.ParamsMemo.Visible:=true;
  ParFile:='Ali.id';
  CommonParametersFrom_ParFile;
  CorrespondParametersToTheForm;
end;

procedure TForm1.AliIid1Click(Sender: TObject);
begin
  ChDir(MainDir);
  Form1.ParamsMemo.Visible:=true;
  ParFile:='Ali_I.id';
  CommonParametersFrom_ParFile;
  CorrespondParametersToTheForm;
end;

procedure TForm1.JaponIid1Click(Sender: TObject);
begin
  ChDir(MainDir);
  Form1.ParamsMemo.Visible:=true;
  ParFile:='Japon_I.id';
  CommonParametersFrom_ParFile;
  CorrespondParametersToTheForm;
end;

procedure TForm1.Default1Click(Sender: TObject);
begin
//  Form1.Default1.Checked:=true;//not(Form1.Default1.Checked);
  ChDir(MainDir);
  ParFile:='';
  CommonParametersFromFile;
  CorrespondParametersToTheForm;
end;

procedure TForm1.Enterfromkeyboard1Click(Sender: TObject);
begin
  Form1.ParamsMemo.Visible:=true;
  Form1.ParamsMemo.Lines.Add('Here you can set any parameters. DblClick to finish.');
end;

procedure TForm1.ParamsMemoDblClick(Sender: TObject);
begin
  Form1.ParamsMemo.Lines.SaveToFile('Memo.id');
  ReadParamsFromFile('Memo.id','Any','Any');
  Form1.ParamsMemo.Visible:=false;
end;

procedure TForm1.Saveallsettings1Click(Sender: TObject);
begin
  WriteInBackUpFile;
end;

procedure TForm1.Restoreprevioussettings1Click(Sender: TObject);
begin
  ReadInBackUpFile;
end;

{ MainMenu.Parameters:}
{ MainMenu.Parameters.HH_type:}

procedure TForm1.Passive1Click(Sender: TObject);
begin
  NP0.HH_type:='Passive';
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.Calmar1Click(Sender: TObject);
begin
  NP0.HH_type:='Calmar';
  NP0.IfSet_gL_or_tau:=1;
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.Destexhe1Click(Sender: TObject);
begin
  NP0.HH_type:='Destexhe';
  NP0.IfSet_gL_or_tau:=2;
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.Migliore1Click(Sender: TObject);
begin
  NP0.HH_type:='Migliore';
  NP0.IfSet_gL_or_tau:=2;
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.Cummins1Click(Sender: TObject);
begin
  NP0.HH_type:='Cummins';
  NP0.IfSet_gL_or_tau:=1;
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.Chow1Click(Sender: TObject);
begin
  NP0.HH_type:='Chow';
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.Lyle1Click(Sender: TObject);
begin
  NP0.HH_type:='Lyle';
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.Naundorf1Click(Sender: TObject);
begin
  NP0.HH_type:='Naundorf';
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.White1Click(Sender: TObject);
begin
  NP0.HH_type:='White';
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.White21Click(Sender: TObject);
begin
  NP0.HH_type:='White2';
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.Shu1Click(Sender: TObject);
begin
  NP0.HH_type:='Shu';
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.Bazhenov1Click(Sender: TObject);
begin
  NP0.HH_type:='Bazhenov';
  NP0.HH_order:='2-p-MainenSejn';
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

{ MainMenu.Parameters.HH_order: }

procedure TForm1.N1point1Click(Sender: TObject);
begin
  NP0.HH_order:='1-point';
  HodgkinPhysParameters(NP0);
//  DefaultCanalParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.N2points1Click(Sender: TObject);
begin
  NP0.HH_order:='2-points';
  HodgkinPhysParameters(NP0);
//  DefaultCanalParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.N2pMainenSejn1Click(Sender: TObject);
begin
  NP0.HH_order:='2-p-MainenSejn';
  HodgkinPhysParameters(NP0);
//  DefaultCanalParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.N2pActiveDend1Click(Sender: TObject);
begin
  NP0.HH_order:='2-p-ActiveDend';
  HodgkinPhysParameters(NP0);
//  DefaultCanalParameters(NP0);
  CorrespondParametersToTheForm;
end;

{ MainMenu.Parameters.Blockage: }

procedure TForm1.INaR1Click(Sender: TObject);
begin
  NP0.IfBlockNaR:=1-NP0.IfBlockNaR;
  case NP0.IfBlockNaR of
  1: Form1.INaR1.Checked:=True;
  0: Form1.INaR1.Checked:=False;
  end;
end;

procedure TForm1.INa1Click(Sender: TObject);
begin
  NP0.IfBlockNa:=1-NP0.IfBlockNa;
  case NP0.IfBlockNa of
  1: Form1.INa1.Checked:=True;
  0: Form1.INa1.Checked:=False;
  end;
end;

procedure TForm1.IK1Click(Sender: TObject);
begin
  NP0.IfBlockK:=1-NP0.IfBlockK;
  case NP0.IfBlockK of
  1: Form1.IK1.Checked:=True;
  0: Form1.IK1.Checked:=False;
  end;
end;

procedure TForm1.IKM1Click(Sender: TObject);
begin
  NP0.IfBlockKM:=1-NP0.IfBlockKM;
  case NP0.IfBlockKM of
  1: Form1.IKM1.Checked:=True;
  0: Form1.IKM1.Checked:=False;
  end;
end;

procedure TForm1.IKA1Click(Sender: TObject);
begin
  NP0.IfBlockKA:=1-NP0.IfBlockKA;
  case NP0.IfBlockKA of
  1: Form1.IKA1.Checked:=True;
  0: Form1.IKA1.Checked:=False;
  end;
end;

procedure TForm1.IPass1Click(Sender: TObject);
begin
  NP0.IfBlockPass:=1-NP0.IfBlockPass;
  case NP0.IfBlockPass of
  1: Form1.IPass1.Checked:=True;
  0: Form1.IPass1.Checked:=False;
  end;
end;

{ MainMenu.Parameters.IfSet_gL_or_tau: }

procedure TForm1.gLisfixed1Click(Sender: TObject);
begin
  NP0.IfSet_gL_or_tau:=1;
end;

procedure TForm1.tauisfixed1Click(Sender: TObject);
begin
  NP0.IfSet_gL_or_tau:=2;
end;

{ MainMenu.Parameters.IfSet_VL_or_Vrest: }

procedure TForm1.VLisfixed1Click(Sender: TObject);
begin
  NP0.IfSet_VL_or_Vrest:=1;
end;

procedure TForm1.Vrestisfixed1Click(Sender: TObject);
begin
  NP0.IfSet_VL_or_Vrest:=2;
end;

{ MainMenu.Parameters.FitPictureToExpData: }

procedure TForm1.FitPictureToExpData1Click(Sender: TObject);
begin
  Form1.FitPictureToExpData1.Checked:=not(Form1.FitPictureToExpData1.Checked);
end;

{ MainMenu.Parameters.Writing: }

procedure TForm1.Writing1Click(Sender: TObject);
begin
  Form1.Writing1.Checked:=not(Form1.Writing1.Checked);
  WriteOrNot:=1-WriteOrNot;
end;

{ MainMenu.Parameters.NoClear: }

procedure TForm1.NoClearClick(Sender: TObject);
begin
  Form1.NoClear.Checked:=not(Form1.NoClear.Checked);
end;

{ MainMenu.Parameters.Draw m_inf(V), h_inf(V): }

procedure TForm1.DrawminfVhinfV1Click(Sender: TObject);
begin
end;

{ MainMenu.Clamp:}
{ MainMenu.Clamp.Samples: }

procedure TForm1.Smpl0Click(Sender: TObject);
begin
  Form1.Smpl0.Checked:=True;
  Form1.Smpl0_.Checked:=True;
  AssignSmpl;
  Form1.FitPictureToExpData1.Checked:=false;
//  HodgkinPhysParameters;
//  CalcParameters;
end;

procedure TForm1.Smpl1Click(Sender: TObject);
begin
  Form1.Smpl1.Checked:=True;
  Form1.Smpl1_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl2Click(Sender: TObject);
begin
  Form1.Smpl2.Checked:=True;
  Form1.Smpl2_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl3Click(Sender: TObject);
begin
  Form1.Smpl3.Checked:=True;
  Form1.Smpl3_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl4Click(Sender: TObject);
begin
  Form1.Smpl4.Checked:=True;
  Form1.Smpl4_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl5Click(Sender: TObject);
begin
  Form1.Smpl5.Checked:=True;
  Form1.Smpl5_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl6Click(Sender: TObject);
begin
  Form1.Smpl6.Checked:=True;
  Form1.Smpl6_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl7Click(Sender: TObject);
begin
  Form1.Smpl7.Checked:=True;
  Form1.Smpl7_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl8Click(Sender: TObject);
begin
  Form1.Smpl8.Checked:=True;
  Form1.Smpl8_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl9Click(Sender: TObject);
begin
  Form1.Smpl9.Checked:=True;
  Form1.Smpl9_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl10Click(Sender: TObject);
begin
  Form1.Smpl10.Checked:=True;
  Form1.Smpl10_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl11Click(Sender: TObject);
begin
  Form1.Smpl11.Checked:=True;
  Form1.Smpl11_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl12Click(Sender: TObject);
begin
  Form1.Smpl12.Checked:=True;
  Form1.Smpl12_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl13Click(Sender: TObject);
begin
  Form1.Smpl13.Checked:=True;
  Form1.Smpl13_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl14Click(Sender: TObject);
begin
  Form1.Smpl14.Checked:=True;
  Form1.Smpl14_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl15Click(Sender: TObject);
begin
  Form1.Smpl15.Checked:=True;
  Form1.Smpl15_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl16Click(Sender: TObject);
begin
  Form1.Smpl16.Checked:=True;
  Form1.Smpl16_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl17Click(Sender: TObject);
begin
  Form1.Smpl17.Checked:=True;
  Form1.Smpl17_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl18Click(Sender: TObject);
begin
  Form1.Smpl18.Checked:=True;
  Form1.Smpl18_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl19Click(Sender: TObject);
begin
  Form1.Smpl19.Checked:=True;
  Form1.Smpl19_.Checked:=True;
  AssignSmpl;
end;

procedure TForm1.Smpl20Click(Sender: TObject);
begin
  Form1.Smpl20.Checked:=True;
  Form1.Smpl20_.Checked:=True;
  AssignSmpl;
end;

{ MainMenu.Clamp.CurrentClamp: }

procedure TForm1.IindVexp1Click(Sender: TObject);
begin
  NP0.If_I_V_or_g:=7;
  Form1.IindVexp1.Checked:=not(Form1.IindVexp1.Checked);
end;

procedure TForm1.Iind1Click(Sender: TObject);
begin
  NP0.If_I_V_or_g:=6;
  CorrespondParametersToTheForm;
end;

procedure TForm1.CC1Click(Sender: TObject);
begin
  NP0.If_I_V_or_g:=2;
  CorrespondParametersToTheForm;
end;

{ MainMenu.Clamp.VoltageClamp: }

procedure TForm1.VC1Click(Sender: TObject);
begin
  NP0.If_I_V_or_g:=1;
  CorrespondParametersToTheForm;
end;

procedure TForm1.forgNa1Click(Sender: TObject);
begin
  NP0.If_I_V_or_g:=3;
  CorrespondParametersToTheForm;
end;

procedure TForm1.VCatVexp1Click(Sender: TObject);
begin
  NP0.If_I_V_or_g:=5;
  CorrespondParametersToTheForm;
//  Form1.VhVexp1.Checked:=not(Form1.VhVexp1.Checked);
end;

procedure TForm1.VCwithpipette1Click(Sender: TObject);
begin
  NP0.If_I_V_or_g:=4;
  CorrespondParametersToTheForm;
//  Form1.VCwithpipette1.Checked:=not(Form1.VCwithpipette1.Checked);
end;

{ MainMenu.Help }

procedure TForm1.Help1Click(Sender: TObject);
var Dir :string;
begin
//  GetDir(0,Dir);
  Application.HelpFile :=MainDir+'\Help\MyHelp.hlp';
  Application.HelpJump('Help');
end;

{ MainMenu.Simplex: }

procedure TForm1.Clearallmarks1Click(Sender: TObject);
begin
  Form1.tau1.Checked :=False;
  Form1.ro1.Checked  :=False;
  Form1.gNaR1.Checked:=False;
  Form1.gNa1.Checked :=False;
  Form1.gK1.Checked  :=False;
  Form1.gKA1.Checked :=False;
  Form1.gKD1.Checked :=False;
  Form1.gL1.Checked  :=False;
  Form1.a1NaR.Checked:=False;
  Form1.b1NaR.Checked:=False;
  Form1.a2NaR.Checked:=False;
  Form1.b2NaR.Checked:=False;
  Form1.a3NaR.Checked:=False;
  Form1.b3NaR.Checked:=False;
  Form1.c1NaR.Checked:=False;
  Form1.d1NaR.Checked:=False;
  Form1.c2NaR.Checked:=False;
  Form1.d2NaR.Checked:=False;
  Form1.c3NaR.Checked:=False;
  Form1.d3NaR.Checked:=False;
  Form1. VNaR.Checked:=False;
  Form1.  a1K.Checked:=False;
  Form1.  a2K.Checked:=False;
  Form1.  a3K.Checked:=False;
  Form1.  b1K.Checked:=False;
  Form1.  b2K.Checked:=False;
  Form1.  b3K.Checked:=False;
  Form1.   VK.Checked:=False;
end;

procedure TForm1.FitKcurrent1Click(Sender: TObject);
begin
  Form1.tau1.Checked :=False;
  Form1.ro1.Checked  :=False;
  Form1.gNaR1.Checked:=False;
  Form1.gNa1.Checked :=False;
  Form1.gK1.Checked  :=True;
  Form1.gKA1.Checked :=False;
  Form1.gKD1.Checked :=False;
  Form1.gL1.Checked  :=False;
  Form1.a1NaR.Checked:=False;
  Form1.b1NaR.Checked:=False;
  Form1.a2NaR.Checked:=False;
  Form1.b2NaR.Checked:=False;
  Form1.a3NaR.Checked:=False;
  Form1.b3NaR.Checked:=False;
  Form1.c1NaR.Checked:=False;
  Form1.d1NaR.Checked:=False;
  Form1.c2NaR.Checked:=False;
  Form1.d2NaR.Checked:=False;
  Form1.c3NaR.Checked:=False;
  Form1.d3NaR.Checked:=False;
  Form1. VNaR.Checked:=False;
  Form1.  a1K.Checked:=True;
  Form1.  a2K.Checked:=True;
  Form1.  a3K.Checked:=True;
  Form1.  b1K.Checked:=True;
  Form1.  b2K.Checked:=False;
  Form1.  b3K.Checked:=True;
  Form1.   VK.Checked:=False;
end;

procedure TForm1.tau1Click(Sender: TObject);
begin Form1.tau1.Checked:=not(Form1.tau1.Checked); end;

procedure TForm1.ro1Click(Sender: TObject);
begin Form1.ro1.Checked:=not(Form1.ro1.Checked); end;

procedure TForm1.gNaR1Click(Sender: TObject);
begin Form1.gNaR1.Checked:=not(Form1.gNaR1.Checked); end;

procedure TForm1.gNa1Click(Sender: TObject);
begin Form1.gNa1.Checked:=not(Form1.gNa1.Checked); end;

procedure TForm1.gK1Click(Sender: TObject);
begin Form1.gK1.Checked:=not(Form1.gK1.Checked); end;

procedure TForm1.gKA1Click(Sender: TObject);
begin Form1.gKA1.Checked:=not(Form1.gKA1.Checked); end;

procedure TForm1.gKD1Click(Sender: TObject);
begin Form1.gKD1.Checked:=not(Form1.gKD1.Checked); end;

procedure TForm1.gL1Click(Sender: TObject);
begin Form1.gL1.Checked:=not(Form1.gL1.Checked); end;

procedure TForm1.VL11Click(Sender: TObject);
begin Form1.VL11.Checked:=not(Form1.VL11.Checked); end;

procedure TForm1.a1NaRClick(Sender: TObject);
begin Form1.a1NaR.Checked:=not(Form1.a1NaR.Checked); end;

procedure TForm1.b1NaRClick(Sender: TObject);
begin Form1.b1NaR.Checked:=not(Form1.b1NaR.Checked); end;

procedure TForm1.a2NaRClick(Sender: TObject);
begin Form1.a2NaR.Checked:=not(Form1.a2NaR.Checked); end;

procedure TForm1.b2NaRClick(Sender: TObject);
begin Form1.b2NaR.Checked:=not(Form1.b2NaR.Checked); end;

procedure TForm1.a3NaRClick(Sender: TObject);
begin Form1.a3NaR.Checked:=not(Form1.a3NaR.Checked); end;

procedure TForm1.b3NaRClick(Sender: TObject);
begin Form1.b3NaR.Checked:=not(Form1.b3NaR.Checked); end;

procedure TForm1.c1NaRClick(Sender: TObject);
begin Form1.c1NaR.Checked:=not(Form1.c1NaR.Checked); end;

procedure TForm1.d1NaRClick(Sender: TObject);
begin Form1.d1NaR.Checked:=not(Form1.d1NaR.Checked); end;

procedure TForm1.c2NaRClick(Sender: TObject);
begin Form1.c2NaR.Checked:=not(Form1.c2NaR.Checked); end;

procedure TForm1.d2NaRClick(Sender: TObject);
begin Form1.d2NaR.Checked:=not(Form1.d2NaR.Checked); end;

procedure TForm1.c3NaRClick(Sender: TObject);
begin Form1.c3NaR.Checked:=not(Form1.c3NaR.Checked); end;

procedure TForm1.d3NaRClick(Sender: TObject);
begin Form1.d3NaR.Checked:=not(Form1.d3NaR.Checked); end;

procedure TForm1.VNaRClick(Sender: TObject);
begin Form1.VNaR.Checked:=not(Form1.VNaR.Checked); end;

procedure TForm1.a1KClick(Sender: TObject);
begin Form1.a1K.Checked:=not(Form1.a1K.Checked); end;

procedure TForm1.a2KClick(Sender: TObject);
begin Form1.a2K.Checked:=not(Form1.a2K.Checked); end;

procedure TForm1.a3KClick(Sender: TObject);
begin Form1.a3K.Checked:=not(Form1.a3K.Checked); end;

procedure TForm1.b1KClick(Sender: TObject);
begin Form1.b1K.Checked:=not(Form1.b1K.Checked); end;

procedure TForm1.b2KClick(Sender: TObject);
begin Form1.b2K.Checked:=not(Form1.b2K.Checked); end;

procedure TForm1.b3KClick(Sender: TObject);
begin Form1.b3K.Checked:=not(Form1.b3K.Checked); end;

procedure TForm1.VKClick(Sender: TObject);
begin Form1.VK.Checked:=not(Form1.VK.Checked); end;

{======== End Main Menu ======================}
{======== Plot2DPopMenu ======================}

procedure TForm1.FrequencynuIind1Click(Sender: TObject);
begin
  Form1.FrequencynuIind1.Checked:=not(Form1.FrequencynuIind1.Checked);
end;

procedure TForm1.Plot2Dnuus1Click(Sender: TObject);
begin
  Form1.Plot2Dnuus1.Checked:=not(Form1.Plot2Dnuus1.Checked);
  if Form1.Plot2Dnuus1.Checked then  Form9.Visible:=true;
end;

{========== Save Dialogs and their popmenus ============}

procedure TForm1.SaveDialog1CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  AssignFile(fff, SaveDialog1.FileName);  //Rewrite(fff);
  ChDir(MainDir);
  IfWriteInFFF:=1;
  { Calculating, drawing and writing the functions }
  {***********}
  Form1.Chart5.Visible:=True;
  Form1.Chart4.Visible:=True;
  VoltageOrCurrentClamp(uu,ss);
  {***********}
  if MessageDlg(MyWarning+'. OK?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//    CloseFile(fff)
  else begin
    Rewrite(fff);
    CloseFile(fff);
  end;
  IfWriteInFFF:=0;
end;

procedure TForm1.SaveDialog2CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  AssignFile(fff, SaveDialog2.FileName);  //Rewrite(fff);
  ChDir(MainDir);
  IfWriteInFFF:=2;
  { Calculating, drawing and writing the functions }
  {***********}
  Form1.Chart5.Visible:=True;
  Form1.Chart4.Visible:=True;
  VoltageOrCurrentClamp(uu,ss);
  {***********}
  if MessageDlg(MyWarning+'. OK?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//    CloseFile(fff)
  else begin
    Rewrite(fff);
    CloseFile(fff);
  end;
  IfWriteInFFF:=0;
end;

procedure TForm1.SaveDialog3CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  AssignFile(fff, SaveDialog3.FileName);  //Rewrite(fff);
  ChDir(MainDir);
  IfWriteInFFF:=3;
  { Calculating, drawing and writing the functions }
  {***********}
  Form1.Chart5.Visible:=True;
  Form1.Chart4.Visible:=True;
  VoltageOrCurrentClamp(uu,ss);
  {***********}
  if MessageDlg(MyWarning+'. OK?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//    CloseFile(fff)
  else begin
    Rewrite(fff);
    CloseFile(fff);
  end;
  IfWriteInFFF:=0;
end;

procedure TForm1.SaveDialog4CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  AssignFile(fff, SaveDialog4.FileName);  //Rewrite(fff);
  ChDir(MainDir);
  IfWriteInFFF:=4;
  { Calculating, drawing and writing the functions }
  {***********}
  Form1.Chart5.Visible:=True;
  Form1.Chart4.Visible:=True;
  { VoltageOrCurrentClamp(uu[1],ss[1]);  or  IntegrateWithNoise(100000); }
  if (MessageDlg('Run "RunClamp"', mtConfirmation,[mbYes,mbNo],0)=mrYes) then
      VoltageOrCurrentClamp(uu,ss) else
  if (MessageDlg('Run "WithNoise"',mtConfirmation,[mbYes,mbNo],0)=mrYes) then
      IntegrateWithNoise(100000);
  {***********}
  if MessageDlg(MyWarning+'. OK?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
//    CloseFile(fff)
  else begin
    Rewrite(fff);
    CloseFile(fff);
  end;
  IfWriteInFFF:=0;
end;

procedure TForm1.SaveVtofile1Click(Sender: TObject);
begin
  SaveDialog1.Execute;
end;

procedure TForm1.Saveexpmodcurvestofile1Click(Sender: TObject);
begin
  SaveDialog2.Execute;
end;

procedure TForm1.SavemRandhRtofile1Click(Sender: TObject);
begin
  SaveDialog3.Execute;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Form1.PopupMenu1.Popup(Form1.Button1.Left,
                         Form1.Button1.Top);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Form1.PopupMenu2.Popup(Form1.Button2.Left,
                         Form1.Button2.Top);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Form1.PopupMenu3.Popup(Form1.Button3.Left,
                         Form1.Button3.Top);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Form1.RadioGroup1.Visible:=true;
  Form1.Memo1.Visible:=true;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  Form17.Visible:=true;
  Form1.Left:=Form1.Left+1000;
  Form4.Visible:=false;
  Form17.Button2.Caption:='Show detailed information';
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Form1.RadioGroup1.Visible:=true;
  Form1.Memo1.Visible:=true;
  IfDrawAskedCurve:=1;
end;

{========== Open Dialogs =============================================}

procedure TForm1.Openidfile1Click(Sender: TObject);
var CurrDir :string;
begin
  GetDir(0,CurrDir);  ChDir(CurrDir);
  Form1.OpenDialog1.InitialDir:=CurrDir;
  OpenDialog1.Execute;
  ChDir(CurrDir);
end;

procedure TForm1.OpenDialog1CanClose(Sender: TObject;
  var CanClose: Boolean);
var CurrDir :string;
begin
//  GetDir(0,CurrDir);  ChDir(CurrDir);
  Form1.ParamsMemo.Visible:=true;
  ParFile:=OpenDialog1.FileName;
  CommonParametersFrom_ParFile;
  CorrespondParametersToTheForm;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  if IfDrawAskedCurve=1 then begin
     VoltageOrCurrentClamp(uu,ss);
     IfDrawAskedCurve:=0;
  end else begin
     SaveDialog4.Execute;
  end;
  Form1.RadioGroup1.Visible:=false;
  Form1.Memo1.Visible:=false;
  Form1.RadioGroup1.ItemIndex:=-1;
end;

{========== Panel for FiringClamp ====================================}

procedure TForm1.CloseRadioGroup1Click(Sender: TObject);
begin
  Form1.RadioGroup1.Visible:=false;
end;

procedure TForm1.Noise1Click(Sender: TObject);
begin
  Form1.DDSpinEdit7.Visible:=true;
  Form1.StaticText7.Visible:=true;
end;

procedure ShowNoisePanel(YesOrNo :boolean);
begin
  Form1.Panel1.Visible:=YesOrNo;
  Form1.DDSpinEdit7.Visible:=YesOrNo;
  Form1.StaticText7.Visible:=YesOrNo;
  Form1.DDSpinEdit8.Visible:=YesOrNo;
  Form1.StaticText8.Visible:=YesOrNo;
  Form1.DDSpinEdit9.Visible:=YesOrNo;
  Form1.StaticText9.Visible:=YesOrNo;
  Form1.DDSpinEdit10.Visible:=YesOrNo;
  Form1.StaticText10.Visible:=YesOrNo;
  Form1.DDSpinEdit11.Visible:=YesOrNo;
  Form1.StaticText11.Visible:=YesOrNo;
  Form1.DDSpinEdit12.Visible:=YesOrNo;
  Form1.StaticText13.Visible:=YesOrNo;
  Form1.RadioGroup2.Visible:=YesOrNo;
//  Form1.Button9 .Visible:=YesOrNo;
  Form1.Button2 .Visible:=not(YesOrNo);
  Form1.Button3 .Visible:=not(YesOrNo);
  Form1.Chart5.Visible:=not(YesOrNo);
  Form1.Chart4.Visible:=not(YesOrNo);
  Form1.Chart2.Visible:=not(YesOrNo);
  Form1.Label2.Visible:=not(YesOrNo);
  Form8.Visible:=YesOrNo;
  Form16.Visible:=YesOrNo;
end;

procedure TForm1.Button8MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ShowNoisePanel(true);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  if StopKey='P' then StopKey:=' ' else
  StopKey:='P';
//  Form8.Visible:=true;
//  AnalyzeByFiringClamp_In_Thread:=TFCinThread.Create(False);
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  Form13.Visible:=Form1.CheckBox1.Checked;
  if not(Form1.CheckBox1.Checked) then IfStartStat:=0;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  Form14.Visible:=Form1.CheckBox2.Checked;
  Form8.CheckBox1.Checked:=false;
  Form8.TurnOnWiener;
end;

procedure TForm1.ThrModelClick(Sender: TObject);
begin
  Form1.ThrModel.Checked:=not(Form1.ThrModel.Checked);
  NP0.IfThrModel:=IfTrue(Form1.ThrModel.Checked);
  NP0.IfBlockNa:=NP0.IfThrModel;
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.LIFmodelClick(Sender: TObject);
begin
  Form1.LIFmodel.Checked:=not(Form1.LIFmodel.Checked);
  NP0.IfLIF:=IfTrue(Form1.LIFmodel.Checked);
  HodgkinPhysParameters(NP0);
  CorrespondParametersToTheForm;
end;

procedure TForm1.Panel1DblClick(Sender: TObject);
begin
  ShowNoisePanel(false);
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  if Form1.ComboBox2.ItemIndex in[3,4] then begin
     Form1.ComboBox1.ItemIndex:=4;  {Nothing}
     Form1.DDSpinEdit18.Value:=-40; {du_Reset}
     Form1.RadioGroup3.ItemIndex:=5;{VT_1ms}
     Form1.DDSpinEdit8.Value:=200;  {Freq.hold}
     Form9.DDSpinEdit6.Value:=79;   {Max number of spikes}
     Form9.DDSpinEdit13.Value:=-2;  {u_min}
     Form9.DDSpinEdit9.Value:=-0.1; {s_min}
     Form9.DDSpinEdit7.Value:=60;   {nue}
     Form9.DDSpinEdit8.Value:=30;   {nse}
     Form1.DDSpinEdit10.Value:=30;  {tau_E}
     Form1.DDSpinEdit11.Value:=40;  {tau_I}
     Form1.DDSpinEdit6.Value:=0.2;  {s}
     Form1.DDSpinEdit3.Value:=400;  {t_end}
  end;
  CorrespondParametersToTheForm;
end;

procedure TForm1.DDSpinEdit20Change(Sender: TObject);
begin
  t_IindShift :=Form1.DDSpinEdit20.Value/1000;
end;

procedure TForm1.DDSpinEdit5DblClick(Sender: TObject);
begin
  uu:=0;
  Form1.DDSpinEdit5.Value:=0;
end;

procedure TForm1.DDSpinEdit6DblClick(Sender: TObject);
begin
  ss:=0;
  Form1.DDSpinEdit6.Value:=0;
end;

procedure TForm1.DDSpinEdit10DblClick(Sender: TObject);
begin
  Form1.DDSpinEdit10.Value:=0;
end;

procedure TForm1.DDSpinEdit11DblClick(Sender: TObject);
begin
  Form1.DDSpinEdit11.Value:=0;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
  if Form1.Button10.Caption ='Make linear F,G' then begin
     Form1.Button10.Caption:='Undo linear F,G';
  end else begin
     Form1.Button10.Caption:='Make linear F,G';
  end;
  ReadAndDraw_fm_gm;
end;

{----- disable Series -----}

procedure TForm1.Series1DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.Series1.Active:=false;
end;

procedure TForm1.Series2DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.Series2.Active:=false;
end;

procedure TForm1.Series3DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.Series3.Active:=false;
end;

procedure TForm1.Series4DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.Series4.Active:=false;
end;

procedure TForm1.Series5DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.Series5.Active:=false;
end;

procedure TForm1.Series6DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.Series6.Active:=false;
end;

procedure TForm1.Series7DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.Series7.Active:=false;
end;

procedure TForm1.Series8DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.Series8.Active:=false;
end;

procedure TForm1.Series9DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form1.Series9.Active:=false;
end;

procedure TForm1.Series10DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series10.Active:=false;
end;

procedure TForm1.Series11DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series11.Active:=false;
end;

procedure TForm1.Series12DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series12.Active:=false;
end;

procedure TForm1.Series13DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series13.Active:=false;
end;

procedure TForm1.Series14DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series14.Active:=false;
end;

procedure TForm1.Series15DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series15.Active:=false;
end;

procedure TForm1.Series16DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series16.Active:=false;
end;

procedure TForm1.Series17DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series17.Active:=false;
end;

procedure TForm1.Series18DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series18.Active:=false;
end;

procedure TForm1.Series19DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series19.Active:=false;
end;

procedure TForm1.Series20DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series20.Active:=false;
end;

procedure TForm1.Series21DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series21.Active:=false;
end;

procedure TForm1.Series22DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series22.Active:=false;
end;

procedure TForm1.Series23DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series23.Active:=false;
end;

procedure TForm1.Series24DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series24.Active:=false;
end;

procedure TForm1.Series25DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series25.Active:=false;
end;

procedure TForm1.Enableallseries1Click(Sender: TObject);
begin
  Form1.Series1.Active:=true;
  Form1.Series2.Active:=true;
  Form1.Series3.Active:=true;
  Form1.Series4.Active:=true;
  Form1.Series5.Active:=true;
  Form1.Series6.Active:=true;
  Form1.Series7.Active:=true;
  Form1.Series8.Active:=true;
  Form1.Series9.Active:=true;
  Form1.Series10.Active:=true;
  Form1.Series11.Active:=true;
  Form1.Series12.Active:=true;
  Form1.Series13.Active:=true;
  Form1.Series14.Active:=true;
  Form1.Series15.Active:=true;
  Form1.Series16.Active:=true;
  Form1.Series17.Active:=true;
  Form1.Series18.Active:=true;
  Form1.Series19.Active:=true;
  Form1.Series20.Active:=true;
  Form1.Series21.Active:=true;
  Form1.Series22.Active:=true;
  Form1.Series23.Active:=true;
  Form1.Series24.Active:=true;
  Form1.Series25.Active:=true;
  Form1.Series26.Active:=true;
end;

{-------------------------------------------------------}
procedure TForm1.Button11Click(Sender: TObject);
{ Adjust scales to current plot }
begin
  Form1.Chart1.BottomAxis.AutomaticMaximum:=false;
  Form1.Chart1.BottomAxis.AutomaticMinimum:=false;
  if Form1.Chart2.BottomAxis.Maximum>Form1.Chart1.BottomAxis.Minimum then begin
     Form1.Chart1.BottomAxis.Maximum:=Form1.Chart2.BottomAxis.Maximum;
     Form1.Chart1.BottomAxis.Minimum:=Form1.Chart2.BottomAxis.Minimum;
  end else begin
     Form1.Chart1.BottomAxis.Minimum:=Form1.Chart2.BottomAxis.Minimum;
     Form1.Chart1.BottomAxis.Maximum:=Form1.Chart2.BottomAxis.Maximum;
  end;
  Application.ProcessMessages;
end;

procedure TForm1.Button12Click(Sender: TObject);
{ Adjust scales to voltage plot }
begin
  Form1.Chart2.BottomAxis.AutomaticMaximum:=false;
  Form1.Chart2.BottomAxis.AutomaticMinimum:=false;
  Form1.Chart2.BottomAxis.Maximum:=Form1.Chart1.BottomAxis.Maximum;
  Form1.Chart2.BottomAxis.Minimum:=Form1.Chart1.BottomAxis.Minimum;
  Application.ProcessMessages;
end;

procedure TForm1.Button13Click(Sender: TObject);
{ Auto }
begin
  Form1.Chart1.BottomAxis.AutomaticMaximum:=true;
  Form1.Chart1.BottomAxis.AutomaticMinimum:=true;
  Application.ProcessMessages;
end;

procedure TForm1.Button14Click(Sender: TObject);
{ Auto }
begin
  Form1.Chart2.BottomAxis.AutomaticMaximum:=true;
  Form1.Chart2.BottomAxis.AutomaticMinimum:=true;
  Application.ProcessMessages;
end;

procedure TForm1.Button15Click(Sender: TObject);
{ Adjust scales to voltage plot }
begin
  Form1.Chart4.BottomAxis.AutomaticMaximum:=false;
  Form1.Chart4.BottomAxis.AutomaticMinimum:=false;
  Form1.Chart4.BottomAxis.Maximum:=Form1.Chart1.BottomAxis.Maximum;
  Form1.Chart4.BottomAxis.Minimum:=Form1.Chart1.BottomAxis.Minimum;
  Application.ProcessMessages;
end;

procedure TForm1.Button16Click(Sender: TObject);
{ Adjust scales to voltage plot }
begin
  Form1.Chart5.BottomAxis.AutomaticMaximum:=false;
  Form1.Chart5.BottomAxis.AutomaticMinimum:=false;
  Form1.Chart5.BottomAxis.Maximum:=Form1.Chart1.BottomAxis.Maximum;
  Form1.Chart5.BottomAxis.Minimum:=Form1.Chart1.BottomAxis.Minimum;
  Application.ProcessMessages;
end;

procedure TForm1.Button17Click(Sender: TObject);
{ Auto }
begin
  Form1.Chart4.BottomAxis.AutomaticMaximum:=true;
  Form1.Chart4.BottomAxis.AutomaticMinimum:=true;
  Application.ProcessMessages;
end;

procedure TForm1.Button18Click(Sender: TObject);
{ Auto }
begin
  Form1.Chart5.BottomAxis.AutomaticMaximum:=true;
  Form1.Chart5.BottomAxis.AutomaticMinimum:=true;
  Application.ProcessMessages;
end;

procedure TForm1.Button19Click(Sender: TObject);
begin
  Form1.Chart4.CopyToClipboardBitmap;
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
  Form1.Chart5.CopyToClipboardBitmap;
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
  Form1.Chart1.CopyToClipboardBitmap;
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
  Form1.Chart2.CopyToClipboardBitmap;
end;

procedure TForm1.Button23Click(Sender: TObject);
begin
  Form1.Chart3.CopyToClipboardBitmap;
end;

procedure TForm1.Button24Click(Sender: TObject);
begin
  Form18.Visible:=true;
  Form31.Visible:=true;
end;

procedure TForm1.Button25Click(Sender: TObject);
begin
  if Form1.RunClampButton.Enabled then begin
     Form1.Button25.Enabled:=false;
     Form12.Show;
     Form20.Show;
     VoltageOrCurrentClamp_ActiveFiber;
     Form1.Button25.Enabled:=true;
  end;
end;

procedure TForm1.Series26DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series26.Active:=false;
end;

procedure TForm1.Series27DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form1.Series27.Active:=false;
end;

procedure TForm1.DDSpinEdit23Change(Sender: TObject);
begin
  s_soma:=Form1.DDSpinEdit23.Value;
end;

procedure TForm1.DDSpinEdit23DblClick(Sender: TObject);
begin
  Form1.DDSpinEdit23.Value:=0;
  s_soma:=0;
end;

procedure TForm1.rampid1Click(Sender: TObject);
begin
  ChDir(MainDir);
  Form1.ParamsMemo.Visible:=true;
  ParFile:='ramp.id';
  CommonParametersFrom_ParFile;
  CorrespondParametersToTheForm;
end;

procedure TForm1.VCstepsid1Click(Sender: TObject);
begin
  ChDir(MainDir);
  Form1.ParamsMemo.Visible:=true;
  ParFile:='VC_steps.id';
  CommonParametersFrom_ParFile;
  CorrespondParametersToTheForm;
end;

procedure TForm1.Simplex2Click(Sender: TObject);
{ Simplex }
begin
  Form1.SimplexMemo.Visible:=True;
  Form1.    CoeMemo.Visible:=True;
  Form1.Chart5.Visible:=False;
  Form1.Chart4.Visible:=False;
  Form1.Chart1.Visible:=false;
  Form1.Chart2.Visible:=false;
  AssignCoeffToChange;

//  ThreadObject.ForExecute:=
  Run_Simplex;
//  RunThread.Start;
end;

procedure TForm1.FiringClampandPRC1Click(Sender: TObject);
{ Firing-Clamp and PRC }
begin
  IntegrateWithNoise(100000);
  StopKey:='N';
end;

procedure TForm1.ActInact1Click(Sender: TObject);
{ Act/Inact }
begin
  Form2.Visible:=true;
end;


procedure TForm1.Setexpdatafile1Click(Sender: TObject);
begin
  Form1.OpenDialog2.Execute;
  SmplFile[Smpl]:=Form1.OpenDialog2.FileName;
end;


procedure TForm1.Memo1Click(Sender: TObject);
begin
  Form1.RadioGroup1.Visible:=false;
  Form1.Memo1.Visible:=false;
end;

end.
