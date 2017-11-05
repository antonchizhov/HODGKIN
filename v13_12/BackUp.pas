unit BackUp;

interface
procedure WriteInBackUpFile;
procedure ReadInBackUpFile;

implementation
uses sconnect,sysutils,MyTypes,MathMyO,Init,t_dtO,Clamp;

procedure WriteInBackUpFile;
var b :File;
    i: Integer;
begin
  AssignFile(vvv,'settings.bak'); rewrite(vvv);
  AssignFile(b,'safeArrs.bak'); rewrite(b);
  writeln(vvv,
    t,' ',told,' ', dt,' ',t_end,' ',
    NV0.Vold,' ',avVmax,' ',freq,' ',NV0.tAP,' ',
    ThrNeuron.V,' ',ThrNeuron.VE,' ',NV0.DVDt,' ',
    ThrNeuron.nn,' ',
    Vr,' ',NV0.PSC,' ',Vh,' ',NP0.n_AP);
//                                                :double;
  writeln(vvv,
    nt,' ',nt_end,' ',
    Smpl,' ',NSmpls,' ',
    WriteOrNot,' ', NP0.If_I_V_or_g,' ', IfInSyn_al_EQ_beta,' ',
    n_Draw,' ',n_Write,' ',
    KeepParams,' ',NV0.indic,' ',nue,' ',nse,' ',IIspike,' ', IfDataIn1column,' ',
    NP0.IfBlockNa,' ',NP0.IfBlockK,' ',NP0.IfBlockKM,' ',NP0.IfBlockKA,' ',NP0.IfBlockPass,' ',NP0.IfBlockNaR,' ',
    NP0.IfReduced,' ', moveLeg);
//                                                :integer;
  writeln(vvv,
    name);writeln(vvv,ParFile);
//                                   :string;
    { for Simplex }
  writeln(vvv,
    mC,' ',ndim,' ', istop,' ',nFunk);
//                                                :integer;
//  write(vvv,
    i:=SizeOf(longvect);
    BlockWrite(b,g,i);BlockWrite(b,g_dg,i);BlockWrite(b,LimL,i);BlockWrite(b,LimR,i);
//                                :longvect;
//  writeln(vvv,
    i:=SizeOf(vectint);
    BlockWrite(b,ifC,i);BlockWrite(b,iC_ig,i);BlockWrite(b,ig_iC,i);
//                                 :vectint;
//  writeln(vvv,
    i:=SizeOf(vecstr);
    BlockWrite(b,strC,i);
//                                            :vecstr;
  writeln(vvv,
    Functional,' ',sc_Simplex);
//                           :double;
  writeln(vvv,
    t1);writeln(vvv,t2);
//                                           :string;
//  writeln(vvv,
    i:=SizeOf(vecSmpl);
    BlockWrite(b,SmplFile,i);
//                                :array[1..MaxSmpls] of string;

    { for Exp.Data }
//  writeln(vvv,
//    i:=SizeOf(vecExp);
//    BlockWrite(b,Vexp,i);
//               :array[0..MaxExp,' ',1..MaxSmpls] of double;
  writeln(vvv,
    scx_Smpl,' ',scy_Smpl,' ',shift_Smp);
//                                                :double;

    { for H-H }
//  writeln(vvv,
    i:=SizeOf(longvect);
    BlockWrite(b,NV0.mmR,i);BlockWrite(b,NV0.hhR,i);BlockWrite(b,NV0.mm,i);BlockWrite(b,NV0.nn,i);BlockWrite(b,NV0.hh,i);BlockWrite(b,NV0.ii,i);BlockWrite(b, NV0.nM,i);BlockWrite(b,NV0.nA,i);BlockWrite(b,NV0.lA,i);BlockWrite(b,NV0.mCaH,i);BlockWrite(b,NV0.hCaH,i);BlockWrite(b,NV0.kCaH,i);BlockWrite(b,NV0.nKCa,i);BlockWrite(b,NV0.Ca,i);BlockWrite(b,
    NV0.wAHP,i);BlockWrite(b, NV0.mCaT,i);BlockWrite(b,NV0.hCaT,i);BlockWrite(b, NV0.mBst,i);BlockWrite(b,NV0.mNaP,i);BlockWrite(b,
    NV0.nA,i);BlockWrite(b,NV0.lA,i);BlockWrite(b,NV0.xD,i);BlockWrite(b,NV0.yD,i);BlockWrite(b,
    ss,i);BlockWrite(b,uu,i);BlockWrite(b,NP0.gNa,i);BlockWrite(b,NP0.gL,i);BlockWrite(b,NP0.VL,i);BlockWrite(b, NP0.Square,i);BlockWrite(b, NP0.tau_m0,i);BlockWrite(b,NP0.ro,i);BlockWrite(b,NP0.Vrest,i);BlockWrite(b,
    NV0.V,i);BlockWrite(b,NV0.Im,i);BlockWrite(b,NV0.IsynE,i);BlockWrite(b,NV0.IsynI,i);BlockWrite(b,NV0.IsynE_old,i);BlockWrite(b,NV0.VatE,i);
