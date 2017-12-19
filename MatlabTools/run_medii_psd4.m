function run_medii_psd4(nume, dmin, pas, dmax, fs, nf, nt, ngrup, optprel, optgraf)
%
% functia mediaza fisierul .fps pe ngrup intervale
% salveaza si fisierul cu valorile a0 si a1 pentru fiecare diametru
i=0;
for diam=dmin:pas:dmax
    i=i+1;
    d(i)=diam;
    numefis=[nume,'-',int2str(diam),'-',int2str(fs),'-',int2str(nf),'-',int2str(nt)];
%    [medii]=medii_psd4(numefis,'fps',ngrup,'jpg',2);
    medii_psd4(numefis,'fps',ngrup,'jpg',optprel, optgraf);
end
%