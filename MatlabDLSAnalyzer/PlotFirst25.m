figure;
subplot(3,1,1);
plot(dclassical(1:25), 'b--o');
hold on;
plot(dnn(1:25), 'r--o');
xlabel('Time (min)');
ylabel('Diameter (nm)');
legend;
legend('Classical', 'Neural Network');
subplot(3,1,2);
plot(erabs(1:25));
xlabel ('Time (min)');
ylabel('Absolute Error (nm)');
ylabel('Absolute Error (nm)');
subplot(3,1,3);
plot(errel(1:25));
xlabel('Time (min)');
ylabel('Relative Error (%)');
