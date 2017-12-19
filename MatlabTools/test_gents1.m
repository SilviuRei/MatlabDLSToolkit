function test_gents1(nume, diam, theta, lambda, tcelsius, fs, nf, nt, a0)
%
%   Functia citeste un fisier de tip fps si reprezinta grafic valorile din fisier si functia
%  continua calculata cu valorile a0 date ca parametrii
%  
% apelare:
% test_gents1('t1', 100, 0.7854, 633, 293.15, 2000, 100, 1000,10)
%
% calculeaza valorile necesare pentru parametrii functiei Lorentz
%
%
numefis=[nume,'-',int2str(diam),'-',int2str(fs),'-',int2str(nf),'-',int2str(nt),'.fps']
buf=load(numefis,'-ascii');
[nf,ntmp]=size(buf);
%
kb=1.3806505e-23;   % constanta lui Boltzman
eta=water_viscosity(tcelsius);  % vascozitate apei, in daP
lambdam=lambda*1.e-9;  % trece lambda in SI, in m
tabs=tcelsius+273.15;  % temperatura in Kelvin
diamm=diam*1.e-9; %diametrul in m
%
K=(4*pi/lambdam)*sin(0.5*theta);
a1=(2*kb*tabs*K^2)/(6*pi*eta*0.5*diamm)
%
% genereaza vectorul linie cu frecventele, in intervalul [0, fs/2]
%
f=buf(:,1);   %vectorul coloana cu frecventele 
psg=buf(:,2);    % vectorul coloana cu ps generat
amp=zeros(nf,1);
amp=4*pi^2*f.*f+a1^2;   %vectorul coloana cu amplitudinile, calculat in pasi
amp=a0*a1./amp;
%
% genereaza seria de timp 
%
%keyboard;
%
% reprezinta grafic valorile generate cu cercuri si ideale cu linie
%
figure(1)
plot(f,psg,'ob',f,amp,'-r')
xlabel('f, Hz')
ylabel('PSD')
%
figure(2)
loglog(f,psg,'ob',f,amp,'-r')
xlabel('f, Hz')
ylabel('PSD')
numefis1=[nume,'-',int2str(diam),'-',int2str(fs),'-',int2str(nf),'-',int2str(nt),'-PSD-lin.jpg'];
saveas(1,numefis1);
numefis2=[nume,'-',int2str(diam),'-',int2str(fs),'-',int2str(nf),'-',int2str(nt),'-PSD-log.jpg'];
saveas(2,numefis2);
%
