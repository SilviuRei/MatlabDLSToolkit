function run_filtru1(text1,text2,nrmin,nrmax,pas,ext_fis,valmin,valmax)
%
% run_filtru1(text1,text2,nrmin,nrmax,pas,ext_fis,valmin,valmax)
%
% functia citeste fisierele scrise de ps_dls5
%
for k=nrmin:pas:nrmax
    nume=[text1,int2str(k),text2];
    disp(['Execut fisierul ',nume]);
    [y1,y2]=filtru1(nume, ext_fis, valmin, valmax);
end
%