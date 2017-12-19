function [a,d]=load_ts36(nume,dmin,pas,dmax,theta,lambda,indref,tcelsius,fs,nt,optsav);
%
% functia incarca matricea cu serii temporale, cate o serie pe cate o
% coloana, cate o coloana pentru fiecare diametru
% seriile sunt genreate cu gents36 
% 
% Daca opt este >=1 va scrie si fisierul cu matricea, ascii, pe disc, cu
% extensia ext si fisierul cu valorile diametrelor, a0 si a1 pentru fiecare
% serie
%
t1=clock;
texpas=0;
nrpasi=(dmax-dmin)/pas;
i=0;
for dd=dmin:pas:dmax
    tic
    i=i+1;
    d(i)=dd;   % trece in vectorul d valoarea curenta
    [t,a(:,i),a0(i,1),a1(i,1)]=gents36(nume, d(i), theta, lambda, indref, tcelsius, fs, nt, 0);
    texpas=toc;
    tramas=(nrpasi-i)*texpas/60; %timpul aprox ramas
    disp(['i: ',int2str(i),' t.r.m.: ',num2str(tramas)])
end
%
rez=[d',a0,a1]; %le aduna intr-o matrice pt verificare cu fitare
%
if optsav >= 1 % vrea scris fisierul psd pe disc
    save([nume,'-',int2str(dmin),'-',int2str(pas),'-',int2str(dmax),'_ts_g36.ext'],'a','-ascii')
    save([nume,'-',int2str(dmin),'-',int2str(pas),'-',int2str(dmax),'_d_g36.txt'],'d','-ascii')
    save([nume,'-',int2str(dmin),'-',int2str(pas),'-',int2str(dmax),'_d_a0_a1_g36.txt'],'rez','-ascii')
end
t2=etime(clock,t1);
disp(['durata executiei pentru',int2str(nrpasi),' diametre este: ',num2str(t2/3600),' ore'])
%


