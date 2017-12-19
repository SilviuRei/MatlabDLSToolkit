function run_gents1(nume, dmin, pas, dmax, theta, lambda, tcelsius, fs, nf, nt, opt)
%
% functia genreaza un set de serii temporale pornind de la dmin, cu pasul
% pas pan ala dmax, toate un nm
% salveaza si fisierrul cu valorile a0 si a1 pentru fiecare diametru
i=0;
for diam=dmin:pas:dmax
    i=i+1;
    d(i)=diam;
    [t,x,a0(i),a1(i)]=gents1(nume, diam, theta, lambda, tcelsius, fs, nf, nt, opt);
end
rez=[d',a0',a1'];
save([nume,'-diam-a0-a1-generate.txt'],'rez','-ascii')
%