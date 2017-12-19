function run_ps_dls1(text,nrmin,nrmax, pas,frecvachiz,tip,opt)
%
% run_ps_dls1(text,nrmin,nrmax, pas,frecvachiz,tip,opt)
%
% functia citeste fisierele scrise slicer
% calculeaza fisierul cu frecventa si amplitudinea puterii si screi
% fisierul cu extensia fps
% fisier care contine distanta si valoarea medie
%
for k=nrmin:pas:nrmax
    nume=[text,int2str(k)];
    disp(['Execut fisierul ',nume]);
    ps_dls1(nume,frecvachiz,tip,opt)
end
%