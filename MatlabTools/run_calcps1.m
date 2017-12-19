%
[indref,lambda,tcelsius,theta]=initconst1;
for i=1:500
    rez(i,1)=i;
    [tmp,rez(i,2)]=calcps1('g', 6, 10, rez(i,1), theta, lambda, indref, tcelsius, 0, 'jpg');
end
save(['diametre_a1_',num2str(theta),'.txt'],'rez','-ascii')
%
