unit Other;

interface
{**************** INPUTING/OUTPUTING **********************************}
procedure InitiateWriting;
procedure Writing;
procedure CloseFFF;
{**************** EXPERIMENTAL RECORDS ********************************}
procedure ReadExpData;
procedure DontReadExpData;
procedure FitGraphScalesToExpData(var minSc,maxSc :double);
{**********************************************************************}

implementation
uses MyTypes,Init,t_dtO,MathMyO,Clamp,Unit1;

{
}

{**************** INPUTING/OUTPUTING **********************************}
procedure InitiateWriting;
var tt      :string;
begin
  tt:=SmplFile[Smpl]+'at';
  assign(ccc,tt);
  rewrite(ccc);
end;

procedure Writing;
var V0ex,Vex,Vmod_ :double;
begin
  if nt<=MaxExp then  Vex:= Vexp[nt,Smpl]  else Vex:=0;
  if NP0.If_I_V_or_g in [1,3,4,5,6] then begin
                        Vmod_:=Vr;
                   end else
  if NP0.If_I_V_or_g in [2,7] then begin
                        Vex  :=(Vex+NP0.Vrest)*1000;
                        Vmod_:=(Vr +NP0.Vrest)*1000;
                   end;
  {           1-A            2-B        3-C          4-D    }
  writeln(ccc,t*1000:10:5,' ',Vex:11,' ',Vmod_:12,' ',NV0.Vold*1e3:12);
end;

procedure CloseFFF;
begin
  case IfWriteInFFF of
  1: MyWarning:='Written columns are: 1-t(ms)  2-V(mV)';
  2: MyWarning:='Written columns are: 1-t(ms)  2-Exp.Curve(Volts or pA) 3-Mod.Curve(Volts or pA)';
  3: MyWarning:='Written columns are: 1-t(ms)  2-mmR  3-hhR';
  4: MyWarning:='Written columns are: 1-t(ms)  2-'
               +Form1.RadioGroup1.Items[Form1.RadioGroup1.ItemIndex];
  end;
  if IfWriteInFFF<>0 then CloseFile(fff);
end;

{**************** EXPERIMENTAL RECORDS ********************************}
procedure  ReadExpData;
{
  Reading of experimental data as arrays: tE[0..200] -- time moments;
  E[0..200] -- values.
  Interpolation (linear) is applied to fill the array 'Vexp'.
}
var
     n,nt,nE            :integer;
     t,w                :double;
     E,tE               :array[1..MaxExp] of double;
     s                  :string;
begin
  { Reading file }
  GetDir(0,s);
  assign(aaa,SmplFile[Smpl]);  reset(aaa);
  n:=0;
  repeat  n:=n+1;
    if IfDataIn1column=1 then begin
       readln(aaa,E[n]);
       tE[n]:=0.05{ms}*n;
    end else
    readln(aaa,tE[n],E[n]);
  until (eof(aaa)) or (n=MaxExp);
  nE:=n;
  close(aaa);
  { Filling array 'Vexp' }
  nt:=-1;
  repeat  nt:=nt+1;
    t:=nt*dt/scx_Smpl+shift_Smp;
    { Finding of the nearest right point in array 'E' }
    n:=1;
    repeat n:=n+1
    until (n=nE) or (tE[n]>t);
    { Linear interpolation }
    if tE[n]-tE[n-1]>1e-8 then  w:=(t-tE[n-1])/(tE[n]-tE[n-1]) else w:=0;
    Vexp[nt,Smpl]:=(E[n-1]*(1-w) + E[n]*w)*scy_Smpl{ - Vrest[1]};
  until (nt=MaxExp) or (nt=nt_end);
end;

procedure  DontReadExpData;
var  nt :integer;
begin
  for nt:=0 to imin(MaxExp,nt_end) do  Vexp[nt,Smpl]:=0;
end;

procedure FitGraphScalesToExpData(var minSc,maxSc :double);
var  Smpl_o,nt :integer;
begin
  if NSmpls>0 then begin
     Smpl_o:=Smpl;
     Smpl:=0;
     repeat Smpl:=Smpl+1;
      { Parameters special for Smpl }
      Read_Params_from_File_or_Procedure;
      { Exp. data }
      if (Smpl=0)or(SmplFile[Smpl]='NoFile')or(SmplFile[Smpl]='')
          then DontReadExpData
          else begin
               ReadExpData;
               nt:=-1;
               repeat  nt:=nt+1;
                 minSc:=min(minSc, Vexp[nt,Smpl]);
                 maxSc:=max(maxSc, Vexp[nt,Smpl]);
               until (nt=MaxExp) or (nt=nt_end);
          end;
     until Smpl=NSmpls;
     Smpl:=Smpl_o;
     Read_Params_from_File_or_Procedure;
     if (Smpl=0)or(SmplFile[Smpl]='NoFile')or(SmplFile[Smpl]='')
         then DontReadExpData
         else     ReadExpData;
  end;
end;
{**********************************************************************}

end.
