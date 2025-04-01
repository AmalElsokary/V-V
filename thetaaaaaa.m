% Given data
G = 1361; % W/m^2
A = 0.661; % m^2
T = 25; % Constant temperature (reference)
T_ref = 25; % Reference temperature
eta_cells = 0.283; % Solar Cell Efficiency
eta_packing = 0.90; % Packing efficiency
eta_losses = 0.85; % Losses percentage
eta_temp = 0.88; % Temperature efficiency factor
beta = -0.004; % Efficiency loss rate
N = 2; % Number of solar panels
Theta_space = 0:1:90; % Theta from 0 to 90 degrees

% Calculate P_incident (depends on theta)
P_incident = G * A * cosd(Theta_space); 

% Since T = T_ref, the efficiency remains constant
eta_T = eta_cells; % η(T) = η_cells

% Calculate panel efficiency
eta_panel = eta_T * eta_temp * eta_packing * eta_losses;

% Calculate Power Output and Total Power
P_output = P_incident * eta_panel;
Total_power = N * P_output;

% Find the angles where Total Power reaches 235 W or more
above_235_indices = find(Total_power >= 235);
Theta_low = Theta_space(above_235_indices(1));
Theta_high = Theta_space(above_235_indices(end));

% Plotting the results
figure;
plot(Theta_space, Total_power, 'b-', 'LineWidth', 1.5); % Smooth curve
hold on;
yline(235, 'r--', 'LineWidth', 1.5, 'DisplayName', '235 W Line');
xline(Theta_low, 'k--', 'LineWidth', 1.5, 'DisplayName', sprintf('\\Theta_{low} = %.2f°', Theta_low));
xline(Theta_high, 'k--', 'LineWidth', 1.5, 'DisplayName', sprintf('\\Theta_{high} = %.2f°', Theta_high));
xlabel('Incident Angle \\Theta (°)');
ylabel('Total Power Output (W)');
title('Total Power Output vs. Incident Angle');
legend('Total Power Output', '235 W Line', ...
    sprintf('\\Theta_{low} = %.2f°', Theta_low), ...
    sprintf('\\Theta_{high} = %.2f°', Theta_high));
grid on;

% Display the angles where Total Power is ≥ 235 W
fprintf('Incident angle where Total Power first reaches 235 W: %.2f°\n', Theta_low);
fprintf('Incident angle where Total Power last reaches 235 W: %.2f°\n', Theta_high);