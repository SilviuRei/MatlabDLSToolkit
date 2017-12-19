function [] = plotTs(name, ts, t, typeG)
%-------------------------------------------------------------------------------
%	Version 20171217, Silviu Rei
%	function [] = plotTs(name, ts, t, typeG)
%		The funtion plots and saves the plot for a time series
%	Input:
%		name   				= file name for the plot save
%       ts                  = time series vector
%       t                   = time vector
%       typeG               = plot file type (ex: 'png')
%	Output:
%	Example:
%       plotTs('ts_01', ts, t, 'png');
%-------------------------------------------------------------------------------
figureNumber=5;
figure(figureNumber);
plot(t, ts);
title('Signal');
xlabel('Time (s)');
ylabel('Signal Amplitude');
nameg=[name,'-ts.png'];
saveas(figureNumber,nameg,typeG);
