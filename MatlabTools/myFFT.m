function [fftMagnitude, fftPhase, frequency ] = myFFT(x, dt)
%-------------------------------------------------------------------------------
% Version 20180101, Silviu Rei
% function [fftMagnitude, fftPhase, frequency ] = myFFT(x, dt)
%	The function returns the Fast Fourier transform of a signal
% 
% Input:
%	x		= signal vector
%	dt		= sampling period
%	
% Output:
%	fftMagnitude = Fast Fourier magnitude
%	fftPhase = Fast Fourier phase
%	frequency = frequency vector
%	
% Example:
%	[fftMagnitude, fftPhase, frequency ] = myFFT(x, dt);
%-------------------------------------------------------------------------------
fftComplex=fft(x);
N=length(fftComplex);
fftMagnitude=abs(fftComplex(1:((N/2)+1)));
fftMagnitude=fftMagnitude/max(fftMagnitude);
fftPhase=angle(fftComplex(1:((N/2)+1)));
frequency=(0:(N/2))/(N*dt);

