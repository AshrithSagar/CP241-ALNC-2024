%% ALNC Lab Assignment-3 Question-3
clc;
clear;
close all;

% System dynamics
T = 0.1; % Sampling time
A = zeros(3); % No dynamics (for simplicity)
B = eye(3); % Inputs directly affect states
C = eye(3); % Output is the state
D = zeros(3); % No direct feedthrough

% State-space model
plant = ss(A, B, C, D, T);

% Define reference trajectory
tspan = 0:T:20; % Time span
xr = cos(tspan); % Reference x position
yr = sin(tspan); % Reference y position

% Create MPC controller
mpcObj = mpc(plant, T);
mpcObj.PredictionHorizon = 20; % Prediction horizon
mpcObj.ControlHorizon = 5; % Control horizon
mpcObj.Weights.ManipulatedVariables = [0.1 0.1 0.1]; % Control effort weights
mpcObj.Weights.ManipulatedVariablesRate = [0.1 0.1 0.1];
mpcObj.Weights.OutputVariables = [1 1 0]; % Tracking weights

% Initial state
x0 = [1.5; 0; 0]; % Initial [x; y; theta]
x = x0;

% Create the MPC state object from initial state
mpcState = mpcstate(mpcObj, x);

% Simulation
X = zeros(3, length(tspan) - 1);
U = zeros(3, length(tspan) - 1);

for k = 1:length(tspan) - 1
    ref = [xr(k); yr(k); 0]; % Reference at time step k
    u = mpcmove(mpcObj, mpcState, ref); % Compute optimal control using MPC state object

    % Update state (discretized dynamics)
    x = A * x + B * u;

    % Update the MPC state with the new state
    mpcState = mpcstate(mpcObj, x);

    X(:, k) = x;
    U(:, k) = u;
end

% Plot results
figure;
subplot(2, 1, 1);
hold on;
plot(tspan(1:end - 1), X(1, :), 'r', 'LineWidth', 1.5);
plot(tspan(1:end - 1), X(2, :), 'b', 'LineWidth', 1.5);
plot(tspan, xr, '--r', 'LineWidth', 1.2); % Reference x
plot(tspan, yr, '--b', 'LineWidth', 1.2); % Reference y
legend('x (state)', 'y (state)', 'x_{ref}', 'y_{ref}');
title('State Evolution');
xlabel('Time (s)');
ylabel('Position');
grid on;

subplot(2, 1, 2);
plot(tspan(1:end - 1), U(1, :), 'k', 'LineWidth', 1.5);
legend('Control Input V_x');
title('Control Input');
xlabel('Time (s)');
ylabel('Input');
grid on;

% Plot 2D trajectory
figure;
plot(X(1, :), X(2, :), 'r', 'LineWidth', 1.5); hold on;
plot(xr, yr, '--k', 'LineWidth', 1.2);
legend('Robot Trajectory', 'Reference Trajectory');
title('Robot 2D Trajectory');
xlabel('x');
ylabel('y');
grid on;
axis equal;
