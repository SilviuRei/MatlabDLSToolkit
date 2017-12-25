function [errelFitDLS,errelFitNN,errabsFitDLS,errabsFitNN]=estimateErrFitDLSVsNN(d,dFitDLS,dFitNN,typeG,dispMode)
%-------------------------------------------------------------------------------
% Version 20171223, Silviu Rei
% function 
%	The function 
%	Input:
%	Output:
%	Example:
%		
%-------------------------------------------------------------------------------
figureNumber1=20;
figureNumber2=21;
figureNumber3=22;
figureNumber4=23;

disp('[+++] Error Estimation Function Started');

[~, errabsFitDLS, errelFitDLS] = xdif(d, dFitDLS);
[~, errabsFitNN, errelFitNN] = xdif(d, dFitNN);

disp('   [-] Error Estimation Complete');

errelFitDLS = errelFitDLS.*100;
errelFitNN = errelFitNN.*100;

save('dlsFitErrAbs.txt','errabsFitDLS','-ascii');
disp('   [+] File Saved: dlsFitErrAbs.txt')

save('dlsNNErrAbs.txt','errabsFitNN','-ascii');
disp('   [+] File Saved: dlsNNErrAbs.txt')

save('dlsFitErrRel.txt','errelFitDLS','-ascii');
disp('   [+] File Saved: dlsFitErrRel.txt')

save('dlsNNErrRel.txt','errelFitNN','-ascii');
disp('   [+] File Saved: dlsNNErrRel.txt')

if dispMode==1
    figure(figureNumber1);
elseif dispMode==0
    figureNumber1 = figure('visible','off');
end
plot(d,errabsFitDLS,'b');
title("Absolute Error Fit DLS");
xlabel("Particle Size (nm)");
ylabel("Abs Err (nm)");

if dispMode==1
    figure(figureNumber2);
elseif dispMode==0
    figureNumber2 = figure('visible','off');
end
plot(d,errabsFitNN,'r');
title("Absolute Error Fit NN");
xlabel("Particle Size (nm)");
ylabel("Abs Err (nm)");

if dispMode==1
    figure(figureNumber3);
elseif dispMode==0
    figureNumber3 = figure('visible','off');
end
plot(d,errelFitDLS,'b');
title("Relative Error Fit DLS");
xlabel("Particle Size (nm)");
ylabel("Rel Err (%)");

if dispMode==1
    figure(figureNumber4);
elseif dispMode==0
    figureNumber4 = figure('visible','off');
end
plot(d,errelFitNN,'r');
title("Relative Error Fit NN");
xlabel("Particle Size (nm)");
ylabel("Rel Err(%)");

saveas(figureNumber1,'plot_dlsFitErrAbs',typeG);
disp('   [+] File Saved: plot_dlsFitErrAbs.png')

saveas(figureNumber2,'plot_dlsNNErrAbs',typeG);
disp('   [+] File Saved: plot_dlsNNErrAbs.png')

saveas(figureNumber3,'plot_dlsFitErrRel',typeG);
disp('   [+] File Saved: plot_dlsFitErrRel.png')

saveas(figureNumber4,'plot_dlsNNErrRel',typeG);
disp('   [+] File Saved: plot_dlsNNErrRel.png')
disp('[+++] Error Estimation Function Complete');