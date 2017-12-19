function []=batch4(f1, f2, y1, y2)
%
%Functia doar executa secventa, are ca parametrii frecventele si maximele
%Este scrisa pentru versiunea 4 a functiei analizor, respectiv analizor4
%
%
rez=analizor4('.\date\oldmilk-prb23','oldmilk-prb23',40,f1,f2,y1,y2);
rez=analizor4('.\date\freshmilk-prb22','freshmilk-prb22',40,f1,f2,y1,y2);
rez=analizor4('.\date\orange-prb24','orange-prb24',40,f1,f2,y1,y2);
rez=analizor4('.\date\laser','laser',40,f1,f2,y1,y2);
rez=analizor4('.\date\dark','dark',40,f1,f2,y1,y2);
%
