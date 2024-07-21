B = 4e6;
Te = 2e-6;
Grid = 64;
amf = af_lfm(B,Te,Grid);

function amf = af_lfm(B, Te, Grid)
    u = B / Te;
    t = -Te:Te/Grid:Te;
    f = -B:B/Grid:B;
    [tau, fd] = meshgrid(t, f);
    var1 = Te - abs(tau);
    var2 = pi * (fd - u * tau) .* var1;
    var2 = var2 + eps; % Avoid division by zero
    amf = abs(sin(var2) ./ var2 .* var1 / Te);
    amf = amf / max(max(amf)); % Normalize
    var3 = pi * u * tau .* var1;
    tau1 = abs(sin(var3) ./ var3 .* var1);
    tau1 = tau1 / max(max(tau1)); % Normalize distance ambiguity
    mul = Te .* abs(sin(pi * fd * Te) ./ (pi * fd * Te));
    mul = mul / max(max(mul)); % Normalize velocity ambiguity
    % Plotting
    figure(1);
    surfl(tau * 1e6, fd * 1e-6, amf);
    grid on;
    title('Ambiguity Function of Linear Frequency Modulated Signal (\sigma=1us)');
    xlabel('\tau/us');
    ylabel('f_d/MHz');
    zlabel('|AF(\tau,f_d)|');
    figure(2);
    contour(tau * 1e6, fd * 1e-6, amf, 1, 'b');
    grid on;
    title('Ambiguity Diagram of Linear Frequency Modulated Signal (-6dB)');
    xlabel('\tau/us');
    ylabel('f_d/MHz');
    figure(3);
    plot(t * 1e6, tau1(Grid + 1, :));
    grid on;
    title('Distance Ambiguity Function of Linear Frequency Modulated Signal');
    xlabel('\tau/us');
    ylabel('|AF(\tau,0)|');
    figure(4);
    plot(fd * 1e-6, mul(:, Grid + 1));
    grid on;
    title('Doppler Ambiguity Function of Linear Frequency Modulated Signal');
    xlabel('f_d/MHz');
    ylabel('|AF(0,f_d)|');
end