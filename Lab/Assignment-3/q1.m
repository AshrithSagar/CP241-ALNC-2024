%% ALNC Lab Assignment-3 Question-1
clc;
clear;
close all;

% System matrices
A = [0, 1, 0;
     0, 0, 1;
     -501.6e-6, -128.8e-3, -854e-3];
B = [1; 0; 0];
C = [0.78e-4, 41.4e-4, 0.01];
D = 0;

% Check controllability
Ctrb = ctrb(A, B);

if rank(Ctrb) ~= size(A, 1)
    error('The system is not controllable.');
else
    disp('The system is controllable.');
end

% Desired closed-loop poles
desired_poles = [-1/15, -1/15, -1/2];

% Compute state feedback gain K
K = acker(A, B, desired_poles);
disp('State feedback gain K:');
disp(K);

% Closed-loop system matrices
A_cl = A - B * K;

% Simulation parameters
dt = 0.01; % Time step
t = 0:dt:50; % Simulation time
x0 = [0; 0; 0]; % Initial states
u = ones(size(t)); % Step input

% Define closed-loop system
sys_cl = ss(A_cl, B, C, D);

% Simulate the step response
[y, t, x] = lsim(sys_cl, u, t, x0);

% Plot results
figure;
subplot(3, 1, 1);
plot(t, x);
title('State Variables');
xlabel('Time (s)');
ylabel('States');
legend('x1', 'x2', 'x3');

subplot(3, 1, 2);
plot(t, u);
title('Input (Insulin Infusion Rate)');
xlabel('Time (s)');
ylabel('u');

subplot(3, 1, 3);
plot(t, y);
title('Output (Plasma Insulin Concentration)');
xlabel('Time (s)');
ylabel('y');
