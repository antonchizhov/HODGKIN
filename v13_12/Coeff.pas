unit Coeff;

interface
uses MyTypes,Init,typeNrnParsO,MathMyO,Unit1;

procedure Define_ig_iC;
procedure AssignDefaultCoeffToChange;
procedure AssignCoeffToChange;
procedure CoeffFrom_g(g :longvect);
procedure g_FromCoeff(var g :longvect);

implementation
{
}

procedure Define_ig_iC;
var  i,ig :integer;
begin
  ig:=0;
  for i:=1 to mC do  begin
      if ifC[i]=1 then begin
         ig:=ig+1;
         iC_ig[i]:=ig;
         ig_iC[ig]:=i;
      end else
         iC_ig[i]:=0;
  end;
end;

procedure AssignDefaultCoeffToChange;
var  i :integer;
begin
  mC:=2*mMax;
  { Default }
  for i:=1 to mC do  ifC[i]:=0;
  for i:=1 to mC do  LimL[i]:=0;
  for i:=1 to mC do  LimR[i]:=1e8;
  { Which coefficients are used (1\0)? }
  strC[ 1]:='tau_m, [s]  ';  ifC[ 1]:=0;    {LimL[1]:=0.0005; LimR[1]:=0.002;}
  strC[ 2]:='ro          ';  ifC[ 2]:=0;
  strC[ 3]:='gNaR        ';  ifC[ 3]:=1;
  strC[ 4]:='a1NaR       ';  ifC[ 4]:=1;
  strC[ 5]:='a2NaR       ';  ifC[ 5]:=1;
  strC[ 6]:='a3NaR       ';  ifC[ 6]:=1;
  strC[ 7]:='b1NaR       ';  ifC[ 7]:=0;      LimL[7]:=-100;
  strC[ 8]:='b2NaR       ';  ifC[ 8]:=1;
  strC[ 9]:='b3NaR       ';  ifC[ 9]:=1;      LimL[9]:=-100;
  strC[10]:='c1NaR       ';  ifC[10]:=1;
  strC[11]:='c2NaR       ';  ifC[11]:=1;
  strC[12]:='c3NaR       ';  ifC[12]:=0;
  strC[13]:='d1NaR       ';  ifC[13]:=1;
  strC[14]:='d2NaR       ';  ifC[14]:=1;
  strC[15]:='d3NaR       ';  ifC[15]:=1;
  strC[16]:='VNaR        ';  ifC[16]:=1;      LimL[16]:=-100;
  strC[17]:='gNa         ';  ifC[17]:=0;
  strC[18]:='gK          ';  ifC[18]:=0;
  strC[19]:='gL          ';  ifC[19]:=0;      LimL[19]:=0.0001;
  strC[20]:='gKA         ';  ifC[20]:=0;
  strC[21]:='gKD         ';  ifC[21]:=0;
  strC[22]:='VL          ';  ifC[22]:=0;      LimL[22]:=-100;
  strC[23]:='a1K         ';  ifC[23]:=0;
  strC[24]:='a2K         ';  ifC[24]:=0;
  strC[25]:='a3K         ';  ifC[25]:=0;
  strC[26]:='b1K         ';  ifC[26]:=0;
  strC[27]:='b2K         ';  ifC[27]:=0;
  strC[28]:='b3K         ';  ifC[28]:=0;
  strC[29]:='VK          ';  ifC[29]:=0;      LimL[29]:=-100;
  if ifC[ 1]=1 then Form1. tau1.Checked:=True;
  if ifC[ 2]=1 then Form1.  ro1.Checked:=True;
  if ifC[ 3]=1 then Form1.gNaR1.Checked:=True;
  if ifC[ 4]=1 then Form1.a1NaR.Checked:=True;
  if ifC[ 6]=1 then Form1.a2NaR.Checked:=True;
  if ifC[ 8]=1 then Form1.a3NaR.Checked:=True;
  if ifC[ 5]=1 then Form1.b1NaR.Checked:=True;
  if ifC[ 7]=1 then Form1.b2NaR.Checked:=True;
  if ifC[ 9]=1 then Form1.b3NaR.Checked:=True;
  if ifC[10]=1 then Form1.c1NaR.Checked:=True;
  if ifC[12]=1 then Form1.c2NaR.Checked:=True;
  if ifC[14]=1 then Form1.c3NaR.Checked:=True;
  if ifC[11]=1 then Form1.d1NaR.Checked:=True;
  if ifC[13]=1 then Form1.d2NaR.Checked:=True;
  if ifC[15]=1 then Form1.d3NaR.Checked:=True;
  if ifC[16]=1 then Form1. VNaR.Checked:=True;
  if ifC[17]=1 then Form1. gNa1.Checked:=True;
  if ifC[18]=1 then Form1.  gK1.Checked:=True;
  if ifC[19]=1 then Form1.  gL1.Checked:=True;
  if ifC[20]=1 then Form1. gKA1.Checked:=True;
  if ifC[21]=1 then Form1. gKD1.Checked:=True;
  if ifC[22]=1 then Form1. VL11.Checked:=True;
  if ifC[23]=1 then Form1.  a1K.Checked:=True;
  if ifC[24]=1 then Form1.  a2K.Checked:=True;
  if ifC[25]=1 then Form1.  a3K.Checked:=True;
  if ifC[26]=1 then Form1.  b1K.Checked:=True;
  if ifC[27]=1 then Form1.  b2K.Checked:=True;
  if ifC[28]=1 then Form1.  b3K.Checked:=True;
  if ifC[29]=1 then Form1.   VK.Checked:=True;
