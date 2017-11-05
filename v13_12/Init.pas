unit Init;

interface
uses
  Windows,Messages,SysUtils,Classes,Graphics,Controls,Forms,Dialogs,StdCtrls,
  MyTypes,MathMyO,typeNrnParsO;

var
    ThrNeuron,FullNeuron                        :NrnRec;
    ISI                                         :vect;

    told,t_end,
    Vr,Vh,Isyn,DispV
                                                :double;
    nt,nt_end,
    Smpl,NSmpls,
    WriteOrNot, IfInSyn_al_EQ_beta,
    n_Draw,n_Write,
    KeepParams,nue,nse,IIspike, IfDataIn1column,
    moveLeg, IfWriteInFFF,IfDrawAskedCurve,
    IfStartStat
                                                :integer;
    name,ParFile,MainDir,File_u_s               :string;
    aaa,vvv,ddd,ccc,fff,nnn,zzz,ttt             :text;
    StopKey                                     :char;
    { for Simplex }
    mC,ndim, istop,nFunk
                                                :integer;
    g,g_dg,LimL,LimR                            :longvect;
    ifC,iC_ig,ig_iC                             :vectint;
    strC                                        :vecstr;
    Functional,sc_Simplex                       :double;
    t1,t2                                       :string;
    SmplFile                                    :vecSmpl;

    { for Exp.Data }
    Vexp,Vmod                                   :vecExp;
    scx_Smpl,scy_Smpl,shift_Smp
                                                :double;

    { for H-H ***************************************************}

    { Parameters and variables used in TNeuron }
    NP0                                         :NeuronProperties;
    NV0                                         :NeuronVariables;

    { Control vars }
    ss,uu,tt,s_soma                                         :double;

    { Other stuff }
    {Gs,}tau1,Vrev_for_g,sgm_V,
    Iind,t_Iind,t_IindShift,Freq_Iind, du_Reset,dt_Reset,
//    INa,IK,IKM,IKA,IKD,IKCa,IH,IAHP,ICaH,ICaT,IBst,INaP,INaR,
    a1K,a2K,a3K,a4K,b1K,b2K,b3K,b4K,
    tau_mm,tau_hh,tau_ii,
    avVmax,Vmin_prev, freq,tAP1,tAP2,WidthAP,
    Vav,avPSC,avPSC_prev,Vav_prev,avVmin,Vmin,Vmax,VT_1ms,
    Vweigh,Vweigh_prev,
    V_Conv,VxZ,IxZ,
    NoiseToSignal,tau_E,tau_I,tau_Noise
                                                            :double;
    MyWarning
                                                            :string;

{--------------------EOF---------------------------------------------------}
implementation

end.
