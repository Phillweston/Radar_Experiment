pt = 100;
freq = 5.6e+9;
G = 20;
sigma = 0.01;
ti = 2;
range = 10:1:100;
dt = [0.3, 0.2, 0.1];
NF = 4;
L = 6;
hprf_req(pt, freq, G, sigma, ti, range, NF, L, dt);

function snr = hprf_req(pt, freq, G, sigma, ti, range, NF, L, dt)
    c = 3.0e+8;
    lamda = c / freq;
    num1 = 10 * log10(pt * 1000.0 * lamda.^2 * sigma * ti * dt.') + 2 * G;
    num2 = 10 * log10((4.0 * pi)^3 * 1.38e-23 * 290 * (range * 1000).^4) + NF + L; 
    snr = num1 * ones(1, length(range)) - ones(length(dt), 1) * num2;
    figure;
    plot(range, snr);
    hold on;
    grid on;
    xlabel('Distance/km');
    ylabel('SNR/dB');
    legend('dt=0.3', 'dt=0.2', 'dt=0.1');
end