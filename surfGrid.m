% Estimate Efficiency of Solar Panel for Total Power Calculation

% Given Specifications
eta_cells = 0.283;       % Cell Efficiency (28.3%)
eta_packing = 0.90;      % Packing Efficiency (90%)
eta_losses = 0.85;       % Losses Efficiency (85%)
A = 0.661;               % Panel Area (m^2)
beta = -0.004;           % 0.4% per degree
T_ref = 25;              % Reference temperature for Si solar panel (25°C)
G = 1361;                % Constant Solar Irradiance (W/m^2)

% Define Ranges for Temperature and Incident Angle
T_range = linspace(-50, 77, 50);   % Temperature from -50 to 77 °C
Theta_range = linspace(0, 60, 50); % Incident angle from 0 to 60 degrees

% Create Mesh Grid
[T, Theta] = meshgrid(T_range, Theta_range);
Theta_rad = deg2rad(Theta); % Convert degrees to radians

% Determine Temperature Efficiency
dT = T - T_ref;
eta_temp = 1 + beta * dT;

% Combined Efficiency
eta_Panel = eta_cells .* eta_temp .* eta_packing * eta_losses;

% Calculate Power Output
P_incident = G * A .* cos(Theta_rad);
P_output = P_incident .* eta_Panel;
Total_Power = P_output * 2;

% Plot 2D Grid with Color Bar
figure;
contourf(T, Theta, Total_Power, 20, 'LineColor', 'none');
colorbar;
xlabel('Temperature (°C)');
ylabel('Incident Angle (°)');
title('Total Power Distribution - 2D Grid');
grid on;

% Identify Worst and Optimal Cases
[minPower, minIndex] = min(Total_Power(:));
[maxPower, maxIndex] = max(Total_Power(:));
[minT, minTheta] = ind2sub(size(Total_Power), minIndex);
[maxT, maxTheta] = ind2sub(size(Total_Power), maxIndex);
text(T_range(minT), Theta_range(minTheta), sprintf('Worst: %.2f W', minPower), 'Color', 'red', 'FontSize', 10, 'FontWeight', 'bold');
text(T_range(maxT), Theta_range(maxTheta), sprintf('Optimal: %.2f W', maxPower), 'Color', 'green', 'FontSize', 10, 'FontWeight', 'bold');

% Plot 3D Surface with Reference Plane
figure;
surf(T, Theta, Total_Power, 'FaceAlpha', 0.8, 'EdgeColor', 'k');
hold on;
plane_P = ones(size(T)) * 235; % Reference plane at P = 235 W
surf(T, Theta, plane_P, 'FaceAlpha', 0.3, 'EdgeColor', 'none', 'FaceColor', 'g');
hold off;
shading interp;
xlabel('Temperature (°C)');
ylabel('Incident Angle (°)');
zlabel('Total Power (W)');
title('Total Power vs Temperature and Incident Angle');
colorbar;
grid on;
view([-30, 30]);
