function [ts, t, fftM, fftP, f] = genSound(a0,a1,a2,a3,a4,p1,p2,p3,p4,f1,f2,f3,f4,fs,duration)
%---------------------------------------------------------------------------------------------
% Version 20171030, Silviu Rei
% function [ts, t, fftM, fftP, f] = genSound(a0,a1,a2,a3,a4,p1,p2,p3,p4,f1,f2,f3,f4,fs,length)
%	The function generates sound time series using the soundcard. It generates a superposition
%	of maximum 4 sine waves + optional noise (normal random).
%	Input parameters:
%		a1,2,3,4 = amplitudes for the sine waves
%		a0 = variance for noise
%		p1,p2,p3,p4 = phases for the sine waves
%		f1, f2, f3, f4 = frequencies for the sine waves
%		fs = sampling frequency
%		length = time series length (seconds)
%	Output parameters:
%		ts = time series recorded
%		t = time vector
%		fftM = Fourier transform magnitude normed to 1
%		fftP = Fourier transform phase
%		f = frequency vector
%---------------------------------------------------------------------------------------------
t=0:1/fs:(duration-(1/fs));
x=a1*sin(2*pi*f1*t+p1)+a2*sin(2*pi*f2*t+p2)+a3*sin(2*pi*f3*t+p3)+a4*sin(2*pi*f4*t+p4);
noise = a0/2*randn(size(t));
x = x + noise;

[fftMagnitude, fftPhase, frequency ] = myFFT(x, 1/fs);

ts = x;
fftM = fftMagnitude;
fftP = fftPhase;
f = frequency;

disp(['Generating.Sampling frequency=' num2str(fs) 'Hz, duration=' num2str(duration) ' seconds']);
disp(['Noise variance=' num2str(a0/2)]);
disp(['Wave description:']);
disp(['   frequency1=' num2str(f1) 'Hz, amplitude1=' num2str(a1) ', phase1 = ' num2str(p1)]);
disp(['   frequency2=' num2str(f2) 'Hz, amplitude2=' num2str(a2) ', phase2 = ' num2str(p2)]);
disp(['   frequency3=' num2str(f3) 'Hz, amplitude3=' num2str(a3) ', phase3 = ' num2str(p3)]);
disp(['   frequency4=' num2str(f4) 'Hz, amplitude4=' num2str(a4) ', phase4 = ' num2str(p4)]);
sound(x, fs);

end