unit sgr_def;
{(c) S.P.Pod'yachev 1998-1999 }
{ver. 2.3}
{*******************************************************}
{ here the base definition of SGraph                    }
{ Tsp_XYPlot - Plot itself which holds Axis as Tsp_Axis }
{ declaration Tsp_DataSeries - Plot Series ancestor     }
{ declaration Tsp_PlotMarker - Plot Marker ancestor     }
{*******************************************************}
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, clipbrd, sgr_misc, sgr_scale;
Type
Tsp_XYPlot = class;
Tsp_Axis=class(Tsp_Scale)
private
  sMin, sMax : double;                                              
  fMargin: integer;                                                  
  fCaption: string;                           
  fDrawCaption: boolean;
  fPlot: Tsp_XYPlot;                         
  fGrid: Tsp_LineAttr;                            
  fMinMaxStored: boolean;                          
  procedure aInvalidatePlot;
  procedure SetMargin(const V:integer);
  procedure SetCaption(const V:string);
  procedure SetMin(const V:double);
  procedure SetMax(const V:double);
  procedure SetTicksCount(V:Byte);
  procedure SetLabelFormat(const V:string);
  procedure SetLineAttr(const V:Tsp_LineAttr);
  procedure LineChanged(V:TObject);
  procedure SetGrid(const V:Tsp_LineAttr);
  procedure GridChanged(V:TObject);
protected
  procedure FlagsChanged(const BN:integer; const On:boolean); override;
  procedure StoreMinMax;
  procedure ReStoreMinMax;
  function  TickLabel(tickNum:integer): string; override;
public
  constructor Create(Flags:integer);
  destructor Destroy; override;
  procedure Assign(Source: TPersistent); override;
  procedure AssignTo(Dest: TPersistent); override;
  procedure SetMinMax(aMin,aMax:double);
  procedure MoveMinMax(aDelta:double);
published
  property Margin:integer read fMargin write SetMargin;
  property Caption:string read fCaption write SetCaption;
  property Min:double read fMin write SetMin stored False;
  property Max:double read fMax write SetMax stored False;
  property TicksCount: Byte read GetTicksCount write SetTicksCount default 5;
  property LineAttr:Tsp_LineAttr read fLineAttr write SetLineAttr;
  property GridAttr:Tsp_LineAttr read fGrid write SetGrid;
  property AutoMin:boolean index fbposAutoMin read GetFlagBit write SetFlagBit stored False;
  property AutoMax:boolean index fbposAutoMax read GetFlagBit write SetFlagBit stored False;
  property LabelAsDataTime:boolean index fbposLabelAsDate read GetFlagBit
                                   write SetFlagBit stored False;
  property LabelFormat: string read fLabelFormat write SetLabelFormat;
end;
Tsp_WhatXAxis=(dsxBottom, dsxTop);
Tsp_WhatYAxis=(dsyLeft,   dsyRight);
TIP_Reason=(rsDataChanged, rsAttrChanged);
Tsp_WhenDrawMarker=(dmBeforeSeries, dmAfterSeries);
Tsp_PlotMarker=class(TComponent)
protected
  fWhenDraw:Tsp_WhenDrawMarker;
  fVisible:boolean;
  fPlot: Tsp_XYPlot;                
  fWXA:Tsp_WhatXAxis;                                  
  fWYA:Tsp_WhatYAxis;                                  
  fXAx, fYAx:Tsp_Axis;
  procedure SetPlot(const Value: Tsp_XYPlot);                             
  procedure Notification(AComponent:TComponent; Operation:TOperation); override;
  procedure mInvalidatePlot;
  procedure SetWhenDraw(V:Tsp_WhenDrawMarker);
  procedure SetWXA(const V:Tsp_WhatXAxis);               
  procedure SetWYA(const V:Tsp_WhatYAxis);
  procedure SetVisible(const V:boolean);
public
  procedure BringToFront;
  procedure SendToBack;
  procedure Draw; virtual; abstract;
  property XAxisObj:Tsp_Axis read fXAx;
  property YAxisObj:Tsp_Axis read fYAx;
published
  property Plot: Tsp_XYPlot read fPlot write SetPlot;
  property XAxis:Tsp_WhatXAxis read fWXA write SetWXA default dsxBottom;
  property YAxis:Tsp_WhatYAxis read fWYA write SetWYA default dsyLeft;
  property WhenDraw:Tsp_WhenDrawMarker read fWhenDraw write SetWhenDraw;
  property Visible:boolean read fVisible write SetVisible;
end;
Tsp_DataSeries=class(TComponent)
protected
  fPlot: Tsp_XYPlot;                
  fWXA:Tsp_WhatXAxis;                                  
  fWYA:Tsp_WhatYAxis;                                  
  fActive:boolean;                                                            
  fLegend:string;
  procedure SetPlot(const Value: Tsp_XYPlot);                             
  procedure Notification(AComponent:TComponent; Operation:TOperation); override;
  procedure SetActive(const V:boolean);
  procedure SetWXA(const V:Tsp_WhatXAxis);               
  procedure SetWYA(const V:Tsp_WhatYAxis);
  procedure SetLegend(const V:string);
  procedure DoOnChange; virtual;
  procedure InvalidatePlot(const Reason:TIP_Reason);
public
  constructor Create(AOwner:TComponent); override;
  procedure Draw; virtual; abstract;
  function GetXMin(var V:double):boolean; virtual; abstract;
  function GetXMax(var V:double):boolean; virtual; abstract;
  function GetYMin(var V:double):boolean; virtual; abstract;
  function GetYMax(var V:double):boolean; virtual; abstract;
  procedure DrawLegendMarker(const LCanvas:TCanvas; MR:TRect); virtual;
  procedure BringToFront;
  procedure SendToBack;
  property Active:boolean read fActive write SetActive;
published
  property Plot: Tsp_XYPlot read fPlot write SetPlot;
  property XAxis:Tsp_WhatXAxis read fWXA write SetWXA default dsxBottom;
  property YAxis:Tsp_WhatYAxis read fWYA write SetWYA default dsyLeft;
  property Legend:string read fLegend write SetLegend;
end;
Tsp_BorderStyle=(bs_None, bs_Raised, bs_Lowered, bs_Gutter,
                 bs_BlackRect, bs_BoldRect, bs_FocusRect);
TGetTickLabelEvent=procedure(Sender: Tsp_Axis; LabelNum: integer;
                              LabelVal : double; var LS:string) of object;
Tsp_ShiftKeys=set of (ssShift, ssAlt, ssCtrl);
Tsp_zpDirections=(zpdNone, zpdHorizontal, zpdVertical, zpdBoth);
Tsp_ZoomData=record
  R:TRect;
  State:byte;          
end;
TZoomAxisEvent=procedure(Sender: Tsp_Axis; var min, max : double;
                                      var CanZoom:boolean) of object;
Tsp_XYPlot = class(TCustomControl)
private
  LA,RA,BA,TA: Tsp_Axis;             
  FR: TRect;                          
  fDCanvas: TCanvas;                              
  fDWidth,
  fDHeight: integer;                           
  fDDBBuf: Tsp_MemBitmap;                                
  fBuffered: boolean;                         
  VFont:TFont;                           
  fFieldDraw: TNotifyEvent;
  fDrawEnd: TNotifyEvent;
  fOnTickLabel: TGetTickLabelEvent;
  fOnZoom: TZoomAxisEvent;
  fFrameStyle: Tsp_BorderStyle;
  FBColor: TColor;                             
  fSeries: TList;                          
  fBSML,fASML:TList;                                
  fPanCursor:TCursor;
  fZoomEnabled, fPanEnabled : Tsp_zpDirections;
  fZoomShift: TShiftState;                                      
  fPanShift: TShiftState;                                      
  fZoomData: Tsp_ZoomData;                
  fXCursOn:boolean;                             
  fXCursVal:double;                     
  fXCursPos:integer;        
  procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  procedure CMFontChanged(var Message: TMessage); message CM_FontChanged;
  procedure CMSysColorChange(var Message: TMessage);  message CM_SysColorChange;
  procedure SysColorChange;
  procedure WMSize(var Message: TWMSize); message WM_SIZE;
  procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
  procedure WMEraseBKGND(var Message: TWMERASEBKGND); message WM_ERASEBKGND;
  procedure SetLA(const V:Tsp_Axis);
  procedure SetRA(const V:Tsp_Axis);
  procedure SetBA(const V:Tsp_Axis);
  procedure SetTA(const V:Tsp_Axis);
  procedure FreshVFont;
  procedure SetFBColor(const V:TColor);
  procedure SetBorderStyle(const V: Tsp_BorderStyle);
  procedure SetBuffered(const V:boolean);
  procedure SetZoomShift(const V:Tsp_ShiftKeys);
  function  GetZoomShift:Tsp_ShiftKeys;
  procedure SetPanShift(const V:Tsp_ShiftKeys);
  function  GetPanShift:Tsp_ShiftKeys;
  function  GetSeriesPtr(i:integer):Tsp_DataSeries;
  function  GetSeriesCount:integer;
  procedure SetXCursOn(const V:boolean);
  procedure SetXCursVal(V:double);
  procedure DrawXCursor;
  procedure DrawXCursorOnPaint;
  procedure AddSeries(const DS:Tsp_DataSeries);
  procedure RemoveSeries(const DS:Tsp_DataSeries);
  function  MarkerList(const WDM:Tsp_WhenDrawMarker):TList;
  procedure RemoveMarker(const FM:Tsp_PlotMarker; const WDM:Tsp_WhenDrawMarker);
  procedure AddMarker(const FM:Tsp_PlotMarker; const WDM:Tsp_WhenDrawMarker);
  procedure SetMarkerAt(const FM:Tsp_PlotMarker; const WDM:Tsp_WhenDrawMarker; Front:boolean);
  procedure Arrange(AvgFntW,FntH:integer);
  function FindXAutoMin(WX:Tsp_WhatXAxis; var min:double ):boolean;
  function FindXAutoMax(WX:Tsp_WhatXAxis; var max:double ):boolean;
  function FindYAutoMin(WY:Tsp_WhatYAxis; var min:double ):boolean;
  function FindYAutoMax(WY:Tsp_WhatYAxis; var max:double ):boolean;
  function DoAutoMinMax(Axis:Tsp_Axis):boolean;
  procedure RectToLimits(ZR:TRect; D:Tsp_zpDirections);
  function LimitsStored:boolean;
  procedure StoreLimits;
  procedure RestoreLimits;
protected
  ValidArrange:boolean;
  ValidField:boolean;
  ValidAround:boolean;
  procedure CreateParams(var Params: TCreateParams); override;
  procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
                                                X, Y: Integer); override;
  procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
  procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
                                                X, Y: Integer); override;
  procedure DrawAroundField;
  procedure DrawBorder;
  procedure DrawField;
  procedure DrawNotRect(R:TRect);
  procedure CustomInvalidate(Arrange, Around, Field :boolean);
  procedure InvalidateSeries(DS:Tsp_DataSeries);
  procedure pDrawPlot;
  procedure DoOnDrawEnd; virtual;
  procedure DoOnFieldDraw; virtual;
