unit Unit31;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DDSpinEdit, TeEngine, Series, ExtCtrls, TeeProcs, Chart, FileCtrl;

type
  TForm31 = class(TForm)
    DDSpinEdit1: TDDSpinEdit;
    Label1: TLabel;
    Button1: TButton;
    Chart1: TChart;
    Series1: TLineSeries;
    Chart2: TChart;
    Series2: TLineSeries;
    DDSpinEdit2: TDDSpinEdit;
    Label2: TLabel;
    Series3: TLineSeries;
    Series4: TPointSeries;
    Series5: TPointSeries;
    Label7: TLabel;
    OpenDialog1: TOpenDialog;
    Series6: TPointSeries;
    ComboBox1: TComboBox;
    Memo1: TMemo;
    Label11: TLabel;
    DDSpinEdit9: TDDSpinEdit;
    Series9: TPointSeries;
    DDSpinEdit10: TDDSpinEdit;
    Label12: TLabel;
    Button2: TButton;
    Series7: TLineSeries;
    GroupBox1: TGroupBox;
    DDSpinEdit3: TDDSpinEdit;
    Label3: TLabel;
    Button3: TButton;
    Label4: TLabel;
    DDSpinEdit4: TDDSpinEdit;
    Series8: TLineSeries;
    Button4: TButton;
    Chart3: TChart;
    DDSpinEdit5: TDDSpinEdit;
    Label5: TLabel;
    DDSpinEdit6: TDDSpinEdit;
    Label6: TLabel;
    Series10: TPointSeries;
    Series11: TPointSeries;
    ComboBox2: TComboBox;
    Label8: TLabel;
    DDSpinEdit7: TDDSpinEdit;
    CheckBox1: TCheckBox;
    DDSpinEdit8: TDDSpinEdit;
    Label9: TLabel;
    Button5: TButton;
    Button13: TButton;
    Button6: TButton;
    Button21: TButton;
    Button7: TButton;
    Button8: TButton;
    Button11: TButton;
    Button9: TButton;
    Button10: TButton;
    procedure Button1Click(Sender: TObject);
    procedure DDSpinEdit2Change(Sender: TObject);
    procedure Label7Click(Sender: TObject);
    procedure Chart1DblClick(Sender: TObject);
    procedure Memo1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Series1DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series10DblClick(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Series11DblClick(Sender: TChartSeries; ValueIndex: Integer;
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
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function AskFileName :boolean;
  procedure ReReadDataFromSimulationToRampAnalysis;

var
  Form31: TForm31;

implementation
uses {RampInit,}MyTypes,MathMyO,RampMain,Init,t_dtO;

{$R *.DFM}

function AskFileName :boolean;
var ie,i :integer;
begin
  Form31.OpenDialog1.InitialDir:=Form31.ComboBox1.Items[Form31.ComboBox1.ItemIndex];
  Form31.OpenDialog1.Execute;
  if Form31.OpenDialog1.FileName='' then  exit;
  Ramp.FName:=Form31.OpenDialog1.FileName;
  { Root Directory }
  GetDir(0,Ramp.RootDir);
  AskFileName:=true;
end;

procedure TForm31.Button1Click(Sender: TObject);
begin
  AskFileName;
  Ramp.ReadAndDraw;
end;

procedure TForm31.DDSpinEdit2Change(Sender: TObject);
begin
  if (Form31.DDSpinEdit2.Value>=1)and(Form31.DDSpinEdit2.Value<=MaxSmpls)
  then begin
      Ramp.Smpl:=trunc(Form31.DDSpinEdit2.Value);
      Ramp.Draw2Arrays(Ramp.Smpl);
      Ramp.FilterCurrent;
      Ramp.FindThreshold;
  end else Form31.DDSpinEdit2.Value:=min(max(Form31.DDSpinEdit2.Value,1),MaxSmpls);
end;

procedure TForm31.Label7Click(Sender: TObject);
var i,ie :integer;
begin
  AskFileName;
end;

procedure TForm31.Chart1DblClick(Sender: TObject);
begin
  Form31.Chart1.BottomAxis.Automatic:=true;
  Form31.Chart1.LeftAxis.Automatic:=true;
end;

procedure TForm31.Memo1Click(Sender: TObject);
begin
  Form31.Memo1.Visible:=false;
end;

procedure TForm31.Button2Click(Sender: TObject);
begin
  Ramp.FilterCurrent;
end;

procedure TForm31.Button3Click(Sender: TObject);
begin
  Ramp.FindThreshold;
end;

procedure TForm31.FormShow(Sender: TObject);
begin
  {*****************}
  {*****************}
  {*****************}
  Ramp:=TRamp.Create;
  {*****************}
  {*****************}
  {*****************}
  if Form31.ComboBox2.ItemIndex=1 then begin {Unscaled}
     Form31.DDSpinEdit9.Enabled:=false;
     Form31.DDSpinEdit10.Enabled:=false;
     Form31.DDSpinEdit5.Enabled:=false;
  end else begin
     Form31.DDSpinEdit9.Enabled:=true;
     Form31.DDSpinEdit10.Enabled:=true;
     Form31.DDSpinEdit5.Enabled:=true;
  end;
  Ramp.RootDir:='E:\Anton\NN_Data\Na-channels\09_02_2010\Cell_1\';
  Ramp.FName:=Ramp.RootDir+'ramp_002[1-80].txt';
  { if Data from simulations }
  if FileExists(Ramp.FName)=false then begin
     ReReadDataFromSimulationToRampAnalysis;
     Form31.ComboBox1.ItemIndex:=5;
  end else begin
     Ramp.ReadAndDraw;
  end;   
  Ramp.FilterCurrent;
  Ramp.FindThreshold;
end;

procedure TForm31.Button4Click(Sender: TObject);
begin
  Ramp.TreatAllSamples;
end;

procedure TForm31.ComboBox1Change(Sender: TObject);
begin
  if Form31.ComboBox1.ItemIndex=1 then begin  //Cell_3
     Form31.DDSpinEdit4.Value:=800;
     Form31.DDSpinEdit5.Value:=3000;
     Form31.DDSpinEdit6.Value:=1.0;
     Form31.DDSpinEdit7.Value:=1000;
     Ramp.RootDir:=Form31.ComboBox1.Items[Form31.ComboBox1.ItemIndex];
     Ramp.FName:=Ramp.RootDir+'ramp[1-70].txt';
  end;
  if Form31.ComboBox1.ItemIndex=2 then begin  //Lyle
     Form31.DDSpinEdit4.Value:=400;
//     Form31.DDSpinEdit5.Value:=3000;
     Form31.DDSpinEdit6.Value:=1.5;
     Form31.DDSpinEdit7.Value:=500;
     Ramp.RootDir:=Form31.ComboBox1.Items[Form31.ComboBox1.ItemIndex];
     Ramp.FName:=Ramp.RootDir+'all_ramps_Lyle.dat';
  end;
  if Form31.ComboBox1.ItemIndex=3 then begin  //Destexhe
     Form31.DDSpinEdit4.Value:=200;
//     Form31.DDSpinEdit5.Value:=3000;
     Form31.DDSpinEdit6.Value:=4;
     Form31.DDSpinEdit7.Value:=200;
     Ramp.RootDir:=Form31.ComboBox1.Items[Form31.ComboBox1.ItemIndex];
     Ramp.FName:=Ramp.RootDir+'all_ramps_Destexhe.dat';
  end;
  if Form31.ComboBox1.ItemIndex=4 then begin  //Soma+Axon_Migli
     Form31.DDSpinEdit4.Value:=400;
//     Form31.DDSpinEdit5.Value:=3000;
     Form31.DDSpinEdit6.Value:=2;
     Form31.DDSpinEdit7.Value:=200;
     Ramp.RootDir:=Form31.ComboBox1.Items[Form31.ComboBox1.ItemIndex];
     Ramp.FName:=Ramp.RootDir+'all_ramps_S+A_Migli.dat';
  end;
  Ramp.ReadAndDraw;
  Ramp.FilterCurrent;
  Ramp.FindThreshold;
end;

procedure TForm31.ComboBox2Change(Sender: TObject);
begin
  if Form31.ComboBox2.ItemIndex=1 then begin {Unscaled}
     Form31.DDSpinEdit9.Enabled:=false;
     Form31.DDSpinEdit10.Enabled:=false;
     Form31.DDSpinEdit5.Enabled:=false;
  end else begin
     Form31.DDSpinEdit9.Enabled:=true;
     Form31.DDSpinEdit10.Enabled:=true;
     Form31.DDSpinEdit5.Enabled:=true;
  end;
end;

procedure TForm31.Button11Click(Sender: TObject);
{ Adjust scales to current plot }
begin
  Form31.Chart1.BottomAxis.AutomaticMaximum:=false;
  Form31.Chart1.BottomAxis.AutomaticMinimum:=false;
  if Form31.Chart2.BottomAxis.Maximum>Form31.Chart1.BottomAxis.Minimum then begin
     Form31.Chart1.BottomAxis.Maximum:=Form31.Chart2.BottomAxis.Maximum;
     Form31.Chart1.BottomAxis.Minimum:=Form31.Chart2.BottomAxis.Minimum;
  end else begin
     Form31.Chart1.BottomAxis.Minimum:=Form31.Chart2.BottomAxis.Minimum;
     Form31.Chart1.BottomAxis.Maximum:=Form31.Chart2.BottomAxis.Maximum;
  end;
  Application.ProcessMessages;
end;

procedure TForm31.Button5Click(Sender: TObject);
{ Adjust scales to voltage plot }
begin
  Form31.Chart2.BottomAxis.AutomaticMaximum:=false;
  Form31.Chart2.BottomAxis.AutomaticMinimum:=false;
  Form31.Chart2.BottomAxis.Maximum:=Form31.Chart1.BottomAxis.Maximum;
  Form31.Chart2.BottomAxis.Minimum:=Form31.Chart1.BottomAxis.Minimum;
  Application.ProcessMessages;
end;

procedure TForm31.Button13Click(Sender: TObject);
{ Auto }
begin
  Form31.Chart1.BottomAxis.AutomaticMaximum:=true;
  Form31.Chart1.BottomAxis.AutomaticMinimum:=true;
  Application.ProcessMessages;
end;

procedure TForm31.Button6Click(Sender: TObject);
{ Auto }
begin
  Form31.Chart2.BottomAxis.AutomaticMaximum:=true;
  Form31.Chart2.BottomAxis.AutomaticMinimum:=true;
  Application.ProcessMessages;
end;

procedure TForm31.Button21Click(Sender: TObject);
begin
  Form31.Chart1.CopyToClipboardBitmap;
end;

procedure TForm31.Button7Click(Sender: TObject);
begin
  Form31.Chart2.CopyToClipboardBitmap;
end;

procedure TForm31.Button8Click(Sender: TObject);
begin
  Form31.Chart3.CopyToClipboardBitmap;
end;

procedure TForm31.Series1DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form31.Series1.Active:=false;
end;

{ ---- disable Series ---- }

procedure TForm31.Series10DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form31.Series10.Active:=false;
end;

procedure TForm31.Series11DblClick(Sender: TChartSeries;
  ValueIndex: Integer; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  Form31.Series11.Active:=false;
end;

procedure TForm31.Series2DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form31.Series2.Active:=false;
end;

procedure TForm31.Series3DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form31.Series3.Active:=false;
end;

procedure TForm31.Series4DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form31.Series4.Active:=false;
end;

procedure TForm31.Series5DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form31.Series5.Active:=false;
end;

procedure TForm31.Series6DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form31.Series6.Active:=false;
end;

procedure TForm31.Series7DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form31.Series7.Active:=false;
end;

procedure TForm31.Series8DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form31.Series8.Active:=false;
end;

procedure TForm31.Series9DblClick(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Form31.Series9.Active:=false;
end;

procedure TForm31.Button9Click(Sender: TObject);
begin
  Form31.Series1.Active:=true;
  Form31.Series2.Active:=true;
  Form31.Series3.Active:=true;
  Form31.Series4.Active:=true;
  Form31.Series5.Active:=true;
  Form31.Series6.Active:=true;
  Form31.Series7.Active:=true;
  Form31.Series8.Active:=true;
  Form31.Series9.Active:=true;
  Form31.Series10.Active:=true;
  Form31.Series11.Active:=true;
end;

{************************ Data from Simulations *******************************}

procedure ReReadDataFromSimulationToRampAnalysis;
var
    nt_,Smpl_            :integer;
    t_,V_,I_             :double;
begin
  Ramp.RootDir:=MainDir+'\';
  Ramp.NSmpl:=NSmpls;
  Ramp.t_maxLimit:=Form31.DDSpinEdit8.Value/1000; {s}
  nt_end:=imin(nt_end,MaxExp);
  for Smpl_:=1 to NSmpls do begin
      nt_:=0;
      repeat nt_:=nt_+1;
        t_:=nt_*dt;
        Ramp.texp[nt_]:=t_*1e3;
        Ramp.Vexp[nt_,Smpl_]:=Vexp[nt_,Smpl_];
        Ramp.Iexp[nt_,Smpl_]:=Vmod[nt_,Smpl_];
      until (nt_=nt_end) or (t_>=Ramp.t_maxLimit);
      Ramp.Nexp:=nt_;
  end;
  Ramp.IfExpIsRead:=1;
  Ramp.Smpl:=Smpl;
  Ramp.Draw2Arrays(Ramp.Smpl);
end;

procedure TForm31.Button10Click(Sender: TObject);
begin
  ReReadDataFromSimulationToRampAnalysis;
end;

procedure TForm31.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Ramp.Free;
  Ramp:=nil;
end;

end.
