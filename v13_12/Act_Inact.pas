unit Act_Inact;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, {sgr_def, sgr_data,} StdCtrls;

procedure FormActivation;
procedure Act_InactCurves;
procedure m3_h_ActInact;
procedure tau_ActInact;
procedure NondimConds_ActInact;
procedure ClearAll_ActInact;

implementation
uses Unit2,Unit11,
     MyTypes,Init,t_dtO,Clamp,Hodgkin,HH_canal,MathMyO,Graph,Other,Threads;
type
    time_arr=array[-MaxExp..MaxExp] of double;
var
     IPicS,IPicE,gPicS,gPicE,Vi           :time_arr;
     N                                    :integer;

function FindExtremum(x :time_arr; nb,ne :integer) :double;
var i  :integer;
    fm :double;
begin
  fm:=0;
  for i:=nb+1 to ne-1 do
      if (abs(fm)<abs(x[i])) and
         (abs(x[i])>=abs(x[i-1])) and
         (abs(x[i])>=abs(x[i+1])) then fm:=x[i];
  FindExtremum:=fm;
end;

function FindMax(x :time_arr; nb,ne :integer) :double;
var i  :integer;
    fm :double;
begin
  fm:=0;
  for i:=nb to ne do
      if abs(fm)<abs(x[i]) then fm:=x[i];
  FindMax:=fm;
end;

procedure FormActivation;
begin
  if (NP0.If_I_V_or_g<>1) or (NSmpls<=0) then begin
     Form11.Visible:=true;
     Form11.Memo1.Lines.Add(
     '¬се возможности окна не будут доступны с заданными параметрами. '+
     'ѕример параметров задани€ параметров см. в файле "Na_V10&S12.id"'
                           );
  end;
  { *** Parameters *** }
//  ParFile:=MainDir+'\Na_V10&S12.id';
//  CommonParametersFrom_ParFile;
//  CorrespondParametersToTheForm;
end;

{=====================================================================}
procedure Act_InactCurves;
var  I_Sim,I_Exp,g_Sim,g_Exp              :time_arr;
     i,nt_end_local                       :integer;
     Dir_                                 :string;
BEGIN
  nt_end_local:=imin(nt_end,MaxExp);
  { *** Exp. Data directory for Activation *** }
  Dir_:=MainDir+'\Data\Pavlov';
  { *** Simulation ************************************ }
  N:=20;
  for i:=-N to N do begin
      { Conditioning and testing potentials }
      if i<=0 then begin
         { Activation, red }
         NP0.Vrest:=-0.100 {mV};
         Vh:=-0.050+abs(i)*0.005;
         Vi[i]:=Vh;
      end else begin
         { Inactivation, green }
         NP0.Vrest:=-0.115+abs(i)*0.005;
         Vh:=0;
         Vi[i]:=NP0.Vrest;
      end;
      { *** Exp. Data *** }
      Smpl:=1;
      if i=1 then  { switch to Inactivation }
      Dir_:=MainDir+'\Data\Pavlov\DataOf_SSA12';
      SmplFile[Smpl]:=Dir_+'a'+IntToStr(round(Vi[i]*1000))+'.d';
      ReadExpData;
      { Initialisation }
      InitialConditions;
      Form2.XYLine9.Clear;
      Form2.XYLine10.Clear;
      REPEAT  nt:=nt+1;  t:=nt*dt; { time step }
        MembranePotential;
        I_Sim[nt]:=NV0.PSC;                   g_Sim[nt]:=-I_Sim[nt]/(Vh-NP0.VNaR);
        I_Exp[nt]:=Vexp[nt,Smpl];         g_Exp[nt]:=-I_Exp[nt]/(Vh-NP0.VNaR);
        { Draw Evolution in time }
        if (nt=1)or(trunc(nt/n_Draw)=nt/n_Draw) then begin
            Form2.XYLine9 .AddXY(t*1e3,I_Sim[nt]);
            Form2.XYLine10.AddXY(t*1e3,I_Exp[nt]);
        end;
        RunThread.Synch;
      UNTIL (nt=nt_end_local)or(ThreadObject.IfStop=1);
                                IF ThreadObject.IfStop<>1 THEN BEGIN
      Form2.XYPlot3.Update;
      IPicS[i]:=FindMax{Extremum}(I_Sim, 2,nt_end_local);
      IPicE[i]:=FindMax{Extremum}(I_Exp, trunc(0.001/dt),nt);
      gPicS[i]:=FindMax{Extremum}(g_Sim, 2,nt_end_local);
      gPicE[i]:=FindMax{Extremum}(g_Exp, trunc(0.001/dt),nt);
      if abs(Vh-NP0.VNaR)<2e-3 then gPicE[i]:=0;
      { Writing and Drawing }
            { BAX }
      Form2.XYLine7.AddXY(Vi[i]*1e3,IPicE[i]);
      if i<=0 then Form2.XYLine11.AddXY(Vi[i]*1e3,IPicS[i])
              else Form2.XYLine8 .AddXY(Vi[i]*1e3,IPicS[i]);
            { Pic currents }
      if i<=0 then begin  {Activation}
         Form2.XYLine1.AddXY(Vi[i]*1e3,gPicS[i]);
         Form2.XYLine5.AddXY(Vi[i]*1e3,gPicE[i]);
         {Form2.Series1.AddXY(Vi[i]*1e3,gPicS[i]);
         Form2.Series3.AddXY(Vi[i]*1e3,gPicE[i]);}
         if IfWriteInFFF=1 then
         writeln(fff,Vi[i]*1e3:9:3,' ',gPicE[i]:9:3
                                  ,' ',gPicS[i]:9:3);
      end else begin      {Inactivation}
         Form2.XYLine2.AddXY(Vi[i]*1e3,IPicS[i]);
         Form2.XYLine6.AddXY(Vi[i]*1e3,IPicE[i]);
         {Form2.Series2.AddXY(Vi[i]*1e3,IPicS[i]);
         Form2.Series4.AddXY(Vi[i]*1e3,IPicE[i]);}
         if IfWriteInFFF=2 then
         writeln(fff,Vi[i]*1e3:9:3,' ',IPicE[i]:9:3
                                  ,' ',IPicS[i]:9:3);
      end;
      {Application.ProcessMessages;}
                                END;  {IfStop}
  end;
  ChDir(MainDir);
  DrawLegendTable(Form2.XYPlot1,'lb');
  DrawLegendTable(Form2.XYPlot2,'rt');
  DrawLegendTable(Form2.XYPlot3,'rt');
  if IfWriteInFFF=1 then
  MyWarning:='Columns for "Activation":   V  g_Exp  g_Mod';
  if IfWriteInFFF=2 then
  MyWarning:='Columns for "Inactivation": V  I_Exp  I_Mod';
