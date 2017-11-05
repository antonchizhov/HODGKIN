unit Simplex;

interface
procedure Run_Simplex;

implementation
uses
  MyTypes,Init,MathMyO,Graph,Coeff,Clamp,Unit1,Unit17,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;
{
procedure Run_Simplex(ndim :integer);
   function Funk(ptry: vec0) :double;
   procedure SimplexMethod;
}

procedure Run_Simplex;
{ **********************************************************************
  Extracting of parameters 'g' by Simplex-method.
  **********************************************************************}
type
   matr=array[1..mMax+1,1..mMax] of double;
   vec0=array[1..mMax] of double;
var
   p                        : matr;
   i,j                      : integer;
   ptry                     : vec0;
   F                        : double;

function Funk(ptry: vec0) :double;
{ **********************************************************************}
{  Target function.                                                     }
{ **********************************************************************}
var  i,j,LimOK,iSmpl                    :integer;
     S,Si                               :double;
begin
  for j:=1 to ndim do  g_dg[j]:=ptry[j];
  { Check limits of coefficients }
  LimOK:=1;
  for i:=1 to mC do  if (ifC[i]=1) and
      ((g_dg[iC_ig[i]]<LimL[i]) or (g_dg[iC_ig[i]]>LimR[i]))
      then LimOK:=0;
  { If OK then calculate functional }
  if LimOK=1 then begin
     CoeffFrom_g(g_dg);
     {************************************}
     S:=0;
     for iSmpl:=1 to NSmpls do begin
         Smpl:=iSmpl;
         {**** Functional for Sample *********}
         Si:= Calc_Functional;
         {************************************}
         S := S + Si/sc_Simplex;
     end;
     Funk:=S;
     {************************************}
  end else Funk:=1e8;
end;

procedure SimplexMethod;
{
  Multidimensional minimization of the function 'Funk(X)' where 'x[1..ndim]'
  is a vector in 'ndim' dimensions, by the downhill simplex method.
  The matrix 'p[1..ndim+1, 1..ndim]' is input. Its 'ndim+1' rows are
  'ndim'-dimensional vectors which are the vertices of the starting simplex.
  Also input is the vector 'y[1..ndim+1]', whose components must be
  preinitialized to the values of 'Funk' evaluated at the 'ndim+1' vertices
  (rows) of 'p'; and 'ftol' the fractional convergence tolerance to be
  achieved in the function value. On output, 'p' and 'nFunk' gives the
  number of function evaluations taken.
}
{Uses
    Crt,Graph;}
const  {mMax=4;}
       TINY=1e-8;  NMAX=5000;
type
   {matr=array[1..mMax+1,1..mMax] of double;
   vec0=array[1..mMax] of double;}
   vec1=array[1..mMax+1] of double;
var
   {p                        : matr;}
   x,psum,ptry              : vec0;
   y                        : vec1;
   ftol,rtol,ysave,ytry
                                            : double;
   i,j,ihi,ilo,inhi
                                            : integer;

