unit sgr_misc;
{(c) S.P.Pod'yachev 1998}
{***************************************************}
{ Some procedures & objects used for drawing        }
{***************************************************}
interface
uses Windows, Classes, Graphics, Extctrls;
Type
Tsp_MemBitmap = class(TObject)
private
  FMemDC: HDC;                                    
  FBitmap: HBitmap;                               
  FCanvas: TCanvas;                           
  OldBitmap: HBitmap;
  FLoose: boolean;                                                 
protected
  FWidth :integer;
  FHeight :integer;
  procedure CreateHandles;
  procedure FreeHandles;
  function GetValid: boolean;
public
  constructor Create(Width, Height:integer);
  destructor  Destroy; override;
  procedure Recreate(Width, Height:integer);
  property Handle: HDC read FMemDC;
  property Bitmap: HBitmap read FBitmap;
  property Valid : boolean read GetValid;
  property Width : integer read FWidth;
  property Height: integer read FHeight;
  property Canvas: TCanvas read FCanvas;
  property Lost  : boolean read FLoose;
end;
IMPLEMENTATION
procedure Tsp_MemBitmap.CreateHandles;
var DC:HDC;
begin
 DC:=GetDC(0);                                
 if DC>0 then
 begin
   FMemDC:=CreateCompatibleDC(DC);
   if DC>0 then FBitmap:=CreateCompatibleBitmap(DC, fWidth, fHeight)
   else FBitmap:=0;
 end
 else FMemDC:=0;
 if DC>0 then ReleaseDC(0,DC);
 OldBitmap:=0;
 if (FMemDC<>0) and (FBitmap<>0) then OldBitmap:=SelectObject(FMemDC, FBitmap);
 FCanvas.Handle:=FMemDC;
end;
procedure Tsp_MemBitmap.FreeHandles;
begin
  FLoose:=True;
  FCanvas.Handle:=0;                                              
  if FMemDC<>0 then begin
   if OldBitmap<>0 then SelectObject(FMemDC, OldBitmap);
   DeleteDC(FMemDC);
  end;
  OldBitmap:=0;
  if FBitmap<>0 then DeleteObject(FBitmap);
  FBitmap:=0;
end;
function Tsp_MemBitmap.GetValid: boolean;
begin
 Result:=(FMemDC<>0) and (FBitmap<>0);
end;
constructor Tsp_MemBitmap.Create(Width, Height:integer);
begin
 FCanvas:=TCanvas.Create;
 FWidth:=Width; FHeight:=Height;
 CreateHandles;
end;
destructor Tsp_MemBitmap.Destroy;
begin
  FreeHandles;
  FCanvas.Free;
  inherited;
end;
procedure Tsp_MemBitmap.Recreate(Width, Height:integer);
begin
 FreeHandles;
 FWidth:=Width; FHeight:=Height;
 CreateHandles;
end;
END.
