Te = 1e-6;
Grid = 64;
amf = af_sp(Te, Grid);

function amf = af_sp(Te, Grid)
    t = -Te:Te/Grid:Te;
    f = -10/Te:10/Te/Grid:10/Te;
    [tau, fd] = meshgrid(t, f);
    tau1 = (Te - abs(tau)) / Te;
    mul = pi * fd .* tau1 * Te;
    mul = mul + eps; % Avoid division by zero
    amf = abs(sin(mul) ./ mul .* tau1);
    % Plotting the ambiguity function of a rectangular pulse signal
    figure(1);
    surfl(tau * 1e6, fd * 1e-6, amf);
    xlabel('\tau/us');
    ylabel('f_d/MHz');
    zlabel('|AF(\tau,f_d)|');
    title('Ambiguity Function of a Rectangular Pulse Signal');
    % Plotting the ambiguity diagram
    figure(2);
    contour(tau * 1e6, fd * 1e-6, amf, 1, 'b');
    xlabel('\tau/us');
    ylabel('f_d/MHz');
    title('Ambiguity Diagram of a Rectangular Pulse Signal');
    % Plotting the distance ambiguity function
    figure(3);
    plot(t * 1e6, tau1(Grid + 1, :));
    xlabel('\tau/us');
    ylabel('|AF(\tau,0)|');
    title('Distance Ambiguity Function');
    % Plotting the velocity ambiguity function
    ff = abs(sin(mul) ./ mul);
    ffd = ff(:, Grid + 1);
    figure(4);
    plot(fd * 1e-6, ffd);
    xlabel('f_d/MHz');
    ylabel('|AF(0,f_d)|');
    title('Velocity Ambiguity Function');
end