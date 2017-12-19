function [fftMagnitude, fftPhase, frequency ] = myFFT(x, dt)
%------------------------------------------------------------
%function [fftMagnitude, fftPhase, frequency ] = myFFT(x, dt)
%Fast Fourier function
%Input:
%	x = time series
%	dt = sampling period
%Output:
%	fftMagnitude = Fast Fourier magnitude
%	fftPhase = Fast Fourier phase
%	frequency = frequency vector
%------------------------------------------------------------
fftComplex=fft(x);
N=length(fftComplex);
fftMagnitude=abs(fftComplex(1:((N/2)+1)));
fftMagnitude=fftMagnitude/max(fftMagnitude);
fftPhase=angle(fftComplex(1:((N/2)+1)));
frequency=(0:(N/2))/(N*dt);
end

