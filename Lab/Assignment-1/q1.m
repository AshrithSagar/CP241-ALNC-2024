%% ALNC Lab Assignment-1 Question-1
clc;
clear;
close all;

%% Simple pendulum system
% Parameters
g = 9.81; % Acceleration due to gravity [m/s^2]
l = 0.1; % Length of the pendulum [m]
m = 0.01; % Mass of the pendulum [kg]
b = 0.01; % Damping coefficient
t_end = 40; % Simulation time span [s]
h = 0.01;
tsamples = (0:h:t_end)';

% State initialisation
numSamples = length(tsamples);
X = zeros(numSamples, 2);

% Initial state value
x0 = [pi / 6, pi / 12];
X(1, :) = x0;

% State space representation
f = @(t, x) [x(2), (-g / l * sin(x(1)) - b / (m * l * l) * x(2))];

%% Runge Kutta method | Order 4
% Implementation
tic

for i = 1:numSamples - 1
    k_1 = f(tsamples(i), X(i, :));
    k_2 = f(tsamples(i) + h / 2, X(i, :) + k_1 / 2);
    k_3 = f(tsamples(i) + h / 2, X(i, :) + k_2 / 2);
    k_4 = f(tsamples(i) + h, X(i, :) + k_3);
    X(i + 1, :) = X(i, :) + (h / 6) * f(tsamples(i), X(i, :));
end

toc

%% Plots
subplot(2, 1, 1);
plot(tsamples, X(:, 1), "b", "DisplayName", "Angular position");
ylabel("Angular position x_1(t)");
xlabel("Time (seconds)");
title('Angular position vs Time');
legend();

subplot(2, 1, 2);
plot(tsamples, X(:, 2), "b", "DisplayName", "Angular velocity");
ylabel("Angular velocity x_2(t)");
xlabel("Time (seconds)");
title('Angular velocity vs Time');
legend();
