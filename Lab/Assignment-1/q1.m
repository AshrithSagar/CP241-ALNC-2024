%% ALNC Lab Assignment-1 Question-1
clc;
clear;
close all;

%% Simple pendulum system
% Parameters
g = 9.81; % Acceleration due to gravity
l = 0.1; % Length of the pendulum
m = 0.01; % Mass of the pendulum
b = 0.01; % Damping coefficient
t_end = 40; % [seconds]
dt = 0.1;
tsamples = (0:dt:t_end);

% State initialisation
numSamples = length(tsamples);
X = zeros(1, numSamples);

% Initial state value
x0 = [pi / 6, pi / 12];

% State space representation
f1 = @(t, x) x(2);
f2 = @(t, x) -g / l * sin(x(1)) - b / (m * l * l * x(2));
