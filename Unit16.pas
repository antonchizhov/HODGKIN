unit Unit16;  {Form16 - Show (u_s)-plane}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TeEngine, Series, BubbleCh, ExtCtrls, TeeProcs, Chart,
  MyTypes,Init,MathMyO;

type
  TForm16 = class(TForm)
    Chart1: TChart;
    Series1: TBubbleSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    Chart2: TChart;
    Series5: TLineSeries;
    Series6: TLineSeries;
    Series7: TLineSeries;
    Series8: TLineSeries;
    Series9: TLineSeries;
    Series10: TLineSeries;
    Series11: TFastLineSeries;
    Series12: TFastLineSeries;
    Series13: TLineSeries;
    procedure Chart1DblClick(Sender: TObject);
    procedure Draw_f_in_Chart(f :matr_200x200; ie,je :integer; dx,dy,x0,y0 :double);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form16: TForm16;
  If_fm_or_gm :integer;


implementation
uses Unit8,FiringClamp;

{$R *.DFM}

{*************************************************************************}
procedure TForm16.Draw_f_in_Chart(f :matr_200x200; ie,je :integer; dx,dy,x0,y0 :double);
var
     col,i,j                            :integer;
     x1,y1,fmax,fmin,R                  :double;
     tcol                               :TColor;
begin
  Form16.Series1.Clear;
  fmax:=-1e6;
  fmin:= 1e6;
  for j:=0 to je do  for i:=0 to ie do  if f[i,j]<>0 then begin
      fmax:=max(fmax,f[i,j]);
      fmin:=min(fmin,f[i,j]);
  end;
  FOR j:=0 to je DO BEGIN
      FOR i:=0 to ie DO BEGIN
           col:=trunc(15*(f[i,j]-fmin)/max(fmax-fmin,1e-6));
           col:=imin(col,15);  col:=imax(col,1);
           x1:=i*dx+x0;
           y1:=j*dy+y0;
           tcol:=SetMyColor(col);
           Form16.Series1.AddBubble(x1,y1,dy/2*max(ie,je)/ie,'',tcol);
      END;
  END;
  Application.ProcessMessages;
end;

procedure TForm16.Chart1DblClick(Sender: TObject);
begin
  if If_fm_or_gm<>2 then begin
     Draw_gm;
     If_fm_or_gm:=2;
  end else begin
     Draw_fm;
     If_fm_or_gm:=1;
  end;
end;

end.
