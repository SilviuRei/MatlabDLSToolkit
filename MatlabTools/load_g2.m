function [a]=load_g2(nume, text, dmin, pas, dmax);
%
% functia incarca matricea cu fps pe grupuri si normalizata, cate un set pt
% un diametru pe cate o coloana si ao salveaza ca nume_input.fps. la fel
% diametrele un vector linie nume_d_g2_input.txt
% Fata de versiunea 1 poate prelua si date experimentale, fisiere dupa
% filtrare si se foloseste la generarea marticii de intrate pt nn dupa training ca sa 
% calculeze diamtrele
%
i=0
for dd=dmin:pas:dmax
    i=i+1;
    d(i)=dd;   % trece in vectorul d valoarea curenta
    numefis=[nume,int2str(dd),text,'.fps']
    buf=load(numefis,'-ascii');
    a(:,i)=buf(:,2);    %ia coloana cu media PS si o atribuie coloanei
    end
%
save([nume,'-',text,'_input.fps'],'a','-ascii')
%save([nume,'_d_input.txt'],'d','-ascii')
%


