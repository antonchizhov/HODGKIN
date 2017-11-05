unit Electrode;

interface
uses
  t_dtO,NeuronO,typeNrnParsO;

type
{==================================================================}
  Pipette  =record
    {Properties:}
    G1,C1
                                         :double;
    {Variables:}
    V1,V1old,i2                          :double;
  end;

var
  Pip :Pipette;

  procedure ElectrodePotential(ANrn_:TNeuron; var uuE,ssE,uuI,ssI,Iind,Vh :double);

implementation

{
*******************************************************************************
             i        G1             inp i2
        V           ______    V1
         |---------|______|---|---------o Ampl
    _____|____                |
   |          |    Electrode  |  C1
  _|_  Cell   |             -----
 |   |        | C           -----
 | G |      -----             |
 |   |      -----             |
 |___|        |               o
   |          |
   |__________|
         |
         o
C dV/dt  = -G V + G1(V1-V)
C1 dV1/dt = -G1(V1-V)+i2
}

procedure ElectrodePotential(ANrn_:TNeuron; var uuE,ssE,uuI,ssI,Iind,Vh :double);
{
  Solves equations for the electrode-pipette.
  "Iind" is, initially, the input current "i2", and then it attributed to
  the current into the cell "i".
  Scheme is implicit.
}
begin
  { If no electrode }
  if Pip.G1=0 then begin
     Pip.V1:=ANrn_.NV.V;
     Pip.i2:=Iind;
     exit;
  end;
  Pip.V1old:=Pip.V1;
  { Current-Clamp: }
  if (ANrn_.NP.If_I_V_or_g=2) then begin
      if          ANrn_.NP.HH_order='1-point'  then begin
         Pip.i2:=-(ssE+ssI)*(Pip.V1-Vus) + uuE+uuI + Iind;
         uuE:=0; ssE:=0; uuI:=0; ssI:=0;
      end else if ANrn_.NP.HH_order='2-points' then begin
         Pip.i2:=      -ssI*(Pip.V1-Vus) +     uuI + Iind;
         uuI:=0; ssI:=0;
      end;
      Pip.V1:=(Pip.C1/dt*Pip.V1old+Pip.G1*ANrn_.NV.V+Pip.i2)/(Pip.C1/dt+Pip.G1);
  end;
  { Voltage-Clamp: }
  if (ANrn_.NP.If_I_V_or_g=4) then begin
      Pip.V1:=Vh;
      Pip.i2:=Pip.G1*(Pip.V1-ANrn_.NV.V) + Pip.C1*(Pip.V1-Pip.V1old)/dt;
  end;
  Iind:=Pip.G1*(Pip.V1-ANrn_.NV.V);
end;

end.
