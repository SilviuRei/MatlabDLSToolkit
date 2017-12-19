function [h,m,s] = sec2time(sec)
%-----------------------------------------------
% Version 20171030, Silviu Rei
% function [h,m,s] = sec2time(sec)
%	This function converts time in h:m:s format
%	Input:
%		sec = number of seconds
%	Output:
%		h = hours
%		m = minutes
%		s = seconds
%-----------------------------------------------
h = floor(sec/3600);
m = floor((sec-h*3600)/60);
s = sec - h*3600 - m*60;