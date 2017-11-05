unit Graph;

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  sgr_def, sgr_data, StdCtrls, Threads;

procedure DrawLegendTable(XYPlot: Tsp_XYPlot; where :string);
procedure Warning(t1 :string);
procedure PrintTime;
procedure PrintCoefficients;
procedure PrintFunctional;
procedure ClearAllPlots;
procedure InitialPicture;
procedure Evolution;
procedure DrawSpike;
procedure Plot_Th_tAP;
procedure Clear_Th_V;

type
  TDrawT = class(TThread)
  private
    procedure Dummy;
  protected
    procedure Execute; override;
  public
    procedure Start;
    procedure Synch;
    procedure Wait;
    {--------------}
{    procedure DrawLegendTable(XYPlot: Tsp_XYPlot; where :string);
    procedure Warning(t1 :string);
    procedure PrintTime;
    procedure PrintCoefficients;
    procedure PrintFunctional;
    procedure ClearAllPlots;
    procedure InitialPicture;
    procedure Evolution;
    procedure Plot2D;}
  end;

var
  DrawT :TDrawT;
  moveLeg :integer;

implementation
uses MyTypes,Init,t_dtO,MathMyO,Unit1,Unit3,Unit17,
     HH_Canal,Other,Threshold,CreateNrnO;

{--------------------------------------------------------------}
procedure TDrawT.Start;
begin
  if (DrawT=nil) or (ThreadObject.ThreadActive=False) then begin
     DrawT:=TDrawT.Create(False);
     ThreadObject.ThreadActive:=True;
  end;
end;

procedure TDrawT.Dummy;
begin end;

procedure TDrawT.Synch;
begin
  Synchronize(Dummy);
end;

procedure TDrawT.Wait;
begin
  WaitFor;
end;

procedure TDrawT.Execute;
begin
  ThreadObject.ForExecute;
  ThreadObject.ThreadActive:=False;
  ThreadObject.IfStop:=0;
end;
{---------------------------------------------------------------------}
procedure {TDrawT.}DrawLegendTable(XYPlot: Tsp_XYPlot; where :string);
{ This procedure draws legend on plot 'XYPlot'
  in the corner 'where' ('rt'- Right Top or 'lt','rb','lb'). }
var R:TRect; i, sc, lsh,lwh:integer;
    t   :string;
const ds=6;
begin
  //null step: move legend if necessary
  case moveLeg of
  4: where:='rt';
  1: where:='lt';
  2: where:='lb';
  3: where:='rb';
  end;
  //first calculate legend table rectangle size
  lwh:=0; sc:=0;
  with XYPlot.DCanvas do //in reality you can draw on another canvas
  begin
    Font:=XYPlot.Font;   //set axis font as legend font
    //find biggest width of legend text & calc number of legend
    for i:=0 to XYPlot.SeriesCount-1 do with XYPlot.Series[i] do
    begin
      if Active then begin
       lsh:=TextWidth(Legend);
       if lsh>lwh then lwh:=lsh;
       inc(sc);
      end;
    end;
    if sc<1 then Exit; //no one active series
    lsh:=TextHeight('|')+1;      //one legend string height
    inc(lwh, lsh+lsh div 2 +1  + 2 + 3 +2); //legend string height+gap+2border
    with XYPlot do with FieldRect do begin  //place rect in field
           if where='rt' then
         R:=Rect(Right-ds-lwh, Top+ds,           Right-ds,    Top+ds+lsh*sc)
      else if where='lt' then
         R:=Rect(Left+ds,      Top+ds,           Left+ds+lwh, Top+ds+lsh*sc)
      else if where='rb' then
         R:=Rect(Right-ds-lwh, Bottom-ds-lsh*sc, Right-ds,    Bottom-ds)
      else if where='lb' then
         R:=Rect(Left+ds,      Bottom-ds-lsh*sc, Left+ds+lwh, Bottom-ds);
      if (R.Left<Left-2) or (R.Bottom>Bottom-2) then Exit; //field size too small
    end;
    lwh:=lsh+lsh div 2 +1;    //legend picture width
    //draw legend table background rect & calc picture rect
    Brush.Color:=clWhite;
    Brush.Style:=bsSolid;
    with Pen do begin Color:=clBlack; Width:=1 end;
    with R do begin
      Rectangle(Left,Top,Right,Bottom);
      inc(Left,1); inc(Top,1); Right:=Left+lwh; Bottom:=Top+lsh-2;
    end;
    //draw legends
    for i:=0 to XYPlot.SeriesCount-1 do with XYPlot.Series[i] do
    begin
      if Active then begin
        DrawLegendMarker(XYPlot.DCanvas,R);
        if Brush.Style<>bsClear then Brush.Style:=bsClear;
        t:='Legend'+Legend;
        TextOut(R.Right+2,R.Top,Legend);
        OffsetRect(R,0,lsh);
      end;
    end;
  end;
