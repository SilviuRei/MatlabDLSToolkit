function [hisq, erabs, errel] = xdif (x1, x2)
n1 = length(x1);
n2 = length(x2);
if (n1 == n2)
    hisq = sum((x1-x2).^2)/n1;
    erabs = abs(x1-x2);
    errel = erabs./x1;
else
    disp('The 2 vectors should have the same size');
end