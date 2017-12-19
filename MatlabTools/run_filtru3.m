function run_filtru3(text1,text2,nrmin,nrmax,pas,ext_fis,fr,deltafr, frmaxfil,opt, fgr)
%
% run_ps_dls5(text1,text2,nrmin,nrmax, pas,frecvachiz,nr1,nr2,tip,opt)
%
% functia citeste fisierele scrise slicer
% calculeaza fisierul cu frecventa si amplitudinea puterii si screi
% fisierul cu extensia fps
% fisier care contine distanta si valoarea medie
%
for k=nrmin:pas:nrmax
    nume=[text1,int2str(k),text2];
    disp(['Execut fisierul ',nume]);
    [y]=filtru3(nume, ext_fis, fr, deltafr, frmaxfil, opt, fgr);
end
%