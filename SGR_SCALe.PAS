unit sgr_scale;
{(c) S.P.Pod'yachev 1998-1999}
{ver. 2.22   22.10.1999}
{***************************************************}
{ Auxiliary persistent objects for using            }
{ in components with scale and axis                 }
{***************************************************}
interface
uses
  Windows, Messages, SysUtils, Classes, Graphics;
Type
Tsp_CustomLineAttr=class(TPersistent)
private
 fColor:TColor;
 fStyle:TPenStyle;
 fWidth:word;
 fMode:TPenMode;
 fVisible:boolean;
 fOnChange:TNotifyEvent;
 procedure SetColor(const V:TColor);
 procedure SetStyle(const V:TPenStyle);
 procedure SetWidth(const V:word);
 procedure SetMode(const V:TPenMode);
 procedure SetVisible(const V:boolean);
protected
 procedure Changed; virtual;
public
 constructor Create;
 procedure Assign(Source: TPersistent); override;
 procedure AssignTo(Dest: TPersistent); override;
 procedure SetPenAttr(const APen:TPen);
 property Color:TColor read fColor write SetColor;
 property Style:TPenStyle read fStyle write SetStyle;
 property Width:word read fWidth write SetWidth;
 property Mode:TPenMode read fMode write SetMode;
 property Visible:boolean read fVisible write SetVisible;
 property OnChange: TNotifyEvent read FOnChange write FOnChange;
end;
Const
dblDfltAxisMin=0.0; dblDfltAxisMax=10.0;
Type
Tsp_LineAttr=class(Tsp_CustomLineAttr)
public
function IsSame(const LA:Tsp_CustomLineAttr):boolean;
published
 property Color;
 property Style default psSolid;
 property Width default 1;
 property Visible;
end;
Const
 MaxTicksCount=21;                                       
 fbposVertical=0;                    
 fbposInversed=1;                          
 fbposNegMetr=2;                                         
 fbposNoTicks=3;                             
 fbposNoTicksLabel=4;                             
 fbposRevertTicks=5;                                                            
 fbposAutoMin=6;                                         
 fbposAutoMax=7;
 fbposLabelAsDate=8;                    
 fbposNotAjustedTicks=9;                                     
 sdfVertical=1 shl fbposVertical;                   
 sdfInversed=1 shl fbposInversed;                           
 sdfNegMetr=1 shl fbposNegMetr;
 sdfNoTicks=1 shl fbposNoTicks;                              
 sdfNoTicksLabel=1 shl fbposNoTicksLabel;                              
 sdfRevertTicks=1 shl fbposRevertTicks;                             
 sdfLabelAtTop=sdfRevertTicks;                                        
 sdfLabelOnRight=sdfRevertTicks;                                       
 sdfAutoMin=1 shl fbposAutoMin;                                   
 sdfAutoMax=1 shl fbposAutoMax;
 sdfLabelAsDate=1 shl fbposLabelAsDate;                    
 sdfNotAjustedTicks=1 shl fbposNotAjustedTicks;                                     
Type
Tsp_Scale = class(TPersistent)
private
 IMin, IMax : double;                                                 
 IntFactor : double;                                            
 IStep:integer;                                  
 rTksCount: Byte;                                                                    
 fOPos:integer;                                             
 fOVal   : double;                                                         
 fM: Double;                                         
 procedure ReadFlags(Reader: TReader);
 procedure WriteFlags(Writer: TWriter);
 procedure ReadLinePos(Reader: TReader);
 procedure WriteLinePos(Writer: TWriter);
 procedure ReadMin(Reader: TReader);
 procedure WriteMin(Writer: TWriter);
 procedure ReadMax(Reader: TReader);
 procedure WriteMax(Writer: TWriter);
 function  GetVisible:boolean;
protected
 fFlags:integer;                                       
 fO:TPoint;                                                              
 fLen:integer;                           
 fTicksCount:Byte;                                                              
 fLabelFormat: string;                                
 fLineAttr:Tsp_LineAttr;                           
 fMin, fMax: double;                                                     
 fInterval: double;                                  
 fTksPos: array [0..MaxTicksCount-1] of smallInt;                            
 fTksDbl: array [0..MaxTicksCount-1] of double;                             
 function TksDbl(i:integer):double;                                      
 procedure DefineProperties(Filer: TFiler); override;
 procedure FixMinMax(Mi,Ma:double);
 procedure CalcMetr;
 procedure CalcTicksVal;
 procedure CalcTicksPos;
 procedure ShiftScaleBy(pixel:boolean; idelta:double; fdelta:double);
 function  TickLabel(tickNum:integer): string; virtual;
 function  GetTicksCount:byte;
 procedure SetFlagBit(const BN:integer; const On:boolean);
 procedure ReSetFlagBit(const BN:integer; const Off:boolean);
 function  GetFlagBit(const BN:integer):boolean;
 function  NotFlagBit(const BN:integer):boolean;
 procedure FlagsChanged(const BN:integer; const On:boolean); virtual;
public
 constructor Create(Flags:integer);
 destructor Destroy; override;
 function BandWidth(FntWidth, FntHeight:integer):integer;
 function OrgIndent(FntWidth, FntHeight:integer):integer;
 function EndIndent(FntWidth, FntHeight:integer):integer;
 function CalcDrawBounds(fCanvas:TCanvas):TRect;
 procedure DrawLine(fCanvas:TCanvas; odec, einc:word);
 procedure DrawTicks(fCanvas:TCanvas);
 procedure SetLine(oX, oY, lLen:integer);
 procedure ChangeMinMax(aMin,aMax:double);
 procedure ScrollBy(delta:integer);
 function V2P(const V:double):integer;
 function P2V(const V:integer):double;
 property OPos:integer read fOPos;
 property OVal:double  read fOVal;
 property SM:double read fM;
 property Visible: boolean read GetVisible;
 property OX:Longint read fO.x;
 property OY:Longint read fO.y;
 property Len:integer read fLen;
 property NoTicks:boolean index fbposNoTicks read GetFlagBit
                                               write SetFlagBit stored False;
published
 property Inversed:boolean index fbposInversed read GetFlagBit
                                                write SetFlagBit stored False;
 property NoTicksLabel:boolean index fbposNoTicksLabel read GetFlagBit
                                               write SetFlagBit stored False;
 property TicksAdjusted:boolean index fbposNotAjustedTicks read NotFlagBit
                                               write ReSetFlagBit stored False;
 property TicksLines:boolean index fbposNoTicks read NotFlagBit
                                               write ReSetFlagBit stored False;
end;
IMPLEMENTATION
procedure Tsp_CustomLineAttr.Changed;
begin
 if Assigned(fOnChange) then fOnChange(Self);
end;
procedure Tsp_CustomLineAttr.SetColor(const V:TColor);
begin
 if V<>fColor then fColor:=V;
 Changed;
end;
procedure Tsp_CustomLineAttr.SetStyle(const V:TPenStyle);
begin
 if V<>fStyle then fStyle:=V;
 Changed;
end;
procedure Tsp_CustomLineAttr.SetWidth(const V:word);
begin
 if V<>fWidth then fWidth:=V;
 Changed;
end;
procedure Tsp_CustomLineAttr.SetVisible(const V:boolean);
begin
 if V<>fVisible then fVisible:=V;
 Changed;
end;
procedure Tsp_CustomLineAttr.SetMode(const V:TPenMode);
begin
 if V<>fMode then fMode:=V;
 Changed;
end;
constructor Tsp_CustomLineAttr.Create;
begin
 inherited Create;
 fOnChange:=nil;
 fColor:=clBlack;
 fStyle:=psSolid;
 fWidth:=1;
 fVisible:=True;
end;
procedure Tsp_CustomLineAttr.Assign(Source: TPersistent);
var ss:Tsp_CustomLineAttr;
begin
 if Source is Tsp_CustomLineAttr then
 begin
   ss:=Tsp_CustomLineAttr(Source);
   fColor:=ss.fColor;
   fStyle:=ss.fStyle;
   fWidth:=ss.fWidth;
   fVisible:=ss.fVisible;
 end else inherited Assign(Source);
end;
procedure Tsp_CustomLineAttr.AssignTo(Dest: TPersistent);
begin
 if Dest is Tsp_CustomLineAttr then Dest.Assign(Self)
 else inherited AssignTo(Dest);
end;
procedure Tsp_CustomLineAttr.SetPenAttr(const APen:TPen);
begin
 with APen do begin
  Color:=fColor;
  Style:=fStyle;
  Width:=fWidth;
  Mode:=pmCopy;
 end;
end;
function Tsp_LineAttr.IsSame(const LA:Tsp_CustomLineAttr):boolean;
begin
 with LA do
 Result:=(fColor= Color) and (fStyle= Style) and
         (fWidth= Width) and (fVisible= Visible);
end;
Const
 Ln10=2.30258509299405;
 sdfLineOnly=sdfNoTicks or sdfNoTicksLabel;
function Floor(x:double):double;
begin
 if Frac(x)<0 then Result:=Int(x)-1 else Result:=Int(x);
end;
function Ceil(x:double):double;
begin
 if Frac(x)>0 then Result:=Int(x)+1 else Result:=Int(x);
end;
procedure Tsp_Scale.ReadFlags(Reader: TReader);
begin
 fFlags:=Reader.ReadInteger;
end;
procedure Tsp_Scale.ReadLinePos(Reader: TReader);
begin
 with Reader do begin
   ReadListBegin;
   fO.x:=ReadInteger; fO.y:=ReadInteger; fLen:=ReadInteger;
   ReadListEnd;
 end
end;
procedure Tsp_Scale.ReadMin(Reader: TReader);
begin
 fMin:=Reader.ReadFloat;
end;
procedure Tsp_Scale.ReadMax(Reader: TReader);
begin
 ChangeMinMax(fMin,Reader.ReadFloat);                   
end;
procedure Tsp_Scale.WriteFlags(Writer: TWriter);
begin
 Writer.WriteInteger(fFlags)
end;
procedure Tsp_Scale.WriteLinePos(writer: TWriter);
begin
 with Writer do begin
  WriteListBegin;
  WriteInteger(fO.x);
  WriteInteger(fO.y);
  WriteInteger(fLen);
  WriteListEnd;
 end;
end;
procedure Tsp_Scale.WriteMin(Writer: TWriter);
begin
 Writer.WriteFloat(fMin)
end;
procedure Tsp_Scale.WriteMax(Writer: TWriter);
begin
 Writer.WriteFloat(fMax)
end;
function Tsp_Scale.GetVisible:boolean;
begin
 Result:=((fFlags and sdfLineOnly)<>sdfLineOnly) or fLineAttr.Visible;
end;
function Tsp_Scale.TksDbl(i:integer):double;                        
begin
 if (fFlags and sdfNotAjustedTicks)=0 then Result:=fTksDbl[i]
 else if (fFlags and sdfInversed)=0 then Result:=fOVal+fInterval*fTksDbl[i]
      else Result:=fOVal-fInterval*fTksDbl[i];
end;
procedure Tsp_Scale.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(filer);
  Filer.DefineProperty('SFlags', ReadFlags, WriteFlags, True);
  Filer.DefineProperty('SLinePos', ReadLinePos, WriteLinePos, True);
  Filer.DefineProperty('fMin', ReadMin, WriteMin, fMin<>dblDfltAxisMin);
  Filer.DefineProperty('fMax', ReadMax, WriteMax, True);
end;
procedure Tsp_Scale.FixMinMax(Mi,Ma:double);
var  DecmlPos:integer;
begin
 if Mi>Ma then begin fMin:=Ma; fMax:=Mi end
 else begin fMin:=Mi; fMax:=Ma end;
 if fMin=fMax then begin
   if abs(fMax)<10 then begin
     fMax:=fMax+1; fMin:=fMax-1
   end else begin
     fMax:=fMax+abs(fMax)/10; fMin:=fMax-abs(fMax)/10;
   end;
 end;
 fInterval:=fMax-fMin;
 DecmlPos:=Trunc(Floor(Ln(fInterval)/Ln10));
 if DecmlPos>0 then IntFactor:=1/Int(exp((DecmlPos-1)*Ln10))
 else IntFactor:=Int(exp(-(DecmlPos-1)*Ln10));
 IMin:=Ceil(fMin*IntFactor);                                          
 IMax:=Floor(fMax*IntFactor);                                          
end;
procedure Tsp_Scale.CalcMetr;
begin
 if (fFlags and sdfInversed)=0 then begin
   fM:=fLen/fInterval;  fOVal:=fMin;
 end else begin
   fM:=-fLen/fInterval; fOVal:=fMax;
 end;
 if (fFlags and sdfVertical)=0 then fOPos:=fO.x
 else begin fOPos:=fO.y; fM:=-fM; end;
end;
procedure Tsp_Scale.CalcTicksVal;
  procedure LbldTicksVal;
  var j, sstep:integer; oid:double;
  begin
   if fTicksCount>1 then begin
      j:=Round(IMax-IMin);                         
      IStep:=j div (fTicksCount-1);
      if IStep=0 then inc(IStep);
      rTksCount:=(j div IStep)+1;
      if rTksCount>MaxTicksCount then rTksCount:=MaxTicksCount;
    end else IStep:=Round(IMax-IMin);
    if (fFlags and sdfInversed)=0 then begin oid:=IMin; sstep:=IStep; end
    else begin oid:=IMax; sstep:=-IStep; end;
    for j:=0 to rTksCount-1 do fTksDbl[j]:=Int(oid+sstep*j)/IntFactor;
  end;
  procedure TicksVal;
  var j:integer; step:double;
  begin
    if fTicksCount>1 then step:=1/(fTicksCount-1)
    else step:=1;
    for j:=0 to fTicksCount-1 do fTksDbl[j]:=step*j;
  end;
begin               
 rTksCount:=fTicksCount;
 if fTicksCount>0 then
  if (fFlags and (sdfNoTicksLabel or sdfNotAjustedTicks))=0 then LbldTicksVal
  else TicksVal;
end;                
procedure Tsp_Scale.CalcTicksPos;
  procedure LbldTicks;
  var j:integer;
  begin
   for j:=0 to rTksCount-1 do fTksPos[j]:=V2P(fTksDbl[j]);
  end;
  procedure NoLbldTicks;
  var j:integer;
  begin
   if (fFlags and sdfVertical)=0 then
    for j:=0 to rTksCount-1 do fTksPos[j]:=fOPos+round(fLen*fTksDbl[j])
   else
    for j:=0 to rTksCount-1 do fTksPos[j]:=fOPos-round(fLen*fTksDbl[j])
  end;
begin               
 if fTicksCount<1 then begin rTksCount:=fTicksCount; Exit end;
 if (fFlags and (sdfNoTicksLabel or sdfNotAjustedTicks))=0 then LbldTicks
 else NoLbldTicks;
end;                
procedure Tsp_Scale.ShiftScaleBy(pixel:boolean; idelta:double; fdelta:double);
  procedure ShiftMinMax(delta:double);
  begin
   fMin:=fMin+delta;
   fMax:=fMin+fInterval;
   if (fFlags and sdfInversed)=0 then fOVal:=fMin else fOVal:=fMax;
   IMin:=Ceil(fMin*IntFactor);
   IMax:=Floor(fMax*IntFactor);
  end;
  procedure SLbldTicksVal(delta:double);                     
  var id:extended; j:integer;
  begin
    id:=Frac((fTksDbl[0]*IntFactor-fOVal*IntFactor)/IStep);
    if ((fFlags and sdfInversed)=0) then
    begin
      if id<0 then id:=id+1;
      id:=fOVal*IntFactor+id*IStep;
      rTksCount:=Trunc((fMax*IntFactor-id)/IStep)+1;
      if rTksCount>MaxTicksCount then rTksCount:=MaxTicksCount;
      for j:=0 to rTksCount do fTksDbl[j]:=(id+IStep*j)/IntFactor;
    end else begin
      if id>0 then id:=id-1;
      id:=fOVal*IntFactor+id*IStep;
      rTksCount:=Trunc((id-fMin*IntFactor)/IStep)+1;
      if rTksCount>MaxTicksCount then rTksCount:=MaxTicksCount;
      for j:=0 to rTksCount do fTksDbl[j]:=(id-IStep*j)/IntFactor;
    end
  end;
  procedure STicksVal(delta:double);                         
  var id,step:double; j:integer;
  begin
    if fTicksCount>1 then step:=1/(fTicksCount-1) else step:=1;
    if (fFlags and sdfVertical)<>0 then delta:=-delta;
    id:=Frac((fTksDbl[0]*fLen-delta)/(fLen*step));
    if id<0 then id:=id+1;
    rTksCount:=Trunc(1/step-id)+1;
    id:=id*step;
    if rTksCount>MaxTicksCount then rTksCount:=MaxTicksCount;
    for j:=0 to rTksCount-1 do fTksDbl[j]:=id+step*j;
  end;
begin               
 if pixel then fdelta:=idelta/fM else idelta:=fdelta*fM;
 if fdelta=0 then Exit;
 ShiftMinMax(fdelta);
 if abs(fdelta)>fInterval then  CalcTicksVal
 else begin
    if (fFlags and (sdfNoTicksLabel or sdfNotAjustedTicks))=0 then SLbldTicksVal(fdelta)
    else STicksVal(idelta);
 end;
 CalcTicksPos;
end;               
function Tsp_Scale.TickLabel(tickNum: integer): string;
begin
 if ((fFlags and sdfLabelAsDate)<>0) then
  Result:=FormatDateTime(fLabelFormat, TksDbl(tickNum))
 else
  Result:=FormatFloat(fLabelFormat, TksDbl(tickNum));
end;
function Tsp_Scale.GetTicksCount:byte;
begin
 Result:=rTksCount;
end;
procedure Tsp_Scale.SetFlagBit(const BN:integer; const On:boolean);
var Mask:integer;
begin
 Mask:=1 shl BN;
 if On then
 begin
  if ((fFlags and Mask)=0) then begin
    fFlags:=fFlags or Mask;
    FlagsChanged(BN, On);
  end;
 end else
 if ((fFlags and Mask)<>0) then begin
   fFlags:=fFlags and Not Mask;
   FlagsChanged(BN, On);
 end
end;
procedure Tsp_Scale.ReSetFlagBit(const BN:integer; const Off:boolean);
begin
 SetFlagBit(BN,Not(Off));
end;
function  Tsp_Scale.NotFlagBit(const BN:integer):boolean;
begin
 Result:=(fFlags and (1 shl BN))=0;
end;
function Tsp_Scale.GetFlagBit(const BN:integer):boolean;
begin
 Result:=(fFlags and (1 shl BN))<>0;
end;
procedure Tsp_Scale.FlagsChanged(const BN:integer; const On:boolean);
begin
end;
constructor Tsp_Scale.Create(Flags:integer);
begin
 inherited Create;
 fLineAttr:=Tsp_LineAttr.Create;
 fTicksCount:=5;
 fFlags:=Flags;
 fLabelFormat:='###0.##';
 fO.x:=10; fO.y:=30; fLen:=25;
 ChangeMinMax(dblDfltAxisMin, dblDfltAxisMax);
end;
destructor Tsp_Scale.Destroy;
begin
 if Assigned(fLineAttr) then fLineAttr.Free;
 inherited Destroy;
end;
procedure Tsp_Scale.SetLine(oX, oY, lLen:integer);
begin
 if (fO.x<>oX) or (fO.y<>oY) or (lLen<>fLen) then
 begin
  fO.x:=oX; fO.y:=oY;
  if lLen=0 then inc(lLen) else if lLen<0 then lLen:=-lLen;
  fLen:=lLen;
  CalcMetr;
  CalcTicksPos;
 end;
end;
procedure Tsp_Scale.ChangeMinMax(aMin,aMax:double);
begin
  FixMinMax(aMin, aMax);
  CalcMetr;
  CalcTicksVal;
  CalcTicksPos;
end;
procedure Tsp_Scale.ScrollBy(delta:integer);
begin
 ShiftScaleBy(True, delta, 0);
end;
function Tsp_Scale.V2P(const V:double):integer;                                     
var rr:double;
begin
 rr:=fOPos+(fM*(V-fOVal));
 if rr>16383 then Result:=16383
 else if rr<-16383 then Result:=-16383
      else Result:=round(rr);
end;
function Tsp_Scale.P2V(const V:integer):double;                                     
begin
 Result:=fOVal+(V-fOPos)/fM;
end;
Const
 TickOfs=0;                                    
 MnTick=1;                                    
 MjTick=4;                                     
 LblOfs=1;
function Tsp_Scale.BandWidth(FntWidth, FntHeight:integer):integer;
var j, tw:integer;
begin
 Result:=fLineAttr.Width;
 if (FFlags and sdfVertical)=0 then
 begin                                          
   if (rTksCount>0) then begin
     if ((FFlags and sdfNoTicksLabel)=0) then
       inc(Result, TickOfs+MjTick+LblOfs+FntHeight)
     else if (FFlags and sdfNoTicks)=0 then inc(Result, TickOfs+MjTick);
   end;              
 end else
 begin                                        
   Result:=fLineAttr.Width;
   if (rTksCount>0) then begin
     if ((FFlags and sdfNoTicksLabel)=0) then
     begin
      tw:=Length(TickLabel(0));
      for j:=1 to rTksCount-1 do                                     
         if tw < Length(TickLabel(j)) then
            tw:=Length(TickLabel(j));
      inc(Result, TickOfs+MjTick+LblOfs+tw*FntWidth);
     end
     else if (FFlags and sdfNoTicks)=0 then inc(Result, TickOfs+MjTick);
   end;              
 end;
end;            
function Tsp_Scale.OrgIndent(FntWidth, FntHeight:integer):integer;
var tp:integer;
begin
 if (rTksCount>0) and ((FFlags and sdfNoTicksLabel)=0) then
 begin
   tp:=abs(round((fOVal-TksDbl(0))*fM));                     
   if (FFlags and sdfVertical)=0 then
     Result:=FntWidth*Length(TickLabel(0)) div 2-tp
   else Result:=FntHeight div 2-tp;
   if Result<0 then Result:=0;
 end else Result:=0;
end;
function Tsp_Scale.EndIndent(FntWidth, FntHeight:integer):integer;
var tp:integer;
begin
 if (rTksCount>0) and ((FFlags and sdfNoTicksLabel)=0) then
 begin
   if (fFlags and sdfInversed)=0
   then tp:=abs(round((fMax-TksDbl(rTksCount-1))*fM))                      
   else tp:=abs(round((fMin-TksDbl(rTksCount-1))*fM));
   if (FFlags and sdfVertical)=0 then
     Result:=FntWidth*Length(TickLabel(rTksCount-1)) div 2 - tp
   else
     Result:=FntHeight div 2-tp;
   if Result<0 then Result:=0;
 end else Result:=0;
end;
function Tsp_Scale.CalcDrawBounds(fCanvas:TCanvas):TRect;
var j, ti:integer;
begin
 with Result do with fCanvas do
 begin
  if (FFlags and sdfVertical)=0 then
  begin                                          
    ti:=fLineAttr.Width;
    if (rTksCount>0) and ((FFlags and sdfNoTicksLabel)=0) then
    begin
      inc(ti, TickOfs+MjTick+LblOfs+TextHeight('8'));
      Left:=fTksPos[0]-TextWidth(TickLabel(0)) div 2;
      Right:=fTksPos[rTksCount-1]+TextWidth(TickLabel(rTksCount-1)) div 2;
    end
    else if (FFlags and sdfNoTicks)=0 then inc(ti, TickOfs+MjTick);
    if (FFlags and sdfLabelAtTop)=0 then Top:=fO.y else Top:=fO.y-ti+1;
    Bottom:=Top+ti;
    if Left>fO.x then Left:=fO.x;
    if Right<fO.x+fLen then Right:=fO.x+fLen+1;
  end else
  begin                                               
    ti:=fLineAttr.Width;
    if (rTksCount>0) and ((FFlags and sdfNoTicksLabel)=0) then
    begin
      ti:=TextWidth(TickLabel(0));
      for j:=1 to rTksCount-1 do                                     
         if ti< TextWidth(TickLabel(j)) then
            ti:=TextWidth(TickLabel(j));
      inc(ti, TickOfs+MjTick+LblOfs);
      Top:=fTksPos[rTksCount-1]-TextHeight('8')div 2;
      Bottom:=fTksPos[0]+TextHeight('8')div 2;
    end
    else if (FFlags and sdfNoTicks)=0 then inc(ti, TickOfs+MjTick);
    if (FFlags and sdfLabelOnRight)=0 then Left:=fO.x-ti+1 else Left:=fO.x;
    Right:=Left+ti;
    if Top>(fO.y-fLen) then Top:=fO.y-fLen;
    if Bottom<fO.y then Bottom:=fO.y+1;
  end;
 end;
end;                 
procedure Tsp_Scale.DrawLine;                  
var j,st, w,b,e: integer;
begin
 with fLineAttr do if Visible then with fCanvas do
 begin
  Pen.Color:=fLineAttr.Color;
  Pen.Style:=Style;
  Pen.Width:=1;
  Pen.Mode:=pmCopy;
  if (fFlags and sdfRevertTicks)=0 then st:=1 else st:=-1;
  if (FFlags and sdfVertical)=0 then
   begin
     w:=fO.y;
     b:=fO.x-odec; e:=fO.x+fLen+1+einc;
     for j:=1 to Width do begin
      MoveTo(b, w);
      LineTo(e, w);
      inc(w, st);
     end;
   end
  else
   begin
     w:=fO.x;
     e:=fO.y+1+odec; b:=fO.y-fLen-einc;
     for j:=1 to Width do begin
      MoveTo(w, b);
      LineTo(w, e);
      dec(w, st);
     end;
   end;
 end;
end;
procedure Tsp_Scale.DrawTicks;                   
 procedure DrawVert;
 var j:word;
     x,l:integer;
     LS:String; LW:integer;
 begin
  with fCanvas do
  begin
    if ((FFlags and sdfNoTicks)=0) and (rTksCount>0)then
    begin
      if (FFlags and sdfLabelOnRight)=0 then begin
        x:=fO.x-TickOfs-fLineAttr.Width; l:=x-MjTick;
      end else begin
        x:=fO.x+TickOfs+fLineAttr.Width; l:=x+MjTick;
      end;
      for j:=0 to rTksCount-1 do begin             
        MoveTo(x, fTksPos[j]);
        LineTo(l, fTksPos[j]);
      end;
    end;
    if ((FFlags and sdfNoTicksLabel)=0) and (rTksCount>0) then
    begin
      l:=TextHeight('8') div 2;
      if (FFlags and sdfLabelOnRight)=0 then
      begin
        x:=fO.x-TickOfs-fLineAttr.Width-MjTick-LblOfs;
        for j:=0 to rTksCount-1 do begin
          LS:=TickLabel(j);
          LW:=TextWidth(LS);
          TextOut(x-LW, fTksPos[j]-l, LS);
        end;
      end
      else
      begin
        x:=fO.x+TickOfs+fLineAttr.Width+MjTick+LblOfs;
        for j:=0 to rTksCount-1 do begin
          TextOut(x, fTksPos[j]-l, TickLabel(j));
        end;
      end;
    end;                                  
  end;       
 end;             
 procedure DrawHoriz;
 var j:word;
     y,l:integer;
     LS:String;   LW:integer;
 begin
  with fCanvas do
  begin
    if ((FFlags and sdfNoTicks)=0) and (rTksCount>0)then
    begin
      if (FFlags and sdfLabelAtTop)=0 then begin
        y:=fO.y+TickOfs+fLineAttr.Width; l:=y+MjTick;
      end else begin
        y:=fO.y-TickOfs-fLineAttr.Width; l:=y-MjTick;
      end;
      for j:=0 to rTksCount-1 do begin             
        MoveTo(fTksPos[j], y);
        LineTo(fTksPos[j], l);
      end;
    end;
    if ((FFlags and sdfNoTicksLabel)=0) and (rTksCount>0)then
    begin
      if (FFlags and sdfLabelAtTop)=0 then
           y:=fO.y+TickOfs+fLineAttr.Width+MjTick+LblOfs
      else y:=fO.y-TickOfs-fLineAttr.Width-MjTick-LblOfs-TextHeight('8');
      for j:=0 to rTksCount-1 do begin
        LS:=TickLabel(j);
        LW:=TextWidth(LS);
        TextOut(fTksPos[j]-LW div 2, y, LS);
      end;
    end;                                  
  end;       
 end;             
begin            
 if (fFlags and sdfLineOnly)=sdfLineOnly then Exit;
 if (FFlags and sdfVertical)=0 then DrawHoriz
 else DrawVert;
end;             
END.
