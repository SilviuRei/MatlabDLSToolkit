function run_ps_dls52(nume,frecv,plui2,fr,deltafr,nr1,nr2,tip,optps,optfiltru)
%
% run_ps_dls52
%
% functia citeste fisierul ext inreg. experimental, il imparte in felii
% apoi calculeaza fs pe fiecare felie, il salveaza
% in continuare aplica flitru 2 pe frecventa de 50 Hz si armonicile
% scrie fisierul cu extensia fps
%
numefis=[nume,'.','ext'];
atot=load(numefis);
[m,m1]=size(atot);
nrvalset=2^plui2;
nrslices=floor(m/nrvalset); %atatea felii va prelucra
rest=rem(m,nrvalset);
disp(['Fisierul complet are: ', int2str(m), ' inregistrari']);
disp(['Un set contine      : ', int2str(nrvalset), ' inregistrari']);
disp(['Nr. de seturi este  : ', int2str(nrslices)]);
disp(['Raman neprelucrate  : ', int2str(rest), 'valori']);
%
% le prelucreaza pe rand
%
for k=1:nrslices
    numeslice=[nume,'-plui2-',int2str(plui2),'-slice-',int2str(k)];
    disp(numeslice);
    a=atot(((k-1)*nrvalset+1):k*nrvalset);
    [buf1]=ps_dls52(numeslice,a,frecv,plui2,nr1,nr2,tip,optps);
    [y]=filtru2(numeslice,'fps', fr, deltafr, optfiltru, tip);
end
%