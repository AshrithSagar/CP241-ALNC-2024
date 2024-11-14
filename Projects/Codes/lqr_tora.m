clc;
clear;

%% TORA system
syms x1 x2 x3 x4 epsilon;
x = [x1; x2; x3; x4];

% System dynamics
f1 = x2;
f2 = (-x1 + epsilon * x4 ^ 2 * sin(x3)) / (1 - epsilon ^ 2 * cos(x3) ^ 2);
f3 = x4;
f4 = (epsilon * cos(x3) * (x1 - epsilon * x4 ^ 2 * sin(x3))) / (1 - epsilon ^ 2 * cos(x3) ^ 2);
f = [f1; f2; f3; f4];

g1 = 0;
g2 = -epsilon * cos(x3) / (1 - epsilon ^ 2 * cos(x3) ^ 2);
g3 = 0;
g4 = 1 / (1 - epsilon ^ 2 * cos(x3) ^ 2);
g = [g1; g2; g3; g4];

d1 = 0;
d2 = 1 / (1 - epsilon ^ 2 * cos(x3) ^ 2);
d3 = 0;
d4 = -epsilon * cos(x3) / (1 - epsilon ^ 2 * cos(x3) ^ 2);
d = [d1; d2; d3; d4];

%% Jacobians for linearization
A = jacobian(f, x);
B = jacobian(g, x);
D = jacobian(d, x);

%% Equilibrium point
x_eq = [0; 0; 0.1; 0];

% Substitute equilibrium point into the Jacobians
A_eq = subs(A, x, x_eq);
B_eq = subs(B, x, x_eq);
A_eq = simplify(A_eq);
B_eq = simplify(B_eq);

%% Cost matrices for LQR
Q = eye(4); % State weighting matrix
R = 1; % Control input weighting matrix

% Solve for the optimal LQR gain K
[K, ~, ~] = lqr(A_eq, B_eq, Q, R);

%% Closed-loop system with LQR control
x0 = [0; 0; 0.1; 0]; % Initial condition
tspan = [0 50]; % Time span for simulation

% Closed-loop system
closed_loop_sys = @(t, x) (A_eq - B_eq * K) * x;
[t, x] = ode45(closed_loop_sys, tspan, x0);

%% Plot results
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

% Control input for LQR
u = -K * x'; % LQR control law
figure;
plot(t, u);
xlabel('Time (s)');
ylabel('Control Input (u)');
title('LQR Control Input vs Time');
