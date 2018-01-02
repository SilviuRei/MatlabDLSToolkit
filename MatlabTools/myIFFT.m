function [x, t] = myIFFT(fftMagnitude, fftPhase, df )
%-------------------------------------------------------------------------------
% Version 20180101, Silviu Rei
% function [x, t] = myIFFT(fftMagnitude, fftPhase, df )
%	The function returns the inverse Fast Fourier transform of a signal
% 
% Input:
%	fftMagnitude = Fast Fourier magnitude
%	fftPhase = Fast Fourier phase
%	frequency = frequency vector
%	
% Output:
%	x		= signal vector
%	dt		= sampling period
%	
% Example:
%	[x, t] = myIFFT(fftMagnitude, fftPhase, df );
%-------------------------------------------------------------------------------
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

