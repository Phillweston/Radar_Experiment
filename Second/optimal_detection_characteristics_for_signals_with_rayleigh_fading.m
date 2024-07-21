n = 2:2:12; % False alarm probabilities
s = 0:0.1:18; % Single pulse SNR in dB
p = zeros(6, 181); % Initialize detection probability matrix
y = 10.^(-n); % Convert false alarm probabilities to linear scale
x = 10.^(0.1 * s); % Convert SNR from dB to linear scale
x = 1 ./ (1 + x); % Calculate the inverse
p = exp((log(y)).' * x); % Calculate detection probability
% Set y-axis ticks for detection probabilities
set(gca, 'ytick', [0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.75 0.8 0.85 0.9 0.95 0.9999]); hold on;
% Set x-axis ticks for SNR values
set(gca, 'xtick', [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18]);
plot(s, p, 'k'); % Plot detection probability vs. SNR
xlabel('Single Pulse SNR/dB'); % X-axis label
ylabel('Detection Probability'); % Y-axis label
title('Optimal Detection Characteristics for Signals with Rayleigh Fading, Pfa=10^-^[^2^:^2^:^1^2^]'); % Plot title