public
  constructor Create(AOwner: TComponent); override;
  destructor Destroy; override;
  procedure Invalidate; override;
  procedure BufferIsInvalid;
  procedure DrawPlot(DC:TCanvas; W, H:integer);
  procedure Paint; override;
  procedure CopyToClipboardMetafile;
  procedure CopyToClipboardBitmap;
  property DCanvas:TCanvas read fDCanvas;
  property DWidth:integer read fDWidth;
  property DHeight:integer read fDHeight;
  property FieldRect:TRect read FR;
  property Series[i:integer]:Tsp_DataSeries read GetSeriesPtr;
  property SeriesCount:integer read GetSeriesCount;
published
  property Align;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Color;                                 
    property Ctl3D;
    property Font;                                        
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
   property OnStartDrag;
  property Zoom: Tsp_zpDirections read fZoomEnabled write fZoomEnabled default zpdBoth;
  property Pan: Tsp_zpDirections read fPanEnabled write fPanEnabled default zpdBoth;
  property ZoomShiftKeys : Tsp_ShiftKeys read GetZoomShift write SetZoomShift default [ssShift];
  property PanShiftKeys : Tsp_ShiftKeys read GetPanShift write SetPanShift default [ssCtrl];
  property PanCursor:TCursor read fPanCursor write fPanCursor default crDefault;
  property LeftAxis:Tsp_Axis read LA write SetLA;
  property RightAxis:Tsp_Axis read RA write SetRA;
  property BottomAxis:Tsp_Axis read BA write SetBA;
  property TopAxis:Tsp_Axis read TA write SetTA;
  property BorderStyle:Tsp_BorderStyle  read FFrameStyle write SetBorderStyle;
  property FieldColor:TColor read FBColor write SetFBColor;
  property BufferedDisplay:Boolean read fBuffered write SetBuffered default False;
  property XCursorOn:boolean read fXCursOn write SetXCursOn default False;
  property XCursorVal:double read fXCursVal write SetXCursVal;
  property OnAxisZoom: TZoomAxisEvent read fOnZoom write fOnZoom;
  property OnGetTickLabel:TGetTickLabelEvent read fOnTickLabel write fOnTickLabel;
  property OnFieldDraw:TNotifyEvent read fFieldDraw write fFieldDraw;
  property OnDrawEnd:TNotifyEvent read fDrawEnd write fDrawEnd;
end;
IMPLEMENTATION
constructor Tsp_Axis.Create(Flags:integer);
begin
 Inherited Create(Flags);
 fGrid:=Tsp_LineAttr.Create;
 fGrid.Color:=clGray;
 fGrid.Visible:=False;
 fMargin:=4;
 fCaption:='';
 fDrawCaption:=False;
 fPlot:=nil;
 fMinMaxStored:=False;
 fGrid.OnChange:=GridChanged;
 fLineAttr.OnChange:=LineChanged;
end;
destructor Tsp_Axis.Destroy;
begin
 fGrid.OnChange:=nil;
 fLineAttr.OnChange:=nil;
 if Assigned(fGrid) then fGrid.Free;
 inherited Destroy;
end;
procedure Tsp_Axis.aInvalidatePlot;
begin
 if Assigned(fPlot) then with fPlot do begin
   Invalidate;
  end;
end;
procedure Tsp_Axis.SetMargin(const V:integer);
begin
 if V<>fMargin then begin
  fMargin:=V;
  aInvalidatePlot;
 end;
end;
procedure Tsp_Axis.SetCaption(const V:string);
var j:integer;
begin
 if V<>fCaption then begin
  fCaption:=V;
  fDrawCaption:=False;
  for j:=1 to length(fCaption) do if fCaption[j]>' ' then
  begin fDrawCaption:=True; break end;
  aInvalidatePlot;
 end;
end;
procedure Tsp_Axis.SetMin(const V:double);
begin
 fFlags:=fFlags and Not(sdfAutoMin);
 fMinMaxStored:=False;
 if V<>fMin then begin
  ChangeMinMax(V, fMax);
  aInvalidatePlot;
 end;
