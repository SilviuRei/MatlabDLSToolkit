function [tdls,tnn]=test_timp_fitare
[indref,lambda,tcelsius,theta]=initconst4(30)
lambda=lambda*1.e-9;
tic
%run_chi2dlslsq3('t-','-11025-32769-65536', 30, 50, 580,theta,indref,lambda,tcelsius,10,0.0,1.e8,100,5,5000,0,'fig')
run_chi2dlslsq3('fe3o4-','-50-f-50-1', 25, 25, 300,theta,indref,lambda,tcelsius,1.e8,0.0,1.e11,800,1,5000,2,'fig')
tdls=toc
%
load('D:\simdif\Experimente\2016\DLS_30grade-11KHz-new8\Preparation-NN-p2-16\nn22_30gr_5_225.mat')
tic
d_Fe3O4_nn22=sim(nn22_30gr_5_225,a_Fe3O4_nn22)
tnn=toc
%