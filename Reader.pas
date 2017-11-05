unit Reader;

interface
uses Init,typeNrnParsO,SetNrnParsO,MathMyO,Other,Graph,Hodgkin_old,
     Noise,Unit1,Unit3,Sysutils;

procedure ReadParamsFromFile(FileName, FirstWord,LastWord :string);

implementation

procedure ReadParamsFromFile(FileName, FirstWord,LastWord :string);
{
  The procedure translate file 'FileName'
  as if data assignement is written in Pascal.
  Note! Comments: }{ only.
}
const sonm=['a'..'z','A'..'Z','0'..'9','_','.','[',']','=','+','-','&','(',')'];
var
     c          :char;
     a1,a2      :string;
     istart     :integer;
     fff        :text;

  procedure StringComment;
  begin
    read(fff,c);
    if c='/' then begin
       repeat read(fff,c) until eoln(fff);
       read(fff,c);
    end;
  end;

  procedure Comment;
  begin
    repeat read(fff,c) until c='}';
    read(fff,c);
  end;

  procedure NextGoodLetter;
  begin
    repeat
      if      c='/' then StringComment
      else if c='{' then Comment
               else read(fff,c);
//      if c='{' then Comment;
    until (c in sonm) or eof(fff);
  end;

  procedure Blank;
  begin
    repeat
      read(fff,c);
      if c='{' then Comment;
    until ((c<>' ')and(c<>#13)and(c<>#10))or eof(fff);
  end;

  procedure ReadWord(var a :string);
  begin
    a:='';
    if not(c in sonm) then NextGoodLetter;
    repeat
      a:=a+c;
      read(fff,c);
//    until eof(fff) or eoln(fff) or
//         (c=' ') or (c=':') or (c=';') or (c='{');
    until not (c in sonm) or eof(fff);
    if c='{' then Comment;
  end;

  function IfItIsNumber(a2 :string):boolean;
  var i :integer;
  begin
    IfItIsNumber:=true;
    for i:=1 to Length(a2) do
        if (a2[i] in ['a'..'d','f'..'z']) or
           (a2[i] in ['A'..'Z']) then
           IfItIsNumber:=false;
  end;

  procedure ChooseVarAndAssignValue(a1,a2 :string);
  var
     d :^double;
     i :^integer;
     s :^string;
     b :^boolean;
     bv                 :boolean;
     dv                 :double;
     iv,j,IfFail        :integer;
     sv,a2cut           :string;
  begin
    { defaults }
    d:=@dv;
    i:=@iv;
    s:=@sv;
    b:=@bv;
    IfFail:=0;
    { Choose variable }
    if a1='HodgkinPhysParameters(NP)' then HodgkinPhysParameters(NP0) else
    if a1='IfDataIn1column'     then i:=@IfDataIn1column else
    if a1='NSmpls'              then i:=@NSmpls          else
    if a1='NP0.HH_type'         then s:=@NP0.HH_type         else
    if a1='NP0.HH_order'        then s:=@NP0.HH_order        else
    if a1='NP0.NaR_type'        then s:=@NP0.NaR_type        else
    if a1='NP0.NaR_subtype'     then s:=@NP0.NaR_subtype     else
    if a1='t_end'               then d:=@t_end           else
    if a1='t_Iind'              then d:=@t_Iind          else
    if a1='t_IindShift'         then d:=@t_IindShift     else
    if a1='Iind'                then d:=@Iind            else
    if a1='NP0.IfBlockNa'           then i:=@NP0.IfBlockNa       else
    if a1='NP0.IfBlockPass'         then i:=@NP0.IfBlockPass     else
    if a1='NP0.IfBlockK'            then i:=@NP0.IfBlockK        else
    if a1='NP0.IfBlockKM'           then i:=@NP0.IfBlockKM       else
    if a1='NP0.IfBlockKA'           then i:=@NP0.IfBlockKA       else
    if a1='NP0.IfBlockNaR'          then i:=@NP0.IfBlockNaR      else
    if a1='NP0.If_I_V_or_g'         then i:=@NP0.If_I_V_or_g     else
    if a1='NP0.IfSet_gL_or_tau'     then i:=@NP0.IfSet_gL_or_tau else
    if a1='NP0.IfSet_VL_or_Vrest'   then i:=@NP0.IfSet_VL_or_Vrest else
    if a1='NP0.Vrest'               then d:=@NP0.Vrest           else
    if a1='scx_Smpl'                then d:=@scx_Smpl        else
    if a1='scy_Smpl'                then d:=@scy_Smpl        else
    if a1='NP0.Square'              then d:=@NP0.Square          else
    if a1='NP0.tau_m'               then d:=@NP0.tau_m0          else
    if a1='NP0.n_AP'                then d:=@NP0.n_AP            else
    if a1='NP0.gNaR'                then d:=@NP0.gNaR            else
    if a1='NP0.gNa'                 then d:=@NP0.gNa          else
    if a1='NP0.gK'                  then d:=@NP0.gK              else
    if a1='NP0.gKM'                 then d:=@NP0.gKM             else
    if a1='NP0.gKA'                 then d:=@NP0.gKA             else
    if a1='NP0.gKD'                 then d:=@NP0.gKD             else
    if a1='NP0.gCaH'                then d:=@NP0.gCaH            else
    if a1='NP0.gKCa'                then d:=@NP0.gKCa            else
    if a1='NP0.gADP'                then d:=@NP0.gADP            else
    if a1='NP0.gAHP'                then d:=@NP0.gAHP            else
    if a1='NP0.gCaT'                then d:=@NP0.gCaT            else
    if a1='NP0.gBst'                then d:=@NP0.gBst            else
    if a1='NP0.gNaP'                then d:=@NP0.gNaP            else
    if a1='NP0.gL'                  then d:=@NP0.gL              else
    if a1='uu'                      then d:=@uu              else
    if a1='ss'                      then d:=@ss              else
    if a1='NP0.a1NaR'               then d:=@NP0.a1NaR           else
    if a1='NP0.a2NaR'               then d:=@NP0.a2NaR           else
    if a1='NP0.a3NaR'               then d:=@NP0.a3NaR           else
    if a1='NP0.b1NaR'               then d:=@NP0.b1NaR           else
    if a1='NP0.b2NaR'               then d:=@NP0.b2NaR           else
    if a1='NP0.b3NaR'               then d:=@NP0.b3NaR           else
    if a1='NP0.c1NaR'               then d:=@NP0.c1NaR           else
    if a1='NP0.c2NaR'               then d:=@NP0.c2NaR           else
    if a1='NP0.c3NaR'               then d:=@NP0.c3NaR           else
    if a1='NP0.d1NaR'               then d:=@NP0.d1NaR           else
    if a1='NP0.d2NaR'               then d:=@NP0.d2NaR           else
    if a1='NP0.d3NaR'               then d:=@NP0.d3NaR           else
    if a1='NP0.d4NaR'               then d:=@NP0.d4NaR           else
    if a1='NP0.Tr_NaR'              then d:=@NP0.Tr_NaR          else
    if a1='NP0.VNaR'                then d:=@NP0.VNaR            else
    if a1='NP0.VNa'                 then d:=@NP0.VNa             else
    if a1='NP0.VK'                  then d:=@NP0.VK              else
    if a1='NP0.VL'                  then d:=@NP0.VL              else
    if a1='NP0.EIF_deltaT'          then d:=@NP0.EIF_deltaT      else
    if a1='NP0.EIF_tauw'            then d:=@NP0.EIF_tauw        else
    if a1='NP0.EIF_a'               then d:=@NP0.EIF_a           else
    if a1='NP0.EIF_dw'              then d:=@NP0.EIF_dw          else
    if a1='KeepParams'          then i:=@KeepParams      else
    if a1='Vh'                  then d:=@Vh              else
    if a1='FC_dFdu'             then d:=@FC_dFdu         else
    if a1='FC_I0'               then d:=@FC_I0           else
    if a1='FC_freq'             then d:=@FC_freq         else
    if a1='File_u_s'            then s:=@File_u_s        else
    if a1='NoiseToSignal'       then d:=@NoiseToSignal   else
    if a1='tau_E'               then d:=@tau_E           else
    if a1='tau_I'               then d:=@tau_I           else
    if a1='sc_Simplex'          then d:=@sc_Simplex      else
    if a1='SmplFile[Smpl]'      then s:=@SmplFile[Smpl]  else
    if a1='IfDataIn1column'     then i:=@IfDataIn1column         else
    if a1='Smpl'                then i:=@Smpl            else
    if a1='Freq_Iind'           then d:=@Freq_Iind       else
                                IfFail:=1; { If 'a1' has not been recognised }
    if IfFail=0 then begin
       { Assign value 'a2' to the variable }
       if (IfItIsNumber(a2))or(a2='true')or(a2='false') then begin
          if d<>@dv then  d^:=StrToFloat(a2);
          if i<>@iv then  i^:=StrToInt(a2);
          if b<>@bv then  if a2='true'  then b^:=true else
                          if a2='false' then b^:=false;
          Form1.ParamsMemo.Lines.Add(a1+':='+a2+';');
       end else
          if s<>@sv then begin
             s^:=a2;
             Form1.ParamsMemo.Lines.Add(a1+':='+chr(39)+a2+chr(39)+';');
          end;
    end;
  end;

  procedure Assignment;
  begin
    read(fff,c);
    if c<>'=' then begin
       Form1.SimplexMemo.Lines.Add('Bad format of input file');
    end;
    read(fff,c);
    { Read the word of value 'a2'}
    a1:=a2;   {word of identifier}
    ReadWord(a2);
    ChooseVarAndAssignValue(a1,a2);
  end;

begin
  assign(fff,FileName); reset(fff);
  istart:=0; { define if reading mark is behind the 'FirstWord' }
  if FirstWord='Any' then istart:=1;
  a1:=''; a2:='';
  NextGoodLetter;
  REPEAT { global reading }
      { Read the word 'a2' }
      a1:=a2;
      ReadWord(a2);
      { Analyze the final letter 'c' }
      if c=' ' then Blank;
      if c='{' then Comment;
      if a2=FirstWord then istart:=1;
//      if eof(fff) or eoln(fff) then a2:='';
      if eoln(fff) then readln(fff);
      if (c=':') and (istart=1) then  Assignment;
  UNTIL eof(fff) or (a2=LastWord);
  close(fff);
end;

end.
