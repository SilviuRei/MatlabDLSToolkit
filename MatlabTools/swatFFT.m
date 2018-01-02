function [sfftmag, sfftphase, f]=swatFFT(x,dt)
%-------------------------------------------------------------------------------
% Version 20180101, Silviu Rei
% function 
%	The function 
%	Input:
%
%	Output:
%
%	Example:
%
%-------------------------------------------------------------------------------

sfft=fft(x);
N=length(sfft);
sfftmag=abs(sfft(1:((N/2)+1)));
sfftphase=angle(sfft(1:((N/2)+1)));
f=(0:(N/2))/(N*dt);
