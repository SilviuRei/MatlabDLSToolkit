function run_medii_psd3(nume, dmin, pas, dmax, fs, nf, nt, ngrup, opt)
%
% functia genreaza un set de serii temporale pornind de la dmin, cu pasul
% pas pan ala dmax, toate un nm
% salveaza si fisierul cu valorile a0 si a1 pentru fiecare diametru
i=0;
for diam=dmin:pas:dmax
    i=i+1;
    d(i)=diam;
    numefis=[nume,'-',int2str(diam),'-',int2str(fs),'-',int2str(nf),'-',int2str(nt)];
    [medii]=medii_psd3(numefis,'fps',ngrup,'jpg',2);
end
%