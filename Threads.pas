unit Threads;

interface

uses
  Classes, Act_Inact;

type
  TProc = procedure;

  TRunThread = class(TThread)
  private
    procedure Dummy;
  protected
    procedure Execute; override;
  public
    procedure Start;
    procedure Synch;
  end;

  OThreadObject = object
  public
//    RunThread :TRunThread;
    ThreadActive :boolean;
    IfStop       :integer;
    ForExecute :procedure;
  end;

var
  ThreadObject :OThreadObject;
  RunThread :TRunThread;
//  ThreadActive :boolean;
//  IfStop       :integer;

implementation

procedure TRunThread.Start;
begin
  if (RunThread=nil) or (ThreadObject.ThreadActive=False) then begin
     RunThread:=TRunThread.Create(False);
     ThreadObject.ThreadActive:=True;
  end;
end;

procedure TRunThread.Dummy;
begin end;

procedure TRunThread.Synch;
begin
  Synchronize(Dummy);
end;

procedure TRunThread.Execute;
begin
  ThreadObject.ForExecute;
  ThreadObject.ThreadActive:=False;
  ThreadObject.IfStop:=0;
end;

end.
