unit Lyle_KMO;

interface
uses t_dtO,ChannelO,MathMyO,NeuronO;

type
  TLyleKM = class(TChannel)
  private
//    oN :TNeuron;
    procedure tau_inf_KM_Lyle(v2 :double; var tau_n,n_inf :double);
  public
//    V,gKM,VKM,FRT,nM,dt :double;
//    IfBlockKM :integer;
    function Current :double; override;
    function Conductance(x,y,z :double) :double; override;
    procedure Init; override;

    constructor Create(nrn: TNeuron);
  end;

implementation

constructor TLyleKM.Create(nrn: TNeuron);
begin      inherited Create; oN:=nrn;    end;

{---------------- KM -----------------}
procedure TLyleKM.tau_inf_KM_Lyle(v2 :double; var tau_n,n_inf :double);
var a,b :double;
begin
  { Eq. for 'nM' }
  a:=0.003*dexp( (v2+45)*0.6*6*oN.NP.FRT);
  b:=0.003*dexp(-(v2+45)*0.4*6*oN.NP.FRT);
  tau_n:= 1 / (a + b) + 8;
  n_inf:= a / (a + b);
end;

function TLyleKM.Conductance(x,y,z :double):double;
begin
  Conductance :=x*x*(1-oN.NP.IfBlockKM);
end;

function TLyleKM.Current:double;
var  tau_n,n_inf :double;
begin
  tau_inf_KM_Lyle(oN.NV.V*1000, tau_n,n_inf);
  oN.NV.nM:=oN.NV.nM+E_exp(dt,tau_n)*(n_inf-oN.NV.nM);
  Current :=oN.NP.gKM*Conductance(oN.NV.nM,0,0)*(oN.NV.V-oN.NP.VKM);              { Current }
end;

procedure TLyleKM.Init;
var  tau1,tau2 :double;
begin
  tau_inf_KM_Lyle(oN.NV.V*1000, tau1,oN.NV.nM);
end;

end.
 