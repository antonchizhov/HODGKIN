unit Unit18;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DDSpinEdit,
  Init,t_dtO,MathMyO,RunFiber,
  Unit31,RampMain,
  TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TForm18 = class(TForm)
    Button1: TButton;
    DDSpinEdit1: TDDSpinEdit;
    StaticText12: TStaticText;
    DDSpinEdit2: TDDSpinEdit;
    DDSpinEdit3: TDDSpinEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    DDSpinEdit4: TDDSpinEdit;
    StaticText3: TStaticText;
    Chart1: TChart;
    Series1: TLineSeries;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button22: TButton;
    GroupBox1: TGroupBox;
    CheckBox3: TCheckBox;
    DDSpinEdit6: TDDSpinEdit;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    DDSpinEdit7: TDDSpinEdit;
    Series2: TLineSeries;
    RadioGroup1: TRadioGroup;
    StaticText7: TStaticText;
    DDSpinEdit8: TDDSpinEdit;
    GroupBox2: TGroupBox;
    StaticText10: TStaticText;
    DDSpinEdit11: TDDSpinEdit;
    DDSpinEdit9: TDDSpinEdit;
    DDSpinEdit10: TDDSpinEdit;
    DDSpinEdit12: TDDSpinEdit;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    StaticText11: TStaticText;
    DDSpinEdit5: TDDSpinEdit;
    StaticText4: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure DDSpinEdit1DblClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
   Form18: TForm18;
   yyy,vvv :text;

implementation
uses Clamp;

{$R *.dfm}

procedure TForm18.Button1Click(Sender: TObject);
var
    i,Ni,j,nt_ :integer;
    V_level,V0,Vmin,Vmax,Imin,V_DepStep,
    tmin,Imin2,tmin2,t_,
    FirstStepStart,DepStepStart,DepStepDuration,EndOfSteps,
    dV2,tau2,EndOfStep1,I_ :double;
    line :array[1..20] of string;
    sT,sV,sV0            :string;
begin
  Smpl:=19;
//  t_end:=0.210; {s}
  SmplFile[Smpl]:='ramp_.d';
  assignFile(yyy,SmplFile[Smpl]);
  assignFile(vvv,'Steps_V_Imin_Imin2.dat'); rewrite(vvv);
  Ni:=trunc(Form18.DDSpinEdit1.Value);
  Vmin:=Form18.DDSpinEdit2.Value;
  Vmax:=Form18.DDSpinEdit3.Value;
  DepStepStart   :=Form18.DDSpinEdit9.Value;
  DepStepDuration:=Form18.DDSpinEdit10.Value;
  FirstStepStart :=Form18.DDSpinEdit11.Value;
  EndOfSteps     :=Form18.DDSpinEdit12.Value;
  dV2 :=Form18.DDSpinEdit6.Value;
  tau2:=Form18.DDSpinEdit7.Value;   // First Step Duration
  V0       :=Form18.DDSpinEdit8.Value;
  V_DepStep:=Form18.DDSpinEdit5.Value;
  if Form18.CheckBox1.Checked then Form18.Series1.Clear;
  if Form18.CheckBox1.Checked then Form18.Series2.Clear;
