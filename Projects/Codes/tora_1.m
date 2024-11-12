%% ALNC Project Team-9
% TORA system
clc
clear

function dx = tora(~, x, u, w, epsilon)
    % Inputs:
    % t - time
    % x - state vector [x1, x2, x3, x4]
    % u - control input
    % w - disturbance input
    % epsilon - coupling parameter

    x1 = x(1);
    x2 = x(2);
    x3 = x(3);
    x4 = x(4);

    f1 = x2;
    f2 = (-x1 + epsilon * x4 ^ 2 * sin(x3)) / (1 - epsilon ^ 2 * cos(x3) ^ 2);
    f3 = x4;
    f4 = (epsilon * cos(x3) * (x1 - epsilon * x4 ^ 2 * sin(x3))) / (1 - epsilon ^ 2 * cos(x3) ^ 2);
    f = [f1; f2; f3; f4];

    g1 = 0;
    g2 = -epsilon * cos(x3) / (1 - epsilon ^ 2 * cos(x3) ^ 2);
    g3 = 0;
    g4 = 1 / (1 - epsilon ^ 2 * cos(x3) ^ 2);
    g = [g1; g2; g3; g4];

    d1 = 0;
    d2 = 1 / (1 - epsilon ^ 2 * cos(x3) ^ 2);
    d3 = 0;
    d4 = -epsilon * cos(x3) / (1 - epsilon ^ 2 * cos(x3) ^ 2);
    d = [d1; d2; d3; d4];

    dx = f + g * u + d * w;
end

% Parameters
epsilon = 0.1;
u = 1;
w = 0.5;

% Initial conditions
x0 = [0; 0; 0.1; 0]; % Initial state [x1, x2, x3, x4]
tspan = [0 50]; % Time span for simulation

[t, x] = ode45(@(t, x) tora(t, x, u, w, epsilon), tspan, x0);

%% Plots
figure;
subplot(2, 2, 1);
plot(t, x(:, 1)); xlabel('Time (s)'); ylabel('x1');
title('State x1 vs Time');

subplot(2, 2, 2);
plot(t, x(:, 2)); xlabel('Time (s)'); ylabel('x2');
title('State x2 vs Time');

subplot(2, 2, 3);
plot(t, x(:, 3)); xlabel('Time (s)'); ylabel('x3');
title('State x3 vs Time');

subplot(2, 2, 4);
plot(t, x(:, 4)); xlabel('Time (s)'); ylabel('x4');
title('State x4 vs Time');
