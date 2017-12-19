function run_gents32(nume, dmin, pas, dmax, theta, lambda, indref, tcelsius, fs, nf, nt, opt)
%
% functia genereaza un set de serii temporale pornind de la dmin, cu pasul
% pas pan ala dmax, toate un nm
% salveaza si fisierrul cu valorile a0 si a1 pentru fiecare diametru
i=0;
for diam=dmin:pas:dmax
    i=i+1;
    d(i)=diam;
    [t,x,a0(i),a1(i)]=gents32(nume, diam, theta, lambda, indref, tcelsius, fs, nf, nt, opt);
end
rez=[d',a0',a1'];
save([nume,'-diam-a0-a1-gents32.txt'],'rez','-ascii')
%