end;
procedure Tsp_Axis.SetMax(const V:double);
begin
 fFlags:=fFlags and Not(sdfAutoMax);
 fMinMaxStored:=False;
 if V<>fMax then begin
  ChangeMinMax(fMin, V);
  aInvalidatePlot;
 end;
end;
procedure Tsp_Axis.SetTicksCount(V:Byte);
begin
 if V>MaxTicksCount then V:=MaxTicksCount;
 if V<>fTicksCount then begin
   fTicksCount:=V;
   CalcTicksVal;
   CalcTicksPos;
   aInvalidatePlot;
 end;
end;
procedure Tsp_Axis.SetLabelFormat(const V:string);
begin
 if fLabelFormat<>V then
 begin
  fLabelFormat:=V;
  aInvalidatePlot;
 end;
end;
procedure Tsp_Axis.SetLineAttr(const V:Tsp_LineAttr);
begin
 if Not fLineAttr.IsSame(V) then fLineAttr.Assign(V);
end;
procedure Tsp_Axis.LineChanged(V:TObject);
begin
 aInvalidatePlot;
end;
procedure Tsp_Axis.SetGrid(const V:Tsp_LineAttr);
begin
 if Not fGrid.IsSame(V) then fGrid.Assign(V);
end;
procedure Tsp_Axis.GridChanged(V:TObject);
begin
 if Assigned(fPlot) then with fPlot do
 begin
   CustomInvalidate(False, False, True);
 end;
end;
procedure Tsp_Axis.FlagsChanged(const BN:integer; const On:boolean);
begin
  case BN of
  fbposInversed: begin
                  CalcMetr;
                  CalcTicksVal;
                  CalcTicksPos;
                  aInvalidatePlot;
                 end;
  fbposNoTicks,
  fbposNoTicksLabel,
  fbposNotAjustedTicks : begin
                  CalcTicksVal;
                  CalcTicksPos;
                  aInvalidatePlot;
                 end;
  fbposAutoMax,
  fbposAutoMin: if Assigned(fPlot) then
                with fPlot do if DoAutoMinMax(Self) then Invalidate;
  else
   aInvalidatePlot;
 end;       
end;
procedure Tsp_Axis.StoreMinMax;
begin
 if Not fMinMaxStored then begin
   sMin:=Min; sMax:=Max; fMinMaxStored:=True;
 end
end;
procedure Tsp_Axis.RestoreMinMax;
begin
 if fMinMaxStored then begin
   ChangeMinMax(sMin,sMax); fMinMaxStored:=False;
 end;
end;
function Tsp_Axis.TickLabel(tickNum:integer): string;
begin
 Result:=inherited TickLabel(tickNum);
 with fPlot do
  if Assigned(fOnTickLabel)
   then fOnTickLabel(Self, tickNum, TksDbl(tickNum), Result);
end;
procedure Tsp_Axis.Assign(Source: TPersistent);
var ss:Tsp_Axis;
begin
 if Source is Tsp_Axis then
 begin
   ss:=Tsp_Axis(Source);
   fFlags:=ss.fFlags;
   fO:=ss.fO;
   fLen:=ss.fLen;
   fTicksCount:=ss.fTicksCount;
   fLabelFormat:=ss.fLabelFormat;
   fMargin:=ss.fMargin;
   fCaption:=ss.fCaption;
   fDrawCaption:=ss.fDrawCaption;
   fMinMaxStored:=False;
   ChangeMinMax(ss.fMin, ss.Max);
   fLineAttr.Assign(ss.fLineAttr);
   fGrid.Assign(ss.fGrid);
   fGrid.OnChange:=GridChanged;
   fLineAttr.OnChange:=LineChanged;
 end else inherited Assign(Source);
end;
procedure Tsp_Axis.AssignTo(Dest: TPersistent);
begin
 if Dest is Tsp_Axis then Dest.Assign(Self)
 else inherited AssignTo(Dest);
end;
procedure Tsp_Axis.SetMinMax(aMin,aMax:double);
begin
 if (aMin<>fMin) or (aMax<>fMax)then ChangeMinMax(aMin,aMax);
 fFlags:=fFlags and Not(sdfAutoMin or sdfAutoMax);
 fMinMaxStored:=False;
 aInvalidatePlot;
end;
procedure Tsp_Axis.MoveMinMax(aDelta:double);
begin
 ShiftScaleBy(False,0,aDelta);
 fFlags:=fFlags and Not(sdfAutoMin or sdfAutoMax);
 fMinMaxStored:=False;
 if Assigned(fPlot) then with fPlot do begin
   CustomInvalidate(False,True,True);
 end;
end;
procedure Tsp_PlotMarker.SetPlot(const Value: Tsp_XYPlot);                      
begin
  if fPlot=Value then Exit;
  if Assigned(fPlot) then fPlot.RemoveMarker(Self, fWhenDraw);
  fPlot:=Value;
  if Assigned(fPlot) then  begin
    if fWXA=dsxBottom then fXAx:=fPlot.BottomAxis else fXAx:=fPlot.TopAxis;
    if fWYA=dsyLeft then fYAx:=fPlot.LeftAxis else fYAx:=fPlot.RightAxis;
    if Assigned(fPlot) then
    begin                                      
     fPlot.AddMarker(Self, fWhenDraw);
     fPlot.FreeNotification(Self);                                
    end;
  end
  else begin
    fXAx:=nil; fYAx:=nil;
  end;
end;
procedure Tsp_PlotMarker.Notification(AComponent:TComponent; Operation:TOperation);
begin
 inherited Notification(AComponent, Operation);
 if (Operation=opRemove) and (AComponent=fPlot) then
 begin
   fPlot:=nil;
 end;
end;
procedure Tsp_PlotMarker.mInvalidatePlot;
begin
 if Assigned(fPlot) then with fPlot do CustomInvalidate(False,False,True);
end;
procedure Tsp_PlotMarker.SetWhenDraw(V:Tsp_WhenDrawMarker);
begin
 if (V<>fWhenDraw) then begin
   if Assigned(fPlot) then fPlot.RemoveMarker(Self, fWhenDraw);
   fWhenDraw:=V;
   if Assigned(fPlot) then fPlot.AddMarker(Self, fWhenDraw);
 end;
end;
procedure Tsp_PlotMarker.SetWXA(const V:Tsp_WhatXAxis);               
begin
 if V<>fWXA then begin
   fWXA:=V;
   if fWXA=dsxBottom then fXAx:=fPlot.BottomAxis else fXAx:=fPlot.TopAxis;
   mInvalidatePlot;
 end;
end;
procedure Tsp_PlotMarker.SetWYA(const V:Tsp_WhatYAxis);
begin
 if V<>fWYA then begin
   fWYA:=V;
   if fWYA=dsyLeft then fYAx:=fPlot.LeftAxis else fYAx:=fPlot.RightAxis;   
   mInvalidatePlot;
 end;
end;
procedure Tsp_PlotMarker.SetVisible(const V:boolean);
begin
 if V<>fVisible then begin
   fVisible:=V;
   mInvalidatePlot;
 end;
end;
procedure Tsp_PlotMarker.BringToFront;
begin
 if Assigned(fPlot) then fPlot.SetMarkerAt(Self, fWhenDraw, True);
end;
procedure Tsp_PlotMarker.SendToBack;
begin
 if Assigned(fPlot) then fPlot.SetMarkerAt(Self, fWhenDraw, False);
end;
constructor Tsp_DataSeries.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 fWXA:=dsxBottom;
 fWYA:=dsyLeft;
