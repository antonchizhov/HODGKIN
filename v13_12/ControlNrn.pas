unit ControlNrn;

interface
uses MyTypes,Init,t_dtO,Unit1,MathMyO;

function Current_Iind :double;
function Vhold(t :double) :double;

implementation
uses Noise,FC_control;

{function Current_Iind :double;
var  w,Inoise :double;
begin
  if (t>t_IindShift) and (t<=t_Iind+t_IindShift) then begin
     if Freq_Iind=0 then w:=Iind else
     w:=Iind*sin(2*pi*Freq_Iind*(t-t_IindShift));
     if Form1.ComboBox3.ItemIndex=1 then SynCurrentOnNewStep(abs(Iind),0,Inoise)
                                    else Inoise:=0;
     Current_Iind:=(w+Inoise)/(NP0.Square*1e9);
  end else begin
     Current_Iind:=0;
  end;
  ArtificielSpikes;
end;

function Vhold(t :double) :double;
begin
  if Form1.VhVexp1.Checked then begin
     Vhold:=Vexp[trunc(t/dt),Smpl]/1000;
  end else begin
      if (t>=t_IindShift) and (t<=t_Iind+t_IindShift) then
          Vhold:=Vh
      else
          Vhold:=NP0.Vrest;
  end;
end;}

function Current_Iind :double;
var  w,Inoise,tp,t_ :double;
begin
  t_:=t-t_IindShift;
  if Form1.IindVexp1.Checked then begin
     Current_Iind:=Vexp[trunc(t_/dt),Smpl]/(NP0.Square*1e9);
     exit;
  end;
  if (t_>0) and (t_<=t_Iind) then begin
     if Freq_Iind=0 then w:=Iind else
     w:=Iind*sin(2*pi*Freq_Iind*t_);
     if Form1.ComboBox3.ItemIndex=1 then SynCurrentOnNewStep(abs(Iind),0,Inoise)
                                    else Inoise:=0;
     Current_Iind:=(w+Inoise)/(NP0.Square*1e9);
  end else begin
     Current_Iind:=0;
  end;
  { Pulse train }
  if (Freq_Iind>0)and(t_Iind<0.015) then begin
     tp:=trunc(t_*Freq_Iind)/Freq_Iind;
     if (t_>tp)and(t_<tp+t_Iind)and(trunc(t_*Freq_Iind)<=10)
     then  Current_Iind:=Iind/(NP0.Square*1e9)
     else  Current_Iind:=0;
  end;
  { Meander }
  ArtificielSpikes;
end;

function Vhold(t :double) :double;
var  tp :double;
     nt_:integer;
begin
  if NP0.If_I_V_or_g in [4,5]{Form1.VhVexp1.Checked} then begin
     nt_:=trunc(t/dt);
     if (nt_<nt_end)and(nt_<MaxExp) then begin
        Vhold:=(Vexp[nt_,Smpl]+(t/dt-nt_)*(Vexp[nt_+1,Smpl]-Vexp[nt_,Smpl]))/1000;
     end else begin
        Vhold:=Vexp[imin(nt_end,MaxExp),Smpl]/1000;
     end;
  end else begin
      if (t>=t_IindShift) and (t<=t_Iind+t_IindShift)
      then  Vhold:=Vh
      else  Vhold:=NP0.Vrest;
      { Pulse train }
      if (Freq_Iind>0)and(t_Iind<0.015) then begin
         tp:=trunc(t*Freq_Iind)/Freq_Iind;
         if (t>tp)and(t<tp+t_Iind)and(trunc(t*Freq_Iind)<=10)
         then  Vhold:=Vh
         else  Vhold:=NP0.Vrest;
      end;
  end;
end;

end.
