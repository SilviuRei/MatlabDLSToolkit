function [x, t] = myIFFT(fftMagnitude, fftPhase, df )
%------------------------------------------------------------
%function [x, t] = myIFFT(fftMagnitude, fftPhase, df )
%Fast Fourier function
%Input:
%	fftMagnitude = Fast Fourier magnitude
%	fftPhase = Fast Fourier phase
%	df = frequency step
%Output:
%	x = time series
%	t = time vector
%------------------------------------------------------------
i=complex(0,1);
N=length(fftMagnitude);
fftMagnitude=reshape(fftMagnitude,1,N);
fftPhase=reshape(fftPhase,1,N);
fftMagnitude=[fftMagnitude fftMagnitude((N-1):-1:2)];
fftPhase=[fftPhase - fftPhase((N-1):-1:2)];
y=fftMagnitude.*exp(i*fftPhase);
x=real(ifft(y));
t=(0:(2*(N-1)-1))/((2*(N-1))*df);
end

