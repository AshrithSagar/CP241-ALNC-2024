%% ALNC Lab Assignment-1 Question-2
clc;
clear;
close all;

%% Permanent Magnet DC Motor (PMDC) system
% Constants
R_a = 0.1; % [Ohm]
L_a = 0.01; % [H]
J = 10; % [kgm^2]
B = 0.01; % [Nms]
k_b = 1; % [Vs/rad]
k_t = 1; % [Nm/A]
tspan = 90; % Time span [s]
T_load = 0; % Load torque [Nm]
V_inp = 20; % Input voltage [V]
x0 = [0; 0]; % Initial state value

h = 0.01; % Step size
tsamples = (0:h:tspan)'; % Time samples
numSamples = length(tsamples);
X = zeros(2, numSamples);

% State space representation
f = @(t, x) [(1 / L_a) * (V_inp - R_a * x(1) - k_b * x(2)); ...
                 (1 / J) * (k_t * x(1) - B * x(2) - T_load)];

%% Euler's method
% Implementation
tic

for i = 1:numSamples - 1
    X(:, i + 1) = X(:, i) + h * f(tsamples(i), X(:, i));
end

toc

%% Plots
subplot(2, 1, 1);
plot(tsamples, X(1, :), "b", "DisplayName", "Current i_a");
ylabel("Current i_a(t)");
xlabel("Time (seconds)");
title('Current vs Time');
legend();

subplot(2, 1, 2);
plot(tsamples, X(2, :), "b", "DisplayName", "Speed w");
ylabel("Speed w(t)");
xlabel("Time (seconds)");
title('Speed vs Time');
legend();