end;

procedure {TDrawT.}Warning(t1 :string);
begin
  Form1.SimplexMemo.Font.Color := clRed;
  Form1.SimplexMemo.Lines.Add(t1);
end;

procedure PrintTime;
var t1 :string;
begin
   str(t*1000:7:2,t1);
   t1:='t='+t1+' ms';
   Form1.Label6.Caption:=t1;
   Form1.FileLabel.Caption:='"'+SmplFile[Smpl]+'"';
end;

procedure {TDrawT.}PrintCoefficients;
var t1,t2,t3 :string;
    i        :integer;
    dum      :longint;
begin
   Form1.CoeMemo.Font.Color := clPurple;
   t1:='';  t3:='     ';
   for i:=1 to round(min(8,ndim)) do begin
       if abs(g_dg[i])>1e-3 then
          str(g_dg[i]:13:4,t2)
       else
          str(g_dg[i]:12,t2);
       t1:=t1+t2+',';
       t3:=t3+'  '+strC[ig_iC[i]];
   end;
   Form1.CoeMemo.Clear;
   Form1.CoeMemo.Lines.Add(t3);
   Form1.CoeMemo.Lines.Add(t1);
   if ndim>=9 then begin
      t1:='';  t3:='    ';
      for i:=9 to ndim do begin
          str(g_dg[i]:9:3,t2);
          t1:=t1+t2+',';
          t3:=t3+'  '+strC[ig_iC[i]];
      end;
      dum:=Form1.CoeMemo.Lines.Add(t3);
      Form1.CoeMemo.Lines.Add(t1);
   end;
   FromCoeffsToForm17DDSpinEdits;
end;

procedure {TDrawT.}PrintFunctional;
begin
      { Number of Simplex iteration }
      Form1.Canvas.Font.Color := clPurple;
      str(nFunk:4,t1);
      t1:='nFunk='+t1+'  ';
      Form1.Canvas.TextOut(450, 5,t1);
      Form17.Label1.Caption:=t1;
      str(Functional:11,t1);
      t1:='Residual='+t1+'  ';
      Form1.Canvas.TextOut(450,20,t1);
      Form17.Label1.Caption:=Form17.Label1.Caption+' '+t1;
end;

procedure {TDrawT.}ClearAllPlots;
begin
//  Form1.Series1.Clear;
  Form1.Series1.Clear;
  Form1.Series2.Clear;
  Form1.Series3.Clear;
  Form1.Series4.Clear;
  Form1.Series5.Clear;
  Form1.Series6.Clear;
  Form1.Series7.Clear;
  Form1.Series8.Clear;
  Form1.Series9.Clear;
  Form1.Series10.Clear;
  Form1.Series11.Clear;
  Form1.Series12.Clear;
  Form1.Series13.Clear;
  Form1.Series14.Clear;
  Form1.Series15.Clear;
  Form1.Series17.Clear;
  Form1.Series16.Clear;
  Form1.Series18.Clear;
  Form1.Series19.Clear;
  Form1.Series20.Clear;
  Form1.Series21.Clear;
  Form1.Series22.Clear;
  Form1.Series23.Clear;
  Form1.Series24.Clear;
  Form1.Series25.Clear;
  Form1.Series26.Clear;
  Form1.Series27.Clear;
  Form1.Series28.Clear;
  Form1.Series29.Clear;
end;

