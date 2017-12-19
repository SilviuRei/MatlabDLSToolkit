[ts, t, fftM, fftP, f] = genSound(0,0.005,0.007,0.01,0.02,0,0,0,0,100,500,900,1000,16000,10);
plotTsFfts(ts, t, fftM, f);
[ts, t, fftM, fftP, f] = recordSC(16000, 16, 1, 1.2);
plotTsFfts(ts, t, fftM, f);
