range = 20:1:250;
snr = 20;
sigma0 = [-20, -10, 0];
tsc = 2;
az_angle = 180;
el_angle = 135;
NF = 8;
L = 6;

for sigma = sigma0
    power_aperture(range, snr, sigma, tsc, az_angle, el_angle, NF, L);
end

function PAP = power_aperture(range, snr, sigma, tsc, az_angle, el_angle, NF, L)
    omega = az_angle * el_angle / (57.296^2);
    num1 = snr + 10 * log10(4.0 * pi * 1.38e-23 * 290 * omega) + NF + L;
    num2 = sigma' + 10 * log10(tsc);
    PAP = num1 - num2 * ones(1, length(range)) + 40 * ones(length(sigma), 1) * log10(range * 1000);
    
    figure(2);
    plot(range, PAP);
    hold on;
    grid on;
    xlabel('Radial Product/dB');
    ylabel('Distance Detect/km');
    legend('sigma=-20dBm^2', 'sigma=-10dBm^2', 'sigma=0dBm^2');
end