{*********************************************************************}
procedure InitialPicture;
var     xU,tl,minSc,maxSc       :double;
        nl,nle,ntl              :integer;
begin
  Form1.Series9.Active:=(NP0.HH_order='2-points');
  if not(Form1.NoClear.Checked) then ClearAllPlots;
{  Form1.Canvas.TextOut(650, 60,'V, mV');
  Form1.Canvas.TextOut(450,360,'PSC, pA');
  Form1.Canvas.TextOut(650,330,'Im');
  Form1.Canvas.TextOut(650,345,'- INa');
  Form1.Canvas.TextOut(650,360,'- IK');
  Form1.Canvas.TextOut(450, 45,'mm');
  Form1.Canvas.TextOut(450, 60,'hh');
  Form1.Canvas.TextOut(550, 45,'nn');
  Form1.Canvas.TextOut( 50,330,'Vexp[nt,Smpl]');
  Form1.Canvas.TextOut( 50,345,'Vr');
  Form1.sp_XYLine1.DrawLegendMarker(Form1.Canvas,Rect(620, 60,640, 75));
  Form1.sp_XYLine2.DrawLegendMarker(Form1.Canvas,Rect(420,360,440,375));
  Form1.sp_XYLine3.DrawLegendMarker(Form1.Canvas,Rect(620,330,640,345));
  Form1.sp_XYLine4.DrawLegendMarker(Form1.Canvas,Rect(620,345,640,360));
  Form1.sp_XYLine5.DrawLegendMarker(Form1.Canvas,Rect(620,360,640,375));
  Form1.sp_XYLine6.DrawLegendMarker(Form1.Canvas,Rect(420, 45,440, 60));
  Form1.sp_XYLine7.DrawLegendMarker(Form1.Canvas,Rect(420, 60,440, 75));
  Form1.sp_XYLine8.DrawLegendMarker(Form1.Canvas,Rect(520, 45,540, 60));
  Form1.sp_XYLine9.DrawLegendMarker(Form1.Canvas,Rect( 20,330, 40,345));
  Form1.sp_XYLine10.DrawLegendMarker(Form1.Canvas,Rect(20,345, 40,360));}
//  Form1.Chart3.BottomAxis.Maximum:=t_end*1000;
  Form1.Chart5.BottomAxis.Maximum:=t_end*1000;
  Form1.Chart4.BottomAxis.Maximum:=t_end*1000;
  if NP0.If_I_V_or_g in [1,3,4,5] then begin
     {Form1.Chart3.LeftAxis.Minimum:=-1000;
     Form1.Chart3.LeftAxis.Maximum:= 2000;}
     Form1.Chart3.LeftAxis.Title.Caption:='I, pA'
  end else begin
     //Form1.Chart3.LeftAxis.Minimum:={-0.050}-0.020;
     //Form1.Chart3.LeftAxis.Maximum:={ 0.020} 0.120;
     Form1.Chart3.LeftAxis.Title.Caption:='V, Volts'
  end;
  if Form1.FitPictureToExpData1.Checked then
                       FitGraphScalesToExpData(minSc,maxSc);
{  if abs(maxSc-minSc)>1e-3 then begin
     Form1.Chart3.LeftAxis.Minimum:=min(scy_Smpl*minSc,scy_Smpl*maxSc)*1.2;
     Form1.Chart3.LeftAxis.Maximum:=max(scy_Smpl*minSc,scy_Smpl*maxSc)*1.2;
  end;}
  { Sample - 'Black' }
  xU:=Form1.Chart3.BottomAxis.Maximum/dt;  if xU<=0 then xU:=t_end*1000/dt;
  nle:=round(nt+xU);  if nle>nt_end then nle:=nt_end;
  for nl:=nt to nle do begin
      ntl:=trunc(nl-trunc(nl/xU)*xU);
      tl:=ntl*dt*1000 {ms};
      if nl<MaxExp then begin
         Form1.Series11.AddXY(tl, {scy_Smpl*}Vexp[nl,Smpl]);
      end;
  end;
  PrintCoefficients;
  //PrintFunctional;
  Application.ProcessMessages;
end;

