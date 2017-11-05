unit Unit7;     { RateOfGaussianEnsemble }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, {sgr_def, sgr_data,} DDSpinEdit, ExtCtrls,
  TeEngine, Series, TeeProcs, Chart,
  Unit1,Unit4,Unit8,Unit16,RateOfGaussian,Net,Init,typeNrnParsO,MathMyO;

type
  TForm7 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    DDSpinEdit2: TDDSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    DDSpinEdit3: TDDSpinEdit;
    Label3: TLabel;
    DDSpinEdit4: TDDSpinEdit;
    Label4: TLabel;
    Label5: TLabel;
    Button3: TButton;
    CheckBox1: TCheckBox;
    DDSpinEdit1: TDDSpinEdit;
    GroupBox2: TGroupBox;
    DDSpinEdit8: TDDSpinEdit;
    DDSpinEdit9: TDDSpinEdit;
    Label9: TLabel;
    Label10: TLabel;
    Chart1: TChart;
    DDSpinEdit10: TDDSpinEdit;
    Label11: TLabel;
    Series2: TPointSeries;
    Button4: TButton;
    GroupBox3: TGroupBox;
    DDSpinEdit7: TDDSpinEdit;
    Label8: TLabel;
    DDSpinEdit5: TDDSpinEdit;
    Label6: TLabel;
    Label12: TLabel;
    DDSpinEdit11: TDDSpinEdit;
    DDSpinEdit12: TDDSpinEdit;
    Label13: TLabel;
    DDSpinEdit6: TDDSpinEdit;
    Label7: TLabel;
    Series4: TFastLineSeries;
    Series5: TFastLineSeries;
    Series3: TLineSeries;
    Series1: TPointSeries;
    Series6: TPointSeries;
    Series7: TFastLineSeries;
    Series8: TFastLineSeries;
    Label14: TLabel;
    DDSpinEdit13: TDDSpinEdit;
    Label15: TLabel;
    Button5: TButton;
    Button6: TButton;
    Label16: TLabel;
    Label17: TLabel;
    Chart2: TChart;
    Series9: TLineSeries;
    Series10: TLineSeries;
    Label18: TLabel;
    DDSpinEdit14: TDDSpinEdit;
    Label19: TLabel;
    DDSpinEdit15: TDDSpinEdit;
    ComboBox1: TComboBox;
    Button7: TButton;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Button8: TButton;
    ComboBox2: TComboBox;
    DDSpinEdit16: TDDSpinEdit;
    Label20: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComboBox1DblClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure DDSpinEdit16DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;
  IfNoise                                     :boolean;

implementation

uses Unit15;

{$R *.DFM}

procedure TForm7.Button1Click(Sender: TObject);
begin
  Form1.ThrModel.Checked:=false;
  NP0.IfThrModel:=0;
  RateOfGaussianEnsemble;
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
  Form1.ThrModel.Checked:=true;
  NP0.IfThrModel:=1;
  RateOfGaussianEnsemble;
end;

procedure TForm7.CheckBox1Click(Sender: TObject);
begin
//  Form7.CheckBox1.Checked:=not(Form7.CheckBox1.Checked);
  if Form7.CheckBox1.Checked then begin
     Form7.DDSpinEdit1.Enabled:=true;
//     Form7.DDSpinEdit1.Value:=14 {mv};
     NP0.FixThr:=Form7.DDSpinEdit1.Value/1000+NP0.ThrShift;
  end else begin
     Form7.DDSpinEdit1.Enabled:=false;
     NP0.FixThr:=0;
  end;
  Form4.DDSpinEdit31.Value:=NP0.FixThr*1000;
end;

procedure TForm7.Button3Click(Sender: TObject);
begin
  Form7.CheckBox1.Checked:=true;
  Form7.DDSpinEdit1.Value:=14;
  Form1.ThrModel.Checked:=true;
  NP0.IfThrModel:=1;
  RateOfEnsembleWithGaussianConductances;
end;

procedure TForm7.Button4Click(Sender: TObject);
begin
  Form1.ThrModel.Checked:=false;
  NP0.IfThrModel:=0;
  RateOfEnsembleWithGaussianConductances;
end;

procedure TForm7.Button5Click(Sender: TObject);
begin
  Form1.ThrModel.Checked:=false;
  NP0.IfThrModel:=0;
  RateWithNoise;
end;

procedure TForm7.Button6Click(Sender: TObject);
begin
  if NP0.HH_type='Passive' then  Form1.LIFmodel.Checked:=true
                          else  Form1.ThrModel.Checked:=true;
  NP0.IfThrModel :=IfTrue(Form1.ThrModel.Checked);
  NP0.IfLIF      :=IfTrue(Form1.LIFmodel.Checked);
  RateWithNoise;
end;

procedure TForm7.FormShow(Sender: TObject);
begin
  Form7.ComboBox1.ItemIndex:=0;
  Form7.ComboBox2.ItemIndex:=0;
end;

procedure TForm7.ComboBox1DblClick(Sender: TObject);
begin
  Form7.ComboBox1.ItemIndex:=1-Form7.ComboBox1.ItemIndex;
  if Form7.ComboBox1.ItemIndex=1 then
     Form7.DDSpinEdit13.Value:=Form7.DDSpinEdit13.Value/10
  else
     Form7.DDSpinEdit13.Value:=Form7.DDSpinEdit13.Value*10;
end;

procedure TForm7.ComboBox1Change(Sender: TObject);
begin
  if Form7.ComboBox1.ItemIndex=1 then
     Form7.DDSpinEdit13.Value:=Form7.DDSpinEdit13.Value/10
  else
     Form7.DDSpinEdit13.Value:=Form7.DDSpinEdit13.Value*10;
end;

procedure TForm7.Button7Click(Sender: TObject);
begin
  Form15.Visible:=true;
  Form1.ThrModel.Checked:=false;
  NP0.IfThrModel :=IfTrue(Form1.ThrModel.Checked);
  IfNoise:=false;
  RunNet;
end;

procedure TForm7.Button8Click(Sender: TObject);
begin
  Form15.Visible:=true;
{  Form1.ThrModel.Checked:=false;
  NP0.IfThrModel :=IfTrue(Form1.ThrModel.Checked);}
  IfNoise:=true;
  RunNet;
end;

procedure TForm7.ComboBox2Change(Sender: TObject);
begin
  if Form7.ComboBox2.ItemIndex in [1,2] then Form7.ComboBox1.ItemIndex:=1;
end;


procedure TForm7.DDSpinEdit16DblClick(Sender: TObject);
begin
  Form7.DDSpinEdit16.Value:=0;
end;

end.