end;

procedure AssignCoeffToChange;
var  i :integer;
begin
  if Form1. tau1.Checked=True then  ifC[ 1]:=1 else ifC[ 1]:=0;
  if Form1.  ro1.Checked=True then  ifC[ 2]:=1 else ifC[ 2]:=0;
  if Form1.gNaR1.Checked=True then  ifC[ 3]:=1 else ifC[ 3]:=0;
  if Form1.a1NaR.Checked=True then  ifC[ 4]:=1 else ifC[ 4]:=0;
  if Form1.a2NaR.Checked=True then  ifC[ 5]:=1 else ifC[ 5]:=0;
  if Form1.a3NaR.Checked=True then  ifC[ 6]:=1 else ifC[ 6]:=0;
  if Form1.b1NaR.Checked=True then  ifC[ 7]:=1 else ifC[ 7]:=0;
  if Form1.b2NaR.Checked=True then  ifC[ 8]:=1 else ifC[ 8]:=0;
  if Form1.b3NaR.Checked=True then  ifC[ 9]:=1 else ifC[ 9]:=0;
  if Form1.c1NaR.Checked=True then  ifC[10]:=1 else ifC[10]:=0;
  if Form1.c2NaR.Checked=True then  ifC[11]:=1 else ifC[11]:=0;
  if Form1.c3NaR.Checked=True then  ifC[12]:=1 else ifC[12]:=0;
  if Form1.d1NaR.Checked=True then  ifC[13]:=1 else ifC[13]:=0;
  if Form1.d2NaR.Checked=True then  ifC[14]:=1 else ifC[14]:=0;
  if Form1.d3NaR.Checked=True then  ifC[15]:=1 else ifC[15]:=0;
  if Form1. VNaR.Checked=True then  ifC[16]:=1 else ifC[16]:=0;
  if Form1. gNa1.Checked=True then  ifC[17]:=1 else ifC[17]:=0;
  if Form1.  gK1.Checked=True then  ifC[18]:=1 else ifC[18]:=0;
  if Form1.  gL1.Checked=True then  ifC[19]:=1 else ifC[19]:=0;
  if Form1. gKA1.Checked=True then  ifC[20]:=1 else ifC[20]:=0;
  if Form1. gKD1.Checked=True then  ifC[21]:=1 else ifC[21]:=0;
  if Form1. VL11.Checked=True then  ifC[22]:=1 else ifC[22]:=0;
  if Form1.  a1K.Checked=True then  ifC[23]:=1 else ifC[23]:=0;
  if Form1.  a2K.Checked=True then  ifC[24]:=1 else ifC[24]:=0;
  if Form1.  a3K.Checked=True then  ifC[25]:=1 else ifC[25]:=0;
  if Form1.  b1K.Checked=True then  ifC[26]:=1 else ifC[26]:=0;
  if Form1.  b2K.Checked=True then  ifC[27]:=1 else ifC[27]:=0;
  if Form1.  b3K.Checked=True then  ifC[28]:=1 else ifC[28]:=0;
  if Form1.   VK.Checked=True then  ifC[29]:=1 else ifC[29]:=0;
  ndim:=0;
  for i:=1 to mC do  ndim:=ndim+ifC[i];     { 'ndim' - number of changed parameters }
  { Define 'ig_iC' - numbers of changing coefficients }
  Define_ig_iC;
end;

