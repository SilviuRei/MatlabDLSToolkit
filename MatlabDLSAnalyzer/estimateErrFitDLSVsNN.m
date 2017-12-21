function [errelFitDLS,errelFitNN,errabsFitDLS,errabsFitNN]=estimateErrFitDLSVsNN(d,dFitDLS,dFitNN,typeG)
%
%

[~, errabsFitDLS, errelFitDLS] = xdif(d, dFitDLS);
[~, errabsFitNN, errelFitNN] = xdif(d, dFitNN);

errelFitDLS = errelFitDLS.*100;
errelFitNN = errelFitNN.*100;

save('dlsFitErrAbs.txt','errabsFitDLS','-ascii');
save('dlsNNErrAbs.txt','errabsFitNN','-ascii');
save('dlsFitErrRel.txt','errelFitDLS','-ascii');
save('dlsNNErrRel.txt','errelFitNN','-ascii');

figure(20);
plot(d,errabsFitDLS,'b');
title("Absolute Error Fit DLS");
xlabel("Particle Size (nm)");
ylabel("Abs Err (nm)");

figure(21);
plot(d,errabsFitNN,'r');
title("Absolute Error Fit NN");
xlabel("Particle Size (nm)");
ylabel("Abs Err (nm)");

figure(22);
plot(d,errelFitDLS,'b');
title("Relative Error Fit DLS");
xlabel("Particle Size (nm)");
ylabel("Rel Err (%)");

figure(23);
plot(d,errelFitNN,'r');
title("Relative Error Fit NN");
xlabel("Particle Size (nm)");
ylabel("Rel Err(%)");

saveas(20,'dlsFitErrAbs',typeG);
saveas(21,'dlsNNErrAbs',typeG);
saveas(22,'dlsFitErrRel',typeG);
saveas(23,'dlsNNErrRel',typeG);