END;

procedure NondimConds_ActInact;
var  i :integer;
     gMaxS,gMaxE,IMaxS,IMaxE :double;
begin
  Form2.XYPlot1.LeftAxis.Min:=0;
  Form2.XYPlot1.LeftAxis.Max:=1;
  Form2.XYPlot1.RightAxis.Min:=0;
  Form2.XYPlot1.RightAxis.Max:=1;
  { Plot nondimensional conductances }
  gMaxS:=FindMax(gPicS, -N,-1);
  gMaxE:=FindMax(gPicE, -15,-1);
  IMaxS:=FindMax(IPicS,  0,N);
  IMaxE:=FindMax(IPicE,  0,N);
  if (gMaxS=0)or(IMaxS=0)or(gMaxE=0)or(IMaxE=0) then Exit;
  Form2.XYLine1.Clear;
  Form2.XYLine2.Clear;
  Form2.XYLine5.Clear;
  Form2.XYLine6.Clear;
  {Form2.Series1.Clear;
  Form2.Series2.Clear;
  Form2.Series3.Clear;
  Form2.Series4.Clear;}
  for i:=-N to N do begin
      if i<=0 then begin       {Act.}
         Form2.XYLine1.AddXY(Vi[i]*1e3,gPicS[i]/gMaxS);
         Form2.XYLine5.AddXY(Vi[i]*1e3,gPicE[i]/gMaxS);
         {Form2.Series1.AddXY(Vi[i]*1e3,gPicS[i]/gMaxS);
         Form2.Series3.AddXY(Vi[i]*1e3,gPicE[i]/gMaxS);}
         if IfWriteInFFF=1 then
         writeln(fff,Vi[i]*1e3:9:3,' ',gPicE[i]/gMaxE:9:3
                                  ,' ',gPicS[i]/gMaxS:9:3);
      end else begin           {Inact.}
         Form2.XYLine2.AddXY(Vi[i]*1e3,IPicS[i]/IMaxS);
         Form2.XYLine6.AddXY(Vi[i]*1e3,IPicE[i]/IMaxS);
         {Form2.Series2.AddXY(Vi[i]*1e3,IPicS[i]/IMaxS);
         Form2.Series4.AddXY(Vi[i]*1e3,IPicE[i]/IMaxS);}
         if IfWriteInFFF=2 then
         writeln(fff,Vi[i]*1e3:9:3,' ',IPicE[i]/IMaxE:9:3
                                  ,' ',IPicS[i]/IMaxS:9:3);
      end;
  end;
  DrawLegendTable(Form2.XYPlot1,'lb');
  if IfWriteInFFF=1 then
  MyWarning:='For "Activation":   V  g/gMax_Exp  g/gMax_Mod';
  if IfWriteInFFF=2 then
  MyWarning:='For "Inactivation": V  I/IMax_Exp  I/IMax_Mod';
