function dx = tora(~, x, u, w, epsilon)
    % Inputs:
    % t - time
    % x - state vector [x1, x2, x3, x4]
    % u - control input
    % w - disturbance input
    % epsilon - coupling parameter

    x1 = x(1);
    x2 = x(2);
    x3 = x(3);
    x4 = x(4);

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

    dx = f + g * u + d * w;
end
