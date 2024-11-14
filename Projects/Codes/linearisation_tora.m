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