end;

procedure m3_h_ActInact;
var  i :integer;
     m0,h0,Vrest_mem :double;
begin
  Vrest_mem:=NP0.Vrest;
  Form2.XYPlot1.RightAxis.Min:=0;
  Form2.XYPlot1.RightAxis.Max:=1;
  { Plot 'm_inf^3' and 'h_inf' }
  for i:=0 to 160 do begin
      NP0.Vrest:=-0.110+i*0.001;
      InitialConditions;
      m0:=NV0.mmR;
      h0:=NV0.hhR;
      Form2.XYLine3.AddXY(NP0.Vrest*1e3,m0*m0*m0);
      Form2.XYLine4.AddXY(NP0.Vrest*1e3,h0);
      if IfWriteInFFF=1 then
      writeln(fff, NP0.Vrest*1e3:9:3,' ',m0*m0*m0:9:3,' ',h0:9:3);
  end;
  DrawLegendTable(Form2.XYPlot1,'lb');
  if IfWriteInFFF=1 then
  MyWarning:='Written columns are: V  m^3  h';
  NP0.Vrest:=Vrest_mem;
end;

procedure tau_ActInact;
var  i :integer;
     a,b,tau_m,tau_h,V,v2 :double;
begin
  { Plot 'tau_m' and 'tau_h' }
  for i:=0 to 80 do begin
      {tau_m}
      V:=-0.110+i*0.002;
      v2:= V*1000 - NP0.Tr;
      a:= NP0.a1NaR * alphabeta(NP0.a2NaR-v2, NP0.a3NaR,NP0.a4NaR);
      b:= NP0.b1NaR * alphabeta(NP0.b2NaR-v2, NP0.b3NaR,NP0.b4NaR);
      tau_m:= 1 / (a + b);
      Form2.XYLine12.AddXY(V*1e3,tau_m);
      Form2.XYLine14.AddXY(V*1e3,a);
      Form2.XYLine15.AddXY(V*1e3,b);
      if IfWriteInFFF=1 then
      write  (fff, V:9:3,' ',tau_m:9:3,' ',a:9:3,' ',b:9:3,' ');
      {tau_h}
      a:= NP0.c1NaR * alphabeta  (NP0.c2NaR-v2, NP0.c3NaR,NP0.c4NaR);
      b:= NP0.d1NaR * alphabeta_h(NP0.d2NaR-v2, NP0.d3NaR,NP0.d4NaR);
      tau_h:= 1 / (a + b);
      Form2.XYLine13.AddXY(V*1e3,tau_h);
      Form2.XYLine16.AddXY(V*1e3,a);
      Form2.XYLine17.AddXY(V*1e3,b);
      if IfWriteInFFF=1 then
      writeln(fff, tau_h:9:3,' ',a:9:3,' ',b:9:3,' ');
  end;
  DrawLegendTable(Form2.XYPlot4,'rt');
  DrawLegendTable(Form2.XYPlot5,'rt');
  if IfWriteInFFF=1 then
  MyWarning:='Written columns are: V  tau_m  alpha_m  beta_m  tau_h  alpha_h  beta_h';
end;

procedure ClearAll_ActInact;
begin
  {Form2.Series1.Clear;
  Form2.Series2.Clear;
  Form2.Series3.Clear;
  Form2.Series4.Clear;}
  Form2.XYLine1 .Clear;
  Form2.XYLine2 .Clear;
  Form2.XYLine3 .Clear;
  Form2.XYLine4 .Clear;
  Form2.XYLine5 .Clear;
  Form2.XYLine6 .Clear;
  Form2.XYLine7 .Clear;
  Form2.XYLine8 .Clear;
  Form2.XYLine9 .Clear;
  Form2.XYLine10.Clear;
  Form2.XYLine11.Clear;
  Form2.XYLine12.Clear;
  Form2.XYLine13.Clear;
  Form2.XYLine14.Clear;
  Form2.XYLine15.Clear;
  Form2.XYLine16.Clear;
  Form2.XYLine17.Clear;
end;

end.
