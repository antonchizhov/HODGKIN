unit sgr_data;
{(c) S.P.Pod'yachev 1998-1999}
{ver. 2.3 28.10.1999}
{***************************************************}
{ Example of series for Tsp_xyPlot                  }
{                                                   }
{***************************************************}

interface
uses
  Windows, SysUtils,  Classes,  Graphics, Variants,
  sgr_scale, sgr_def;

Type

{*** Tsp_XYDataSeries ***}

//ancestor of my data series
//has storage for x, y data and maintains main method & properties for it
Tsp_XYDataSeries=class(Tsp_DataSeries)
protected
  //canvas where draw
  fCanvas:TCanvas;
  //capacity & points number service
  fPN:integer;        //number of valid data elements (x,y points)
  fCapacity:integer;  //reserved memory in number of data elements
  fInc:integer;       //step of expand increment of allocated memory
  //
  XV: Variant;        //storage for X values
  YV: Variant;        //storage for Y values
  //Max Min service
  XMin,XMax,            //Min & Max of data
  YMin,YMax: double;
  ValidMinMax:boolean;  //used to minimise MinMax calculating
  //Draw attributes
  fLineAttr:Tsp_LineAttr; //line attribute
  //control service
  fLockInvalidate:boolean; //lock invalidate plot while data are changing

  //if can invalidate Plot then return True
  function CanPlot:boolean;
  //if it is possible then immediately redraw plot to reflect changes
  procedure TryUpdatePlot;
  //used in several procedures when data are added
  procedure TryUpdateMinMax(aX,aY:double);

  //increase allocated memory size by fInc
  procedure Expand;
  //increase allocated memory size by IncSize
  procedure ExpandBy(IncSize:integer);
  //find Min & Max of data of series;
  procedure FindMinMax;
  //stop invalidate or force invalidate plot
  procedure SetLockInvalidate(const V:boolean);
  //attributes change
  procedure SetLineAttr(const V:Tsp_LineAttr);
  procedure AtrributeChanged(V:TObject); virtual;

public //Tsp_XYDataSeries
  constructor Create(AOwner:TComponent); override;
  destructor Destroy; override;
  //next 4 functions must be implemented for any series
  function GetXMin(var V:double):boolean; override;
  function GetXMax(var V:double):boolean; override;
  function GetYMin(var V:double):boolean; override;
  function GetYMax(var V:double):boolean; override;
  //this one does not clear memory, only set Count=0 and update Plot,
  //use AdjustCapacity after Clear, or SetCapacity(0) instead of Clear to free memory
  procedure Clear;
  //set minimum Capacity for current Count
  procedure AdjustCapacity;
  //use it if you know how many elements data will have and don't want to loose
  //time on auto expand when add data. If series is not empty and C less then
  //Count of data elements they will be truncated to fit capacity
  procedure SetCapacity(C:integer);
  //add values at the end of series data and update Plot
  procedure AddXY(aX,aY:double);
  //used to add many values at the end of series data and update Plot
  //pX, pY must points to array of double, n - number of elements in arrays
  procedure AddXYArrays(pX,pY:pointer; n:integer);
  //insert values at index i, shift rest to end
  procedure InsertXY(i:integer; aX,aY:double);
  //replace values at index i
  procedure ReplaceXY(i:integer; aX,aY:double);
  //Delete values at index i
  procedure Delete(i:integer);
  //Delete values with indexes from fromi up to toi
  procedure DeleteRange(fromi, toi:integer);
  //current memory allocation for data elements (for example number of points)
  property Capacity:integer read fCapacity;
  //current number of valid data elements (for example number of points)
  property Count:integer read fPN;
  //lock invalidate plot while data are changing and then unlock it
  property LockInvalidate:boolean read fLockInvalidate write setLockInvalidate;
  //
  property Canvas:TCanvas read fCanvas write fCanvas;
published
  //if True then series is visible and taken into account in AutoMin & AutoMax
  property Active default True;
end;


{*** Type for series points drawing ***}

TPointKind=(ptRectangle, ptEllipse, ptDiamond, ptCross, ptCustom,
            ptTriangle, ptDownTriangle);

{*** Tsp_PointAttr ***}

//holds points markers properties
Tsp_PointAttr=class(TBrush)
private
  fPointType:TPointKind;
  fHSize,  fVSize :integer;  //even half of horiz. & vert. point size
  fHSize1, fVSize1:integer;  //odd half of horiz. & vert. point size
  fVisible: boolean;
  fBorderWidth:integer;
  fBorderColor:TColor;
protected
  procedure SetType(const V:TPointKind);
  procedure SetVisible(const V:boolean);
  procedure SetHSize(V:integer);
  procedure SetVSize(V:integer);
  function  GetHSize:integer;
  function  GetVSize:integer;
  procedure SetBorderWidth(V:integer);
  procedure SetBorderColor(const V:TColor);
public
  constructor Create;
  procedure SetPenAttr(const APen:TPen);
  procedure Assign(Source: TPersistent); override;
  property eHSize:integer read fHSize;
  property oHSize:integer read fHSize1;
  property eVSize:integer read fVSize;
  property oVSize:integer read fVSize1;
  //is points are drawn
published
  //kind of point
  property Kind:TPointKind read fPointType write SetType;
  //horizontal size of Point
  property HSize:integer read GetHSize write SetHSize default 5;
  //vertical size of Point
  property VSize:integer read GetVSize write SetVSize default 5;
  //is points are drawn
  property Visible:boolean read fVisible write SetVisible;
  //points border width (pen)
  property BorderWidth:integer read fBorderWidth write SetBorderWidth default 1;
  //points border color (pen)
  property BorderColor:TColor read fBorderColor write SetBorderColor default clBlack;
end;

//type of darw point procedure
TDrawPointProc=procedure (const x, y: Integer) of object;

Tsp_XYLine=class;

//event to draw custom points
TDrawCustomPointEvent=procedure
(const XYLine:Tsp_XYLine; const xv,yv :double; x, y: Integer) of object;

{*** Tsp_XYLine ***}

//draw data as points and/or chain of line segments
Tsp_XYLine=class(Tsp_XYDataSeries)
protected
  fPA:Tsp_PointAttr;
  fDLM:boolean; //DrawingLegendMarker
  DrawPointProc:TDrawPointProc;
  fOnDrawCustomPoint:TDrawCustomPointEvent;
  procedure SetPointAttr(const V:Tsp_PointAttr);
  procedure AtrributeChanged(V:TObject); override;
  procedure DrawRect(const x, y: Integer);
  procedure DrawEllipse(const x, y: Integer);
  procedure DrawDiamond(const x, y: Integer);
  procedure DrawCross(const x, y: Integer);
  procedure DrawTriangle(const x, y: Integer);
  procedure DrawDownTriangle(const x, y: Integer);
public
  constructor Create(AOwner:TComponent); override;
  destructor Destroy; override;
  //implements series draw procedure
  procedure Draw; override;
  //implements series draw marker procedure
  procedure DrawLegendMarker(const LCanvas:TCanvas; MR:TRect); override;
  //add values at end like AddXY, but don't spend time to update Plot, instead
  //simply draw next line segment, therefore AutoMin and AutoMax are ignored
  procedure QuickAddXY(aX,aY:double); virtual;
  //to access to data
  function GetX(i:integer):double;
  function GetY(i:integer):double;
  property DrawingLegendMarker:boolean read fDLM; //true when DrawLegendMarker
published
  //defines is draw & how lines segments between points
  property LineAttr:Tsp_LineAttr read fLineAttr write SetLineAttr;
  //defines is draw & how lines points marker
  property PointAttr:Tsp_PointAttr read fPA write SetPointAttr;
  //if assigned caled to draw point with Kind=ptCustom
  property OnDrawCustomPoint:TDrawCustomPointEvent read fOnDrawCustomPoint
                                                   write fOnDrawCustomPoint;
end;


{*** Tsp_SpectrLines ***}

Tsp_SpectrLines=class;

Tsp_YOrigin=(yoBaseLine, yoXAxises);

Tsp_WhatValues=(wvXValues, wvYValues);

Tsp_GetLabelEvent=procedure(Sender: Tsp_SpectrLines;
                         Num: integer;  //point number
                         X, Y : double; //points values
                         var LS:string) of object;   //label string

//draw data as bar with center at XV pos. and height from Bottom
//axis to YV or from BaseLine to YV;
Tsp_SpectrLines=class(Tsp_XYDataSeries)
private
  fBaseValue:double;
  fYOrigin:Tsp_YOrigin;
  fOnGetLabel: Tsp_GetLabelEvent; //customize label format handler
  fLabelFormat: string;       //format string for line label
  fLFont:TFont;               //label font
  fLVisible:boolean;          //is label visible
  fWhatValues:Tsp_WhatValues; //what values x or y use for label
  fBLVisible:boolean;         //is base line visible
  procedure SetBaseValue(V:double);
  procedure SetYOrigin(V:Tsp_YOrigin);
  procedure SetWhatValues(V:Tsp_WhatValues);
  procedure SetLabelFormat(const V:string);
  procedure SetLFont(V:TFont);
  procedure SetLVisible(const V:boolean);
  procedure SetBLVisible(const V:boolean);
public
  constructor Create(AOwner:TComponent); override;
  destructor Destroy; override;
  procedure Draw;override;
  function GetYMin(var V:double):boolean; override;
  function GetYMax(var V:double):boolean; override;
published
  //if YOrigin=yoBaseLine then lines begin from BaseValue
  property BaseYValue:double read fBaseValue write SetBaseValue;
  //define how lines are drawn
  property LineAttr:Tsp_LineAttr read fLineAttr write SetLineAttr;
  //if YOrigin=yoBaseLine then lines begin from BaseValue else from X Axis
  property YOrigin:Tsp_YOrigin read fYOrigin write SetYOrigin;
  //define X or Y values used in labels near spectral line
  property LabelValues:Tsp_WhatValues read fWhatValues write SetWhatValues;
  //format string to convert values to label text (template for FloatToStrF)
  property LabelFormat: string read fLabelFormat write SetLabelFormat;
  property LabelFont:TFont read fLFont write SetLFont;
  //show or not value label near line
  property ShowLabel:boolean read fLVisible write SetLVisible;
  //draw horizontal line at BaseYValue
  property ShowBaseLine:boolean read fBLVisible write SetBLVisible default True;
  //customize label format handler
  property OnGetLabel: Tsp_GetLabelEvent read fOnGetLabel write fOnGetLabel;
end;


IMPLEMENTATION

Type
 TDbls=array [0..MaxInt div 16] of double;
 pDbls= ^TDbls;
 TLP=array[0..MaxInt div 16] of TPoint;
 pLP= ^TLP;


{*** Tsp_XYDataSeries ***}

constructor Tsp_XYDataSeries.Create(AOwner:TComponent);
begin
 inherited Create(AOwner); 
 fInc:=32;
 XV:=VarArrayCreate([0, fInc], varDouble);
 YV:=VarArrayCreate([0, fInc], varDouble);
 fCapacity:=VarArrayHighBound(XV,1);
 fPN:=0;
 XMin:=5.0E-324; XMax:=1.7E308;
 YMin:=5.0E-324; YMax:=1.7E308;
 ValidMinMax:=False;
 fActive:=True;
 if csDesigning in ComponentState then
   while fPN<10 do AddXY(fPN, 1+2*(fPN mod 5)+Random(2));
 fLineAttr:=Tsp_LineAttr.Create;
 fLockInvalidate:=False;
 fLineAttr.OnChange:=AtrributeChanged;
end;

destructor Tsp_XYDataSeries.Destroy;
begin
 if Assigned(fLineAttr) then
 begin
   fLineAttr.OnChange:=nil;
   fLineAttr.Free
 end;
 inherited;
end;

function Tsp_XYDataSeries.CanPlot:boolean;
begin
 Result:=Not(fLockInvalidate) and Assigned(Plot);
end;

procedure Tsp_XYDataSeries.TryUpdatePlot;
begin
 if Not(fLockInvalidate) and Assigned(Plot) then
 begin
   InvalidatePlot(rsDataChanged);
   Plot.Update;                //call to redraw immediately
 end;
end;

procedure Tsp_XYDataSeries.TryUpdateMinMax(aX,aY:double);
begin
 if fPN=0 then begin
   XMin:=aX; XMax:=aX;
   YMin:=aY; YMax:=aY;
   ValidMinMax:=True;
 end
 else if ValidMinMax then begin
   if aX<XMin then XMin:=aX
   else if aX>XMax then XMax:=aX;
   if aY<YMin then YMin:=aY
   else if aY>YMax then YMax:=aY;
 end;
end;

procedure Tsp_XYDataSeries.Expand;
begin
 VarArrayRedim(XV, fCapacity+fInc);
 VarArrayRedim(YV, fCapacity+fInc);
 fCapacity:=VarArrayHighBound(XV,1);
end;

procedure Tsp_XYDataSeries.ExpandBy(IncSize:integer);
begin
 IncSize:=((IncSize div fInc)+1)*fInc;
 VarArrayRedim(XV, fCapacity+IncSize);
 VarArrayRedim(YV, fCapacity+IncSize);
 fCapacity:=VarArrayHighBound(XV,1);
end;

procedure Tsp_XYDataSeries.FindMinMax;
var pdX, pdY:pDbls; j:integer;
begin
 if fPN<1 then Exit;  //Exception
 pdX:=VarArrayLock(XV);
 pdY:=VarArrayLock(YV);
 try
  XMin:=pdX^[0]; XMax:=XMin;
  YMin:=pdY^[0]; YMax:=YMin;
  for j:=1 to fPN-1 do begin
    if pdX[j]<XMin then XMin:=pdX[j]
    else if pdX[j]>XMax then XMax:=pdX[j];
    if pdY[j]<YMin then YMin:=pdY[j]
    else if pdY[j]>YMax then YMax:=pdY[j];
  end;
  ValidMinMax:=True;
 finally
  VarArrayUnlock(YV);
  VarArrayUnlock(XV);
 end;
end;

procedure Tsp_XYDataSeries.SetLockInvalidate(const V:boolean);
begin
 if fLockInvalidate<>V then
 begin
   fLockInvalidate:=V;
   if CanPlot then InvalidatePlot(rsDataChanged)
 end;
end;

procedure Tsp_XYDataSeries.SetLineAttr(const V:Tsp_LineAttr);
begin
 if Not fLineAttr.IsSame(V) then begin
   fLineAttr.Assign(V);
 end;
end;

procedure Tsp_XYDataSeries.AtrributeChanged;
begin
 if CanPlot then InvalidatePlot(rsAttrChanged);
end;

//*******

function Tsp_XYDataSeries.GetXMin;
begin
 Result:=Count>0;
 if Result then
 begin
   if Not(ValidMinMax) then FindMinMax;
   V:=XMin;
 end;
end;

function Tsp_XYDataSeries.GetXMax;
begin
 Result:=Count>0;
 if Result then
 begin
   if Not(ValidMinMax) then FindMinMax;
   V:=XMax;
 end;
end;

function Tsp_XYDataSeries.GetYMin;
begin
 Result:=Count>0;
 if Result then
 begin
   if Not(ValidMinMax) then FindMinMax;
   V:=YMin;
 end;
end;

function Tsp_XYDataSeries.GetYMax;
begin
 Result:=Count>0;
 if Result then
 begin
   if Not(ValidMinMax) then FindMinMax;
   V:=YMax;
 end;
end;

procedure Tsp_XYDataSeries.Clear;
begin
 if Active and (fPN>0) then
 begin
   fPN:=0;
   if CanPlot then InvalidatePlot(rsDataChanged)
 end
 else fPN:=0;
end;

procedure Tsp_XYDataSeries.AdjustCapacity;
var n:integer;
begin
 n:=((fPN div fInc) +1)*fInc;
 if n<>fCapacity then
 begin
   VarArrayRedim(XV, n);
   VarArrayRedim(YV, n);
   fCapacity:=VarArrayHighBound(XV,1);
 end;
end;

procedure Tsp_XYDataSeries.SetCapacity(C:integer);
var n:integer;
begin
 if C<fPN then   //truncate data if Capacity less then Count
 begin
   fPN:=C;
   AdjustCapacity;
   ValidMinMax:=False;   //added 28.10.1999
   if CanPlot then InvalidatePlot(rsDataChanged);
 end
 else
 begin
   n:=((C div fInc) +1)*fInc;
   if n<>fCapacity then begin
     VarArrayRedim(XV, n);
     VarArrayRedim(YV, n);
     fCapacity:=VarArrayHighBound(XV,1);
   end;
 end;
end;

procedure Tsp_XYDataSeries.AddXY(aX,aY:double);
begin
 if fPN >= fCapacity then Expand;
 XV[fPN]:=aX;  YV[fPN]:=aY;
 TryUpdateMinMax(aX,aY);
 inc(fPN);
 TryUpdatePlot;      //try to redraw changes immediately
end;

procedure Tsp_XYDataSeries.AddXYArrays(pX,pY:pointer; n:integer);
var pdX, pdY:pDbls; j:integer;
begin
 if n<=0 then Exit;
 if (fPN+n) >= fCapacity then ExpandBy(n);
 j:=n*SizeOf(Double);
 pdX:=VarArrayLock(XV);
 pdY:=VarArrayLock(YV);
 try
  System.Move(pX^,pdX^[fPN],j);
  System.Move(pY^,pdY^[fPN],j);
  j:=fPN;
  inc(fPN,n);        //do not win essential time if n>old_fPN
  if ValidMinMax and (n<2*j) then //rewrite at 27.10.1999
   for j:=j to fPN-1 do begin
     if pdX[j]<XMin then XMin:=pdX[j]
     else if pdX[j]>XMax then XMax:=pdX[j];
     if pdY[j]<YMin then YMin:=pdY[j]
     else if pdY[j]>YMax then YMax:=pdY[j];
   end
  else ValidMinMax:=False;
 finally
  VarArrayUnlock(YV);
  VarArrayUnlock(XV);
 end;
 if CanPlot then InvalidatePlot(rsDataChanged); //? may be update  immediately
end;

procedure Tsp_XYDataSeries.InsertXY(i:integer; aX,aY:double);
var pdX, pdY:pDbls; j:integer;
begin
 if (i>fPN) or (i<0) then Exit;  //Exception
 if i=fPN then AddXY(ax,ay)
 else begin
   j:=(fPN-i)*SizeOf(Double);
   if fPN >= fCapacity then Expand;
   pdX:=VarArrayLock(XV);
   pdY:=VarArrayLock(YV);
   try
    System.Move(pdX^[i],pdX^[i+1],j);
    System.Move(pdY^[i],pdY^[i+1],j);
    pdX[i]:=aX;    pdY[i]:=aY;
    TryUpdateMinMax(aX,aY);
    inc(fPN);
   finally
    VarArrayUnlock(YV);
    VarArrayUnlock(XV);
   end;
 end;
 TryUpdatePlot;      //try to redraw changes immediately
end;

procedure Tsp_XYDataSeries.ReplaceXY(i:integer; aX,aY:double);
begin
 if (i>=fPN) or (i<0) then Exit; //Exception //? may be raise Exception
 XV[i]:=aX; YV[i]:=aY;
 ValidMinMax:=False;
 TryUpdatePlot;      //try to redraw changes immediately
end;

procedure Tsp_XYDataSeries.Delete(i:integer);
var pdX, pdY:pDbls; j:integer;
begin
 if (i>=fPN) or (i<0) then Exit;  //Exception
 ValidMinMax:=False;
 if i=fPN-1 then dec(fPN)
 else begin
   j:=(fPN-i-1)*SizeOf(Double);
   //if fPN >= fCapacity then Expand;
   pdX:=VarArrayLock(XV);
   pdY:=VarArrayLock(YV);
   try
    System.Move(pdX^[i+1],pdX^[i],j);
    System.Move(pdY^[i+1],pdY^[i],j);
    dec(fPN);
   finally
    VarArrayUnlock(YV);
    VarArrayUnlock(XV);
   end;
 end;
 TryUpdatePlot;      //try to redraw changes immediately
end;

procedure Tsp_XYDataSeries.DeleteRange(fromi, toi:integer);
var pdX, pdY:pDbls; j:integer;
begin
 if fromi>toi then begin       //swap if need
   j:=fromi; fromi:=toi; toi:=j;
 end;
 if (fromi>=fPN) or (fromi<0) then Exit;  //Exception
 ValidMinMax:=False;
 if toi>=fPN-1 then begin
   fPN:=fromi;
   Exit;
 end;
 j:=(fPN-toi)*SizeOf(Double);
 dec(fPN,(toi-fromi+1));
 pdX:=VarArrayLock(XV);
 pdY:=VarArrayLock(YV);
 try
   System.Move(pdX^[toi+1],pdX^[fromi],j);
   System.Move(pdY^[toi+1],pdY^[fromi],j);
 finally
   VarArrayUnlock(YV);
   VarArrayUnlock(XV);
 end;
 TryUpdatePlot;      //try to redraw changes immediately
end;


{*** Tsp_PointAttr ***}

constructor Tsp_PointAttr.Create;
begin
 inherited;
 fVSize:=2; fVSize1:=3;
 fHSize:=2; fHSize1:=3;
 fBorderColor:=clBlack;
 fBorderWidth:=1;
end;

procedure Tsp_PointAttr.SetPenAttr(const APen:TPen);
begin
 with APen do begin
   Color:=fBorderColor;
   Width:=fBorderWidth;
   Style:=psSolid;
   Mode:=pmCopy;
 end;
end;

procedure Tsp_PointAttr.SetType(const V:TPointKind);
begin
 if fPointType<>V then
 begin
   fPointType:=V;
   Changed;
 end;
end;

procedure Tsp_PointAttr.SetVisible(const V:boolean);
begin
 if fVisible<>V then
 begin
  fVisible:=V;
  Changed;
 end;
end;

procedure Tsp_PointAttr.Assign(Source: TPersistent);
var ss: Tsp_PointAttr;
begin
 if Source is Tsp_PointAttr then begin
   ss:=Source as Tsp_PointAttr;
   fPointType:=ss.fPointType;   fVisible:=ss.fVisible;
   HSize:=ss.HSize; VSize:=ss.VSize;
 end;
 inherited Assign(Source);
end;

procedure Tsp_PointAttr.SetHSize(V:integer);
begin
 if V<0 then V:=1;
 V:=V div 2;
 if eHSize<>V then begin
   fHSize:=V;    fHSize1:=V+1;
   Changed;
 end;
end;

procedure Tsp_PointAttr.SetVSize(V:integer);
begin
 if V<0 then V:=1;
 V:=V div 2;
 if eVSize<>V then begin
   fVSize:=V;   fVSize1:=V+1;
   Changed;
 end;
end;

function Tsp_PointAttr.GetHSize:integer;
begin
 Result:=fHSize+fHSize1;
end;

function Tsp_PointAttr.GetVSize:integer;
begin
 Result:=fVSize+fVSize1;
end;

procedure Tsp_PointAttr.SetBorderWidth(V:integer);
begin
 if V<0 then V:=1;
 if V>fHSize then V:=fHSize;
 if V>fVSize then V:=fVSize;
 if fBorderWidth<>V then begin
   fBorderWidth:=V;
   Changed;
 end;
end;

procedure Tsp_PointAttr.SetBorderColor(const V:TColor);
begin
 if fBorderColor<>V then begin
   fBorderColor:=V;
   Changed;
 end;
end;


{*** Tsp_XYLine ***}

constructor Tsp_XYLine.Create(AOwner:TComponent);
begin
 inherited Create(AOwner);
 DrawPointProc:=DrawRect;
 fOnDrawCustomPoint:=nil;
 fPA:=Tsp_PointAttr.Create;
 fPA.OnChange:=AtrributeChanged;
end;

destructor Tsp_XYLine.Destroy;
begin
 if Assigned(FPA) then begin
  FPA.OnChange:=nil;
  FPA.Free;
 end;
 inherited;
end;

procedure Tsp_XYLine.SetPointAttr(const V:Tsp_PointAttr);
begin
 fPA.Assign(V);
end;

procedure Tsp_XYLine.AtrributeChanged(V:TObject);
begin
 if V=fPA then
 case fPA.Kind of
   ptRectangle: DrawPointProc:=DrawRect;
   ptEllipse:   DrawPointProc:=DrawEllipse;
   ptDiamond:   DrawPointProc:=DrawDiamond;
   ptCross:     DrawPointProc:=DrawCross;
   ptCustom:    DrawPointProc:=DrawRect; //DrawCustom;
   ptTriangle:  DrawPointProc:=DrawTriangle;
   ptDownTriangle: DrawPointProc:=DrawDownTriangle;
   else         DrawPointProc:=DrawRect;
 end;
 inherited AtrributeChanged(fPA);
end;

procedure Tsp_XYLine.DrawRect(const x, y: Integer);
begin
 with fPA do
  fCanvas.Rectangle(x-eHSize, y-eVSize, x+oHSize, y+eVSize+1);
end;

procedure Tsp_XYLine.DrawEllipse(const x, y: Integer);
begin
 with fPA do
  fCanvas.Ellipse(x-eHSize, y-eVSize, x+oHSize, y+oVSize);
end;

procedure Tsp_XYLine.DrawDiamond(const x, y: Integer);
begin
 with fPA do
  fCanvas.Polygon([Point(x, y - eVSize), Point(x + eHSize, y),
                         Point(x, y + eVSize), Point(x - eHSize, y)]);
end;

procedure Tsp_XYLine.DrawCross(const x, y: Integer);
begin
 with fCanvas, fPA do
 begin
   MoveTo(x - eHSize, y);
   LineTo(x + oHSize, y);
   MoveTo(x, y - eVSize);
   LineTo(x, y + oVSize);
 end;
end;

procedure Tsp_XYLine.DrawTriangle(const x, y: Integer);
begin
 with fPA do
  fCanvas.Polygon([Point(x, y - eVSize), Point(x + eHSize, y + eVSize),
                   Point(x - eHSize, y + eVSize)]);
end;

procedure Tsp_XYLine.DrawDownTriangle(const x, y: Integer);
begin
 with fPA do
  fCanvas.Polygon([Point(x-eHSize, y-eVSize), Point(x+eHSize, y-eVSize),
                   Point(x, y + eVSize)]);
end;


procedure Tsp_XYLine.Draw;
const
     ep_Out=1; op_Out=2; Both_Out=op_Out or ep_Out;
var
     pdx, pdy : pDbls; i,a : double;
     XA, YA : Tsp_Axis;

 procedure DrawLines(const pxa, pya : pDbls; const XA, YA : Tsp_Axis);
 var
    j:integer;  pa:array [0..1] of TPoint;   is_out:word;
 begin
   with fCanvas, YA  do
   begin
     fLineAttr.SetPenAttr(Pen);
     Brush.Style:=bsClear;
     with pa[0] do
     begin
       x:=XA.V2P(pxa^[0]); y:=V2P(pya^[0]);
       if (x<-16000) or (y<-16000) or (x>16000) or (y>16000) then is_out:=op_out
       else is_out:=0;
     end;
     for j:=1 to Count-1 do
     begin
       with pa[1] do
       begin
         x:=XA.V2P(pxa^[j]); y:=V2P(pya^[j]);
         if (x<-16000) or (y<-16000) or (x>16000) or (y>16000) then
         is_out:=is_out or ep_out;
       end;
       //draw line if at least one point inside
       if (is_out and both_out)<>both_out then PolyLine(pa);
       is_out:=is_out shl 1;
       pa[0]:=pa[1];
     end;
   end;
 end; //DrawLines

 procedure DrawPoints(const pxa, pya : pDbls; const XA, YA : Tsp_Axis);
 var
    j:integer; p:TPoint;
 begin
    with fCanvas, YA  do
    begin
     fPA.SetPenAttr(Pen);
     Brush.Assign(fPA);
     if (fPA.Kind=ptCustom) then begin
       if Assigned(fOnDrawCustomPoint) then
       for j:=0 to Count-1 do with p do
       begin
         x:=XA.V2P(pxa^[j]); y:=V2P(pya^[j]);
         if PtInRect(fPlot.FieldRect, p) then
            fOnDrawCustomPoint(Self,pxa^[j],pya^[j],x,y);
       end;
     end else
       for j:=0 to Count-1 do with p do
       begin
         x:=XA.V2P(pxa^[j]); y:=V2P(pya^[j]);
         if PtInRect(fPlot.FieldRect, p) then DrawPointProc(x,y);
       end;
    end;
 end; //DrawPoints


begin  //Draw
 if (Count<1) or Not Assigned(fPlot) or
    Not(fPA.fVisible or ((fLineAttr.Visible) and (Count>1)))then Exit;
 with Plot do begin
   fCanvas:=DCanvas;    //assign canvas to where draw
   if XAxis=dsxBottom then XA:=BottomAxis else XA:=TopAxis;
   GetXMin(i); GetXMax(a);
   if (i>XA.Max) or (a<XA.Min) then Exit;
   GetYMin(i); GetYMax(a);
   if YAxis=dsyLeft then YA:=LeftAxis else YA:=RightAxis;
   if (i>YA.Max) or (a<YA.Min) then Exit;
 end;
 pdx:=VarArrayLock(XV);
 pdy:=VarArrayLock(YV);
 try
   if (Count>1) and fLineAttr.Visible and (fLineAttr.Style<>psClear)
   then DrawLines(pdx,pdy,XA,YA);
   if fPA.fVisible then DrawPoints(pdx,pdy,XA,YA);
 finally
   VarArrayUnlock(YV);
   VarArrayUnlock(XV);
 end;
end;

procedure Tsp_XYLine.DrawLegendMarker(const LCanvas:TCanvas; MR:TRect);
var OP:TPen; OB:TBrush; x,y:integer;
begin
 if (fLineAttr.Visible or fPA.Visible) then
 begin
   fDLM:=True;          //note that drawing legend marker
   fCanvas:=LCanvas;
   OP:=TPen.Create;   OP.Assign(fCanvas.Pen); //save pen
   OB:=TBrush.Create; OB.Assign(fCanvas.Brush); //save brush
   with MR do y:=(Bottom+Top) div 2;
   if fLineAttr.Visible then with fCanvas do begin
     fLineAttr.SetPenAttr(fCanvas.Pen);
     Brush.Style:=bsClear;
     with MR do PolyLine([Point(Left+1, y), Point(Right, y)]);
   end;
   if fPA.Visible then with fCanvas do begin
     fPA.SetPenAttr(Pen);
     Brush.Assign(fPA);
     with MR do x:=(Left+Right) div 2;
     if (fPA.Kind=ptCustom) and Assigned(fOnDrawCustomPoint) then
        fOnDrawCustomPoint(Self, 0,0, x,y)
     else DrawPointProc(x,y);
   end;
   fCanvas.Brush.Assign(OB); OB.Free;  //restore brush
   fCanvas.Pen.Assign(OP); OP.Free; //restore pen
   fDLM:=False;
 end;
end;

function Tsp_XYLine.GetX(i:integer):double;
begin
 Result:=XV[i];
end;

function Tsp_XYLine.GetY(i:integer):double;
begin
 Result:=YV[i];
end;

procedure Tsp_XYLine.QuickAddXY(aX,aY:double);
//don't spends time to update Plot, instead simply draw next segment,
//therefore AutoMin and AutoMax are ignored
var l,e:TPoint; A:Tsp_Axis;  inside:boolean;
begin
 if fPN >= fCapacity        //has free space in series data storage?
    then Expand;            //if no then expand data storage
 XV[fPN]:=aX;  YV[fPN]:=aY; //add values to data storage
 TryUpdateMinMax(aX,aY);    //serve data min & max
 inc(fPN);                  //points nubmer was increased
 //instead InvalidatePlot(rsDataChanged) we simply draw line segment;
 //but first check if we can draw
 if CanPlot and Active //has parent plot, can invalidate it & series is active?
 then with Plot do
 begin
   //if plot painted through draw buffer, then mark buffer as invalid
   if BufferedDisplay
      then BufferIsInvalid; //draw buffer will be freshed on next Paint
   with FieldRect do IntersectClipRect(DCanvas.Handle, Left, Top, Right, Bottom);
   if fLineAttr.Visible and (fPN>1) then
   begin
     if XAxis=dsxBottom then A:=BottomAxis else A:=TopAxis;
     with A do  begin       //ask horiz. axis for the scaling
       l.x:=V2P(XV[fPN-2]);
       e.x:=V2P(XV[fPN-1]);       //find x pos new line segment
     end;
     if YAxis=dsyLeft then A:=LeftAxis else A:=RightAxis;
     with A do  begin      //ask vert. axis for the scaling
       l.y:=V2P(YV[fPN-2]);
       e.y:=V2P(YV[fPN-1]);       //find y pos new line segment
     end;
     inside:=PtInRect(FieldRect, e);
     if (PtInRect(FieldRect, l) or inside) then with DCanvas do  begin
       fLineAttr.SetPenAttr(DCanvas.Pen); //set line draw attributes
       if DCanvas.Brush.Style<>bsClear then DCanvas.Brush.Style:=bsClear;
       MoveTo(l.x,l.y);
       LineTo(e.x,e.y);           //draw line
     end;
   end
   else
   begin
     if XAxis=dsxBottom then A:=BottomAxis else A:=TopAxis;
     with A do e.x:=V2P(XV[fPN-1]);       //find x pos new line segment
     if YAxis=dsyLeft then A:=LeftAxis else A:=RightAxis;
     with A do e.y:=V2P(YV[fPN-1]);       //find y pos new line segment
     inside:=PtInRect(FieldRect, e);
   end;
   if fPA.fVisible and inside then begin
     fCanvas:=DCanvas;
     with fCanvas do begin
//     if not (Pen.Style in [psSolid, psClear]) then Pen.Style:=psSolid;
       fPA.SetPenAttr(Pen);
       Brush.Assign(fPA);
     end;
     if (fPA.Kind=ptCustom) and Assigned(fOnDrawCustomPoint) then
        fOnDrawCustomPoint(Self, XV[fPN-1],YV[fPN-1], e.x,e.y)
     else DrawPointProc(e.x,e.y);
   end;
 end;
end;



{*** Tsp_SpectrLines ***}

constructor Tsp_SpectrLines.Create(AOwner:TComponent);
begin
 Inherited Create(AOwner);
 fBLVisible:=True;
 fLabelFormat:='###0.##';
 fLFont:=TFont.Create;
 fLFont.OnChange:=AtrributeChanged;
end;

destructor Tsp_SpectrLines.Destroy;
begin
 if Assigned(fLFont) then fLFont.Free;
 inherited;
end;

procedure Tsp_SpectrLines.SetBaseValue(V:double);
begin
 if fBaseValue<>V then
 begin
  fBaseValue:=V;
  AtrributeChanged(Self);
 end;
end;

procedure Tsp_SpectrLines.SetYOrigin(V:Tsp_YOrigin);
begin
 if fYOrigin<>V then
 begin
  fYOrigin:=V;
  AtrributeChanged(Self);
 end;
end;

procedure Tsp_SpectrLines.SetWhatValues(V:Tsp_WhatValues);
begin
 if fWhatValues<>V then
 begin
  fWhatValues:=V;
  AtrributeChanged(Self);//if CanPlot then PLot.Invalidate;
 end;
end;

procedure Tsp_SpectrLines.SetLabelFormat(const V:string);
begin
 if fLabelFormat<>V then
 begin
  fLabelFormat:=V;
  AtrributeChanged(Self);//if CanPlot then PLot.Invalidate;
 end;
end;

procedure Tsp_SpectrLines.SetLFont(V:TFont);
begin
 fLFont.Assign(V);
end;

procedure Tsp_SpectrLines.SetLVisible(const V:boolean);
begin
 if fLVisible<>V then
 begin
  fLVisible:=V;
  AtrributeChanged(Self);//if CanPlot then PLot.Invalidate;
 end;
end;

procedure Tsp_SpectrLines.SetBLVisible(const V:boolean);
begin
 if fBLVisible<>V then
 begin
  fBLVisible:=V;
  AtrributeChanged(Self);//if CanPlot then PLot.Invalidate;
 end;
end;

procedure Tsp_SpectrLines.Draw;
var    ps:pLP;
       pdx, pdy:pDbls;
       XA,YA:Tsp_Axis;  i,a:double;
       by:integer; j:integer;

 procedure DrawBars(ps:pLP; by:integer);
 var j,lx,rx:integer;
 begin
  with Plot do
  begin
    lx:=fLineAttr.Width div 2;  rx:=fLineAttr.Width-lx;
    //begin darw
    if fLineAttr.Width=1 then begin   //draw line if BarWidth=1
      fLineAttr.SetPenAttr(fCanvas.Pen);
      for j:=0 to Count-1 do with DCanvas, ps^[j] do begin
        if y<by then begin MoveTo(x, by); LineTo(x, y); end
        else begin  MoveTo(x, y); LineTo(x, by); end
      end
    end
    else begin                      //draw rectangle if BarWidth=1
      with fCanvas do begin
        Brush.Color:=fLineAttr.Color;
        Brush.Style:=bsSolid;
        Pen.Style:=psClear;
      end;
      inc(rx);
      for j:=0 to Count-1 do with fCanvas, ps^[j] do begin
        if y<by then Rectangle(x-lx, y-1, x+rx, by+1)
        else Rectangle(x-lx, by, x+rx, y+1);
      end;
    end;
  end; //with
 end; //DrawBars

 procedure DrawLabels(pdx,pdy:pDbls; ps:pLP);
 var j,lx,ly:integer; LS:string;
 begin
   lx:=fLineAttr.Width-fLineAttr.Width div 2;
   with fCanvas do begin
     Brush.Style:=bsClear;
     Font:=fLFont;
     ly:=TextHeight('8') div 2;
   end;
   if fWhatValues=wvYValues then
   for j:=0 to Count-1 do with fCanvas, ps^[j] do begin
     LS:=FormatFloat(fLabelFormat,pdy[j]);
     if Assigned(fOnGetLabel) then fOnGetLabel(Self, j, pdx^[j], pdy^[j], LS);
     TextOut(x+lx, y-ly,LS);
   end
   else
   for j:=0 to Count-1 do with fCanvas, ps^[j] do begin
     LS:=FormatFloat(fLabelFormat,pdx[j]);
     if Assigned(fOnGetLabel) then fOnGetLabel(Self, j, pdx^[j], pdy^[j], LS);
     TextOut(x+lx, y-ly,LS);
   end;
 end;    //DrawLabels(pdx,pdy,ps);

begin
 if (Count<1) or Not Assigned(Plot) then Exit;
 with Plot do begin
  fCanvas:=Plot.DCanvas;
  if XAxis=dsxBottom then XA:=BottomAxis else XA:=TopAxis;
  GetXMin(i); GetXMax(a);
  if (i>XA.Max) or (a<XA.Min) then Exit;
 end;
 GetMem(ps, Count*SizeOf(TPoint));
 pdx:=VarArrayLock(XV);
 pdy:=VarArrayLock(YV);
 try
  with Plot do begin
    //find where begin draw bar
    if YAxis=dsyLeft then YA:=LeftAxis else YA:=RightAxis;
    if YOrigin=yoBaseLine then begin
      with YA do by:=V2P(fBaseValue);
      if by>BottomAxis.OY then by:=BottomAxis.OY+2
      else if by<TopAxis.OY then by:=TopAxis.OY-2;
    end
    else begin //if YAxis min at top then from top and vice versa
      if YA.Inversed then by:=TopAxis.OY-2 else by:=BottomAxis.OY+2
    end;
    //calc coordinate
    for j:=0 to Count-1 do with ps^[j], XA do begin
     x:=V2P(pdx^[j]);
    end;
    for j:=0 to Count-1 do with ps^[j], YA do begin
     y:=V2P(pdy^[j]);
    end;
    if fLineAttr.Visible then DrawBars(ps, by);
    //draw base line
    if fBLVisible and (YOrigin=yoBaseLine) then
    begin
      with fCanvas, FieldRect do
      begin
        fLineAttr.SetPenAttr(Pen);
        Pen.Width:=1;
        MoveTo(Left, by);
        LineTo(Right+1,by);
      end;
    end;
    //darw value label
    if fLVisible then DrawLabels(pdx,pdy,ps);
  end;
 finally
  FreeMem(ps, Count*SizeOf(TPoint));
  VarArrayUnlock(YV);
  VarArrayUnlock(XV);
 end;
end;

function  Tsp_SpectrLines.GetYMin;
begin
 Result:=inherited GetYMin(V);
 if Not(Result) then Exit;
 if YOrigin=yoBaseLine then
 begin
   if V>fBaseValue then V:=fBaseValue
 end else
 begin
   if V>0 then V:=0
 end;
end;

function  Tsp_SpectrLines.GetYMax;
begin
 Result:=GetYMax(V);;
 if Not(Result) then Exit;  // V:=inherited GetYMax(V);
 if YOrigin=yoBaseLine then
 begin
   if V<fBaseValue then V:=fBaseValue
 end else
 begin
   if V<0 then V:=0
 end;
end;


END.


