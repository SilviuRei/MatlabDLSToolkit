function [sfftmag, sfftphase, f]=swatFFT(x,dt)


sfft=fft(x);
N=length(sfft);
sfftmag=abs(sfft(1:((N/2)+1)));
sfftphase=angle(sfft(1:((N/2)+1)));
f=(0:(N/2))/(N*dt);
