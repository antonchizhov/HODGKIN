unit Thread_FC;

interface

uses
  Classes,FiringClamp,Noise;

type
  TFCinThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    procedure Synchronize;
  end;

  TSetOfFCinThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    procedure Synchronize;
  end;

var
  AnalyzeByFiringClamp_In_Thread :TFCinThread;
  AnalyzeSetsByFiringClamp_In_Thread :TSetOfFCinThread;
  IfActive1,IfActive2 : boolean;

implementation

{ Important: Methods and properties of objects in VCL can only be used in a
  method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TFCinThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }

{ TFCinThread }

procedure TFCinThread.Execute;
begin
  { Place thread code here }
  IfActive1:=true;
  AnalyzeByFiringClamp(n_FC,F_FC,G_FC,H_FC,U_FC,S_FC,T_FC,Ua_FC,Sa_FC,
                                                    Tg_FC,gE_FC,gI_FC);
  IfActive1:=false;
end;

procedure TSetOfFCinThread.Execute;
begin
  { Place thread code here }
  IfActive2:=true;
  StatisticsOfConductanceEstimations;
  IfActive2:=false;
end;

procedure TFCinThread.Synchronize;
var dum :double;
begin
  dum:=dum;
end;

procedure TSetOfFCinThread.Synchronize;
var dum :double;
begin
  dum:=dum;
end;

end.
