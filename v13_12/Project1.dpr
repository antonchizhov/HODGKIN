program Project1;

{%File '_ObjectsOfNeuron\set_VTh(dVdt)_Chow.dat'}
{%File '_ObjectsOfNeuron\set_VTh(dVdt)_Lyle.dat'}

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1 - main},
  Unit2 in 'Unit2.pas' {Form2 - ActInact},
  Unit3 in 'Unit3.pas' {Form3 - Threshold for refractory neuron},
  Unit4 in 'Unit4.pas' {Form4 - Parameters},
  Unit5 in 'Unit5.pas' {Form5 - Frequency},
  Unit6 in 'Unit6.pas' {Form6 - Adaptation},
  Unit7 in 'Unit7.pas' {Form7 - RateOfGaussianEnsemble},
  Unit8 in 'Unit8.pas' {Form8 - Firing-Clamp},
  Unit9 in 'Unit9.pas' {Form9 - nu(u,s)},
  Unit10 in 'Unit10.pas' {Form10 - Plot of "SaveAnyCurve" },
  Unit11 in 'Unit11.pas' {Form11 - Menu for messages},
  Unit12 in '_ObjectsOfNeuron\Unit12.pas' {Form12 - FiberO},
  Unit13 in 'Unit13.pas' {Form13 - Statistics },
  Unit14 in 'Unit14.pas' {Form14 - Z-function to correct F-C },
  Unit15 in 'Unit15.pas' {Form15 - Synaptic Current for the Net},
  Unit16 in 'Unit16.pas' {Form16 - Show (u_s)-plane},
  Unit17 in 'Unit17.pas' {Form17 - Hodgkin-Huxley approximations},
  Unit18 in 'Unit18.pas' {Form18 - ramps and steps},
  Unit20 in 'Unit20.pas' {Form20 - Distributed model},
  Unit31 in 'Unit31.pas' {Form31 - RampAnalyzer},
  HHUnit18 in '_ObjectsOfNeuron\HHUnit18.pas' {HHForm18},
  Act_Inact in 'Act_Inact.pas',
  AMRandom in 'amrandom.pas',
  BackUp in 'BackUp.pas',
  Coeff in 'Coeff.pas',
  Clamp in 'Clamp.pas',
  ControlNrn in 'ControlNrn.pas',
  Electrode in 'Electrode.pas',
  FC_control in 'FC_control.pas',
  Fiber_f_I_curve in 'Fiber_f_I_curve.pas',
  FiringClamp in 'FiringClamp.pas',
  function_Z in 'function_Z.pas',
  Graph in 'Graph.pas',
  HH_canal in 'HH_canal.pas',
  HH_Migli in 'HH_migli.pas',
  HH_Chow in 'HH_Chow.pas',
  HH_Cummins in 'HH_Cummins.pas',
  HH_Lyle in 'HH_Lyle.pas',
  Hodgkin in 'Hodgkin.pas',
  Init in 'Init.pas',
  LIF in 'LIF.pas',
  MyTypes in 'MyTypes.pas',
  Net in 'Net.pas',
  Noise in 'Noise.pas',
  Other in 'Other.pas',
  RateOfGaussian in 'RateOfGaussian.pas',
  Reader in 'Reader.pas',
  ReducedEq in 'ReducedEq.pas',
  RunFiber in 'RunFiber.pas',
  RampMain in 'RampMain.pas',
  Simplex in 'Simplex.pas',
  Statistics in 'Statistics.pas',
  Threshold in 'Threshold.pas',
  Threads in 'Threads.pas',
  Thread_u_s in 'Thread_u_s.pas',
  Thread_FC in 'Thread_FC.pas',
  ADPO in '_ObjectsOfNeuron\ADPO.pas',
  AHPO in '_ObjectsOfNeuron\AHPO.pas',
  BstO in '_ObjectsOfNeuron\BstO.pas',
  Calmar_KO in '_ObjectsOfNeuron\Calmar_KO.pas',
  Calmar_NaO in '_ObjectsOfNeuron\Calmar_NaO.pas',
  Calmar_NaRO in '_ObjectsOfNeuron\Calmar_NaRO.pas',
  ChannelO in '_ObjectsOfNeuron\ChannelO.pas',
  Chow_NaO in '_ObjectsOfNeuron\Chow_NaO.pas',
  Chow_NaRO in '_ObjectsOfNeuron\Chow_NaRO.pas',
  Chow_KO in '_ObjectsOfNeuron\Chow_KO.pas',
  CondBasedO in '_ObjectsOfNeuron\CondBasedO.pas',
  CreateNrnO in '_ObjectsOfNeuron\CreateNrnO.pas',
  Cum_CaHO in '_ObjectsOfNeuron\Cum_CaHO.pas',
  Cum_CaTO in '_ObjectsOfNeuron\Cum_CaTO.pas',
  Cum_KAO in '_ObjectsOfNeuron\Cum_KAO.pas',
  Cum_KDO in '_ObjectsOfNeuron\Cum_KDO.pas',
  Cum_KO in '_ObjectsOfNeuron\Cum_KO.pas',
  Cum_NaO in '_ObjectsOfNeuron\Cum_NaO.pas',
  Cum_NaRO in '_ObjectsOfNeuron\Cum_NaRO.pas',
  Dest_CaTO in '_ObjectsOfNeuron\Dest_CaTO.pas',
  Dest_CaHO in '_ObjectsOfNeuron\Dest_CaHO.pas',
  Dest_KCaO in '_ObjectsOfNeuron\Dest_KCaO.pas',
  Dest_KMO in '_ObjectsOfNeuron\Dest_KMO.pas',
  Dest_KO in '_ObjectsOfNeuron\Dest_KO.pas',
  FiberO in '_ObjectsOfNeuron\FiberO.pas',
  Fleid_NaO in '_ObjectsOfNeuron\Fleid_NaO.pas',
  KepecsWang_KCaO in '_ObjectsOfNeuron\KepecsWang_KCaO.pas',
  Konon_NaPO in '_ObjectsOfNeuron\Konon_NaPO.pas',
  LIFNrnO in '_ObjectsOfNeuron\LIFNrnO.pas',
  Lyle_HO in '_ObjectsOfNeuron\Lyle_HO.pas',
  Lyle_KAO in '_ObjectsOfNeuron\Lyle_KAO.pas',
  Lyle_KDO in '_ObjectsOfNeuron\Lyle_KDO.pas',
  Lyle_KMO in '_ObjectsOfNeuron\Lyle_KMO.pas',
  Lyle_KO in '_ObjectsOfNeuron\Lyle_KO.pas',
  Lyle_NaO in '_ObjectsOfNeuron\Lyle_NaO.pas',
  Lyle_NaRO in '_ObjectsOfNeuron\Lyle_NaRO.pas',
  Lyle_NaPO in '_ObjectsOfNeuron\Lyle_NaPO.pas',
  LyleMS_NaRO in '_ObjectsOfNeuron\LyleMS_NaRO.pas',
  LyleMS_NaO in '_ObjectsOfNeuron\LyleMS_NaO.pas',
  Mainen_NaO in '_ObjectsOfNeuron\Mainen_NaO.pas',
  Mainen_NaRO in '_ObjectsOfNeuron\Mainen_NaRO.pas',
  MathMyO in '_ObjectsOfNeuron\MathMyO.pas',
  Migli_KAO in '_ObjectsOfNeuron\Migli_KAO.pas',
  Migli_KO in '_ObjectsOfNeuron\Migli_KO.pas',
  Migli_NaO in '_ObjectsOfNeuron\Migli_NaO.pas',
  Migli_NaRO in '_ObjectsOfNeuron\Migli_NaRO.pas',
  Milescu_NaO in '_ObjectsOfNeuron\Milescu_NaO.pas',
  Milescu_NaRO in '_ObjectsOfNeuron\Milescu_NaRO.pas',
  Naundorf_KO in '_ObjectsOfNeuron\Naundorf_KO.pas',
  Naundorf_NaO in '_ObjectsOfNeuron\Naundorf_NaO.pas',
  Naundorf_NaO1 in '_ObjectsOfNeuron\Naundorf_NaO1.pas',
  NeuronO in '_ObjectsOfNeuron\NeuronO.pas',
  NullChannelO in '_ObjectsOfNeuron\NullChannelO.pas',
  Shu_NaO in '_ObjectsOfNeuron\Shu_NaO.pas',
  Shu_NaRO in '_ObjectsOfNeuron\Shu_NaRO.pas',
  Shu_KO in '_ObjectsOfNeuron\Shu_KO.pas',
  SetNrnParsO in '_ObjectsOfNeuron\SetNrnParsO.pas',
  typeNrnParsO in '_ObjectsOfNeuron\typeNrnParsO.pas',
  ThreshNrnO in '_ObjectsOfNeuron\ThreshNrnO.pas',
  t_dtO in '_ObjectsOfNeuron\t_dtO.pas',
  ThresholdO in '_ObjectsOfNeuron\ThresholdO.pas',
  White_AHPO in '_ObjectsOfNeuron\White_AHPO.pas',
  White_CaO in '_ObjectsOfNeuron\White_CaO.pas',
  White_KO in '_ObjectsOfNeuron\White_KO.pas',
  White_NaO in '_ObjectsOfNeuron\White_NaO.pas',
  White2_NaO in '_ObjectsOfNeuron\White2_NaO.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TForm11, Form11);
  Application.CreateForm(TForm12, Form12);
  Application.CreateForm(TForm13, Form13);
  Application.CreateForm(TForm14, Form14);
  Application.CreateForm(TForm15, Form15);
  Application.CreateForm(TForm16, Form16);
  Application.CreateForm(TForm17, Form17);
  Application.CreateForm(THHForm18, HHForm18);
  Application.CreateForm(TForm18, Form18);
  Application.CreateForm(TForm20, Form20);
  Application.CreateForm(TForm31, Form31);
  Application.Run;
end.
