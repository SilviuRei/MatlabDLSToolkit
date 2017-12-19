function [a,d]=load_g1(nume, dmin, pas, dmax, fs, nf, nt,ng);
%
% functia incarca matricea cu fps pe grupuri si normalizata, cate un set pt
% un diametru pe cate o coloana si ao salveaza ca nume_input.fps. la fel
% diametrele un vector linie nume_d_input.txt
%
i=0
for dd=dmin:pas:dmax
    i=i+1;
    d(i)=dd;   % trece in vectorul d valoarea curenta
    numefis=[nume,'-',int2str(dd),'-',int2str(fs),'-',int2str(nf),'-',int2str(nt),'-',int2str(ng),'-medgr-norm.fps']
    buf=load(numefis,'-ascii');
    a(:,i)=buf(:,2);    %ia coloana cu media PS si o atribuie coloanei
    end
%
save([nume,'_input.fps'],'a','-ascii')
save([nume,'_d_input.txt'],'d','-ascii')
%


