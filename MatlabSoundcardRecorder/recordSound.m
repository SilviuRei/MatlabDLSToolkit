function [ts, t, fftM, fftP, f] = recordSound(fs, bitDepth, channel, length)
%------------------------------------------------------------------------------
% Version 20171030, Silviu Rei
% function [ts, t, fftM, fftP, f] = recordSound(fs, bitDepth, channel, length)
%	The function records data using the soundcard microphone channel
%	Input:
%		fs = sampling frequency
%		bitDepth = acqusition bits
%		channel = acquisition channel
%		length = acquisition length (seconds)
%	Output:
%		ts = time series recorded
%		t = time vector
%		fftM = Fourier transform magnitude normed to 1
%		fftP = Fourier transform phase
%		f = frequency vector
%------------------------------------------------------------------------------
recobj = audiorecorder(fs, bitDepth, channel);
disp(['Start Recording.Frequency=' num2str(fs) 'Hz, bit depth=' num2str(bitDepth) 'bits duration=' num2str(length) ' seconds']);
recordblocking(recobj,length);
disp('Recording Complete');
x = getaudiodata(recobj);

[fftMagnitude, fftPhase, frequency ] = myFFT(x, 1/fs);

ts = x;
t=0:1/fs:(length-(1/fs));
fftM = fftMagnitude;
fftP = fftPhase;
f = frequency;

end
