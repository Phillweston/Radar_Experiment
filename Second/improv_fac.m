% Define parameters
m = 100; % Number of pulses
pfa = 1e-6; % Probability of false alarm
pd = 0.9; % Probability of detection

% Call the improv_fac function
improvement_factor = improv_fac(m, pfa, pd);

% Display the result
disp(['Improvement Factor: ', num2str(improvement_factor)]);

function i = improv_fac(m, pfa, pd)
    f1 = 1.0 + log10(1.0 / pfa) / 46.6;
    f2 = 6.79 * (1.0 + 0.235 * pd);
    f3 = 1.0 - 0.14 * log10(m) + 0.0183 * (log10(m)^2);
    i = f1 * f2 * f3 * log10(m); % Corrected variable name from d3 to f3
end