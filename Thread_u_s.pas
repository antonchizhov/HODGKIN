unit Thread_u_s;

interface

uses
  Classes,Threshold;

type
  TPlot2D = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public  
    procedure Synchronize; 
  end;

var
  Plot_for_u_s_In_Thread :TPlot2D;

implementation

{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure Plot2D.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ Plot2D }

procedure TPlot2D.Execute;
begin
  { Place thread code here }
  PlotForControlParametersO;
end;

procedure TPlot2D.Synchronize;
var dum :double;
begin
  dum:=dum;
end;


end.
 