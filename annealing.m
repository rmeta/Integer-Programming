function annealing
    % Initial parameters
    x_current = rand() * 20 - 10;  % Start at a random position between -10 and 10
    T_start = 100;                 % Initial temperature
    T_end = 1e-3;                  % Final temperature
    alpha = 0.95;                  % Cooling rate
    max_iter = 100;                % Maximum iterations at each temperature level

    % Objective function: f(x) = (x-5)^2
    f = @(x) (x - 5)^2;

    % Current cost and initial best cost
    f_current = f(x_current);
    x_best = x_current;
    f_best = f_current;

    T = T_start;
    while T > T_end
        for i = 1:max_iter
            % Generate a new candidate solution
            x_new = x_current + randn();
            f_new = f(x_new);

            % Change acceptance probability
            if f_new < f_current || exp((f_current - f_new) / T) > rand()
                x_current = x_new;
                f_current = f_new;

                % Update the best found solution
                if f_new < f_best
                    x_best = x_new;
                    f_best = f_new;
                end
            end
        end
        % Reduce the temperature
        T = T * alpha;
    end

    % Output the best solution
    fprintf('Best solution x = %f, f(x) = %f\n', x_best, f_best);
end
