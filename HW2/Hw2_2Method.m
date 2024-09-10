num_trials = 10; % Number of trials to average the execution time
execution_times = zeros(1, num_trials);

for trial = 1:num_trials
    tic;
    
    % The problem size
    n = 4; % Number of facilities and locations
    
    % Example matrices for d, f, and C
    d = [0 1 2 3; 1 0 3 4; 2 3 0 5; 3 4 5 0];
    f = [0 3 1 4; 3 0 2 1; 1 2 0 5; 4 1 5 0];
    C = [1 2 3 4; 2 3 4 5; 3 4 5 6; 4 5 6 7]; % Adding a random cost matrix for completeness
    
    % binary variables x(i,p)
    x = binvar(n, n, 'full');
    
    % new variables y(i,p,j,q)
    y = sdpvar(n, n, n, n, 'full');
    
    % Objective function
    Objective = 0;
    for p = 1:n
        for q = 1:n
            for i = 1:n
                for j = 1:n
                    Objective = Objective + d(p, q) * f(i, j) * y(i, p, j, q);
                end
            end
        end
    end
    for p = 1:n
        for i = 1:n
            Objective = Objective + C(i, p) * x(i, p);
        end
    end
    
    % Constraints
    Constraints = [];
    % Each facility is assigned to exactly one location
    for p = 1:n
        Constraints = [Constraints, sum(x(:, p)) == 1];
    end
    % Each location has exactly one facility
    for i = 1:n
        Constraints = [Constraints, sum(x(i, :)) == 1];
    end
    % Link y variables with x variables
    for i = 1:n
        for p = 1:n
            for j = 1:n
                if i > j
                    Constraints = [Constraints, sum(y(i, p, j, :)) == x(i, p)];
                end
            end
        end
    end
    for i = 1:n
        for p = 1:n
            for q = 1:n
                if p ~= q
                    Constraints = [Constraints, sum(y(i, p, :, q)) <= x(i, p)];
                end
            end
        end
    end
    for i = 1:n
        for j = 1:n
            for p = 1:n
                for q = 1:n
                    if i ~= j && p ~= q
                        Constraints = [Constraints, y(i, p, j, q) == y(j, q, i, p)];
                    end
                end
            end
        end
    end
    % Ensuring y variables are binary
    Constraints = [Constraints, y(:) >= 0, y(:) <= 1];
    
    % Solver settings and solving the problem
    options = sdpsettings('solver', 'gurobi', 'verbose', 1);
    sol = optimize(Constraints, Objective, options);
    
    % results
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
