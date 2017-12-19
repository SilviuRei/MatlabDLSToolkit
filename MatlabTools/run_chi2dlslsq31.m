function run_chi2dlslsq31(text1,filename,a,n1,pas,n2,theta,indref,lambda,tcelsius,a0start,a0min,a0max,a1start,a1min,a1max,control,tip)
%
% functia citeste setul de fisiere psd din cate o coloana din matricea a nu
% din fisier iar frecventele dintr-un fisier de tip fps
%
tmp=load(filename,'-ascii'); % citeste fisierul cu frecvente si psd
f=tmp(:,1);
j=0;
for k=n1:pas:n2
%    nume=[text1,int2str(k),text2];
    j=j+1
    mat(j,1)=k;
    [mat(j,2),mat(j,3),mat(j,4),mat(j,5),mat(j,6)]=chi2dlslsq31(f,a(:,j),theta,indref,lambda,tcelsius,a0start,a0min,a0max,a1start,a1min,a1max,control,tip);
end
%
filename=[text1,'-',num2str(n1),'-', num2str(pas),'-',int2str(n2)];
figure(2)
plot(mat(:,1),mat(:,2),'o');
xlabel('n')
ylabel('d, m')
%
save([filename,'.rzfit'],'mat','-ascii');
saveas(2,[filename,tip],tip)
%