function [a,d]=run_load_g34(nume,dmin,pas,dmax,nvaldiam,theta,lambda,indref,tcelsius,fs,nf,nt,ngrup,opt);
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
    for jd=1:nvaldiam
        i=i+1; 
        d(i)=dd;   % trece in vectorul d valoarea curenta
        [t,x,a0,a1]=gents34(nume, d(i), theta, lambda, indref,tcelsius, fs, nf, nt, 0); %nu scrie fisierul
        if opt >= 1
            numefis=[nume,'-',int2str(dd),'-',int2str(jd),'-',int2str(fs),'-',int2str(nf),'-',int2str(nt)];
            save([numefis,'.ext'],'x','-ascii'); % salveaza fisierul din aceasta functie
        end
        % calculeaza psd
        [buf]=ps_dls5(numefis,fs,2,0,'png',0); % scrie doar fisierul fps pe disc nu si graficul
        [medii]=medii_psd5(numefis,'fps',ngrup,'png',2, 0);
        a(:,i)=medii(:,2);    %ia coloana cu media PS si o atribuie coloanei din a
    end
end
%
save([nume,'-',int2str(dmin),'-',int2str(pas),'-',int2str(dmax),'-',int2str(nvaldiam),'_inputg34.fps'],'a','-ascii')
save([nume,'-',int2str(dmin),'-',int2str(pas),'-',int2str(dmax),'-',int2str(nvaldiam),'_d_inputg34.txt'],'d','-ascii')
%


