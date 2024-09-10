clc;
num_trials = 10; % Number of trials to average the execution time
execution_times = zeros(1, num_trials);

for trial = 1:num_trials
    tic;
    
    % The problem size
    n = 4; % Number of facilities and locations
    
    A = [0 3 1 4; 3 0 2 1; 1 2 0 5; 4 1 5 0]; % Example flow matrix
    D = [0 1 2 3; 1 0 3 4; 2 3 0 5; 3 4 5 0]; % Example distance matrix
    C = [1 2 3 4; 2 3 4 5; 3 4 5 6; 4 5 6 7]; % Example cost matrix
    
    % Binary variables x(i, j) where x_ij = 1 if facility i is assigned to location j
    x = binvar(n, n, 'full');
    
    % Auxiliary variables y(i, p, j, q) for the product x(i, p) * x(j, q)
    y = binvar(n, n, n, n, 'full');
    
    % Objective function
    Objective = 0;
    for p = 1:n
        for q = 1:n
            for i = 1:n
                for j = 1:n
                    Objective = Objective + A(i, j) * D(p, q) * y(i, p, j, q);
                end
            end
        end
    end
    for i = 1:n
        for p = 1:n
            Objective = Objective + C(i, p) * x(i, p);
        end
    end
    
    % Constraints
    Constraints = [];
    % Each facility is assigned to exactly one location
    for i = 1:n
        Constraints = [Constraints, sum(x(i, :)) == 1];
    end
    % Each location has exactly one facility
    for j = 1:n
        Constraints = [Constraints, sum(x(:, j)) == 1];
    end
    % Link y variables with x variables
    for i = 1:n
        for j = 1:n
            for p = 1:n
                for q = 1:n
                    % Link y variables with x variables
                    if i ~= p && j ~= q
                        Constraints = [Constraints, y(i, p, j, q) <= x(i, p)];
                        Constraints = [Constraints, y(i, p, j, q) <= x(j, q)];
                        Constraints = [Constraints, y(i, p, j, q) >= x(i, p) + x(j, q) - 1];
                    end
                end
            end
        end
    end
    
    % Ensuring x variables are binary
    Constraints = [Constraints, x(:) >= 0, x(:) <= 1];
    
    % Ensuring y variables are binary
    Constraints = [Constraints, y(:) >= 0, y(:) <= 1];
    
    % Solver settings and solving the problem
    options = sdpsettings('solver', 'gurobi', 'verbose', 1);
    sol = optimize(Constraints, Objective, options);
    
    % Results
    if sol.problem == 0
        % Successful solution
        disp('Optimal assignment matrix X:');
        disp(value(x));
    else
        % Something went wrong
        disp('Failed to solve the problem');
        disp(sol.info);
    end
    
    execution_times(trial) = toc;
end

avg_execution_time = mean(execution_times);
fprintf('Average execution time over %d trials: %.4f seconds\n', num_trials, avg_execution_time);
