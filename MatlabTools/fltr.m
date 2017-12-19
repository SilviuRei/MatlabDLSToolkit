function [yf] = fltr (y, Fs, sT, fF, fFdelta)

d = designfilt('bandstopiir','FilterOrder',2, ...
               'HalfPowerFrequency1',fF-fFdelta,'HalfPowerFrequency2',fF+fFdelta, ...
               'DesignMethod','butter','SampleRate',Fs);

%fvtool (d, 'Fs', Fs);  
yf = filtfilt(d, y);

