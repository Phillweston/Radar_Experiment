pt = 1500;
freq = 5.6e+9;
G = 45;
sigma = [-10 0 10];
b = 5.0e+6;
NF = 3;
L = 6;
range = [20:1:100];
radar_eq(pt, freq, G, sigma, b, NF, L, range);

function [snr] = radar_eq(pt, freq, G, sigma, b, NF, L, range)
    % Constants
    c = 3.0e+8; % Speed of light in m/s
    lamda = c / freq; % Wavelength in meters
    t0 = 290; % Standard temperature in Kelvin
    
    % Calculations
    num1 = 10 * log10(pt * 1.0e3 * lamda^2) + 2 * G + sigma';
    num2 = 10 * log10((4.0 * pi)^3 * 1.38e-23 * t0 * b) + NF + L;
    range_db = 40 * log10(range * 1000);
    snr = num1 * ones(1, length(range)) - num2 - ones(length(sigma), 1) * range_db;
    
    % Plotting
    figure;
    plot(range, snr.');
    ylabel('SNR/dB');
    xlabel('Distance/km');
end