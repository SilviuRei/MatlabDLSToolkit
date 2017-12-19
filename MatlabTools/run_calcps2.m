function run_calcps2(theta)
%
%functia calculeaza parametrul a1 pentru diferite valori ale diametrului
%experimate in nm.
%
[indref,lambda,tcelsius,garb]=initconst1;
for i=1:2000
    rez(i,1)=i;
    [tmp,rez(i,2)]=calcps1('g', 6, 10, i, theta, lambda, indref, tcelsius, 0, 'jpg');
end
save(['diametre_a1_',num2str(theta),'.txt'],'rez','-ascii')
%
