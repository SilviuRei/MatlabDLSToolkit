function [] = plotTsPsds(ts, t, fftM, f)

figure;
subplot(3,1,1);
plot(t, ts);
title('Signal');
xlabel('Time (s)');
ylabel('Signal Amplitude');

subplot(3,1,2);
plot(f, fftM);
grid on;
title('Periodogram Using FFT');
xlabel('Frequency (Hz)');
ylabel('Normalized Amplitude');

subplot(3,1,3);
plot(f,10*log10(fftM));
grid on;
title('Periodogram Using FFT');
xlabel('Frequency (Hz)');
ylabel('Power/Frequency (dB/Hz)');

end