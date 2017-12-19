function []=batch4_2(f1, f2, y1, y2,ext,isave)
%
%Functia doar executa secventa, are ca parametrii frecventele si maximele
%Este scrisa pentru versiunea 4 a functiei analizor, respectiv analizor4
%
%
rez=analizor4('.\date\water','water',40,f1,f2,y1,y2,ext,isave);
keyboard;
rez=analizor4('.\date\oldmilk-prb23','oldmilk-prb23',40,f1,f2,y1,y2,ext,isave);
keyboard;
rez=analizor4('.\date\freshmilk-prb22','freshmilk-prb22',40,f1,f2,y1,y2,ext,isave);
keyboard;
keyboard;
rez=analizor4('.\date\orange-prb24','orange-prb24',40,f1,f2,y1,y2,ext,isave);
keyboard;
rez=analizor4('.\date\blood-prb26','blood-prb26',40,f1,f2,y1,y2,ext,isave);
keyboard;
rez=analizor4('.\date\u-prb25','u-prb25',40,f1,f2,y1,y2,ext,isave);
keyboard;
rez=analizor4('.\date\flo-prb31','flour-prb31',40,f1,f2,y1,y2,ext,isave);
%rez=analizor4('.\date\dark','dark',40,f1,f2,y1,y2,ext,isave);
%rez=analizor4('.\date\laser','laser',40,f1,f2,y1,y2,ext,isave);
%