end;
procedure Tsp_DataSeries.SetPlot(const Value: Tsp_XYPlot);
begin
  if fPlot=Value then Exit;
  if Assigned(fPlot) then fPlot.RemoveSeries(Self);
  fPlot:=Value;
  if Assigned(fPlot) then
  begin
   fPlot.AddSeries(Self);
   fPlot.FreeNotification(Self);                                
  end;
end;
procedure Tsp_DataSeries.Notification(AComponent:TComponent; Operation:TOperation);
begin
 inherited Notification(AComponent, Operation);
 if (Operation=opRemove) and (AComponent=fPlot) then
 begin
   fPlot:=nil;
 end;
end;
procedure Tsp_DataSeries.SetActive(const V:boolean);
begin
 if V<>fActive then
 begin
  fActive:=V;
  if Assigned(fPlot) then fPlot.InvalidateSeries(Self)
 end;
end;
procedure Tsp_DataSeries.SetWXA(const V:Tsp_WhatXAxis);
begin
 if V<>fWXA then
 begin
   fWXA:=V;
   if Assigned(fPlot) then with fPlot do
     if DoAutoMinMax(LA) or  DoAutoMinMax(RA) then Invalidate;
 end;
end;
procedure Tsp_DataSeries.SetWYA(const V:Tsp_WhatYAxis);
begin
 if V<>fWYA then
 begin
   fWYA:=V;
   if Assigned(fPlot) then with fPlot do
   begin
     if DoAutoMinMax(BA) or DoAutoMinMax(TA) then Invalidate;
   end;
 end;
end;
procedure Tsp_DataSeries.SetLegend(const V:string);
begin
 if V<>fLegend then begin
   fLegend:=V;
   DoOnChange;
 end;
end;
procedure Tsp_DataSeries.DoOnChange;
begin
end;
procedure Tsp_DataSeries.DrawLegendMarker(const LCanvas:TCanvas; MR:TRect);
begin
end;
procedure Tsp_DataSeries.InvalidatePlot(const Reason:TIP_Reason);
begin
 if Not Active then Exit;
 if Assigned(fPlot) then with fPlot do
 case Reason of
   rsDataChanged: InvalidateSeries(Self);
   rsAttrChanged: CustomInvalidate(False,False,True);
 end;
end;
procedure Tsp_DataSeries.BringToFront;
var ci:integer;
begin
 if Assigned(fPlot) then with fPlot.fSeries do
 if Last<>Self then
 begin
  ci:=IndexOf(Self);
  if (ci>-1) then Move(ci, fPlot.fSeries.Count-1);
 end;
end;
procedure Tsp_DataSeries.SendToBack;
var ci:integer;
begin
 if Assigned(fPlot) then with fPlot.fSeries do
 begin
  ci:=IndexOf(Self);
  if ci>0 then Move(ci,0);
 end;
end;
procedure Tsp_XYPlot.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;
procedure Tsp_XYPlot.CMFontChanged(var Message: TMessage);
begin
  ValidArrange:=False;                      
  ValidAround:=False; ValidField:=False;
  FreshVFont;
  inherited;
end;
procedure Tsp_XYPlot.CMSysColorChange(var Message: TMessage);
begin
 SysColorChange;
 inherited;
end;
procedure Tsp_XYPlot.SysColorChange;
begin
 if fBuffered then
 begin
  fDDBBuf.Recreate(Width, Height);
  if fDDBBuf.Valid then DrawPlot(fDDBBuf.Canvas, Width, Height);
 end;
end;
procedure Tsp_XYPlot.WMSize(var Message: TWMSize);
begin
 Invalidate;                                                    
end;
procedure Tsp_XYPlot.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;                      
end;
procedure Tsp_XYPlot.WMERASEBKGND(var Message: TWMERASEBKGND);
begin
 Message.Result:=1;
end;
procedure Tsp_XYPlot.SetLA(const V:Tsp_Axis);
begin
 if V<>LA then LA.Assign(V);
end;
procedure Tsp_XYPlot.SetRA(const V:Tsp_Axis);
begin
 if V<>RA then RA.Assign(V);
end;
procedure Tsp_XYPlot.SetBA(const V:Tsp_Axis);
begin
 if V<>BA then BA.Assign(V);
end;
procedure Tsp_XYPlot.SetTA(const V:Tsp_Axis);
begin
 if V<>TA then TA.Assign(V);
end;
procedure Tsp_XYPlot.SetFBColor(const V:TColor);
begin
 if V<>FBColor then
 begin
  FBColor:=V;
  CustomInvalidate(False, False, True);
 end;
end;
procedure Tsp_XYPlot.SetBorderStyle(const V:Tsp_BorderStyle );
begin
  if V<> FFrameStyle then  begin
    FFrameStyle := V;
    if BufferedDisplay then BufferIsInvalid;
    DrawBorder;
    if csDesigning in ComponentState then Invalidate;
  end;
end;
procedure Tsp_XYPlot.SetBuffered(const V:boolean);
begin
 if V=fBuffered then Exit;
 if V then begin
  fDDBBuf:=Tsp_MemBitmap.Create(Width, Height);
 end
 else begin
  if Assigned(fDDBBuf) then fDDBBuf.Free;
  fDDBBuf:=nil;
 end;
 fBuffered:=Assigned(fDDBBuf);
 Invalidate;
end;
procedure Tsp_XYPlot.SetZoomShift(const V:Tsp_ShiftKeys);
begin
 fZoomShift:=[ssLeft]+TShiftState(V);
end;
function Tsp_XYPlot.GetZoomShift:Tsp_ShiftKeys;
var S:TShiftState;
begin
 S:=fZoomShift-[ssLeft];
 Result:=Tsp_ShiftKeys(S);
end;
procedure Tsp_XYPlot.SetPanShift(const V:Tsp_ShiftKeys);
begin
 fPanShift:=TShiftState(V)+[ssLeft];
end;
function Tsp_XYPlot.GetPanShift:Tsp_ShiftKeys;
var S:TShiftState;
begin
 S:=fPanShift-[ssLeft];
 Result:=Tsp_ShiftKeys(S);
end;
procedure Tsp_XYPlot.DrawXCursor;
begin
 with Canvas do begin
  with Pen do begin
    Mode:=pmNot;
    Style:=psSolid;
  end;
  with FR do if (fXCursPos>Left) and (fXCursPos<Right) then
  begin
    MoveTo(fXCursPos, Top+1);
    LineTo(fXCursPos, Bottom-1);
  end;
 end;
end;
procedure Tsp_XYPlot.DrawXCursorOnPaint;
begin
 if fXCursOn then
 begin
   fXCursPos:=BA.V2P(fXCursVal);
   DrawXCursor;
 end;
end;
procedure Tsp_XYPlot.SetXCursVal(V:double);
var tpos:integer;
begin
 tpos:=BA.V2P(V);
 fXCursVal:=V;                                   
 if fXCursPos<>tpos then
 begin
   if fXCursOn then begin
    DrawXCursor;
    fXCursPos:=tpos;
    DrawXCursor;
   end;
 end;
end;
procedure Tsp_XYPlot.SetXCursOn(const V:boolean);
begin
 if V<>fXCursOn then begin
   fXCursOn:=V;
   if fXCursOn then DrawXCursorOnPaint else DrawXCursor;
 end;
end;
function Tsp_XYPlot.GetSeriesPtr(i:integer):Tsp_DataSeries;
begin
 Result:=fSeries[i];
end;
function Tsp_XYPlot.GetSeriesCount:integer;
begin
 Result:=fSeries.Count;
