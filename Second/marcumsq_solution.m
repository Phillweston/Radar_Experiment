% Define SNR range and Pfa values
SNR = 0:0.1:18;
Pfa = 10.^(-[2:2:12]);

% Preallocate p for speed
p = zeros(length(SNR), length(Pfa));

% Calculate detection probability for each SNR and Pfa
for n = 1:length(Pfa)
    y = sqrt(-2.0 * log(Pfa(n)));
    for k = 1:length(SNR)
        x = sqrt(2.0 * 10^(0.1 * SNR(k)));
        p(k, n) = marcumsq(x, y);
    end
end

% Plot the results
plot(SNR, p, 'k');
xlabel('Single Pulse SNR/dB');
ylabel('Detection Probability');
title('Detection Probability vs. Single Pulse SNR Curve Pfa=10^-^[^2^:^2^:^1^2^];');

% Define the Marcum Q-function
function PD = marcumsq(a, b)
    max_test_value = 1000;
    if (a < b)
        alphan0 = 1.0;
        dn = a / b;
    else
        alphan0 = 0.;
        dn = b / a;
    end
    alphan_1 = 0;
    betan0 = 0.5;
    betan_1 = 0;
    D1 = dn;
    n = 0;
    ratio = 2.0 / (a * b);
    alphan = 0.0;
    betan = 0.0;
    while (betan < max_test_value)
        n = n + 1;
        alphan = dn + ratio * n * alphan0 + alphan;
        betan = 1.0 + ratio * n * betan0 + betan;
        alphan_1 = alphan0;
        alphan0 = alphan;
        betan_1 = betan0;
        betan0 = betan;
        dn = dn * D1;
    end
    PD = (alphan0 / (2.0 * betan0)) * exp(-(a - b)^2 / 2.0);
    if (a >= b)
        PD = 1.0 - PD;
    end
end