//  n_Draw:=50;
  for i:=0 to Ni do begin
      if Ni=0 then V_level:=Vmin else V_level:=Vmin+(Vmax-Vmin)/Ni*i;
      Form18.DDSpinEdit4.Value:=V_level;
      { Write protocol in file }
      rewrite(yyy);
      str(V0:3:0,sV0);
      line[1]:='0		'+sV0;
      str(DepStepStart-0.1  :4:1,sT);                 //39.9
      line[2]:=sT+'   '+sV0;
      str(DepStepStart      :4:1,sT);                 //40
      str(V_DepStep:5:1,sV);                          //24mV
      line[3]:=sT+' 	'+sV;
      str(DepStepStart+DepStepDuration-0.1 :4:1,sT);  //139.9
      line[4]:=sT+'	  '+sV;
      str(DepStepStart+DepStepDuration     :4:1,sT);  //140
      line[5]:=sT+'		'+sV0;
      str(FirstStepStart      :4:1,sT);
      line[6]:=sT+'		'+sV0;
      str(FirstStepStart+0.1  :4:1,sT);
      str(V_level:5:1,sV);
      line[7]:=sT+'	 '+sV;
      { Double step }
      if Form18.CheckBox3.Checked then begin  // If double steps
         str(FirstStepStart+tau2 :4:1,sT);
         line[8]:=sT+' 	 '+sV;
         str(FirstStepStart+tau2+0.1 :4:1,sT);
         str(V_level+dV2:5:1,sV);
         line[9]:=sT+'	 '+sV;
      end else begin
         line[8]:=line[7];
         line[9]:=line[7];
      end;
      str(EndOfSteps     :4:1,sT);                    //FirstStepStart+40
      line[10]:=sT+' 	 '+sV;
      str(EndOfSteps+0.1 :4:1,sT);                    //FirstStepStart+40.1
      line[11]:=sT+'     '+sV0;
      line[12]:='500		'+sV0;
      for j:=1 to 12 do writeln(yyy,line[j]);
      closeFile(yyy);
      { Recording }
      {********** Data Source *************}
      case Form18.RadioGroup1.ItemIndex of
         {*** One-compartmental model *****}
      0: begin
           VoltageOrCurrentClamp(uu,ss);
           ReReadDataFromSimulationToRampAnalysis;
         end;
         {*** DistributedModel ************}
      1: begin
           VoltageOrCurrentClamp_ActiveFiber;
           ReReadDataFromSimulationToRampAnalysis;
         end;
         {*** Experiment (Form 31) ********}
      2: Smpl:=i+1;
      end;
      {************************************}
      { Analyze }
      Imin:=0;  Imin2:=0;  EndOfStep1:=EndOfSteps; //FirstStepStart+40;
      for nt_:=1 to nt_end do begin
          t_:=Ramp.texp[nt_];//nt_*dt*1000;
          if (t_>FirstStepStart)and(t_<EndOfSteps) then begin
             if Form18.RadioGroup1.ItemIndex in [0,1] then begin
                I_:=Vmod[nt_,Smpl];
             end else begin
                I_:=Ramp.Iexp[nt_,Smpl];
             end;
             { Double step }
             if Form18.CheckBox3.Checked then begin  // If double steps
                EndOfStep1:=FirstStepStart+tau2;
                if (t_>EndOfStep1)and(Imin2>I_) then begin
                   Imin2:=I_;    // second peak
                   tmin2:=t_;
                end;
             end;
             if (t_<EndOfStep1)and(Imin>I_) then begin
                Imin:=I_;        // first peak
                tmin:=t_;
             end;
          end;
      end;
      Form18.Series1.AddXY(V_level,Imin/1000);
      if Form18.CheckBox3.Checked then   // If double steps
      Form18.Series2.AddXY(V_level,Imin2/1000);
      Application.ProcessMessages;
      { Writing }
      writeln(vvv,V_level:9:3,' ',Imin/1000:9:3,' ',Imin2/1000:9:3,' ');
  end;
  closeFile(vvv);
end;

procedure TForm18.CheckBox2Click(Sender: TObject);
begin
  Form18.Series1.LinePen.Visible:=Form18.CheckBox2.Checked;
  Form18.Series2.LinePen.Visible:=Form18.CheckBox2.Checked;
end;

procedure TForm18.Button22Click(Sender: TObject);
begin
  Form18.Chart1.CopyToClipboardBitmap;
end;

procedure TForm18.DDSpinEdit1DblClick(Sender: TObject);
begin
  Form18.DDSpinEdit1.Value:=0;
end;

procedure TForm18.RadioGroup1Click(Sender: TObject);
begin
  if Form18.RadioGroup1.ItemIndex=2 then begin { Experiment }
     AskFileName;
     Ramp.ReadAndDraw;
  end;
end;

end.
