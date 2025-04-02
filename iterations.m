% Estimate Efficiency of Solar Panel for Total Power Calculation

% Given Specifications
eta_cells = 0.283;       % Cell Efficiency (28.3%)
eta_packing = 0.90;      % Packing Efficiency (90%)
eta_losses = 0.85;       % Losses Efficiency (85%)
A = 0.661;               % Panel Area (m^2)
beta = -0.004;           % 0.4% per degree
T_ref = 25;              % Reference temperature for Si solar panel (25°C)
eta_temp = 1;

% Input Parameters
num_iterations = 150;    % Number of scenarios

% Generate theta values from 0 to 60° (linearly spaced)
Theta = linspace(0, 60, num_iterations);
theta_rad = deg2rad(Theta);

% Combined Efficiency
eta_Panel = eta_cells * eta_temp * eta_packing * eta_losses;

% Generate Random Solar Irradiance between 1200 and 1361 (W/m^2)
G = 1200 + (1361 - 1200) * rand(1, num_iterations);

% Initialize Results
Total_Power = zeros(1, num_iterations);

% Calculation Loop
for n = 1:num_iterations
    P_incident = G(n) * A * cos(theta_rad(n));
    P_output = P_incident * eta_Panel;
    Total_Power(n) = P_output * 2;
end

% Calculate Mean and Standard Deviation
mean_power = mean(Total_Power);
std_dev_power = std(Total_Power);

% Display Results
fprintf('Total Power Values:\n');
disp(Total_Power');
fprintf('Mean Power: %.4f\n', mean_power);
fprintf('Standard Deviation of Power: %.4f\n', std_dev_power);