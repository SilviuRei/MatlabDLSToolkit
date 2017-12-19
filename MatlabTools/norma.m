function [d, costeta]=norma(x1, y1, z1, x2, y2, z2);
%
% functia calculeaza distanta intre cele doua puncta in coordonate
% carteziene si cosinusul unghiurilor teta si fi in coordonate polare sub
% care se vede punctul 2 din punctul 1
%
d=(x2-x1).^2+(y2-y1).^2+(z2-z1).^2; %patratul distantei
d=d.^0.5;    %distanta
costeta=(z2-z1)/d;
%
