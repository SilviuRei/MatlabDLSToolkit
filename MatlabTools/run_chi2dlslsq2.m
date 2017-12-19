function run_chi2dlslsq2(text1,text2,n1,pas,n2,dmic,dist,indref,lambda,tcelsius,a0start,a0min,a0max,a1start,a1min,a1max,control,tip)
%
j=0;
for k=n1:pas:n2
    nume=[text1,int2str(k),text2];
    j=j+1;
    mat(j,1)=k;
    [mat(j,2),mat(j,3),mat(j,4),mat(j,5),mat(j,6)]=chi2dlslsq2(nume,dmic,dist,indref,lambda,tcelsius,a0start,a0min,a0max,a1start,a1min,a1max,control,tip);
end
%
filename=[text1,text2,'-',int2str(n1),'-',int2str(pas),'-',int2str(n2),'.rzfit'];
save(filename,'mat','-ascii');
%