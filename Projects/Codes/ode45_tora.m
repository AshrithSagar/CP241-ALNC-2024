clc
clear

%% TORA system
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
