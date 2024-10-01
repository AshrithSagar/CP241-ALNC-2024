clear; clc; close all;

system = @(t, x, a, b) [
                        -x(1) + a * x(2) - b * x(1) * x(2) + x(2) ^ 2;
                        - (a + b) * x(1) + b * x(1) ^ 2 - x(1) * x(2)
                        ];

cases = [
         1, 1;
         1, -0.5;
         ];

for case_idx = 1:size(cases, 1)
    a = cases(case_idx, 1);
    b = cases(case_idx, 2);

    figure;
    hold on;
    title(['Phase Portrait for a = ', num2str(a), ', b = ', num2str(b)]);
    xlabel('x_1');
    ylabel('x_2');
    axis([-2 2 -2 2]);

    % Plot nullclines (where dx/dt = 0)
    [x1_vals, x2_vals] = meshgrid(linspace(-2, 2, 20), linspace(-2, 2, 20));

    dx1_dt = -x1_vals + a * x2_vals - b * x1_vals .* x2_vals + x2_vals .^ 2;
    dx2_dt =- (a + b) * x1_vals + b * x1_vals .^ 2 - x1_vals .* x2_vals;

    quiver(x1_vals, x2_vals, dx1_dt, dx2_dt, 'r'); % Plot direction field

    % Plot solution trajectories
    for x1_0 = -1.5:1:1.5

        for x2_0 = -1.5:1:1.5
            [t, sol] = ode45(@(t, x) system(t, x, a, b), [0 10], [x1_0 x2_0]);
            plot(sol(:, 1), sol(:, 2), 'b'); % Plot trajectory
            plot(sol(1, 1), sol(1, 2), 'bo'); % Mark starting point
        end

    end

    % Plot equilibrium points
    plot(0, 0, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');
    plot(0, -a, 'ko', 'MarkerSize', 8, 'MarkerFaceColor', 'k');

    hold off;
end
