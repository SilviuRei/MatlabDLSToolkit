function run_gents36(nume, dmin, pas, dmax, theta, lambda, indref, tcelsius, fs, nt, opt)
%
% functia genereaza un set de serii temporale pornind de la dmin, cu pasul
% pas panala dmax, toate un nm
% salveaza si fisierrul cu valorile a0 si a1 pentru fiecare diametru
i=0;
for diam=dmin:pas:dmax
    i=i+1;
    d(i)=diam;
    [t,x,a0(i),a1(i)]=gents36(nume, diam, theta, lambda, indref, tcelsius, fs, nt, opt);
end
rez=[d',a0',a1'];
save([nume,'-diam-a0-a1-gents36.txt'],'rez','-ascii')
%