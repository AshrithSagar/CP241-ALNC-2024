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
function r = control_input(t, x)

    if t < 10
        r = -2 * x(3);
    elseif t < 20
        r = -4 * x(3);
    elseif t < 30
        r = -2 * x(3);
    elseif t < 40
        r = -3 * x(3);
    elseif t < 50
        r = -3 * x(3);
    else
        r = 0;
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

    u = u_func(t, x);
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
u = arrayfun(@(ti) control_input(ti, X(find(t == ti), :)), t);

%% Plots
figure;
subplot(2, 1, 1);
plot(t, u, 'r', 'LineWidth', 1.5, 'DisplayName', 'Control input');
legend;
grid on;

subplot(2, 1, 2);
hold on;
plot(t, X(:, 1), 'r', 'LineWidth', 1.5, 'DisplayName', 'x_1 [Position]');
plot(t, X(:, 2), 'g', 'LineWidth', 1.5, 'DisplayName', 'x_2 [Velocity]');
plot(t, X(:, 3), 'b', 'LineWidth', 1.5, 'DisplayName', 'x_3 [Angle]');
plot(t, X(:, 4), 'm', 'LineWidth', 1.5, 'DisplayName', 'x_4 [Angular velocity]');
legend;
grid on;
hold off;
