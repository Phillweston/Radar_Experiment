Te = 200e-6;
Bm = 1e6;
Ts = 0.5e-6;
R0 = [80e3, 85e3];
Vr = [0, 0];
SNR = [20, 10];
Rmin = 20e3;
Rrec = 150e3;
M = round(Te/Ts);
Window = taylorwin(M)';
bos = 2*pi/0.03;
[y] = LFM_comp(Te, Bm, Ts, R0, Vr, SNR, Rmin, Rrec, Window, bos);

function [y] = LFM_comp(Te, Bm, Ts, R0, Vr, SNR, Rmin, Rrec, Window, bos)
    mu = Bm/Te; % modulation factor
    c = 3e8;
    M = round(Te/Ts);
    t1 = (-M/2 + 0.5 : M/2 - 0.5) * Ts; % time vector
    NR0 = ceil(log2(2 * Rrec / c / Ts));
    NR1 = 2^NR0;
    lfm = exp(1j * pi * mu * t1.^2);
    W_t = lfm .* Window;
    game = (1 + 2 * Vr ./ c).^2;
    sp = (0.707 * (randn(1, NR1) + 1j * randn(1, NR1))); % noise
    for k = 1:length(R0)
        NR = fix(2 * (R0(k) - Rmin) / c / Ts);
        spt = (10^(SNR(k)/20)) * exp(-1j * bos * R0(k)) * exp(1j * pi * mu * game(k) * t1.^2);
        sp(NR:NR+M-1) = sp(NR:NR+M-1) + spt; % signal + noise
    end
    spf = fft(sp, NR1);
    Wf_t = fft(W_t, NR1);
    y = abs(ifft(spf .* conj(Wf_t), NR1) / NR0); % /(NR1/2)
    figure;
    plot(real(sp));
    xlabel('Time/us');
    ylabel('Amplitude');
    title('Received Signal');
    grid;
    figure;
    plot(t1 * 1e6, real(lfm));
    xlabel('Time (us)');
    ylabel('Amplitude');
    title('LFM Pulse');
    grid;
    figure;
    semilogy(real(y));
    xlabel('Range Bin');
    ylabel('Amplitude');
    title('Matched Filter Output');
    grid;
end