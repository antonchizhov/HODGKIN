unit Unit20;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DDSpinEdit;

type
  TForm20 = class(TForm)
    GroupBox1: TGroupBox;
    DDSpinEdit1: TDDSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    DDSpinEdit2: TDDSpinEdit;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    DDSpinEdit3: TDDSpinEdit;
    Label3: TLabel;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    DDSpinEdit4: TDDSpinEdit;
    DDSpinEdit5: TDDSpinEdit;
    Label5: TLabel;
    DDSpinEdit6: TDDSpinEdit;
    Label6: TLabel;
    ComboBox2: TComboBox;
    Label7: TLabel;
    DDSpinEdit7: TDDSpinEdit;
    CheckBox2: TCheckBox;
    GroupBox4: TGroupBox;
    DDSpinEdit8: TDDSpinEdit;
    Label8: TLabel;
    Label9: TLabel;
    DDSpinEdit9: TDDSpinEdit;
    DDSpinEdit10: TDDSpinEdit;
    Label10: TLabel;
    DDSpinEdit11: TDDSpinEdit;
    DDSpinEdit12: TDDSpinEdit;
    Label11: TLabel;
    Label12: TLabel;
    CheckBox5: TCheckBox;
    GroupBox7: TGroupBox;
    Label19: TLabel;
    DDSpinEdit19: TDDSpinEdit;
    GroupBox8: TGroupBox;
    DDSpinEdit18: TDDSpinEdit;
    Label18: TLabel;
    ComboBox1: TComboBox;
    DDSpinEdit17: TDDSpinEdit;
    Label13: TLabel;
    DDSpinEdit13: TDDSpinEdit;
    Label14: TLabel;
    procedure DDSpinEdit3DblClick(Sender: TObject);
    procedure DDSpinEdit7DblClick(Sender: TObject);
    procedure DDSpinEdit19Change(Sender: TObject);
    procedure DDSpinEdit17Change(Sender: TObject);
    procedure DDSpinEdit18Change(Sender: TObject);
    procedure DDSpinEdit18DblClick(Sender: TObject);
    procedure DDSpinEdit13DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form20: TForm20;

implementation
uses typeNrnParsO,FiberO,RunFiber;

{$R *.dfm}

procedure TForm20.DDSpinEdit3DblClick(Sender: TObject);
begin
  Form20.DDSpinEdit3.Value:=1;
end;

procedure TForm20.DDSpinEdit7DblClick(Sender: TObject);
begin
 Form20.DDSpinEdit7.Value:=1;
end;

procedure TForm20.DDSpinEdit19Change(Sender: TObject);
begin
  if Form20.DDSpinEdit19.Value<1 then Form20.DDSpinEdit19.Value:=1;
  Space.N:=trunc(Form20.DDSpinEdit19.Value);
end;

procedure TForm20.DDSpinEdit17Change(Sender: TObject);
begin
  Space.Gs_R:=Form20.DDSpinEdit17.Value;
end;

procedure TForm20.DDSpinEdit18Change(Sender: TObject);
begin
  if Form20.DDSpinEdit18.Value<0 then Form20.DDSpinEdit18.Value:=1;
end;

procedure TForm20.DDSpinEdit18DblClick(Sender: TObject);
begin
  Form20.DDSpinEdit18.Value:=0;
end;

procedure TForm20.DDSpinEdit13DblClick(Sender: TObject);
begin
  if Form20.DDSpinEdit13.Value=0 then Form20.DDSpinEdit13.Value:=1
                                 else Form20.DDSpinEdit13.Value:=0;
end;

end.
