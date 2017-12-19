function chodin8(nume,control,verbose,controls)
%
%   Simuleaza dinamica imprastierii luminii coerente pe suspensii. 
%   Parametrii de apel sunt:
%   - nume - numele fisierului cu datele de intrarea
%   - control; daca control=0 Returneaza un fisier avand un sir de valori,
%               intensitatea in acel punct la momente succesive. Scrie si
%               pozitiile finale ale particulelorin fisier cu extensia .poz
%               Daca control = 1 returneaza un fisier de tip avi. Aria de pe ecran
%               trebuie sa fie un multiplu de 4x4.
%               Daca control = 2 scrie doar matricea cu intensitatea, un
%               fisier cu acelasi nume si cu extensia mat.
%   -verbose: daca este 0 scrie doar timpul estimat
%             daca este 1 scrie la care cadru a ajuns si timpul estimat
%             daca este 2 scrie la care cadru a ajuns si cati centrii
%             activi sunt
%   
%   datele de intrare din fisier sunt:
%       nscat - numarul de centrii de imprastiere
%       amp amplitudinea campului electric in laser, a.u. for now
%       xmin, xmax, ymin, ymax, zmin, zmax, in metri, dimensiunea in care
%       se gasesc centrii de imprastiere
%       decran distanta mijlocul cuvei - cuva ecran
%       xstarte,ystarte, nstepex, nstepey  coordonatele zonei de pe ecran pt
%       care calculeaza imaginea
%       ncad - numarul de cadre, de ecrane care trebuiesc simulate
%       framerate cate cadre pe secunda
%       sigma, in metrii patrati
%       vcentru, volumul centrului de imprastiere, in metrii cubi
%       g, adimensional, valoarea medie a lui miu, adica a lui cos de teta
%       densitatea SC
%       densitatea mediului
%       coef de vascozitate dinamica, in daP
%       temperatura absoluta, in K
%       vsed viteza de sedimentare (VSH pt hematii) Daca este dif de zero
%       atunci in loc de vstokes se ia valoarea data
%       Toate sunt intr-un fisier cu numele nume.inn
%
%   chodin2 ia in calcul si viteza limita Stokes si misc. browniana, cu pas
%   de timp mai mic, prinsa in movesc2
%
%   chodin3 are optiunea de a scrie pe disk matricea cu intensitatea de pe
%   imagine, nu in format bitmap, pentru care se face o scalare pe fiecare
%   imagine, pierzandu-se informatia despre intensitatea medie.
%
%   chodin4 in plus foloseste valoarea vascozitatii calulata prin
%   interpolarea datelor tabelate. La fel pentru densitatea apei.
%
%   Chodin5 genereaza la fiecare cadru o distributie Maxwell-Boltzman dupa
%   viteze cu varianta distributia trebuie sa fie Maxwell-Boltzman, adica normala cu
%   varianta (kt/m).^0.5
%
%   Chodin6 in plus tine seama de miscarea centrilor de imprastiere prin
%   dreptul zonei fasciculului, isi recalculeaza numarul si dimensiunile
%   initiale ale distributiei si sumeaza amplitudinile doar pentru cei care
%   se gasesc in zona fasciculului. Timpul de calcul va creste de cateva
%   ori pe acest motiv.
%  
%   Remarca finala: acelasi fisier de intrare se poate folosi pentru a
%   calcula film, serie temporala si imagine, programul modifica singur
%   numarul de cadre, nr. de pixeli pe imagine fara a modifica fisierul de
%   intrare
%
%   Pentru a rula fara a tine seama de miscarea browniana se alege
%   deltatbrown mai mare ca 1/framerate
%
% In starsit da bine pt. Stokes, ramane sa determin deltatbrown pentru
% fiecare tip de SC
%
%   2014.05.20
%  Versiunea 7 are un parametru de control in plus, respectiv controls
%   care controloeaza daca ia in calcul sedimentare, Brown sau ambele,
%   astfel:
%       -daca controls=0 ia in calcul doar sedimentarea,
%                       face coefdif=0 si vstks=vsed, citit din
%                       nume.inn (bun pentru nesferice ca RBC)
%       -daca controls=1 ia in calcul doar sedimentarea,
%                       face coefdif=0 si vstks cel calculat
%                       in program
%       -daca controls=2 ia in calcul doar miscarea Browniana, 
%                       face vstks=0
%       -daca controls=3 ia in calcul ambele, face vstks=vsed, citit din
%                       nume.inn (bun pentru nesferice ca RBC)
%       -daca controls=4 ia in calcul ambele, face vstks cel calculat
%                       in program
%       -alta valoare - opreste executia
%
%       2015.11.18
%       Versiunea 8
% Modificarea a fost facuta pentru ca viteza de calcul sa scada drastic. Nu
% mai generez viteza ci ditributie Gauss (normala) la fiecare pas de timp
% de miscare browniana ci generez direct deplasarile pe x,y,si z cu distributie normala 
%de varianta 2Dt, o generarea pentru deltat, intervalul dintre doua
%frame-uri
% am modificat si modul in care secventa controls actioneaza, fata de
% versiunea 7
%
nume_intrare=[nume,'.inn'];
disp('___________________________________');
disp(' ');
disp('                 CHODIN8');
disp('                 Ultima modificare: 18 Noiembrie 2015');
disp(' ');
disp(['Rulare ',nume,',  ',datestr(clock,0)]);
disp(['Control ',int2str(control)]);
disp(['Controls ',int2str(controls)]);
disp(' ');
disp('___________________________________');
disp(' ');
%
s=load(nume_intrare);
nscat=s(1);
amp=s(2);
lambda=s(3);
xmin=s(4);    %dimensiunile cuvei; toate dimensiunile si pozitiile sunt date in metri
xmax=s(5);
ymin=s(6);
ymax=s(7);
zmin=s(8);
zmax=s(9);
decran=s(10);   %coordonata Z a ecranului
xstarte=s(11);  %pozitia de inceput pe ecran pe directia x
ystarte=s(12);  %pozitia de inceput pe ecran pe directia y
stepe=s(13);    %pasul de deplasare pe ecran
nstepex=s(14);  %numarul de pasi pe ecran pe directia x
nstepey=s(15);  %numarul de pasi pe ecran pe directia y
ncad=s(16); %numarul totalde cadre
framerate=s(17); %   cate pe secunda
deltat=1/framerate;
%
% urmeaza datele legate de centrii de imprastiere
%
sigma=s(18);   %Sectiunea centrului, in m2
sredus=sigma.^0.5;  %radicalul sectiunii
raza=(sigma/pi).^0.5;
vcentru=s(19);  %volumul centrului, in m3
g=s(20);
ro=s(21);       %densitatea SC
rozero=s(22);   %densitatea mediului
eta=s(23);      %coef de vascozitate dinamica, in daP
tabs=s(24);     %temperatura absoluta
deltatbrown=s(25);  %pasul de timp pentru miscarea browniana la acel tip de SC
vsed=s(26);     %negativa daca coboara in cuva
ze=decran;
%
%   datele de intrare sunt citie
%   Calculeaza valoarea densitatii si vascozitatii apei la acea temperatura
%
tincep=clock; 
tcelsius=tabs-273.15;
rozero=water_density(tcelsius);
%eta=water_viscosity(tcelsius); % ramane valoarea din fisier, for n ow
%vt=vtermic(vcentru, ro, tabs);  % nu are rost pentru versiunea aceasta,
                                               %foloseste coef de difuzie        
