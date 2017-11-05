unit Unit2;  {Form2 - ActInact}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  {sgr_def, sgr_data, sgr_mark,} StdCtrls,
  Init,Act_Inact, Graph, ComCtrls,
  Threads, Menus, sgr_def, sgr_data, TeEngine, Series, ExtCtrls, TeeProcs,
  Chart;

type
  TForm2 = class(TForm)
    XYPlot1: Tsp_XYPlot;
    XYLine1: Tsp_XYLine;
    XYLine2: Tsp_XYLine;
    XYLine3: Tsp_XYLine;
    XYLine4: Tsp_XYLine;
    XYLine5: Tsp_XYLine;
    XYLine6: Tsp_XYLine;
    XYPlot2: Tsp_XYPlot;
    XYLine7: Tsp_XYLine;
    StaticText1: TStaticText;
    XYLine8: Tsp_XYLine;
    XYPlot3: Tsp_XYPlot;
    XYLine9: Tsp_XYLine;
    XYLine10: Tsp_XYLine;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    XYLine11: Tsp_XYLine;
    XYPlot4: Tsp_XYPlot;
    StaticText4: TStaticText;
    Button5: TButton;
    XYPlot5: Tsp_XYPlot;
    StaticText5: TStaticText;
    XYLine12: Tsp_XYLine;
    XYLine13: Tsp_XYLine;
    XYLine14: Tsp_XYLine;
    XYLine15: Tsp_XYLine;
    XYLine16: Tsp_XYLine;
    XYLine17: Tsp_XYLine;
    Button6: TButton;
    Button7: TButton;
    SaveDialog1: TSaveDialog;
    SaveDialog2: TSaveDialog;
    SaveDialog3: TSaveDialog;
    SaveDialog4: TSaveDialog;
    SaveDialog5: TSaveDialog;
    SaveDialog6: TSaveDialog;
    PopupMenu1: TPopupMenu;
    Savegtofile1: TMenuItem;
    SaveItofile1: TMenuItem;
    PopupMenu2: TPopupMenu;
    Saveggmaxtofile1: TMenuItem;
    SaveIImaxtofile1: TMenuItem;
    PopupMenu3: TPopupMenu;
    Savem3htofile1: TMenuItem;
    PopupMenu4: TPopupMenu;
    Savetaumtauhtofile1: TMenuItem;
    PopupMenu5: TPopupMenu;
    Savegtofile2: TMenuItem;
    SaveItofile2: TMenuItem;
    Saveggmaxtofile2: TMenuItem;
    SaveIImaxtofile2: TMenuItem;
    Savem3htofile2: TMenuItem;
    OpenDialog1: TOpenDialog;
    Chart1: TChart;
    Series1: TLineSeries;
    Series2: TLineSeries;
    Series3: TLineSeries;
    Series4: TLineSeries;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure HotKey1Enter(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure SaveDialog1CanClose(Sender: TObject; var CanClose: Boolean);
    procedure Button9Click(Sender: TObject);
    procedure SaveDialog2CanClose(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure SaveDialog3CanClose(Sender: TObject; var CanClose: Boolean);
    procedure Button10Click(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure CalcPeaks1Click(Sender: TObject);
    procedure Unscale1Click(Sender: TObject);
    procedure m3h1Click(Sender: TObject);
    procedure taumtauh1Click(Sender: TObject);
    procedure ClearAll1Click(Sender: TObject);
    procedure Stop1Click(Sender: TObject);
    procedure Save2Click(Sender: TObject);
    procedure Savetofile1Click(Sender: TObject);
    procedure Savetofile2Click(Sender: TObject);
    procedure SaveDialog4CanClose(Sender: TObject; var CanClose: Boolean);
    procedure SaveDialog5CanClose(Sender: TObject; var CanClose: Boolean);
    procedure SaveDialog6CanClose(Sender: TObject; var CanClose: Boolean);
    procedure Savegtofile1Click(Sender: TObject);
    procedure SaveItofile1Click(Sender: TObject);
    procedure Saveggmaxtofile1Click(Sender: TObject);
    procedure SaveIImaxtofile1Click(Sender: TObject);
    procedure Savem3htofile1Click(Sender: TObject);
    procedure Savetaumtauhtofile1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}

{*************************************************************}

procedure TForm2.FormShow(Sender: TObject);
begin
  FormActivation;
end;

{***** Main Menu *********************************************}


procedure TForm2.CalcPeaks1Click(Sender: TObject);
begin
  //  Act_InactCurves;
  ThreadObject.ForExecute:=Act_InactCurves;
  RunThread.Start;
end;

procedure TForm2.Unscale1Click(Sender: TObject);
begin
  NondimConds_ActInact;
end;

procedure TForm2.m3h1Click(Sender: TObject);
begin
  m3_h_ActInact;
end;

procedure TForm2.taumtauh1Click(Sender: TObject);
begin
  tau_ActInact;
end;

procedure TForm2.ClearAll1Click(Sender: TObject);
begin
  ClearAll_ActInact;
end;

procedure TForm2.Stop1Click(Sender: TObject);
begin
  ThreadObject.IfStop:=1;
end;

{************************************************************}
procedure TForm2.Button3Click(Sender: TObject);
begin
  //  Act_InactCurves;
  ThreadObject.ForExecute:=Act_InactCurves;
  RunThread.Start;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  NondimConds_ActInact;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  m3_h_ActInact;
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  ClearAll_ActInact;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  tau_ActInact;
end;

procedure TForm2.HotKey1Enter(Sender: TObject);
begin
  { Move all the legends on the Form }
  if not (moveLeg in [1,2,3,4]) then moveLeg:=0;
  moveLeg:=moveLeg+1;
end;

procedure TForm2.Button6Click(Sender: TObject);
begin
  { Move all the legends on the Form }
  if not (moveLeg in [1,2,3,4]) then moveLeg:=0;
  moveLeg:=moveLeg+1;
{  DrawLegendTable(Form2.XYPlot1,'rt');
  DrawLegendTable(Form2.XYPlot2,'rt');
  DrawLegendTable(Form2.XYPlot3,'rt');
  DrawLegendTable(Form2.XYPlot4,'rt');
  DrawLegendTable(Form2.XYPlot5,'rt');}
end;

procedure TForm2.Button7Click(Sender: TObject);
begin
  ThreadObject.IfStop:=1;
end;

{** Safe files **********************************************************}


procedure TForm2.Save1Click(Sender: TObject);
begin
  SaveDialog1.Execute;
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
  SaveDialog1.Execute;
end;

procedure TForm2.Button9Click(Sender: TObject);
begin
  SaveDialog2.Execute;
end;

procedure TForm2.Button10Click(Sender: TObject);
begin
  SaveDialog3.Execute;
end;

procedure TForm2.SaveDialog1CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  AssignFile(fff, SaveDialog1.FileName);  Rewrite(fff);
  IfWriteInFFF:=1;
  { Calculating, drawing and writing the functions }
  {***********}
  tau_ActInact;
  {***********}
  if MessageDlg(MyWarning+'. OK?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    CloseFile(fff)
  else begin
    Rewrite(fff);
    CloseFile(fff);
  end;
  IfWriteInFFF:=0;
end;

procedure TForm2.SaveDialog2CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  AssignFile(fff, SaveDialog2.FileName);  Rewrite(fff);
  IfWriteInFFF:=1;
  { Calculating, drawing and writing the functions }
  {************}
  m3_h_ActInact;
  {************}
  if MessageDlg(MyWarning+'. OK?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    CloseFile(fff)
  else begin
    Rewrite(fff);
    CloseFile(fff);
  end;
  IfWriteInFFF:=0;
end;

procedure TForm2.SaveDialog3CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  AssignFile(fff, SaveDialog3.FileName);  Rewrite(fff);
  IfWriteInFFF:=1;
  { Calculating, drawing and writing the functions }
  {*******************}
  NondimConds_ActInact;
  {*******************}
  if MessageDlg(MyWarning+'. OK?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    CloseFile(fff)
  else begin
    Rewrite(fff);
    CloseFile(fff);
  end;
  IfWriteInFFF:=0;
end;

procedure TForm2.SaveDialog4CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  AssignFile(fff, SaveDialog4.FileName);  Rewrite(fff);
  IfWriteInFFF:=2;
  { Calculating, drawing and writing the functions }
  {*******************}
  NondimConds_ActInact;
  {*******************}
  if MessageDlg(MyWarning+'. OK?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    CloseFile(fff)
  else begin
    Rewrite(fff);
    CloseFile(fff);
  end;
  IfWriteInFFF:=0;
end;

procedure TForm2.SaveDialog5CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  AssignFile(fff, SaveDialog5.FileName);  Rewrite(fff);
  IfWriteInFFF:=1;
  { Calculating, drawing and writing the functions }
  {***************************************}
  Act_InactCurves;
  // ThreadObject.ForExecute:=Act_InactCurves;
  // RunThread.Start;
  {***************************************}
  if MessageDlg(MyWarning+'. OK?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    CloseFile(fff)
  else begin
    Rewrite(fff);
    CloseFile(fff);
  end;
  IfWriteInFFF:=0;
end;

procedure TForm2.SaveDialog6CanClose(Sender: TObject;
  var CanClose: Boolean);
begin
  AssignFile(fff, SaveDialog6.FileName);  Rewrite(fff);
  IfWriteInFFF:=2;
  { Calculating, drawing and writing the functions }
  {***************************************}
  Act_InactCurves;
  // ThreadObject.ForExecute:=Act_InactCurves;
  // RunThread.Start;
  {***************************************}
  if MessageDlg(MyWarning+'. OK?',
    mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    CloseFile(fff)
  else begin
    Rewrite(fff);
    CloseFile(fff);
  end;
  IfWriteInFFF:=0;
end;

procedure TForm2.Save2Click(Sender: TObject);
begin
  SaveDialog6.Execute;
end;

procedure TForm2.Savetofile1Click(Sender: TObject);
begin
  SaveDialog2.Execute;
end;

procedure TForm2.Savetofile2Click(Sender: TObject);
begin
  SaveDialog1.Execute;
end;

procedure TForm2.Savegtofile1Click(Sender: TObject);
begin
  SaveDialog5.Execute;
end;

procedure TForm2.SaveItofile1Click(Sender: TObject);
begin
  SaveDialog6.Execute;
end;

procedure TForm2.Saveggmaxtofile1Click(Sender: TObject);
begin
  SaveDialog3.Execute;
end;

procedure TForm2.SaveIImaxtofile1Click(Sender: TObject);
begin
  SaveDialog4.Execute;
end;

procedure TForm2.Savem3htofile1Click(Sender: TObject);
begin
  SaveDialog2.Execute;
end;

procedure TForm2.Savetaumtauhtofile1Click(Sender: TObject);
begin
  SaveDialog1.Execute;
end;

end.
