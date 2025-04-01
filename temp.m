% Constants and Parameters
eta_cells = 0.283;
eta_packing = 0.9;
eta_Losses = 0.85;
TRef = 25;
beta = -0.004;
A = 0.661;
G = 1361;
P_required = 235;

% Temperature Range
T = -150:1:150;
dT = abs(T - TRef);

% Calculate Power
P_incident = G * A; % cos(theta)=1 since theta=0
eta_temp = 1 + beta * dT;
eta_Panel = eta_cells * eta_temp * eta_packing * eta_Losses;
P_output = 2 * P_incident .* eta_Panel;

% Plot Results
figure;
plot(T, P_output, 'b-');
yline(P_required, 'k--', 'DisplayName', 'Required Power = 235 W');

grid on;
xlabel('Temperature (°C)');
ylabel('Total Power (W)');
title('Effect of Temperature on Satellite Solar Panel Output Power');
legend show;

legend(["data1", "Required Power = 235 W"], "Position", [0.3267 0.1769 0.5468, 0.1159])

% Find Temperature Range Meeting Power Requirement
valid_T = T(P_output >= P_required);
fprintf('Beta -0.4%%: Temperature Range Achieving >= 235 W: %d°C to %d°C\n', min(valid_T), max(valid_T));