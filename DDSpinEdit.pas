unit DDSpinEdit;

interface
uses Windows, Classes, StdCtrls, ExtCtrls, Controls, Messages, SysUtils,
  Forms, Graphics, Menus, Buttons,Spin;
{ TSpinEdit }



type

  TDDSpinEdit = class(TCustomEdit)
  private
    FOnClickChange:TNotifyEvent;
    FMinValue: double;
    FMaxValue: double;
    FIncrement: double;
    FButton: TSpinButton;
    FStrWidth: integer;
    FStrDecimals: integer;
    FEditorEnabled: Boolean;
    function GetMinHeight: Integer;
    function GetValue: double;
    function CheckValue (NewValue: double): double;
    procedure SetValue (NewValue: double);
    procedure SetEditRect;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMExit);   message CM_EXIT;
    procedure WMPaste(var Message: TWMPaste);   message WM_PASTE;
    procedure WMCut(var Message: TWMCut);   message WM_CUT;
    procedure SetStrDecimals(const Value: integer);
    procedure SetStrWidth(const Value: integer);
  protected
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
    function IsValidChar(Key: Char): Boolean; virtual;
    procedure UpClick (Sender: TObject); virtual;
    procedure DownClick (Sender: TObject); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Button: TSpinButton read FButton;
  published
    property StrWidth   : integer read FStrWidth    write SetStrWidth;
    property StrDecimals: integer read FStrDecimals write SetStrDecimals;
    property Anchors;
    property AutoSelect;
    property AutoSize;
    property Color;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Enabled;
    property Font;
    property Increment: double read FIncrement write FIncrement;
    property MaxLength;
    property MaxValue: double read FMaxValue write FMaxValue;
    property MinValue: double read FMinValue write FMinValue;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Value: double read GetValue write SetValue;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    property OnClickChange: TNotifyEvent read FOnClickChange write FOnClickChange;

  end;
procedure Register;

implementation

constructor TDDSpinEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButton := TSpinButton.Create (Self);
  FButton.Width := 15;
  FButton.Height := 17;
  FButton.Visible := True;
  FButton.Parent := Self;
  FButton.FocusControl := Self;
  FButton.OnUpClick := UpClick;
  FButton.OnDownClick := DownClick;
  FStrWidth    :=2;
  FStrDecimals :=2;
  Text := '0';
  ControlStyle := ControlStyle - [csSetCaption];
  FIncrement := 1;
  FEditorEnabled := True;
  decimalseparator:='.';
end;

destructor TDDSpinEdit.Destroy;
begin
  FButton := nil;
  inherited Destroy;
end;

procedure TDDSpinEdit.GetChildren(Proc: TGetChildProc; Root: TComponent);
begin
end;

procedure TDDSpinEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key = VK_UP then UpClick (Self)
  else if Key = VK_DOWN then DownClick (Self);
  inherited KeyDown(Key, Shift);
end;

procedure TDDSpinEdit.KeyPress(var Key: Char);
begin
  if not IsValidChar(Key) then
  begin
    Key := #0; 
    MessageBeep(0)
  end;
  if Key <> #0 then inherited KeyPress(Key);
end;

function TDDSpinEdit.IsValidChar(Key: Char): Boolean;
begin
  Result := (Key in [DecimalSeparator, '+', '-', '0'..'9']) or
    ((Key < #32) and (Key <> Chr(VK_RETURN)));
  if not FEditorEnabled and Result and ((Key >= #32) or
      (Key = Char(VK_BACK)) or (Key = Char(VK_DELETE))) then
    Result := False;
end;

procedure TDDSpinEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
{  Params.Style := Params.Style and not WS_BORDER;  }
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TDDSpinEdit.CreateWnd;
begin
  inherited CreateWnd;
  SetEditRect;
end;

procedure TDDSpinEdit.SetEditRect;
var
  Loc: TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc.Bottom := ClientHeight + 1;  {+1 is workaround for windows paint bug}
  Loc.Right := ClientWidth - FButton.Width - 2;
  Loc.Top := 0;
  Loc.Left := 0;
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));  {debug}
end;

procedure TDDSpinEdit.WMSize(var Message: TWMSize);
var
  MinHeight: Integer;
begin
  inherited;
  MinHeight := GetMinHeight;
    { text edit bug: if size to less than minheight, then edit ctrl does
      not display the text }
  if Height < MinHeight then
    Height := MinHeight
  else if FButton <> nil then
  begin
    if NewStyleControls and Ctl3D then
      FButton.SetBounds(Width - FButton.Width - 5, 0, FButton.Width, Height - 5)
    else FButton.SetBounds (Width - FButton.Width, 1, FButton.Width, Height - 3);
    SetEditRect;
  end;
end;

function TDDSpinEdit.GetMinHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  I: Integer;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  I := SysMetrics.tmHeight;
  if I > Metrics.tmHeight then I := Metrics.tmHeight;
  Result := Metrics.tmHeight + I div 4 + GetSystemMetrics(SM_CYBORDER) * 4 + 2;
end;

procedure TDDSpinEdit.UpClick (Sender: TObject);
begin
  if ReadOnly then MessageBeep(0)
  else
  begin
      Value := Value + FIncrement;
      if Assigned(FOnClickChange) then FOnClickChange(self);
  end;
end;

procedure TDDSpinEdit.DownClick (Sender: TObject);
begin
  if ReadOnly then MessageBeep(0)
  else
  begin
      Value := Value - FIncrement;
      if Assigned(FOnClickChange) then FOnClickChange(self);
  end;    
end;

procedure TDDSpinEdit.WMPaste(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

procedure TDDSpinEdit.WMCut(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then Exit;
  inherited;
end;

procedure TDDSpinEdit.CMExit(var Message: TCMExit);
begin
  inherited;
  if CheckValue (Value) <> Value then
    SetValue (Value);
end;

function TDDSpinEdit.GetValue: double;
begin
  try
    if (Text<>'')and(Text<>' ') then  Result := StrToFloat (Text)
    else                              Result := FMinValue;
  except
//    on E: EConvertError do        // my string, 1.12.2011
    Result := FMinValue;
  end;
end;

procedure TDDSpinEdit.SetValue (NewValue: double);
var s:string;
begin
  str(CheckValue(NewValue):StrWidth:StrDecimals,s);
  Text := s;
end;

function TDDSpinEdit.CheckValue (NewValue: double): double;
begin
  Result := NewValue;
  if (FMaxValue <> FMinValue) then
  begin
    if NewValue < FMinValue then
      Result := FMinValue
    else if NewValue > FMaxValue then
      Result := FMaxValue;
  end;
end;

procedure TDDSpinEdit.CMEnter(var Message: TCMGotFocus);
begin
  if AutoSelect and not (csLButtonDown in ControlState) then
    SelectAll;
  inherited;
end;


procedure Register;
begin
  RegisterComponents('Works', [TDDSpinEdit]);
end;


procedure TDDSpinEdit.SetStrDecimals(const Value: integer);
begin
  FStrDecimals := Value;
end;

procedure TDDSpinEdit.SetStrWidth(const Value: integer);
begin
  FStrWidth := Value;
end;


end.