end;
procedure Tsp_XYPlot.AddSeries(const DS:Tsp_DataSeries);
begin
 if DS<>nil then begin
   with fSeries do if IndexOf(DS)<0 then Add(DS);
   if DS.Active then InvalidateSeries(DS);
 end;
end;
procedure Tsp_XYPlot.RemoveSeries(const DS:Tsp_DataSeries);
begin
 fSeries.Remove(DS);
 if (DS<>nil) and DS.Active then InvalidateSeries(DS);
end;
function Tsp_XYPlot.MarkerList(const WDM:Tsp_WhenDrawMarker):TList;
begin
 if WDM=dmBeforeSeries then Result:=fBSML else Result:=fASML;
end;
procedure Tsp_XYPlot.RemoveMarker(const FM:Tsp_PlotMarker; const WDM:Tsp_WhenDrawMarker);
begin
 MarkerList(WDM).Remove(FM);
 if (FM<>nil) and FM.Visible then CustomInvalidate(False,False,True);
end;
procedure Tsp_XYPlot.AddMarker(const FM:Tsp_PlotMarker; const WDM:Tsp_WhenDrawMarker);
begin
 if FM<>nil then begin
   with MarkerList(WDM) do if IndexOf(FM)<0 then Add(FM);
   if FM.Visible then CustomInvalidate(False,False,True);
 end;
end;
procedure Tsp_XYPlot.SetMarkerAt(const FM:Tsp_PlotMarker;
                                 const  WDM:Tsp_WhenDrawMarker; Front:boolean);
var ci:integer;
begin
 with MarkerList(WDM) do begin
   if Front and (Last<>Self) then begin
     ci:=IndexOf(Self);
     if (ci>-1) then Move(ci,Count-1);
   end
   else begin
     ci:=IndexOf(Self);
     if ci>0 then Move(ci,0);
   end;
 end;
end;
function Tsp_XYPlot.FindXAutoMin(WX:Tsp_WhatXAxis; var min:double ):boolean;
var j,k:integer; tm:double;
begin
 Result:=False;
 if fSeries.Count<1 then Exit;
 k:=-1;
 for j:=0 to fSeries.Count-1 do with Tsp_DataSeries(fSeries[j]) do
 begin
   if Active and (XAxis=WX) and GetXMin(min) then
   begin
     k:=j;
     break;
   end;
 end;
 if k > -1 then
 begin
   Result:=True;
   for j:=k+1 to fSeries.Count-1 do with Tsp_DataSeries(fSeries[j]) do
   begin
     if Active and (XAxis=WX) and GetXMin(tm) then
     begin
       if tm<min then min:=tm;
     end;
   end;
 end;       
end;
function Tsp_XYPlot.FindXAutoMax(WX:Tsp_WhatXAxis; var max:double ):boolean;
var j,k:integer; tm:double;
begin
 Result:=False;
 if fSeries.Count<1 then Exit;
 k:=-1;
 for j:=0 to fSeries.Count-1 do with Tsp_DataSeries(fSeries[j]) do
 begin
   if Active and (XAxis=WX) and GetXMax(max) then
   begin
     k:=j;
     break;
   end;
 end;
 if k > -1 then
 begin
   Result:=True;
   for j:=k+1 to fSeries.Count-1 do with Tsp_DataSeries(fSeries[j]) do
   begin
     if Active and (XAxis=WX) and GetXMax(tm) then
     begin
       if tm>max then max:=tm;
     end;
   end;
 end;       
end;
function Tsp_XYPlot.FindYAutoMin(WY:Tsp_WhatYAxis; var min:double ):boolean;
var j,k:integer; tm:double;
begin
 Result:=False;
 if fSeries.Count<1 then Exit;
 k:=-1;
 for j:=0 to fSeries.Count-1 do with Tsp_DataSeries(fSeries[j]) do
 begin
   if Active and (YAxis=WY) and GetYMin(min) then
   begin
    k:=j;
    break;
   end;
 end;
 if k > -1 then
 begin
   Result:=True;
   for j:=k+1 to fSeries.Count-1 do with Tsp_DataSeries(fSeries[j]) do
   begin
     if Active and (YAxis=WY) and GetYMin(tm) then
     begin
      if tm<min then min:=tm;
     end;
   end;
 end;       
end;
function Tsp_XYPlot.FindYAutoMax(WY:Tsp_WhatYAxis; var max:double ):boolean;
var j,k:integer; tm:double;
begin
 Result:=False;
 if fSeries.Count<1 then Exit;
 k:=-1;
 for j:=0 to fSeries.Count-1 do with Tsp_DataSeries(fSeries[j]) do
 begin
   if Active and (YAxis=WY) and GetYMax(max) then
   begin
    k:=j;
    break;
   end;
 end;
 if k > -1 then
 begin
   Result:=True;
   for j:=k+1 to fSeries.Count-1 do with Tsp_DataSeries(fSeries[j]) do
   begin
     if Active and (YAxis=WY) and GetYMax(tm) then
     begin
      if tm>max then max:=tm;
     end;
   end;
 end;       
end;
function Tsp_XYPlot.DoAutoMinMax(Axis:Tsp_Axis):boolean;
var WX:Tsp_WhatXAxis; WY:Tsp_WhatYAxis;
    dmin, dmax, gap:double;
    bin, bax:boolean;
begin
 Result:=False;
 if (Axis.fFlags and (sdfAutoMin or sdfAutoMax))=0 then Exit;
 if (Axis.fFlags and sdfVertical)<>0 then
 begin
   if Axis=LA then WY:=dsyLeft else WY:=dsyRight;
   bin:=((Axis.fFlags and sdfAutoMin)<>0) and FindYAutoMin(WY, dmin);
   bax:=((Axis.fFlags and sdfAutoMax)<>0) and FindYAutoMax(WY, dmax);
 end else
 begin
   if Axis=BA then WX:=dsxBottom else WX:=dsxTop;
   bin:=((Axis.fFlags and sdfAutoMin)<>0) and FindXAutoMin(WX, dmin);
   bax:=((Axis.fFlags and sdfAutoMax)<>0) and FindXAutoMax(WX, dmax);
 end;
 if not (bin or bax) then Exit;
 if not bin then dmin:=Axis.Min;
 if not bax then dmax:=Axis.Max;
 gap:=(dmax-dmin)*0.025;
 if bin then dmin:=dmin-gap;                     
 if bax then dmax:=dmax+gap;
 Result:=True;
 with Axis do if (dmin<>Min) or (dmax<>Max)then ChangeMinMax(dmin,dmax);
end;
function Tsp_XYPlot.LimitsStored:boolean;
begin
 Result:=LA.fMinMaxStored and BA.fMinMaxStored and
         RA.fMinMaxStored and TA.fMinMaxStored;
end;
procedure Tsp_XYPlot.StoreLimits;
begin
 if Not LimitsStored then begin
   LA.StoreMinMax; BA.StoreMinMax; RA.StoreMinMax; TA.StoreMinMax;
 end;
end;
procedure Tsp_XYPlot.RestoreLimits;
begin
 if LimitsStored then begin
   LA.RestoreMinMax; BA.RestoreMinMax; RA.RestoreMinMax; TA.RestoreMinMax;
   Invalidate;
 end;
end;
procedure Tsp_XYPlot.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
   WindowClass.style := WindowClass.style and not (CS_HREDRAW or CS_VREDRAW);
end;
procedure Tsp_XYPlot.Notification(AComponent: TComponent; Operation: TOperation);
begin
 inherited Notification(AComponent, Operation);
 if (Operation=opRemove) then begin
   if (AComponent is Tsp_DataSeries) then
   RemoveSeries(AComponent as Tsp_DataSeries);
   if (AComponent is Tsp_PlotMarker) then
   RemoveMarker(AComponent as Tsp_PlotMarker,
                 (AComponent as Tsp_PlotMarker).WhenDraw);
 end;
