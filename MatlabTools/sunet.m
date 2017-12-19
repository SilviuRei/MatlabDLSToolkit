function sunet(nume_wav,play)
%
% Functia reprezinta grafic sunetul stocat pe disc intr-un fisier wav
% o filtreaza de componenta continua si reprezinta  grafic transformata 
% Fourier a sunetului nefiltrat si filtrat
%
% Sintaxa: sunet(nume_wav,play)
%		nume_wav - nume fisier
%		play - variabila logica:1=asculta fisier, 0=nu asculta fisier



[x,fs]=wavread(nume_wav);

dt=1/fs;
tfinal=dt*length(x);
t=(0+dt:dt:tfinal);

xf=x-mean(x);

[xm,xp,fq]=swatFFT(x,dt);
[xmf,xpf,fqf]=swatFFT(xf,dt);

xmmax=max(xm);
xmmaxf=max(xmf);

figure(1);

subplot(2,1,1);
plot(t,x,'r');
title('Sunetul original');
xlabel('timp,secunde');
ylabel('amplitudine,adim');

subplot(2,1,2);
plot(fq,xm/xmmax,'r');
title('Transformata Fourier a functiei care da sunetul');
xlabel('frecventa,Hz');
ylabel('amplitudine,adim');


figure(2);

subplot(2,1,1);
plot(t,xf,'r');
title('Sunetul original filtrat');
xlabel('timp,secunde');
ylabel('amplitudine,adim');

subplot(2,1,2);
plot(fq,xmf/xmmaxf,'r');
title('Transformata Fourier a functiei care da sunetul,filtrata');
xlabel('frecventa,Hz');
ylabel('amplitudine relativa,adim');


if play==1
	sound(x,fs);
end