%mpart=vcentru*ro;   %masa particulei
kb=1.38064852e-23; %constanta lui Boltzman
coefdif=kb*tabs/(6*pi*eta*raza);   %constanta de dif cu formula Einstein
%
% ajusteaza cativa parametrii in functie de ce se doreste
%
if controls==0       %vreau ca valoarea sa fie fixata prin parametrii 
                           % de intrare, pt simulare rbc sau nesferice
    vstks=vsed;
    coefdif=0;
elseif controls==1    %vreau ca valoarea sa fie calculata de program, Stokes
    vstks=vstokes(raza, ro, rozero, eta);
    coefdif=0;
elseif controls==2
    vstks=0.0;         %ia in calcul doar miscarea Browniana, face vstks=0
elseif controls==3      %ia in calcul ambele, face vstks=vsed, citit din
%                       nume.inn (bun pentru nesferice ca RBC) 
    vstks=vsed;
elseif controls==4      %ia in calcul ambele, face vstks cel calculat
%                       in program  
    vstks=vstokes(raza, ro, rozero, eta);
else                    %valoare gresita, iese
    dsip('Parametrul controls are valoare gresita, in afara intervalului 0 - 4')
    return              % incheie executia
end
%
%   Calculeaza concentratia, noua zona de interes si nr. nou de SC
%
timpsim=ncad*deltat;
if vstks<0      %SC coboara
    xgenmax=xmax-vstks*timpsim;
    xgenmin=xmin;
elseif vstks>0  %SC urca
    xgenmin=xmin-vstks*timpsim;
    xgenmax=xmax;
else    %SC are doar miscare browniana
    xgenmin=xmin;
    xgenmax=xmax;
end
increase=(xgenmax-xgenmin)/(xmax-xmin);
nscat=round(nscat*increase);
disp(['Nr. de SC a fost marit de: ',num2str(increase),' si este: ',int2str(nscat)]);
%
% trebuie sa rezolv partea de difuzie pentru a continua
% mai bine rezolv reflexia particulei la marginea zonei active
%
if control == 0
    disp('Se calculeaza o serie temporala');
    semnal=zeros(ncad,1);   %vrea doar la o locatie; pt control=1 este ultima de pe ecran
    nstepex=1; %daca am uitat sa modific nr de pixeli,
    nstepey=1; %ii modifica programul sa nu calculeze ce nu este nevoie
