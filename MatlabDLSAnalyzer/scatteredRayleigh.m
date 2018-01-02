function [I]=scatteredRayleigh(iZero,theta,R,lambda,indref,d,np)

I=np*iZero*((1+(cos(theta))^2)/(2*R^2))*((2*pi/lambda)^4)*(((indref^2-1)/(indref^2+2))^2)*...
    ((d/2)^6);