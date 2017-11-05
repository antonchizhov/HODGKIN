unit RampMain;

interface
uses   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
       StdCtrls, DDSpinEdit,
       Unit31,{RampInit,}MyTypes,MathMyO;

type
    TRamp =class 
      Vexp,Iexp,Ifilt,Vfilt                       :vecExp;
      texp                                        :vectExp;
      IT,VT,tT,SpikeAmplT                         :vecRampSmpl;
      nt,nt_end,
      Smpl,NSmpl,Nexp,IfExpIsRead,IfInSyn_al_EQ_beta
                                                  :integer;
      RootDir,FName                               :string;
      tEndStep,tStartRamp,SpikeShapeAmpl,
      SpikeShapeHalfDuration,SpikeDuration,
      t_maxLimit
                                                  :double;
      aaa,bbb,vvv,vv2,vv3,vv4,vv5,
      ddd,ccc,fff,nnn,zzz,ttt                     :text;

procedure PrintTime(t :double);
procedure ReadExpData(Smpl :integer);
procedure Draw2Arrays(Smpl :integer);
procedure ReadAndDraw;
function LimRev(x,limit :double):double;
procedure OpenOutFiles;
procedure WriteSpikeMarkers(i0 :integer);
function f_Spike(t :double) :double;
function Convolution(i0 :integer) :double;
procedure DrawSpikeShape(i0 :integer);
function SpikeAmplitude(i0 :integer) :double;
procedure FilterCurrent;
procedure FindThreshold;
procedure TreatAllSamples;

    constructor Create;

    end;


var Ramp :TRamp;


implementation

constructor TRamp.Create;
begin      inherited Create;    end;

procedure TRamp.PrintTime(t :double);
var t1 :string;
begin
   str(t:9:3,t1);
   t1:='t='+t1;
   Form31.Canvas.TextOut(20,2,t1);
end;

procedure TRamp.ReadExpData(Smpl :integer);
var
    i,j,icol            :integer;
    t_,V_,I_,dV_        :double;
begin
  if FileExists(FName)=false then EXIT;
  assign(aaa,FName); reset(aaa);
  t_maxLimit:=Form31.DDSpinEdit8.Value/1000; {s}
  dV_:=Form31.DDSpinEdit11.Value{mV};
  i:=-1; j:=-1; icol:=1;
  while not (eof(aaa)or(j>MaxExp)or(icol>MaxSmpls)) do begin
    i:=i+1;
    readln(aaa,t_,V_,I_);
    if t_<=t_maxLimit then begin   //Use the data
       j:=j+1;
       texp[j]:=t_*1e3;
       Vexp[j,icol]:=V_-dV_;
       Iexp[j,icol]:=I_;
       Nexp:=j;
    end else begin          //Do not use the data
       if (j<>-1)and(not(eof(aaa))) then begin  //Next trial
          icol:=icol+1;
          j:=-1;
       end;
    end;
  end;
  NSmpl:=icol-1;
  close(aaa);
  IfExpIsRead:=1;
  Form31.Label7.Caption:=FName;
end;

procedure TRamp.Draw2Arrays(Smpl :integer);
var i :integer;
begin
  Form31.Series1.Clear;
  Form31.Series2.Clear;
  for i:=0 to Nexp do begin
      Form31.Series1.AddXY(texp[i],Vexp[i,Smpl]);
      Form31.Series2.AddXY(texp[i],Iexp[i,Smpl]);
  end;
  Application.ProcessMessages;
end;

procedure TRamp.ReadAndDraw;
begin
  Smpl:=trunc(Form31.DDSpinEdit2.Value);
  ReadExpData(Smpl);
  Draw2Arrays(Smpl);
end;

function TRamp.LimRev(x,limit :double):double;
begin
  if x<limit then LimRev:=0
             else LimRev:=1/x;
end;

procedure TRamp.OpenOutFiles;
begin
//  RootDir:='E:\Anton\Experiments\Data\2005.09.14\';
//  RootDir:='E:\Anton\Experiments\Data\2005.10.13\';
  RootDir:=Form31.ComboBox1.Items[Form31.ComboBox1.ItemIndex];
  assign(vvv,RootDir+'out_nu_g_I.dat'); rewrite(vvv);  close(vvv);
  assign(vv2,RootDir+'out_Va_g_I.dat'); rewrite(vv2);  close(vv2);
  assign(vv3,RootDir+'out_AP_g_I.dat'); rewrite(vv3);  close(vv3);
  assign(vv4,RootDir+'out_Vm_g_I.dat'); rewrite(vv4);  close(vv4);
  assign(vv5,RootDir+'out_g_I_nu_VT.dat'); rewrite(vv5);  close(vv5);
end;

procedure TRamp.WriteSpikeMarkers(i0 :integer);
var t1 :string;
    f :double;
    i :integer;