procedure CoeffFrom_g(g :longvect);
var i,j :integer;
begin
  if ifC[ 1]=1 then NP0.tau_m0      :=g[iC_ig[ 1]];
  if ifC[ 2]=1 then NP0.ro          :=g[iC_ig[ 2]];
  if ifC[ 3]=1 then NP0.gNaR        :=g[iC_ig[ 3]];
  if ifC[ 4]=1 then NP0.a1NaR       :=g[iC_ig[ 4]];
  if ifC[ 5]=1 then NP0.a2NaR       :=g[iC_ig[ 5]];
  if ifC[ 6]=1 then NP0.a3NaR       :=g[iC_ig[ 6]];
  if ifC[ 7]=1 then NP0.b1NaR       :=g[iC_ig[ 7]];
  if ifC[ 8]=1 then NP0.b2NaR       :=g[iC_ig[ 8]];
  if ifC[ 9]=1 then NP0.b3NaR       :=g[iC_ig[ 9]];
  if ifC[10]=1 then NP0.c1NaR       :=g[iC_ig[10]];
  if ifC[11]=1 then NP0.c2NaR       :=g[iC_ig[11]];
  if ifC[12]=1 then NP0.c3NaR       :=g[iC_ig[12]];
  if ifC[13]=1 then NP0.d1NaR       :=g[iC_ig[13]];
  if ifC[14]=1 then NP0.d2NaR       :=g[iC_ig[14]];
  if ifC[15]=1 then NP0.d3NaR       :=g[iC_ig[15]];
  if ifC[16]=1 then NP0.VNaR        :=g[iC_ig[16]];
  if ifC[17]=1 then NP0.gNa         :=g[iC_ig[17]];
  if ifC[18]=1 then NP0.gK          :=g[iC_ig[18]];
  if ifC[19]=1 then NP0.gL          :=g[iC_ig[19]];
  if ifC[20]=1 then NP0.gKA         :=g[iC_ig[20]];
  if ifC[21]=1 then NP0.gKD         :=g[iC_ig[21]];
  if ifC[22]=1 then NP0.VL          :=g[iC_ig[22]];
  if ifC[23]=1 then NP0.  a1K       :=g[iC_ig[23]];
  if ifC[24]=1 then NP0.  a2K       :=g[iC_ig[24]];
  if ifC[25]=1 then NP0.  a3K       :=g[iC_ig[25]];
  if ifC[26]=1 then NP0.  b1K       :=g[iC_ig[26]];
  if ifC[27]=1 then NP0.  b2K       :=g[iC_ig[27]];
  if ifC[28]=1 then NP0.  b3K       :=g[iC_ig[28]];
  if ifC[29]=1 then NP0.   VK       :=g[iC_ig[29]];
end;

procedure g_FromCoeff(var g :longvect);
var i :integer;
begin
  if ifC[ 1]=1 then g[iC_ig[ 1]]:=NP0.tau_m0    ;
  if ifC[ 2]=1 then g[iC_ig[ 2]]:=NP0.ro        ;
  if ifC[ 3]=1 then g[iC_ig[ 3]]:=NP0.gNaR      ;
  if ifC[ 4]=1 then g[iC_ig[ 4]]:=NP0.a1NaR     ;
  if ifC[ 5]=1 then g[iC_ig[ 5]]:=NP0.a2NaR     ;
  if ifC[ 6]=1 then g[iC_ig[ 6]]:=NP0.a3NaR     ;
  if ifC[ 7]=1 then g[iC_ig[ 7]]:=NP0.b1NaR     ;
  if ifC[ 8]=1 then g[iC_ig[ 8]]:=NP0.b2NaR     ;
  if ifC[ 9]=1 then g[iC_ig[ 9]]:=NP0.b3NaR     ;
  if ifC[10]=1 then g[iC_ig[10]]:=NP0.c1NaR     ;
  if ifC[11]=1 then g[iC_ig[11]]:=NP0.c2NaR     ;
  if ifC[12]=1 then g[iC_ig[12]]:=NP0.c3NaR     ;
  if ifC[13]=1 then g[iC_ig[13]]:=NP0.d1NaR     ;
  if ifC[14]=1 then g[iC_ig[14]]:=NP0.d2NaR     ;
  if ifC[15]=1 then g[iC_ig[15]]:=NP0.d3NaR     ;
  if ifC[16]=1 then g[iC_ig[16]]:=NP0.VNaR      ;
  if ifC[17]=1 then g[iC_ig[17]]:=NP0.gNa       ;
  if ifC[18]=1 then g[iC_ig[18]]:=NP0.gK        ;
  if ifC[19]=1 then g[iC_ig[19]]:=NP0.gL        ;
  if ifC[20]=1 then g[iC_ig[20]]:=NP0.gKA       ;
  if ifC[21]=1 then g[iC_ig[21]]:=NP0.gKD       ;
  if ifC[22]=1 then g[iC_ig[22]]:=NP0.VL        ;
  if ifC[23]=1 then g[iC_ig[23]]:=NP0.  a1K     ;
  if ifC[24]=1 then g[iC_ig[24]]:=NP0.  a2K     ;
  if ifC[25]=1 then g[iC_ig[25]]:=NP0.  a3K     ;
  if ifC[26]=1 then g[iC_ig[26]]:=NP0.  b1K     ;
  if ifC[27]=1 then g[iC_ig[27]]:=NP0.  b2K     ;
  if ifC[28]=1 then g[iC_ig[28]]:=NP0.  b3K     ;
  if ifC[29]=1 then g[iC_ig[29]]:=NP0.   VK     ;
  { Check the limits }
  for i:=1 to mC do begin
      if ifC[i]=1 then
         if ((g[iC_ig[i]]<LimL[i])or(g[iC_ig[i]]>LimR[i])) then begin
             if (g[iC_ig[i]]<LimL[i]) then  g[iC_ig[i]]:=LimL[i];
             if (g[iC_ig[i]]>LimR[i]) then  g[iC_ig[i]]:=LimR[i];
         end;
  end;
end;

{--------------------EOF----------------------------------------------}
end.