//                                                            :vect2;
  writeln(vvv,
    NV0.gActive,' ',
    NP0.C_membr,' ',NP0.gNaR,' ',NP0.gK,' ',NP0.gKM,' ',NP0.gKA,' ',NP0.gKD,' ',NP0.gCaH,' ',NP0.gKCa,' ',NP0.gAHP,' ',NP0.gCaT,' ',NP0.gBst,' ',NP0.gNaP,' ',
    NP0.VNa,' ',NP0.VNaR,' ',NP0.VK,' ', tau1,' ',
    Iind,' ',t_Iind,' ',t_IindShift,' ',
    NP0.Faraday,' ',NP0.d_Ca,' ',NP0.Ca8,' ',NP0.Ca0,' ',NP0.tauCa,' ',NP0.Temperature,' ',NP0.Rgas,' ',NV0.ICaH,' ',NP0.Tr,' ',
    NV0.INa,' ',NV0.IK,' ',NV0.IKM,' ',NV0.IKA,' ',NV0.IKD,' ',NV0.IKCa,' ',NV0.IAHP,' ',NV0.ICaT,' ',NV0.IBst,' ',NV0.INaP,' ',NV0.INaR,' ',
    NP0.a1Na,' ',NP0.a2Na,' ',NP0.a3Na,' ',NP0.a4Na,' ',NP0.b1Na,' ',NP0.b2Na,' ',NP0.b3Na,' ',NP0.b4Na,' ',
    NP0.c1Na,' ',NP0.c2Na,' ',NP0.c3Na,' ',NP0.c4Na,' ',NP0.d1Na,' ',NP0.d2Na,' ',NP0.d3Na,' ',NP0.d4Na,' ',
    NP0.a1NaR,' ',NP0.a2NaR,' ',NP0.a3NaR,' ',NP0.a4NaR,' ',NP0.b1NaR,' ',NP0.b2NaR,' ',NP0.b3NaR,' ',NP0.b4NaR,' ',
    NP0.c1NaR,' ',NP0.c2NaR,' ',NP0.c3NaR,' ',NP0.c4NaR,' ',NP0.d1NaR,' ',NP0.d2NaR,' ',NP0.d3NaR,' ',NP0.d4NaR,' ',NP0.Tr_NaR,' ',
    a1K,' ',a2K,' ',a3K,' ',a4K,' ',b1K,' ',b2K,' ',b3K,' ',b4K);
//                                                            :double;
  writeln(vvv,
    NP0.HH_type);writeln(vvv,NP0.HH_order);
//                                                            :string;
  close(vvv);
  close(b);
end;

{*******************************************************}

procedure ReadInBackUpFile;
var b :File;
    i: Integer;
begin
  AssignFile(vvv,'settings.bak'); reset(vvv);
  AssignFile(b,'safeArrs.bak'); reset(b);
  Readln(vvv,
    t,told, dt,t_end,
    NV0.Vold,avVmax,freq,NV0.tAP,
    ThrNeuron.V,ThrNeuron.VE,NV0.DVDt,ThrNeuron.nn,
    Vr,NV0.PSC,Vh,NP0.n_AP);
//                                                :double;
  Readln(vvv,
    nt,nt_end,
    Smpl,NSmpls,
    WriteOrNot, NP0.If_I_V_or_g, IfInSyn_al_EQ_beta,
    n_Draw,n_Write,
    KeepParams,NV0.indic,nue,nse,IIspike, IfDataIn1column,
    NP0.IfBlockNa,NP0.IfBlockK,NP0.IfBlockKM,NP0.IfBlockKA,NP0.IfBlockPass,NP0.IfBlockNaR,
    NP0.IfReduced, moveLeg);
//                                                :integer;
  Readln(vvv,
    name);Readln(vvv,ParFile);
//                                   :string;
    { for Simplex }
  Readln(vvv,
    mC,ndim, istop,nFunk);
//                                                :integer;
//  Read(vvv,
    i:=SizeOf(longvect);
    BlockRead(b,g,i);BlockRead(b,g_dg,i);BlockRead(b,LimL,i);BlockRead(b,LimR,i);
//                                :longvect;
//  Readln(vvv,
    i:=SizeOf(vectint);
    BlockRead(b,ifC,i);BlockRead(b,iC_ig,i);BlockRead(b,ig_iC,i);
