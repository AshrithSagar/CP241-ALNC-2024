%% ALNC Lab Assignment-2 Question-1
clc;
clear;
close all;

% Constants
alpha = 5e-2;
alpha_h = 3.6e-3;
alpha_e = 8e-3;
T_h = 100;
T_e = 15;

% Simulation parameters
tspan = 50; % Time span [seconds]
dt = 0.1; % Time step [seconds]
t = 0:dt:tspan; % Time vector

% Initial conditions
T_1 = 10; % Room 1 initial temperature [Celsius]
T_2 = 15; % Room 2 initial temperature [Celsius]
T_3 = 20; % Room 3 initial temperature [Celsius]
T_4 = 25; % Room 4 initial temperature [Celsius]
T_5 = 30; % Room 5 initial temperature [Celsius]
X_0 = [T_1, T_2, T_3, T_4, T_5]; % Initial state vector

% State space model
f = @(t, x) [alpha * (x(2) - x(1)) + alpha_e * (T_e - x(1));
             alpha * (x(1) - x(2)) + alpha * (x(3) - x(2)) + alpha * (x(4) - x(2)) + alpha * (x(5) - x(2)) + alpha_h * (T_h - x(2));
             alpha * (x(2) - x(3)) + alpha_e * (T_e - x(3));
             alpha * (x(2) - x(4)) + alpha_e * (T_e - x(4));
             alpha * (x(2) - x(5)) + alpha_e * (T_e - x(5))];

% Simulation using ode45
[t, X] = ode45(f, t, X_0);

% Plots
figure;
hold on;
plot(t, X(:, 1), 'g', 'LineWidth', 1.5, 'DisplayName', 'Room 1');
plot(t, X(:, 2), 'r', 'LineWidth', 1.5, 'DisplayName', 'Room 2');
plot(t, X(:, 3), 'b', 'LineWidth', 1.5, 'DisplayName', 'Room 3');
plot(t, X(:, 4), 'm', 'LineWidth', 1.5, 'DisplayName', 'Room 4');
plot(t, X(:, 5), 'c', 'LineWidth', 1.5, 'DisplayName', 'Room 5');
xlabel('Time [s]');
ylabel('Temperature [Celsius]');
title('Temperature of Rooms [Celsius] vs Time [s]');
legend;
grid on;
hold off;
