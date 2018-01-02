function [yf] = fltr (y, Fs, fF, fFdelta)
%-------------------------------------------------------------------------------
% Version 20180101, Silviu Rei
% function [yf] = fltr (y, Fs, sT, fF, fFdelta)
%	The function filters a signal
%	Input:
%		y 	= original signal vector
%		Fs 	= sampling frequency (Hz)
% 		fF 	= frequency to be filtered (Hz)
%		fFDelta = delta frequency around the filtering frequency (Hz)
%	Output:
%		yf	= filtered signal
%	Example:
%		[yf] = fltr(y,16000,50,5);
%-------------------------------------------------------------------------------
d = designfilt('bandstopiir','FilterOrder',2, ...
               'HalfPowerFrequency1',fF-fFdelta,'HalfPowerFrequency2',fF+fFdelta, ...
               'DesignMethod','butter','SampleRate',Fs);

%fvtool (d, 'Fs', Fs);  
yf = filtfilt(d, y);