end;
Const
 zsNone=0; zsZoomStart=1; zsZoomRect=2; zsStartPan=3; zsPaning=4;
function NormRect(var R:TRect):TRect;
begin
 Result:=R;
 with Result do begin
  if R.Left>R.Right then begin Left:=R.Right+1; Right:=R.Left+1; end;
  if R.Top>R.Bottom then begin Top:=R.Bottom+1; Bottom:=R.Top+1 end;
 end;
end;
procedure Tsp_XYPlot.DrawNotRect(R:TRect);
begin
 with Canvas do
 begin
  with Pen do
  begin
   Style:=psDot;
   Color:=clBlack;
   Mode:=pmNotXor;
  end;
  Brush.Color:=clWhite;
  with R do begin
   PolyLine([TopLeft, Point(Right,Top), BottomRight, Point(Left,Bottom),TopLeft]);
  end;
 end;
end;
procedure Tsp_XYPlot.RectToLimits(ZR:TRect; D:Tsp_zpDirections);
 procedure ZoomAxis(A:Tsp_Axis; p1,p2:integer);
 var mi, ma, sw :double; CanZoom:boolean;
 begin
   with A do
   begin
     mi:=P2V(p1); ma:=P2V(p2);
     if mi>ma then begin sw:=mi; mi:=ma; ma:=sw end;
     CanZoom:=True;
     if Assigned(fOnZoom) then fOnZoom(A, mi, ma, CanZoom);
     if CanZoom then ChangeMinMax(mi,ma);
    end;
 end;
begin
  if D=zpdNone then Exit;
  with ZR do begin
    if ((Right-Left)>2) and ((Bottom-Top)>2) then
    begin
      StoreLimits;
      if ((Right-Left)>1) and (D in [zpdHorizontal, zpdBoth]) then begin
        ZoomAxis(BA, Left, Right);
        ZoomAxis(TA, Left, Right);
      end;
      if ((Bottom-Top)>1) and (D in [zpdVertical, zpdBoth]) then begin
        ZoomAxis(LA, Bottom, Top);
        ZoomAxis(RA, Bottom, Top);
      end;
      Invalidate;
    end;     
  end;       
end;
procedure Tsp_XYPlot.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 if (Button = mbLeft) then
 begin
   if (Shift=fZoomShift) and (fZoomEnabled<>zpdNone) and
       (fZoomData.State=zsNone) then  with fZoomData do                 
   begin
       R.Left:=X; R.Top:=Y;
       case fZoomEnabled of
         zpdHorizontal: R.Top:=FR.Top;
         zpdVertical: R.Left:=FR.Left;
        end;
       State:=zsZoomStart;
   end
   else if (Shift=fPanShift) and (fPanEnabled<>zpdNone) and
           (fZoomData.State=zsNone) then  with fZoomData do            
   begin
      R.Left:=X; R.Top:=Y;
      State:=zsStartPan;
      Screen.Cursor := fPanCursor;         
   end;
 end;
 inherited MouseDown(Button, Shift, X, Y);
end;
procedure Tsp_XYPlot.MouseMove(Shift: TShiftState; X, Y: Integer);
  procedure PanPlot(var ZR:TRect; D:Tsp_zpDirections);
  begin
   StoreLimits;
   with ZR do begin
     if ((Right-Left)<>0) and (D in [zpdHorizontal, zpdBoth]) then begin
       with BA do ScrollBy(Right-Left);
       with TA do ScrollBy(Right-Left);
       CustomInvalidate(False,True,True);                       
     end;
     if ((Bottom-Top)<>0) and (D in [zpdVertical, zpdBoth]) then begin
      with LA do ScrollBy(Bottom-Top);
      with RA do ScrollBy(Bottom-Top);
      CustomInvalidate(False,True,True);                       
     end;
   end;       
  end;           
begin            
 if fZoomData.State<>zsNone then with fZoomData do
 case State of
   zsZoomStart: if (abs(R.Left-X)>3) or (abs(R.Top-Y)>3) then
     begin
       State:=zsZoomRect;
       Screen.Cursor := crCross;
       R.Right:=X;  R.Bottom:=Y;
       case fZoomEnabled of
        zpdHorizontal: R.Bottom:=FR.Bottom;
        zpdVertical:   R.Right:=FR.Right;
       end;
       DrawNotRect(R);
     end;
   zsZoomRect :
     begin
       DrawNotRect(R);
       R.Right:=X;  R.Bottom:=Y;
       case fZoomEnabled of
        zpdHorizontal: R.Bottom:=FR.Bottom;
        zpdVertical:   R.Right:=FR.Right;
       end;
       DrawNotRect(R);
     end;
   zsStartPan: with R do
       if (Left<>X) or (Top<>Y) then
       begin
        Right:=Left; Bottom:=Top;                      
        Left:=X; Top:=Y;
        State:=zsPaning;
        PanPlot(R, fPanEnabled);
       end;
   zsPaning : with R do
     begin
       Right:=Left; Bottom:=Top;                      
       Left:=X; Top:=Y;
       PanPlot(R, fPanEnabled);
     end;
 end;       
 inherited MouseMove(Shift, X, Y);
end;            
procedure Tsp_XYPlot.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
 with fZoomData do
 case State of
  zsZoomStart: RestoreLimits;                                                   
  zsZoomRect:            
    begin
      DrawNotRect(R);
      RectToLimits(NormRect(R), fZoomEnabled);
    end;
  zsStartPan:;
  zsPaning:
    begin
    end;
 end;       
 if fZoomData.State<>zsNone then begin
   fZoomData.State:=zsNone;
   Screen.Cursor := Cursor;            
 end;
 inherited MouseUp(Button, Shift, X, Y);
end;
function MaxI(a,b:integer):integer;
begin
 if a>b then Result:=a else Result:=b;
end;
procedure Tsp_XYPlot.Arrange(AvgFntW,FntH:integer);
var BR:TRect;  h,w:integer;
begin
 FR:=Rect(0,0, DWidth, DHeight);
 h:=FntH;
 w:=AvgFntW;                           
 with BR do begin                                  
  Left:=MaxI(LA.BandWidth(w,h), MaxI(BA.OrgIndent(w,h), TA.OrgIndent(w,h)))+LA.Margin;
  Bottom:=MaxI(BA.BandWidth(w,h), MaxI(LA.OrgIndent(w,h), RA.OrgIndent(w,h)))+BA.Margin;
  Right:=MaxI(RA.BandWidth(w,h), MaxI(BA.EndIndent(w,h), TA.EndIndent(w,h)))+RA.Margin;
  Top:=MaxI(TA.BandWidth(w,h), MaxI(LA.EndIndent(w,h), RA.EndIndent(w,h)))+TA.Margin;
 end;
 with FR do begin
  inc(Left,BR.Left);
  dec(Right,BR.Right);
  dec(Bottom,BR.Bottom);
  inc(Top,BR.Top);
  if Left+3>Right then Right:=Left+3;
  if Top+3>Bottom then Bottom:=Top+3;
  LA.SetLine(Left-1, Bottom-1, Bottom-Top-1);
  RA.SetLine(Right,  Bottom-1, Bottom-Top-1);
  BA.SetLine(Left, Bottom, Right-Left-1);
  TA.SetLine(Left, Top-1,  Right-Left-1);
 end;
 ValidArrange:=True;
