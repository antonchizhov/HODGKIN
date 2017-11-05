unit Unit10;  {Form10 - Plot of "SaveAnyCurve" }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {sgr_def, sgr_data,}
  Unit1, ExtCtrls, TeeProcs, TeEngine, Chart, Series;

type
  TForm10 = class(TForm)
    Chart1: TChart;
    Series1: TFastLineSeries;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

procedure DrawAskedCurve(t_in_ms,Value :double);

implementation

{$R *.DFM}

procedure DrawAskedCurve(t_in_ms,Value :double);
begin
  if not(Form10.Visible) then begin
     Form10.Visible:=true;
     Form10.Series1.Clear;
     Form10.Chart1.BottomAxis.AutomaticMaximum:=true;
  end;
  Form10.Series1.AddXY(t_in_ms,Value);
{  if trunc(trunc(t_in_ms)/0.001)=trunc(t_in_ms/0.001) then begin
     Application.ProcessMessages;
  end;}
end;

procedure TForm10.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form10.Visible:=false;
end;

end.