elseif control == 1
    aviobj=avifile([nume,'.avi'],'fps',framerate);
    figure(1);  %initializeaza o figura pe ecran
    disp('Se calculeaza un film');
    frame=zeros(nstepex,nstepey,3); %initializeaza matricea RGB
 elseif control == 2
     disp('Se calculeaza o imagine');
     ncad=1;    %calculeaza un singur cadru
 else
     disp('Parametrul control are valoare eronata, in afara intervalului [0, 2]');
    return
end
%
rand('state',sum(100*clock));    %resets the generator to a random state, different each time
%rand('state',200700);            % ~ the same each time
pozsc=rand(nscat,3);          %am initializat pozitiile cu numere aleatoare intre 0 si 1
pozsc(:,1)=xgenmin+(xgenmax-xgenmin)*pozsc(:,1);
pozsc(:,2)=ymin+(ymax-ymin)*pozsc(:,2);
pozsc(:,3)=zmin+(zmax-zmin)*pozsc(:,3);
%
%   pozitiile centrilor de imprastiere sunt initializate
%   incepe loop-ul care calculeaza fiecare frame
%
for icad =1:ncad        % calculeaza fiecare cadru din cele ncad
    t0=clock;          %porneste cronometrul pentru determinarea timpului necesar analizarii istoriei unui foton
    ee=complex(zeros(nstepex,nstepey),zeros(nstepex,nstepey));  %initializeaza mat. cu campul electric pe ecran
%
%  misca fiecare centru de imprastiere
%
    pozsc=movesc4(pozsc,vstks,coefdif,deltat); % la fiecare cadru deplaseaza SC
%    pozsc=movesc2(pozsc,vstks,vt,deltat);
    for ixe=1:nstepex
        xe=xstarte+(ixe-1)*stepe;
        for iye=1:nstepey
            ye=ystarte+(iye-1)*stepe;
            contorsc=0;
            for iscat=1:nscat
% calculeaza contributia centrului curent, daca este in zona fasciculului
                if ( (pozsc(iscat,1)>xmin) && (pozsc(iscat,1)<xmax) )    %SC este in zona fasciculului, aduna
                    [d, costeta]=norma(pozsc(iscat,1), pozsc(iscat,2), pozsc(iscat,3), xe, ye, ze);
                    drum=pozsc(iscat,3)-zmin+d;  %drumul optic; faza este zero la zmin
                    faza=(2*pi/lambda)*drum;
                    teta=acos(costeta);
                    dteta=stepe/d;
                    dfi=dteta;
                    factor=fhgtetamare(teta, teta+dteta, g);
                    factor=factor*dfi/(2*pi);
                    esc=amp*sredus*factor*exp(i*faza);
% adauga contributia fiecarui centru
                    ee(ixe,iye)=ee(ixe,iye)+esc;
                    contorsc=contorsc+1;
                end
            end %iscat
            if (verbose==2)% & (control==0) 
                disp(['cadrul: ',int2str(icad),' SC activi: ',int2str(contorsc)])
                
            end
        end %iye
    end %ixe
    if control == 0
        semnal(icad)=abs(ee(ixe,iye));
%
% a calculat un cadru, il scrie si arata timpul estimat pana la sfarsitul
% programului
%
   elseif control == 1
        frame(:,:,1)=abs(ee);   %pune pe culoarea rosu amplitudinea campului electric de pe ecran
        %if icad==1    %primul cadru este cel mai intens, calculeaza factorul de scalare
            scalare=max(max(frame(:,:,1)));
        %end
        frame(:,:,1)=(0.55/scalare).*frame(:,:,1);    %make sure all values are in [0,1]
        image(frame);              %deseneaza pe ecran ce a calculat
        aviobj=addframe(aviobj,1);  %adauga frame-ul tocmai calculat
   end
%
% a terminat un pas de timp (cadru) si hotaraste daca scrie pe ecran sau nu
%
    if (icad == 1) || (verbose >= 1)
        t1=clock;   %opreste cronometrul pentru analizarea istoriei unui cadru
        durata=etime(t1,t0); %calculeaza durata
%        str=['Cadrul ',int2str(icad),' din ',int2str(ncad),', timp ramas ', num2str(durata*(ncad-icad)/60),'  min.'];
        str=['Cdr ',int2str(icad),', tr ', num2str(durata*(ncad-icad)/60),'m'];
disp(str);
    end
end %icad
%
if control == 0
    save([nume,'.ext'], 'semnal','-ASCII');
    save([nume,'.poz'], 'pozsc','-ascii');
elseif control == 1
    aviobj=close(aviobj);
else
    int=abs(ee);
    save([nume,'.mat'],'int','-mat');
end
duratatot=etime(clock, tincep);
disp(['Timp total de executie: ', num2str(duratatot/60), ' , min.']);
%