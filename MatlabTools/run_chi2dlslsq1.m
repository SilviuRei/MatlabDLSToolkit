function run_chi2gdlslsq1(text,n1,pas,n2,dmic,dist,indref,lambda,tcelsius,a0start,a0min,a0max,a1start,a1min,a1max,control,tip)
%
j=0;
for k=n1:pas:n2
    nume=[text,int2str(k)];
    j=j+1;
    mat(j,1)=k;
    [mat(j,2),mat(j,3),mat(j,4),mat(j,5),mat(j,6)]=chi2dlslsq1(nume,dmic,dist,indref,lambda,tcelsius,a0start,a0min,a0max,a1start,a1min,a1max,control,tip);
end
%
filename=[text,'-',int2str(1),'-',int2str(pas),'-',int2str(n2),'.rzfit'];
save(filename,'mat','-ascii');
%