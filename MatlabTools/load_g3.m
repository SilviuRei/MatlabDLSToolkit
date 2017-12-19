function [a,d]=load_g3(nume,dmin,pas,dmax,numfisfr,theta,lambda,indref,tcelsius,optsav);
%
% functia incarca matricea cu fps pe grupuri si normalizata, cate un set pt
% un diametru pe cate o coloana si o salveaza ca nume_input_gen3.fps. la fel
% diametrele un vector linie nume_d_input_gen3.txt
% Fata de versiunea 1 ruleaza functia care genereaza chiar psd, respectiv
% genps2 Nu poate prelua date experimentale ci genereaza matricea pentru nn
% training
% Daca opt este >=1 va scrie si fisierele psd pe disc
%
i=0
for dd=dmin:pas:dmax
    i=i+1;
    d(i)=dd;   % trece in vectorul d valoarea curenta
    [f,amp]=genps2(nume, numfisfr, dd, theta, lambda, indref, tcelsius, optsav, 'png');
    a(:,i)=amp;    %ia coloana cu media PS si o atribuie coloanei
%    if optsav >= 1 % vrea scris fisierul psd pe disc
%        numfispsd=[nume,'-',int2str(dd)]
%    end
end
%
save([nume,'-',int2str(dmin),'-',int2str(pas),'-',int2str(dmax),'_inputg3.fps'],'a','-ascii')
save([nume,'-',int2str(dmin),'-',int2str(pas),'-',int2str(dmax),'_d_inputg3.txt'],'d','-ascii')
%