procedure {TDrawT.}Evolution;
var  i   :integer;
begin
      PrintTime;
      { Evolution in time }
      Form1.Series1.AddXY(t*1000,NV0.V*1000);
      if NP0.IfThrModel=1 then
      Form1.Series3.AddXY(t*1000,(NP0.Vrest+NV0.Thr)*1000);
      Form1.Series4.AddXY(t*1000,NV0.PSC/1000);
      Form1.Series5.AddXY(t*1000,-NV0.Im);
      Form1.Series6.AddXY(t*1000,-NV0.INa);
      Form1.Series7.AddXY(t*1000,-NV0.IK-NV0.IKA-NV0.IKD);
      Form1.Series8.AddXY(t*1000,du_Reset);
      Form1.Series9.AddXY(t*1000,NV0.VatE*1000);
      Form1.Series12.AddXY(t*1000,NV0.mm);
      Form1.Series13.AddXY(t*1000,NV0.hh);
      Form1.Series16.AddXY(t*1000,NV0.nn);
      Form1.Series10.AddXY(t*1000,Vr);
      Form1.Series17.AddXY(t*1000,NV0.nM);
      Form1.Series14.AddXY(t*1000,NV0.mmR);
      Form1.Series15.AddXY(t*1000,NV0.hhR);
      Form1.Series18.AddXY(t*1000,NV0.wAHP);
      Form1.Series19.AddXY(t*1000,NV0.wADP);
      Form1.Series20.AddXY(t*1000,NP0.gL+NV0.gActive);
      Form1.Series26.AddXY(t*1000,NV0.ii);
      if ANrn.NP.Na_type='Lyle' then begin
         Form1.Series22.AddXY(t*1000,ANrn.NV.XNa[1]);
         Form1.Series23.AddXY(t*1000,ANrn.NV.XNa[2]);
         Form1.Series24.AddXY(t*1000,ANrn.NV.XNa[3]);
         Form1.Series25.AddXY(t*1000,ANrn.NV.XNa[4]);
         Form1.Series27.AddXY(t*1000,ANrn.NV.XNa[13]);
      end;
      { Phase plane}
      if Form1.PageControl1.ActivePageIndex=5 then begin
         Form1.Series28.AddXY(NV0.V*1000,NV0.DVDt);
         Form1.Series29.AddXY(NV0.V*1000,NV0.Im);
      end;
end;

procedure DrawSpike;
begin
  Form1.Series21.AddXY(t*1000,NV0.V*1000);
end;

procedure Plot_Th_tAP;
begin
  Form3.Series1.AddXY(DVDt_Th,    Th*1000);
  Form3.Series13.AddXY(DVDt_Th,   Th1*1000);
  if Form3.CheckBox2.Checked then begin  { if x-axis is rate }
     Form3.Chart3.BottomAxis.Title.Caption:='Rate, Hz';
     if tAP2>0 then begin
        Form3.Series5.AddXY(1/tAP2,Th*1000);
        Form3.Series9.AddXY(1/tAP2,Th1*1000);
     end;
  end else begin                         { if x-axis is latency }
     Form3.Chart3.BottomAxis.Title.Caption:='tAP, ms';
     if tAP2>0 then begin
        Form3.Series5.AddXY(tAP2*1000,Th*1000);
        Form3.Series9.AddXY(tAP2*1000,Th1*1000);
     end;
  end;
  Form3.Series6.AddXY(Iind,       Th*1000);
  Form3.Series7.AddXY(Iind,       NV0.tAP*1000);
  Form3.Series8.AddXY(Iind,       DVDt_Th);
  Form3.Series11.AddXY(Iind,      Th_Curv*1000);
  Form3.Series12.AddXY(DVDt_Curv, Th_Curv*1000);
  Form3.LineSeries1.AddXY(hh_Th,  Th*1000);
  Form3.LineSeries2.AddXY(hh_Th1, Th1*1000);
end;

procedure Clear_Th_V;
begin
  Form3.Series2.Clear;
  Form3.Series3.Clear;
  Form3.Series4.Clear;
  Form3.Series10.Clear;
end;
{--------------------EOF---------------------------------------------------}

end.
