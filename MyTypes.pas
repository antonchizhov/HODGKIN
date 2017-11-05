unit MyTypes;

interface
uses
  Windows,Messages,SysUtils,Classes,Graphics,Controls,Forms,Dialogs,StdCtrls;

const
  {mMax=200;} {MaxExp=100000;} MaxSmpls=100;
  {mMax=15;} MaxExp=25000; MaxNT=1000000; {MaxSmpls=20;} MaxVC=1000;
  MaxNrns=10000;
type
//    longvect=array[0..2*mMax]   of double;
//    vectint =array[1..2*mMax]   of integer;
//    vecstr  =array[1..2*mMax]   of string;
//    vect2   =array[1..2]        of double;
    vecNrns =array[1..MaxNrns]  of double;
    veciNrns=array[1..MaxNrns]  of integer;
//    matr    =array[1..mMax,1..mMax] of double;
//    vect    =array[0..mMax]     of double;
    vecExp  =array[0..MaxExp,1..MaxSmpls] of double;
    vectExp =array[0..MaxExp] of double;
    vecRampSmpl =array[1..MaxSmpls] of double;
{    matr    =array[1..mMax,1..mMax] of double;
    vect    =array[0..mMax] of double;
    matr_2x2=array[1..2,1..2] of double;
    vect_2  =array[1..2] of double;   }
{
    vecExp  =array[0..MaxExp,0..MaxSmpls] of double;}
    vecSmpl =array[0..MaxSmpls] of string;
//    matr_2x2=array[1..2,1..2]   of double;
//    vect_2  =array[1..2] of double;
    matr_200x200=array[0..200,0..200] of double;
    vecFC   =array[0..MaxVC]    of double;
    NrnRec  =record
               V,VE,nn,yK,nA,lA,xD,yD,yH,wAHP,nM :double;
             end;

{--------------------EOF---------------------------------------------------}
implementation

end.
