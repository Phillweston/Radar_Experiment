f = [35e+9, 10e+9, 3e+9, 450e+6, 150e+6];
c = 3e+8;
figure(1); % Move figure creation outside the loop
for i = 1:length(f)
    f0 = f(i);
    vr = 0:10^3;
    fd = 2 * vr * f0 / c;
    loglog(vr, fd, 'LineWidth', 1);
    hold on;
end
xlabel('Radial Velocity (m/s)');
ylabel('Doppler Frequency (Hz)');
title('Doppler Frequency vs. Radial Velocity for Different Frequencies');
legend('35GHz', '10GHz', '3GHz', '450MHz', '150MHz');

v = [1000, 100, 10];
figure(2); % Move figure creation outside the loop
for i = 1:length(v)
    vr = v(i);
    lambda = [1e-2:0.01:1, 2:100];
    fd = 2 * vr ./ lambda;
    loglog(lambda, fd, 'LineWidth', 1);
    hold on;
end
xlabel('Wavelength (m)');
ylabel('Doppler Frequency (Hz)');
title('Doppler Frequency vs. Wavelength for Different Radial Velocities');
legend('1000 m/s', '100 m/s', '10 m/s');