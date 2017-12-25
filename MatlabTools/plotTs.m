function [] = plotTs(name, ts, t, typeG, dispMode)
%--------------------------------------------------------------------------
%	Version 20171222, Silviu Rei
%	function [] = plotTs(name, ts, t, typeG, dispMode)
%		The funtion plots and saves the plot for a time series
%	Input:
%		name   				= file name for the plot save
%       ts                  = time series vector
%       t                   = time vector
%       typeG               = plot file type (ex: 'png')
%       dispMode            = if 0, do not display plot
%	Output:
%	Example:
%       plotTs('ts_01', ts, t, 'png', 1);
%--------------------------------------------------------------------------
figureNumber=5;

if dispMode == 1
    figure(figureNumber);
elseif dispMode == 0
    figureNumber = figure('visible', 'off');
end

plot(t, ts);
title(name);
xlabel('Time (s)');
ylabel('Signal Amplitude');
nameg=['plot_ts-' name,'.png'];
saveas(figureNumber,nameg,typeG);
