unit AHPO;

interface
uses ChannelO,MathMyO,NeuronO,t_dtO;

type
  TAHP = class(TChannel)
  private
//    oN :TNeuron;
    procedure tau_inf_AHP(v2 :double; var tau_w,w_inf :double);
  public
//    V,gAHP,VK,wAHP,dt :double;
//    IfBlockAHP :integer;
    function Current :double; override;
    function Conductance(x,y,z :double) :double; override;
    procedure Init; override;

    constructor Create(nrn: TNeuron);
  end;

implementation

constructor TAHP.Create(nrn: TNeuron);
begin      inherited Create; oN:=nrn;    end;

  { *** AHP  ***}
procedure TAHP.tau_inf_AHP(v2 :double; var tau_w,w_inf :double);
begin
  tau_w:= 400*5/(3.3*dexp((v2+35)/20)+dexp(-(v2+35)/20));
  w_inf:=      1 / (1+dexp(-(v2            +35)/10));
end;

function TAHP.Conductance(x,y,z :double):double;
var  tau_w,w_inf,w_exp,w_inf_rest :double;
begin
  Conductance:=x*(1-oN.NP.IfBlockAHP);
end;

function TAHP.Current :double;
var  v2,a,b,tau_w,w_inf,w_exp :double;
begin
  tau_inf_AHP(oN.NV.V*1000,tau_w,w_inf);
//  wAHPthr:=wAHPthr + dt*210*0.028
//    - dt*1000*wAHPthr/(400/(3.3*dexp((-64+35)/20)+dexp(-(-64+35)/20)));
  oN.NV.wAHP:=oN.NV.wAHP + E_exp(dt,tau_w)*(w_inf-oN.NV.wAHP);
  Current :=oN.NP.gAHP*Conductance(oN.NV.wAHP,0,0)*(oN.NV.V-oN.NP.VK);     { Current }
end;

procedure TAHP.Init;
var  tau1,tau2 :double;
begin
  tau_inf_AHP(oN.NV.V*1000,tau1,oN.NV.wAHP);
end;

end.
