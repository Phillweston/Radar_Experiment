sigma = 1e-6;
Te = 4e-6;
Grid = 64;
amf = af_gauss(sigma, Te, Grid);

function amf = af_gauss(sigma, Te, Grid)
    t = -Te:Te/Grid:Te;
    f = -8/Te:8/Te/Grid:8/Te;
    [tau, fd] = meshgrid(t, f);
    tau1 = exp(-(tau.^2 / (4 * sigma^2)));
    mul = exp(-(pi^2 * sigma^2 * fd.^2));
    mul = mul + eps; % Avoid division by zero
    amf = tau1 .* mul;
    % Plotting the ambiguity function of a Gaussian pulse
    figure(1);
    surfl(tau * 1e6, fd * 1e-6, amf);
    grid on;
    title('Ambiguity Function of a Gaussian Pulse (\sigma=1us)');
    xlabel('\tau/us');
    ylabel('f_d/MHz');
    zlabel('|AF(\tau,f_d)|');
    % Plotting the ambiguity diagram
    figure(2);
    contour(tau * 1e6, fd * 1e-6, amf, 1, 'b');
    grid on;
    title('Ambiguity Diagram (-6dB)');
    xlabel('\tau/us');
    ylabel('f_d/MHz');
    % Plotting the distance ambiguity function
    figure(3);
    plot(t * 1e6, tau1(Grid + 1, :));
    grid on;
    title('Distance Ambiguity Function of a Gaussian Pulse');
    xlabel('\tau/us');
    ylabel('|AF(\tau,0)|');
    % Plotting the Doppler ambiguity function
    figure(4);
    plot(fd * 1e-6, mul(:, Grid + 1));
    grid on;
    title('Doppler Ambiguity Function of a Gaussian Pulse');
    xlabel('f_d/MHz');
    ylabel('|AF(0,f_d)|');
end