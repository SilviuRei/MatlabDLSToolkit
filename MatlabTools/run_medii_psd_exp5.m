function run_medii_psd_exp5(nume, text, dmin, pas, dmax, ngrup, extgraf,optprel, optgraf)
%
% functia mediaza fisierul .fps pe ngrup intervale
% considera fisier obtinut in experiment
%
i=0;
for diam=dmin:pas:dmax
    i=i+1;
    d(i)=diam;
    numefis=[nume,int2str(diam),text];
%    [medii]=medii_psd4(numefis,'fps',ngrup,'jpg',2);
    medii_psd5(numefis,'fps',ngrup,extgraf,optprel, optgraf);
end
%