//                                 :vectint;
//  Readln(vvv,
    i:=SizeOf(vecstr);
    BlockRead(b,strC,i);
//                                            :vecstr;
  Readln(vvv,
    Functional,sc_Simplex);
//                           :double;
  Readln(vvv,
    t1);Readln(vvv,t2);
//                                           :string;
//  Readln(vvv,
    i:=SizeOf(vecSmpl);
    BlockRead(b,SmplFile,i);
//                                :array[1..MaxSmpls] of string;

    { for Exp.Data }
//  Readln(vvv,
//    i:=SizeOf(vecExp);
//    BlockRead(b,Vexp,i);
//               :array[0..MaxExp,1..MaxSmpls] of double;
  Readln(vvv,
    scx_Smpl,scy_Smpl,shift_Smp);
//                                                :double;

    { for H-H }
//  Readln(vvv,
    i:=SizeOf(longvect);
    BlockRead(b,NV0.mmR,i);BlockRead(b,NV0.hhR,i);BlockRead(b,NV0.mm,i);BlockRead(b,NV0.nn,i);BlockRead(b,NV0.hh,i);BlockRead(b,NV0.ii,i);BlockRead(b, NV0.nM,i);BlockRead(b,NV0.nA,i);BlockRead(b,NV0.lA,i);BlockRead(b,NV0.mCaH,i);BlockRead(b,NV0.hCaH,i);BlockRead(b,NV0.kCaH,i);BlockRead(b,NV0.nKCa,i);BlockRead(b,NV0.Ca,i);BlockRead(b,
    NV0.wAHP,i);BlockRead(b, NV0.mCaT,i);BlockRead(b,NV0.hCaT,i);BlockRead(b, NV0.mBst,i);BlockRead(b,NV0.mNaP,i);BlockRead(b,
    NV0.nA,i);BlockRead(b,NV0.lA,i);BlockRead(b,NV0.xD,i);BlockRead(b,NV0.yD,i);BlockRead(b,
    ss,i);BlockRead(b,uu,i);BlockRead(b,NP0.gNa,i);BlockRead(b,NP0.gL,i);BlockRead(b,NP0.VL,i);BlockRead(b, NP0.Square,i);BlockRead(b, NP0.tau_m0,i);BlockRead(b,NP0.ro,i);BlockRead(b,NP0.Vrest,i);BlockRead(b,
    NV0.V,i);BlockRead(b,NV0.Im,i);BlockRead(b,NV0.IsynE,i);BlockRead(b,NV0.IsynI,i);BlockRead(b,NV0.IsynE_old,i);BlockRead(b,NV0.VatE,i);
//                                                            :vect2;
  Readln(vvv,
    NV0.gActive,
    NP0.C_membr,NP0.gNaR,NP0.gK,NP0.gKM,NP0.gKA,NP0.gKD,NP0.gCaH,NP0.gKCa,NP0.gAHP,NP0.gCaT,NP0.gBst,NP0.gNaP,
    NP0.VNa,NP0.VNaR,NP0.VK, tau1,
    Iind,t_Iind,t_IindShift,
    NP0.Faraday,NP0.d_Ca,NP0.Ca8,NP0.Ca0,NP0.tauCa,NP0.Temperature,NP0.Rgas,NV0.ICaH,NP0.Tr,
    NV0.INa,NV0.IK,NV0.IKM,NV0.IKA,NV0.IKD,NV0.IKCa,NV0.IAHP,NV0.ICaT,NV0.IBst,NV0.INaP,NV0.INaR,
    NP0.a1Na,NP0.a2Na,NP0.a3Na,NP0.a4Na,NP0.b1Na,NP0.b2Na,NP0.b3Na,NP0.b4Na,
    NP0.c1Na,NP0.c2Na,NP0.c3Na,NP0.c4Na,NP0.d1Na,NP0.d2Na,NP0.d3Na,NP0.d4Na,
    NP0.a1NaR,NP0.a2NaR,NP0.a3NaR,NP0.a4NaR,NP0.b1NaR,NP0.b2NaR,NP0.b3NaR,NP0.b4NaR,
    NP0.c1NaR,NP0.c2NaR,NP0.c3NaR,NP0.c4NaR,NP0.d1NaR,NP0.d2NaR,NP0.d3NaR,NP0.d4NaR,NP0.Tr_NaR,
    a1K,a2K,a3K,a4K,b1K,b2K,b3K,b4K);
//                                                            :double;
  Readln(vvv,
    NP0.HH_type);Readln(vvv,NP0.HH_order);
//                                                            :string;
  close(vvv);
  close(b);
  CorrespondParametersToTheForm;
end;

end.