begin
  str(Smpl:3,t1);
  RootDir:=Form31.ComboBox1.Items[Form31.ComboBox1.ItemIndex];
  { Spike shape }
  assign(aaa,RootDir+'SpikeShape'+t1+'.dat'); rewrite(aaa);
  i:=i0;
  repeat
    f:=f_Spike(texp[i]-texp[i0]);
    writeln(aaa,texp[i]:9:3,' ',f+Ifilt[i0,Smpl]:10:0,' ');
    i:=i+1;
  until (i>Nexp)or(texp[i]-texp[i0]>SpikeDuration);
  close(aaa);
  { Voltage and Current curves }
  assign(aaa,RootDir+'VandI'+t1+'.dat'); rewrite(aaa);
  for i:=1 to Nexp do begin
      write  (aaa,texp[i]:9:3,' ', Vexp[i,Smpl]:12:2,' ', Iexp[i,Smpl]:12:2,' ');
      writeln(aaa,                Vfilt[i,Smpl]:12:2,' ',Ifilt[i,Smpl]:12:2,' ');
  end;
  close(aaa);
  { Spike marker }
  assign(aaa,RootDir+'SpikeMarker'+t1+'.dat'); rewrite(aaa);
  write  (aaa,texp[i0]:9:3,' ', Vexp[i0,Smpl]:12:2,' ', Iexp[i0,Smpl]:12:2,' ');
  writeln(aaa,                 Vfilt[i0,Smpl]:12:2,' ',Ifilt[i0,Smpl]:12:2,' ');
  close(aaa);
end;

procedure TRamp.FilterCurrent;
var i,icol  :integer;
    tauFilt :double;
begin
  tauFilt:=Form31.DDSpinEdit3.Value;
  for icol:=1 to NSmpl do begin
      Ifilt[0,icol]:=Iexp[0,icol];
      Vfilt[0,icol]:=Vexp[0,icol];
      for i:=0 to Nexp-1 do begin
          if tauFilt>0 then begin
             Ifilt[i+1,icol]:=Ifilt[i,icol]
                      +(texp[i+1]-texp[i])/tauFilt*(Iexp[i,icol]-Ifilt[i,icol]);
             Vfilt[i+1,icol]:=Vfilt[i,icol]
                      +(texp[i+1]-texp[i])/tauFilt*(Vexp[i,icol]-Vfilt[i,icol]);
          end else begin
             Ifilt[i+1,icol]:=Iexp[i+1,icol];
             Vfilt[i+1,icol]:=Vexp[i+1,icol];
          end;
      end;
  end;
  Form31.Series3.Clear;
  Form31.Series7.Clear;
  for i:=0 to Nexp do begin
      Form31.Series3.AddXY(texp[i],Vfilt[i,Smpl]);
      Form31.Series7.AddXY(texp[i],Ifilt[i,Smpl]);
  end;
  Application.ProcessMessages;
end;

function TRamp.f_Spike(t :double) :double;
var dt_Top :double;
begin
  dt_Top:=SpikeShapeHalfDuration/3;   // Flat top duration
  SpikeDuration:=0.5{ms}+dt_Top+SpikeShapeHalfDuration*2;
  if t<=0.5{ms} then
     f_Spike:=0
  else if t<=0.5{ms}+SpikeShapeHalfDuration then
     f_Spike:=-SpikeShapeAmpl/SpikeShapeHalfDuration*(t-0.5)
  else if t<=0.5{ms}+SpikeShapeHalfDuration+dt_Top then
     f_Spike:=-SpikeShapeAmpl
  else if t<=SpikeDuration then
     f_Spike:= SpikeShapeAmpl/(1.5*SpikeShapeHalfDuration)
                *(t-0.5{ms}-SpikeShapeHalfDuration-dt_Top)-SpikeShapeAmpl
  else f_Spike:=0;
end;

function TRamp.Convolution(i0 :integer) :double;
var i   :integer;
    S,f :double;
begin
  i:=i0;
  S:=0;
  repeat
    f:=f_Spike(texp[i]-texp[i0]);
    S:=S+sqr(Ifilt[i,Smpl]-Ifilt[i0,Smpl]-f);
    i:=i+1;
  until (i>Nexp)or(texp[i]-texp[i0]>SpikeDuration);
  Convolution:=sqrt(S/(i-i0));
end;

procedure TRamp.DrawSpikeShape(i0 :integer);
var i   :integer;
    S,f :double;
begin
  Form31.Series8.Clear;
  i:=i0;
  repeat
    f:=f_Spike(texp[i]-texp[i0]);
    Form31.Series8.AddXY(texp[i],Ifilt[i0,Smpl]+f);
    i:=i+1;
  until (i>Nexp)or(texp[i]-texp[i0]>SpikeDuration);
end;

function TRamp.SpikeAmplitude(i0 :integer) :double;
var i   :integer;
    mmm :double;
begin
  f_Spike(0); // false call to define SpikeDuration
  mmm:=1e6;
  i:=i0;
  repeat
    if mmm>Ifilt[i,Smpl] then mmm:=Ifilt[i,Smpl];
    i:=i+1;
  until (i>Nexp)or(texp[i]-texp[i0]>SpikeDuration);
  SpikeAmplitude:=Ifilt[i0,Smpl]-mmm;
