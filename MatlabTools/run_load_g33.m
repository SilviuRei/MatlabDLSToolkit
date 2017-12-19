function [a,d]=run_load_g33(nume,dmin,pas,dmax,nvaldiam,numfisfr,theta,lambda,indref,tcelsius,fs,nf,nt,opt);
%
% functia va genera cate nvaldiam valori pentru fiecare diametru, va scrie
% un fisier temporar pe disc cu seria temporala, ii va calcula FS,
% il va media dupa model si va scrie valorile mediate pe disc, si va incarca
% matricea de intrare pentru NN training si o va si salva pe disc impreuna cu
% vectorul linie cu diametrele
%
i=0
for dd=dmin:pas:dmax
    jd=0;    % contorul de diametre, de la 1 la nvaldiam
    for jd=1:10
        i=i+1; 
        d(i)=dd;   % trece in vectorul d valoarea curenta
        [t,x,a0,a1]=gents33(nume, d(i), theta, lambda, indref,tcelsius, fs, nf, nt, opt)
#a(:,i)=amp;    %ia coloana cu media PS si o atribuie coloanei
    end
%
save([nume,'-',int2str(dmin),'-',int2str(pas),'-',int2str(dmax),'_inputg3.fps'],'a','-ascii')
save([nume,'-',int2str(dmin),'-',int2str(pas),'-',int2str(dmax),'_d_inputg3.txt'],'d','-ascii')
%


