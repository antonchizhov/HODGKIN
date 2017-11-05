unit Unit12;   {Form12 - Drawing m_inf(V), h_inf(V)}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Init,typeNrnParsO,Clamp,Graph, StdCtrls, sgr_def, sgr_data;

type
  TForm12 = class(TForm)
    sp_XYPlot1: Tsp_XYPlot;
    sp_XYLine1: Tsp_XYLine;
    sp_XYLine2: Tsp_XYLine;
    Button1: TButton;
    sp_XYPlot2: Tsp_XYPlot;
    sp_XYLine3: Tsp_XYLine;
    sp_XYLine4: Tsp_XYLine;
    procedure m3_h_ActInact;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

{$R *.DFM}

procedure TForm12.m3_h_ActInact;
var  i :integer;
     m0,h0,Vrest_mem :double;
begin
  Form12.Visible:=true;
  Form12.sp_XYLine1.Clear;
  Form12.sp_XYLine2.Clear;
  Form12.sp_XYLine3.Clear;
  Form12.sp_XYLine4.Clear;
  Vrest_mem:=NP0.Vrest;
  { Plot 'm_inf' and 'h_inf' }
  for i:=0 to 160 do begin
      NP0.Vrest:=-0.110+i*0.001;
      InitialConditions;
      m0:=NV0.mm;
      h0:=NV0.hh;
      Form12.sp_XYLine1.AddXY(NP0.Vrest*1e3,m0{*m0*m0});
      Form12.sp_XYLine2.AddXY(NP0.Vrest*1e3,h0);
      Form12.sp_XYLine3.AddXY(NP0.Vrest*1e3,tau_mm);
      Form12.sp_XYLine4.AddXY(NP0.Vrest*1e3,tau_hh);
  end;
  NP0.Vrest:=Vrest_mem;
  Form12.DoShow;
end;

procedure TForm12.Button1Click(Sender: TObject);
begin
  Form12.m3_h_ActInact;
end;

end.
