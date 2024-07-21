pt = 1500;
freq = 5.6e+9;
G = 45;
sigma = 2;
Te = 2e-4;
r0 = 100;
L = 8;
NF = 3;
range = [60:0.5:200];
dual_base_req(pt, freq, G, sigma, Te, r0, NF, L, range);
xlabel('Distance (km)'); ylabel('Distance (km)');

function [snr] = dual_base_req(pt, freq, G, sigma, Te, r0, NF, L, range)
    c = 3.0e+8;
    lamda = c / freq;
    sita = (0:360) * pi / 180;
    [r1, s1] = meshgrid(range, sita);
    num1 = 10 * log10(pt * 1.0e3 * Te * lamda^2 * sigma) + 2 * G;
    num2 = 10 * log10((4.0 * pi)^3 * 1.38e-23 * 290) + NF + L;
    Rt = (r1 .* cos(s1) + r0 / 2).^2 + (r1 .* sin(s1)).^2;
    Rr = (r1 .* cos(s1) - r0 / 2).^2 + (r1 .* sin(s1)).^2;
    range_db = 10 * log10(Rt * 1.0e6 .* Rr * 1.0e6);
    snr = num1 - num2 - range_db;
    figure; 
    [C, h] = contour(r1 .* cos(s1), r1 .* sin(s1), snr, 6); 
    grid;
    set(h, 'ShowText', 'on', 'TextStep', get(h, 'LevelStep') * 4);
    colormap cool;
end