end;
procedure Tsp_XYPlot.FreshVFont;
var LF:TLogFont; HF:HFont;
begin
 VFont.Assign(Font);
 GetObject(VFont.Handle, SizeOf(LF), @LF);
 with LF do begin
  lfEscapement:=900;
  lfOrientation:= lfEscapement;
  lfWeight:= FW_BOLD;
 end;
 HF:=CreateFontIndirect(LF);
 if HF<>0 then VFont.Handle:=HF;
end;
procedure Tsp_XYPlot.DrawAroundField;
 procedure ClearBack;
 begin
  with DCanvas do
  begin
   Brush.Style:=bsSolid;
   Brush.Color:=Self.Color;
   FillRect(Rect(0, 0, DWidth, FR.Top));                            
   FillRect(Rect(0, FR.Bottom+1, DWidth, DHeight));                    
   FillRect(Rect(0, FR.Top, FR.Left, FR.Bottom+1));                  
   FillRect(Rect(FR.Right, FR.Top, DWidth, FR.Bottom+1));             
  end;
 end;
 procedure DrawAxises;
 var co,ce:word; x,y:integer;                     
 begin
  DCanvas.Brush.Style:=bsClear;
  with RA.LineAttr do
   if Visible  then ce:=Width else ce:=0;                                  
  TA.DrawLine(DCanvas,0,ce);
  with BA.LineAttr do
   if Visible  then co:=Width else co:=0;
  RA.DrawLine(DCanvas,co,0);
  with LA.LineAttr do
   if Visible  then co:=Width else co:=0;                          
  BA.DrawLine(DCanvas,co,0);
  with TA.LineAttr do
   if Visible  then ce:=Width else ce:=0;;
  LA.DrawLine(DCanvas,0,ce);
  with DCanvas.Pen do
  begin
    Mode:=pmCopy;
    Style:=psSolid;
    Color:=Font.Color;
    Width:=1;
  end;
  DCanvas.Font:=(Font);
  TA.DrawTicks(DCanvas);
  RA.DrawTicks(DCanvas);
  LA.DrawTicks(DCanvas);
  BA.DrawTicks(DCanvas);
  with DCanvas do
  begin
    if BA.fDrawCaption then with BA do
    begin
     Font.Style:=Font.Style+[fsBold];     
     x:=(FieldRect.Right+FieldRect.Left-TextWidth(fCaption)) div 2;
     y:=fDHeight-Margin;
     TextOut(x,y,fCaption)
    end;
    if TA.fDrawCaption then with TA do
    begin
     x:=(FieldRect.Right+FieldRect.Left-TextWidth(fCaption)) div 2;
     y:=Margin-1-TextHeight('8');
     TextOut(x,y,fCaption)
    end;
    if LA.fDrawCaption or RA.fDrawCaption then
    begin
     DCanvas.Font.Assign(VFont);
     if LA.fDrawCaption then with LA do
     begin
      y:=(FieldRect.Bottom+FieldRect.Top+TextWidth(fCaption)) div 2;
      x:=Margin-1-TextHeight('8');
      TextOut(x,y,fCaption)
     end;
     if RA.fDrawCaption then with RA do
     begin
      y:=(FieldRect.Bottom+FieldRect.Top+TextWidth(fCaption)) div 2;
      x:=fDWidth-Margin;
      TextOut(x,y,fCaption)
     end;
     DCanvas.Font:=Font;
    end;
  end;
 end;
begin                      
 ClearBack;
 DrawAxises;
 DrawBorder;
end;                       
procedure Tsp_XYPlot.DrawBorder;
var R:TRect;
begin
 R:=Rect(0,0,dWidth,dHeight);
 with DCanvas do
 begin
   Brush.style:= bsClear;
   with Pen do begin
     Style:= psSolid;                      
     Mode:=pmCopy;
   end;
   with R do rectangle(left+1, top+1, right-1, bottom-1);
    case fFrameStyle of
      bs_None: with R do begin
         Pen.Color:= Self.Color;
         rectangle(left, top, right, bottom);
         rectangle(left+1, top+1, right-1, bottom-1);
       end;
      bs_Raised : with R do begin
         Frame3D(DCanvas, R, clBtnHighlight, clBtnShadow,1);
         Pen.Color:= Self.Color;
         rectangle(left, top, right, bottom);
        end;
      bs_Lowered: with R do begin
         Frame3D(DCanvas, R, clBtnShadow, clBtnHighlight,1);
         Pen.Color:= Self.Color;
         rectangle(left, top, right, bottom);
        end;
      bs_Gutter : with R do begin
         Pen.Color := clBtnHighlight;
         rectangle(left + 1, top + 1, right, bottom);
         Pen.Color := clBtnShadow;
         rectangle(left, top, right - 1, bottom - 1);
        end;
      bs_BlackRect: with R do begin
         Pen.Color := clBlack;
         rectangle(left, top, right, bottom);
         Pen.Color:= Self.Color;
         rectangle(left+1, top+1, right-1, bottom-1);
        end;
      bs_BoldRect: with R do begin
         Pen.Color := clBlack;
         rectangle(left, top, right, bottom);
         rectangle(left+1, top+1, right-1, bottom-1);
        end;
      bs_FocusRect: begin
         Brush.Style:= bsSolid;  Brush.Color:= clWhite;
         Pen.Style  := psDot;    Pen.Color  := clBlack;
         with R do polyline([point(left,top),point(right-2,top),
                  point(right-2,bottom-1),point(left+1,bottom-1),point(left+1,top)]);
         with R do polyline([point(left+1,top+1),point(right-1,top+1),
                  point(right-1,bottom-2),point(left,bottom-2),point(left,top)]);
        end;
    end;
 end;
end;             
procedure Tsp_XYPlot.DoOnFieldDraw;
begin
 if Assigned(fFieldDraw) then fFieldDraw(Self);
end;
procedure Tsp_XYPlot.DrawField;
  procedure DrawFieldBack;
  var j:integer;
  begin
   with DCanvas do
   begin
    Brush.Style:=bsSolid;
    Brush.Color:=FBColor;
    if FBColor<>clNone then begin
      Brush.Style:=bsSolid;
      Brush.Color:=FBColor;
      FillRect(Rect(FR.Left,FR.Top,FR.Right,FR.Bottom));
    end;
    DoOnFieldDraw;
    Brush.Style:=bsClear;
    with LA do if GridAttr.Visible and (TicksCount>0) then
    begin
      GridAttr.SetPenAttr(Pen);
      for j:=0 to TicksCount-1 do
      with FR do if (fTksPos[j]>Top) and (fTksPos[j]<Bottom-1) then
      begin
       MoveTo(Left,fTksPos[j]);
       LineTo(Right,fTksPos[j]);
      end;
    end;
    with BA do if GridAttr.Visible and (TicksCount>0) then
    begin
      GridAttr.SetPenAttr(Pen);
      for j:=0 to TicksCount-1 do
      with FR do if (fTksPos[j]>Left) and (fTksPos[j]<Right-1) then
      begin
       MoveTo(fTksPos[j],Top);
       LineTo(fTksPos[j],Bottom);
      end;
    end;
    with RA do if GridAttr.Visible and (TicksCount>0) then
    begin
      GridAttr.SetPenAttr(Pen);
      for j:=0 to TicksCount-1 do
      with FR do if (fTksPos[j]>Top) and (fTksPos[j]<Bottom-1) then
      begin
       MoveTo(Left,fTksPos[j]);
       LineTo(Right,fTksPos[j]);
      end;
    end;
    with TA do if GridAttr.Visible and (TicksCount>0) then
    begin
      GridAttr.SetPenAttr(Pen);
      for j:=0 to TicksCount-1 do
      with FR do if (fTksPos[j]>Left) and (fTksPos[j]<Right-1) then
      begin
       MoveTo(fTksPos[j],Top);
       LineTo(fTksPos[j],Bottom);
      end;
    end;
   end;
  end;
  procedure DrawBMarkers;
  var j:integer;
  begin
   with fBSML do
    for j:=0 to Count-1 do
      with Tsp_PlotMarker(Items[j]) do if Visible then Draw;
  end;
  procedure DrawAMarkers;
  var j:integer;
  begin
   with fASML do
    for j:=0 to Count-1 do
      with Tsp_PlotMarker(Items[j]) do if Visible then Draw;
  end;
  procedure DrawSeries;
  var j:integer;
  begin
   if fSeries.Count>0 then
    for j:=0 to fSeries.Count-1 do with Tsp_DataSeries(fSeries[j]) do
     if Active then Draw;
  end;
