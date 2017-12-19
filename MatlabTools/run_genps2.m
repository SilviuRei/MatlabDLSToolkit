function run_genps2(nume, numfisfr, dmin, pas, dmax, theta, lambda, indref, tcelsius, optsav, fgr)
%
% functia genreaza un set de serii temporale pornind de la dmin, cu pasul
% pas pan ala dmax, toate un nm
% salveaza si fisierrul cu valorile a0 si a1 pentru fiecare diametru
i=0;
for diam=dmin:pas:dmax
    i=i+1;
    d(i)=diam;
    [f,amp]=genps2(nume, numfisfr, diam, theta, lambda, indref, tcelsius, optsav, fgr);
end
%