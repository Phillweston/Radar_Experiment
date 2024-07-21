pt = 1.5;
freq = 5.6e+9;
G = 45;
sigma = 0.1;
tao = 0.0001;
NF = 3;
L = 6;
range = 25:5:300;
np = [1, 10, 100];
lprf_req(pt, freq, G, sigma, tao, NF, L, range, np);

function [snr_out] = lprf_req(pt, freq, G, sigma, tao, NF, L, range, np)
    c = 3.0e+8;
    lamda = c / freq;
    num1 = 10 * log10(pt * 1.0e3 * tao * lamda^2 * sigma) + 2 * G;
    num2 = 10 * log10((4.0 * pi)^3 * 1.38e-23 * 290) + NF + L;
    range_db = 40 * log10(range * 1000.0);
    snr_out = num1 + 10 * log10(np') * ones(1, length(range)) - num2 - ones(length(np), 1) * range_db;
    
    figure(1);
    plot(range, snr_out');
    hold on;
    grid on;
    xlabel('Distance/km');
    ylabel('SNR/dB');
    legend('np=1', 'np=10', 'np=100');
end