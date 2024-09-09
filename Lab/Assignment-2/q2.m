%% ALNC Lab Assignment-2 Question-2
clc;
clear;
close all;

% Simulation parameters
tspan = 50; % Time span [seconds]
dt = 0.1; % Time step [seconds]
t = 0:dt:tspan; % Time vector

% Initial conditions
X_0 = [0, 0, pi, 0]; % Initial state vector

% Control input
% S.R. No. : 24233
function u = control_input(t, x)

    if t >= 0 && t < 10
        u = -2 * x(3);
    elseif t >= 10 && t < 20
        u = -4 * x(3);
    elseif t >= 20 && t < 30
        u = -2 * x(3);
    elseif t >= 30 && t < 40
        u = -3 * x(3);
    elseif t >= 40 && t < 50
        u = -3 * x(3);
    else
        u = 0;
    end

end

% State space model
function f = system(t, x, u_func)

    % Constants
    M = 5; % Mass of cart
    m = 1; % Mass of pendulum
    L = 2; % Length of pendulum
    b = 10; % Friction coefficient
    g = 9.8; % Acceleration due to gravity

    u = u_func(t, x); % Control input
    A = -b * x(2) - m * L * x(4) ^ 2 * sin(x(3)) + m * g * cos(x(3)) * sin(x(3)) + u;
    B = M + m * sin(x(3)) ^ 2;

    f_1 = x(2);
    f_2 = A / B;
    f_3 = x(4);
    f_4 = (g / L) * sin(x(3)) + (cos(x(3)) / L) * A / B;

    f = [f_1; f_2; f_3; f_4];
end

% Simulation using ode45
[t, X] = ode45(@(t, x) system(t, x, @control_input), t, X_0);
u = arrayfun(@(ti) control_input(ti, X(t == ti, :)), t);

%% Plots
figure;
plot(t, u, 'r', 'LineWidth', 1.5, 'DisplayName', 'u(t)');
xlabel('Time [s]');
ylabel('Control input u(t)');
title('Control input u(t) vs Time (t)');
legend;
grid on;

figure;
subplot(2, 1, 1);
plot(t, X(:, 1), 'r', 'LineWidth', 1.5, 'DisplayName', 'x(t)');
xlabel('Time [s]');
ylabel('Position x(t)');
title('Position x(t) vs Time (t)');
legend;
grid on;
subplot(2, 1, 2);
plot(t, X(:, 3), 'b', 'LineWidth', 1.5, 'DisplayName', '\theta(t)');
xlabel('Time [s]');
ylabel('Angle \theta(t)');
title('Angle \theta(t) vs Time (t)');
legend;
grid on;
