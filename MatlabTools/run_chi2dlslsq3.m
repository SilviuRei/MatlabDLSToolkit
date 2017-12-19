function run_chi2dlslsq3(text1,text2,n1,pas,n2,teta,indref,lambda,tcelsius,a0start,a0min,a0max,a1start,a1min,a1max,control,tip)
%
j=0;
for k=n1:pas:n2
    nume=[text1,int2str(k),text2];
    j=j+1;
    mat(j,1)=k;
    [mat(j,2),mat(j,3),mat(j,4),mat(j,5),mat(j,6)]=chi2dlslsq3(nume,teta,indref,lambda,tcelsius,a0start,a0min,a0max,a1start,a1min,a1max,control,tip);
end
%
filename=[text1,text2,'-',int2str(n1),'-',int2str(pas),'-',int2str(n2),'.rzfit'];
figure(2)
plot(mat(:,1),mat(:,2),'o');
xlabel('n')
ylabel('d, m')
filename1=[text1,text2,'-',int2str(n1),'-',int2str(pas),'-',int2str(n2),'-diametre.',tip];
saveas(2,filename1,tip)
%
save(filename,'mat','-ascii');
%
% face si statistica pe diametre
%
d=mat(:,2); %diametrele
dmed=mean(d);
stddiam=std(d);
errrel=stddiam/dmed;
%scrie si aceste lucruri
filename1=[text1,text2,'-',int2str(n1),'-',int2str(pas),'-',int2str(n2),'.statfit'];
rezstat=[dmed,stddiam,errrel];
save(filename1,'rezstat','-ascii');
disp(['dmed','   stddiam','     errrel']);
disp([num2str(dmed),' ',num2str(stddiam),' ',num2str(errrel)]);
%
