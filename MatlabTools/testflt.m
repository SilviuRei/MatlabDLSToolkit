Fs = 200;                   %sampling frequency in Hz
sT = 20;                     %length of TS in seconds
L = Fs*sT;                  %length of the time series
T = 1/Fs;                   %sampling period
t = (0:L-1)*T;              %time vector
fF = 50;
dfF = 25;

y = 0.7*sin(2*pi*10*t)+2*sin(2*pi*50*t)+3*sin(2*pi*40*t);
noise = 2*randn(size(t));
%y = y + noise;
[Ym, Yf, f]  = myFFT(y, T);
yf = fltr (y, Fs, sT, fF, dfF);
[Yfm, Yff, f] = myFFT(yf, T);
figure(1);
subplot(2,2,1);
plot(t,y,'r');
title('Original Signal');
xlabel('Time, seconds');
ylabel('Amplitude');
subplot(2,2,2);
plot(f,Ym,'b');
title('Frequency Spectrum');
xlabel('Frequency,Hz');
ylabel('Amplitude');
subplot(2,2,3);
plot(t,yf,'r');
title('Filtered Signal');
xlabel('Time, seconds');
ylabel('Amplitude');

subplot(2,2,4);
plot(f, Yfm,'r');
title('Frequency Spectrum');
xlabel('Frequency,Hz');
ylabel('Amplitude');