var CR:TRect; ClipRgn: HRgn;
begin                 
 CR:=DCanvas.ClipRect;
 with FR do IntersectClipRect(DCanvas.Handle, Left, Top, Right, Bottom);
 DrawFieldBack;
 DrawBMarkers;
 DrawSeries;
 DrawAMarkers;
 begin
   ClipRgn :=CreateRectRgnIndirect(CR);
   SelectClipRgn(DCanvas.Handle, ClipRgn);
   DeleteObject(ClipRgn);
 end;
end;                     
procedure Tsp_XYPlot.DoOnDrawEnd;
begin
 if Assigned(fDrawEnd) then fDrawEnd(Self);
end;
procedure Tsp_XYPlot.pDrawPlot;
begin
 if Not ValidArrange then begin
   DCanvas.Font:=Font;
   Arrange(DCanvas.TextWidth('0'), abs(Font.Height));
 end;
 DrawAroundField;
 DrawField;
 DoOnDrawEnd;
 DrawBorder;
end;
procedure Tsp_XYPlot.DrawPlot;                                
begin
 if Not Assigned(DC) or (W<10) or (H<10) then Exit;
 fDCanvas:=DC;
 fDwidth:=W;
 fDHeight:=H;
 ValidArrange:=False;
 try
   pDrawPlot;       
 finally
   ValidArrange:=False;          
   fDwidth:=Width;
   fDHeight:=Height;
   fDCanvas:=Canvas;
 end;
end;
procedure Tsp_XYPlot.Invalidate;
begin
 ValidArrange:=False;
 ValidAround:=False;
 ValidField:=False;
 inherited;
end;
procedure Tsp_XYPlot.CustomInvalidate(Arrange, Around, Field :boolean);
begin
 if Arrange then ValidArrange:=False;
 if Around then ValidAround:=False;
 if Field then ValidField:=False;
 inherited Invalidate;
end;
procedure Tsp_XYPlot.BufferIsInvalid;
begin
 ValidAround:=False;
 ValidField:=False;
end;
procedure Tsp_XYPlot.InvalidateSeries(DS:Tsp_DataSeries);
var X,Y:Tsp_Axis;  B:boolean;
begin
 if Not Assigned(DS) then Exit;
 with DS do begin
   if XAxis=dsxBottom then X:=BA else X:=TA;
   if YAxis=dsyLeft then Y:=LA else Y:=RA;
 end;
 B:=DoAutoMinMax(X);
 B:=DoAutoMinMax(Y) or B;
 if B then Invalidate
 else CustomInvalidate(False, False, True);
end;                     
procedure Tsp_XYPlot.Paint;
begin
 fDWidth:=Width; fDHeight:=Height;
 if fBuffered and fDDBBuf.Valid then
 begin
   if (Width<>fDDBBuf.Width) or (Height<>fDDBBuf.Height) then
   begin
     fDDBBuf.Recreate(Width, Height);
     if Not fDDBBuf.Valid then begin pDrawPlot; Exit end;           
     ValidArrange:=False;
     ValidAround:=False; ValidField:=False;
   end;
   fDCanvas:=fDDBBuf.Canvas;
   try
     if Not ValidArrange then begin
       DCanvas.Font:=Font;
       Arrange(DCanvas.TextWidth('0'), abs(Font.Height));
     end;
     if Not ValidAround then begin
       DrawAroundField;
       ValidAround:=True;
     end;
     if Not ValidField then begin
       DrawField;
       ValidField:=True;
     end;
     DoOnDrawEnd;
     DrawBorder;
   finally
      fDCanvas:=Canvas;
   end;
   BitBlt(Canvas.Handle, 0, 0, Width, Height,
           fDDBBuf.Canvas.Handle, 0, 0, SRCCOPY)
 end else pDrawPlot;           
 DrawXCursorOnPaint;
end;
procedure Tsp_XYPlot.CopyToClipboardMetafile;
var EMF :TMetafile; MC:TMetafileCanvas;
begin
 EMF := TMetafile.Create;
 try
   EMF.Width:=Width;
   EMF.Height:=Height;
   MC:=TMetafileCanvas.Create(EMF, Canvas.Handle);
   try
     DrawPlot(MC, Width, Height);
   finally
     MC.Free;
   end;
   Clipboard.Assign(EMF);
 finally
  EMF.Free;
 end;
end;
procedure Tsp_XYPlot.CopyToClipboardBitmap;
var BMP :TBitmap;
begin
 BMP := TBitmap.Create;
 BMP.Width:=Width;
 BMP.Height:=Height;
 try
   DrawPlot(BMP.Canvas, Width, Height);
   Clipboard.Assign(BMP);
 finally
   BMP.Free;
 end;
end;
constructor Tsp_XYPlot.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
 ControlStyle := [csCaptureMouse, csClickEvents,
     csSetCaption, csOpaque, csDoubleClicks];                     
 LA:=Tsp_Axis.Create(sdfVertical);
 with LA do begin
  fGrid.Visible:=True;
  fPlot:=Self;                                             
 end;
 RA:=Tsp_Axis.Create(sdfVertical or sdfRevertTicks or sdfNoTicks or sdfNoTicksLabel);
 RA.fPlot:=Self;
 BA:=Tsp_Axis.Create(0) ;
 with BA do begin
  fGrid.Visible:=True;
  fPlot:=Self;
 end;
 TA:=Tsp_Axis.Create(sdfRevertTicks or sdfNoTicks or sdfNoTicksLabel);
 TA.fPlot:=Self;
 VFont:=TFont.Create;
 fDCanvas:=Canvas;
 fBuffered:=False;
 fDDBBuf:=nil;
 fSeries:=TList.Create;
 fBSML:=TList.Create;
 fASML:=TList.Create;
 Color := clBtnFace;
 FBColor:=clWhite;                               
 fZoomEnabled:=zpdBoth;
 fPanEnabled:=zpdBoth;
 ZoomShiftKeys:=[ssShift];
 PanShiftKeys:=[ssCtrl];
 ValidAround:=False;
 ValidField:=False;
 fDWidth:=180;     fDHeight:=120;
 Width := fDWidth; Height := fDHeight;
 ValidArrange:=False;
 FreshVFont;
end;
destructor Tsp_XYPlot.Destroy;
begin
 if Assigned(fBSML) then fBSML.Free;
 if Assigned(fASML) then fASML.Free;
 if Assigned(fSeries) then fSeries.Free;
 if Assigned(fDDBBuf) then fDDBBuf.Free; 
 if Assigned(VFont) then VFont.Free;
 if Assigned(TA) then TA.Free;
 if Assigned(BA) then BA.Free;
 if Assigned(LA) then LA.Free;
 if Assigned(RA) then RA.Free;
 inherited Destroy;
end;
END.
