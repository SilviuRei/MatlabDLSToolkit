function [hisq, erabs, errel] = xdif (x1, x2)
%-----------------------------------------------------------------------------------
% Version 20171030, Silviu Rei
% function [hisq, erabs, errel] = xdif (x1, x2)
%	This function returns indicators related to the differences between 2 vectors
%	Input:
%		x1 		= vector
%		x2 		= vector
%	Output:
%		hisq 	= overall indicator
%		erabs 	= absolute error vector
%		errel 	= relative error vector
%-----------------------------------------------------------------------------------
n1 = length(x1);
n2 = length(x2);
if (n1 == n2)
    hisq = sum((x1-x2).^2)/n1;
    erabs = abs(x1-x2);
    errel = erabs./x1;
else
    disp('The 2 vectors should have the same size');
end