function [medie]=preltexinst(nume,ext)
%
%   Functia citeste fiserul scris de DAQ Texas Instr, dupa ce s-au taiat cu
%   editorul primele randuri si scrie un fisier pe disc cu un vector
%   coloana continand valorile tensiunii 
%   Variabilele de intrare sunt:
%       nume numele fisierului fara extensie
%       ext este extensia fsierului pe care il scrie pe disc
%   Calculaeza media si o returneaza ca parametru de
%   iesire si o afizeaza si pe ecran.
%
numeinn=[nume,'.txt'];
mat=load(numeinn,'-ascii');   %incarca fisierul
[m,n]=size(mat);
%disp(['   Numar de inregistrari: ',int2str(m)]);
%
fid1 = fopen([nume,'.',ext],'w');
for k=1:m
    fprintf(fid1, '%7.4g \n', mat(k,2));
end %k
fclose(fid1);
disp(['Fisierul ',numeinn,' contine: ',int2str(m),' inregistrari'])
medie=mean(mat(:,2));
disp(['Media valorilor este: ',num2str(medie)]);
disp(' ');
%