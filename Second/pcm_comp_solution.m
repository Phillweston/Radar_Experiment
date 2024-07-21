% Define parameters
Te = 1e-6;
Ts = 0.5e-6;
R0 = [60e3, 90e3]; % Initial ranges in meters
Vr = [0, 0]; % Radial velocities in m/s
SNR = [20, 10]; % Signal-to-noise ratios in dB
Rmin = 20e3; % Minimum range in meters
Rrec = 150e3; % Maximum receivable range in meters
M = round(Te/Ts); % Number of samples
bos = 2*pi/0.03; % Baseband oscillation frequency

% Binary code sequence
code = [1 0 0 0 0 0 0 1 1 1 1 1 1 1 0 1 0 1 0 ...
        1 0 0 1 1 0 0 1 1 1 0 1 1 1 0 1 0 0 1 ...
        0 1 1 0 0 0 1 1 0 1 1 1 1 0 1 1 0 1 0 ...
        1 1 0 1 1 0 0 1 0 0 1 0 0 0 1 1 1 0 0 ...
        0 0 1 0 1 1 1 1 1 0 0 1 0 1 0 1 1 1 0 ...
        0 1 1 0 1 0 0 0 1 0 0 1 1 1 1 0 0 0 1 ...
        0 1 0 0 0 0 1 1 0 0 0 0 0];

% Call the PCM_comp function
[y] = PCM_comp(Te, code, Ts, R0, Vr, SNR, Rmin, Rrec, bos);

% PCM_comp function definition
function [y] = PCM_comp(Te, code, Ts, R0, Vr, SNR, Rmin, Rrec, bos)
    M = round(Te/Ts);
    code2 = kron(code, ones(1, M)); % Repeat each element of code M times
    c = 3e8; % Speed of light in m/s
    NR0 = ceil(log2(2 * Rrec / c / Ts));
    NR1 = 2^NR0;
    M2 = M * length(code);
    t1 = (0:M2-1) * Ts; % Time vector
    sp = (0.707 * (randn(1, NR1) + 1j * randn(1, NR1))); % Noise
    for k = 1:length(R0)
        NR = fix(2 * (R0(k) - Rmin) / c / Ts);
        Ri = 2 * (R0(k) - Vr(k) * t1);
        spt = (10^(SNR(k)/20)) * exp(-1j * bos * Ri) .* code2; % Signal
        sp(NR:NR+M2-1) = sp(NR:NR+M2-1) + spt; % Signal + noise
    end
    spf = fft(sp, NR1);
    Wf_t = fft(code2, NR1); % FFT of the code
    y = abs(ifft(spf .* conj(Wf_t), NR1)) / NR0; % Matched filter output
    % Plotting
    figure;
    plot(real(sp));
    xlabel('Time Sample Points');
    ylabel('Real Part of Input Signal');
    title('Real Part of Input Signal');
    grid;
    figure;
    plot(t1 * 1e6, real(code2));
    xlabel('Time (us)');
    ylabel('Real Part of Matched Filter Coefficients');
    title('M-sequence of Length 127');
    grid;
end