end;

procedure TRamp.FindThreshold;
{ It finds the spike shape in the response-to-ramp and defines the threshold }
var
    i,icol                                                      :integer;
    dt,dV,dVdt,ddV,ddI,ddI_thr,dIdt_thr,dIdt,
    Conv_thr,Conv,MinSpikeAmpl,tStartStep_
                                                                :double;
begin
  { Find "tEndStep" and "tStartRamp" }
  tEndStep:=0; tStartRamp:=0;  tStartStep_:=0;
  for i:=5 to Nexp-5 do begin
      dV:=Vexp[i,Smpl]-Vexp[i-1,Smpl];
      dVdt:=(Vfilt[i+1,Smpl]-Vfilt[i,Smpl])/(texp[i+1]-texp[i]);
      if (dV> 20{mV})and(tStartStep_=0) then begin
          tStartStep_:=texp[i];
      end;
      if (tStartStep_>0)and(texp[i]-tStartStep_>10{ms})and
         (dV<-20{mV})and(tEndStep=0) then begin
          tEndStep:=texp[i];
      end;
      if (dVdt>0.6{mV/ms})and(tStartRamp<tEndStep) then begin
          tStartRamp :=texp[i-1];
      end;
  end;
  Form31.Series4.Clear;
  Form31.Series5.Clear;
  Form31.Series6.Clear;
  Form31.Series6.AddXY(tEndStep,  Vexp[0,Smpl]);
  Form31.Series6.AddXY(tStartRamp,Vexp[0,Smpl]);
  { Find spike by the spike shape "f_Spike" and define "VT" and "tT" }
  ddI_thr :=Form31.DDSpinEdit10.Value; {pA/ms^2}
  dIdt_thr:=Form31.DDSpinEdit9.Value;  {pA/ms}
  Conv_thr:=Form31.DDSpinEdit4.Value;  {pA}
  SpikeShapeAmpl:=Form31.DDSpinEdit5.Value; {pA}
  SpikeShapeHalfDuration:=Form31.DDSpinEdit6.Value; {ms}
  MinSpikeAmpl:=Form31.DDSpinEdit7.Value; {pA}
  tT[Smpl]:=0;
  for i:=0 to Nexp-2 do begin
      if texp[i]>tStartRamp then begin
         dt:=texp[i+1]-texp[i];
         dIdt:=(Ifilt[i+2,Smpl]-Ifilt[i,Smpl])/2/dt;
         ddI :=(Ifilt[i+2,Smpl]-2*Ifilt[i+1,Smpl]+Ifilt[i,Smpl])/dt/dt;
//         if ((ddI<-ddI_thr)and(dIdt<-dIdt_thr))and(tT[Smpl]=0) then begin
         if Form31.ComboBox2.ItemIndex=1 then begin // unscale spike shape
            SpikeShapeAmpl:=abs(SpikeAmplitude(i));
         end;
         Conv:=Convolution(i);
         if ((Form31.ComboBox2.ItemIndex=0)and(Conv<Conv_thr)and(tT[Smpl]=0)) or
            ((Form31.ComboBox2.ItemIndex=1)and(SpikeShapeAmpl>MinSpikeAmpl)and
                           (Conv/SpikeShapeAmpl<0.2*Conv_thr/MinSpikeAmpl)and
                                             (tT[Smpl]=0)) then begin
             IT[Smpl]:=Ifilt[i,Smpl];
             VT[Smpl]:=Vfilt[i,Smpl];
             tT[Smpl]:=texp[i];
             Form31.Series4.AddXY(texp[i],IT[Smpl]);
             Form31.Series5.AddXY(texp[i],VT[Smpl]);
             DrawSpikeShape(i);
             SpikeAmplT[Smpl]:=SpikeAmplitude(i);
             if Form31.CheckBox1.Checked then WriteSpikeMarkers(i);
         end;
      end;
  end;
end;

procedure TRamp.TreatAllSamples;
var icol :integer;
begin
  assign(vvv,RootDir+'VT_tau.dat'); rewrite(vvv);
  Form31.Series10.Clear;
  Form31.Series11.Clear;
  for icol:=1 to NSmpl do begin
      Smpl:=icol;
      FilterCurrent;
      FindThreshold;
      Application.ProcessMessages;
      Form31.Series10.AddXY(tT[Smpl]-tEndStep,VT[Smpl]);
      Application.ProcessMessages;
//      Form31.Series11.AddXY(tT[Smpl]-tEndStep,SpikeAmplT[Smpl]);
      Application.ProcessMessages;
      write  (vvv,tT[Smpl]-tEndStep:9:3,' ',VT[Smpl]:9:3,' ');
      writeln(vvv,SpikeAmplT[Smpl]:13:3,' ',IT[Smpl]:13:3);
  end;
  close(vvv);
end;

end.
