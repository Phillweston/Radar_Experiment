Te = 10e-3; % Pulse duration in seconds
Bm = 1e9; % Bandwidth in Hz
R0 = [5, 6.5, 15]; % Initial target ranges in km
Vr = [0, 0, 0]; % Target radial velocities in m/s (stationary targets)
SNR = [10, 10, 20]; % Signal-to-noise ratio in dB for each target
Rmin = 3e3; % Minimum range in meters
Rrec = 30; % Maximum receivable range in km
f0 = 5.6e9; % Carrier frequency in Hz

[y, sp] = stretch_lfm(f0, Te, Bm, Rmin, Rrec, R0, Vr, SNR);

function [y, sp] = stretch_lfm(f0, Te, Bm, Rmin, Rrec, R0, Vr, SNR)
    mu = Bm / Te; % Modulation factor
    c = 3e8; % Speed of light in m/s
    dltR = c / (2 * Bm); % Range resolution
    Trec = 2 * Rrec / c; % Receivable time
    N = 2 * Bm * Trec; % Number of samples
    m = ceil(log2(N)); Nfft = 2^m; % FFT size
    Ts = Te / Nfft; t1 = (0:Nfft-1) * Ts; % Time vector
    Window = kaiser(Nfft, pi).'; % Kaiser window
    sp = (0.707 * (randn(1, Nfft) + 1j * randn(1, Nfft))); % Noise
    for k = 1:length(R0)
        tao = 2 * (R0(k) - Rmin - Vr(k) * t1) / c; % Time delay
        spt = (10^(SNR(k) / 20)) * exp(1j * (2 * pi * mu * tao .* t1 + (2 * pi * f0 - pi * mu * tao) .* tao));
        sp = sp + spt; % Signal + noise
    end
    y = (abs(fft(sp .* Window, Nfft))) / m;
    % Plotting
    figure;
    plot(t1, real(sp));
    xlabel('Relative Time (s)');
    ylabel('Real Part of Echo Signal');
    title('Target Echo Signal');
    grid;
    figure;
    plot((0:Nfft/2-1) * dltR, 20 * log10(y(1:Nfft/2)));
    xlabel('Relative Distance (m)');
    ylabel('Pulse Compression Output (dB)');
    title('Processing Result, 3 Targets Resolvable');
    grid;
end