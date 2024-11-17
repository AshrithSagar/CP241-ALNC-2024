%% ALNC Lab Assignment-3 Question-2
clc;
clear;
close all;

% Parameters
tspan = [0 100]; % Simulation time
x0 = [10; 10]; % Initial conditions

% System dynamics
function dx = sys(~, x)
    x1 = x(1);
    x2 = x(2);

    phi = (-3/2) * x1 ^ 2; % Virtual control, to stabilize x1 system
    z = x2 - phi; % Virtual state

    % Control law
    u = 5 * x1 + (3/2) * x1 ^ 3;

    dx1 = -x2 - (3/2) * x1 ^ 2 - (1/2) * x1 ^ 3;
    dx2 = u;

    dx = [dx1; dx2];
end

% Simulate the system
[t, x] = ode45(@(t, x) sys(t, x), tspan, x0);

% Plot state trajectories
figure;
subplot(2, 1, 1);
plot(t, x(:, 1), 'r', 'LineWidth', 1.5); hold on;
plot(t, x(:, 2), 'b', 'LineWidth', 1.5);
title('State Trajectories');
xlabel('Time (s)');
ylabel('States');
legend('x_1', 'x_2');
grid on;

% Plot control input
subplot(2, 1, 2);
u = -x(:, 1) - x(:, 2); % Control law
plot(t, u, 'k', 'LineWidth', 1.5);
title('Control Input');
xlabel('Time (s)');
ylabel('u');
grid on;