{I E:\Anton\MODEL\Delphi\gr_smplx.inc}

  function Amotry(fac: double) :double;
  {
    Extrapolates by factor 'fac' through the face of the simplex
    across from the high point, tries it, and replaces the high
    point is better.
  }
  var  j              :integer;
       fac1,fac2,ytry :double;
       ptry           :vec0;
  begin
    fac1:=(1-fac)/ndim;
    fac2:=fac1-fac;
    for j:=1 to ndim do  ptry[j]:=psum[j]*fac1-p[ihi,j]*fac2;
    ytry:=Funk(ptry);    { Evaluate the function at the trial point. }
    { If it's better than the highest, then replace the highest. }
    if ytry<y[ihi] then begin
       y[ihi]:=ytry;
       for j:=1 to ndim do begin
           psum[j]:=psum[j]+ptry[j]-p[ihi,j];
           p[ihi,j]:=ptry[j];
       end;
    end;
    Amotry:=ytry;
  end;

  procedure GET_PSUM;
  var  i,j :integer;
       sum :double;
  begin
    for j:=1 to ndim do begin
        sum:=0;
        for i:=1 to ndim+1 do  sum:=sum+p[i,j];
        psum[j]:=sum;
    end;
  end;

  procedure SWAP(var a,b :double);
  var  tmp :double;
  begin
    tmp:=a;  a:=b;  b:=tmp;
  end;

  procedure Define_Ihi_Inhi_Ilow;
  var  i :integer;
  begin
    { First we determine which point is the highest (worst), next-highest, }
    { and lowest (best), by looping  over the points in the simplex.       }
    ihi:=1; for i:=2 to ndim+1 do  if y[i]>y[ihi] then  ihi:=i;
    ilo:=1; for i:=2 to ndim+1 do  if y[i]<y[ilo] then  ilo:=i;
    inhi:=ilo; for i:=1 to ndim+1 do
                   if (i<>ihi) and (i<>ilo) and (y[i]>y[inhi]) then  inhi:=i;
  end;

  procedure CheckAccuracy;
  var  i :integer;
  begin
    { Check accuracy }
    rtol:=2*abs(y[ihi]-y[ilo])/(abs(y[ihi])+abs(y[ilo])+TINY);
    { Compute the fractional range from highest to lowest and return }
    { if satisfactory. }
    if rtol<ftol then begin { If returning, put best point in slot 1. }
       SWAP(y[1],y[ilo]);
       for i:=1 to ndim do SWAP(p[1,i],p[ilo,i]);
       istop:=1;
    end;
    Functional:=y[1];
  end;


BEGIN
  { Tolerance }
  if Form17.DDSpinEdit24.Value>0 then ftol:=Form17.DDSpinEdit24.Value else
  ftol:=0.0001;
  Form17.DDSpinEdit24.Value:=ftol;
  { Initial simplex }
  {for i:=1 to ndim+1 do  for j:=1 to ndim do
      if i=j then p[i,j]:=2 else p[i,j]:=1;}
  { Evaluation of 'Funk' in vertices }
  for i:=1 to ndim+1 do begin
      for j:=1 to ndim do ptry[j]:=p[i,j];
      y[i]:=Funk(ptry);
  end;
  {***********************************}
  nFunk:=0;
  GET_PSUM;
  istop:=0;
  Repeat
    Define_Ihi_Inhi_Ilow;
    ftol:=Form17.DDSpinEdit24.Value;
    CheckAccuracy;
    if istop=0 then begin
    {  **** Main part ************************************************* }
       if nfunk>=NMAX then writeln('NMAX exceeded');
       nFunk:=nFunk+2;
       { Begin a new iteration. First extrapolate by a factor -1 through }
       { the face of the simplex across from the point, i.e. reflect     }
       { the simplex from the high point.                                }
       ytry:=Amotry(-1);
       if ytry<=y[ilo] then begin
          { Gives a result better than the best point, so try an additional }
          { extrapolation by a factor 2.                                    }
          ytry:=Amotry(2);
       end else if ytry>=y[inhi] then begin
          { The reflected point is worse than second-highest, so look for an }
          { intermediate lower point, i.e., do a one-dimensional contraction.}
          ysave:=y[ihi];
          ytry:=Amotry(0.5);
          if ytry>=ysave then begin {Can't seem to get rid of that high point.}
             for i:=1 to ndim+1 do begin {Better contract around the lowest (best) point.}
                 if i<>ilo then begin
                    for j:=1 to ndim do begin
                        psum[j]:=0.5*(p[i,j]+p[ilo,j]);
                        p[i,j]:=psum[j];
                    end;
                    y[i]:=Funk(psum);
                 end;
             end;
             nfunk:=nfunk+ndim;     {Keep track of function evaluations.}
             GET_PSUM;              {Recompute 'psum'                   }
          end;
       end else nfunk:=nfunk-1;  {Correct the evaluation count.}
    end;
{    writeln('nfunk=',nfunk:4,' F=',y[ilo]:11);}
    str(nfunk:4,t1);
    str(y[ilo]:11,t2);
    t1:='nfunk='+t1+',  F='+t2;
    Form1.SimplexMemo.Lines.Add(t1);
    Form17.Label1.Caption:=t1;
    {DrawT.}PrintCoefficients;
  Until istop=1; {Go back for the test of doneness and the next iteration.}
END;

{**************************************************************************}
BEGIN
  { Main initial point }
  g_FromCoeff(g_dg);
  { Initial simplex }
  for i:=1 to ndim+1 do  for j:=1 to ndim do begin
      if i=j then begin
         p[i,j]:=g_dg[j]*(1.1+0.01*j);
      end else begin
         p[i,j]:=g_dg[j];
      end;
  end;
  SimplexMethod;
  { Results }
  Beep;
  for j:=1 to ndim do  g_dg[j]:=p[1,j];
  CoeffFrom_g(g_dg);
  for j:=1 to ndim do  ptry[j]:=p[1,j];
  F:=Funk(ptry);
  {DrawT.}Warning('Stop Simplex.');
END;
end.
