unit LIF;

interface
PROCEDURE LIF_potential(indic :integer; var V,dVdt :double);

implementation
uses Init,t_dtO,MathMyO,ControlNrn;


PROCEDURE LIF_potential(indic :integer; var V,dVdt :double);
{
  LIF-neuron with 'tau_m' and 'Vreset'
}
var
     i                               	        :integer;
     VL_,gL_,Im   	                        :double;
BEGIN
  i:=1;
  VL_:=NP0.VL;  gL_:=NP0.gL;
  { Conditions at spike }
  if indic=2 then begin
     V:=NP0.Vreset;
  end;
  { ---------------- Currents ----------------------------------- }
  Isyn:= -ss*(V-NP0.VK) + uu;
  { ---------------- Ohm's law ---------------------------------- }
  Im:= Isyn -gL_*(V-VL_);
  Im:= Im + Current_Iind;
  dVdt:=0;
  if (t>NV0.tAP+NP0.tau_abs)or(abs(NV0.tAP)<0.001) then begin
     dVdt:=1/NP0.C_membr*Im;
     V:=V + dt*dVdt;
  end;
END;

end.
