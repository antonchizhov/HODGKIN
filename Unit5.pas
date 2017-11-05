unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, DDSpinEdit,
  Init,Threshold,Fiber_f_I_curve,
  Chart, TeEngine, Series, ExtCtrls,
  TeeProcs;

type
  TForm5 = class(TForm)
    DDSpinEdit4: TDDSpinEdit;
    StaticText4: TStaticText;
    StaticText1: TStaticText;
    DDSpinEdit1: TDDSpinEdit;
    Button1: TButton;
    Button2: TButton;
    StaticText3: TStaticText;
    DDSpinEdit3: TDDSpinEdit;
    StaticText2: TStaticText;
    CheckBox1: TCheckBox;
    Chart1: TChart;
    Series1: TLineSeries;
    DDSpinEdit6: TDDSpinEdit;
    StaticText6: TStaticText;
    ComboBox1: TComboBox;
    Button22: TButton;
    CheckBox2: TCheckBox;
    procedure DDSpinEdit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DDSpinEdit4Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DDSpinEdit3Change(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;
  dIind,Iind_max  :double;

implementation
uses Unit7;

{$R *.DFM}

procedure TForm5.FormShow(Sender: TObject);
begin
  Iind_max:=400;
  dIind:=4;
  Form5.DDSpinEdit1.Value:=Iind_max;
  Form5.DDSpinEdit4.Value:=dIind;
  Form5.DDSpinEdit3.Value:=t_end*1e3;
  Form5.Chart1.BottomAxis.Maximum:=Iind_max;
end;

{ SpinEdits }

procedure TForm5.DDSpinEdit1Change(Sender: TObject);
begin
  Iind_max  :=Form5.DDSpinEdit1.Value;
  if Iind_max>Form5.Chart1.BottomAxis.Minimum then
     Form5.Chart1.BottomAxis.Maximum:=Iind_max;
end;

procedure TForm5.DDSpinEdit4Change(Sender: TObject);
begin
  dIind  :=Form5.DDSpinEdit4.Value;
end;

procedure TForm5.DDSpinEdit3Change(Sender: TObject);
begin
  t_end  :=Form5.DDSpinEdit3.Value/1e3;
end;

{ Buttons }

procedure TForm5.Button1Click(Sender: TObject);
begin
  Form5.Button1.Enabled:=false;
  if Form5.CheckBox2.Checked=false then begin
     Plot_nu_IindO;
  end else begin // IfDistributedModel
     Plot_nu_IindO_Fiber;
  end;
  beep;
  Form5.Button1.Enabled:=true;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin
  Form5.Series1.Clear;
end;

procedure TForm5.CheckBox1Click(Sender: TObject);
begin
  Form7.Visible :=Form5.CheckBox1.Checked;
  IfNoise       :=Form5.CheckBox1.Checked;
end;

procedure TForm5.Button22Click(Sender: TObject);
begin
  Form5.Chart1.CopyToClipboardBitmap;
end;

end.
