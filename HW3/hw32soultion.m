clc;
clear;
% Add YALMIP to the MATLAB path
addpath(genpath('C:/Users/armita/Downloads/YALMIP-master')); % Use the path where you have YALMIP
% Alternatively, you can use the other path if that's the one you prefer
addpath(genpath('C:\gurobi1101\win64'));


% Define the decision variables
x1 = sdpvar(1,1);
x2 = sdpvar(1,1);

% Define the objective function
Objective = 5*x1 + 6*x2;

% Define the constraints
Constraints = [x1 + x2 <= 5, 
               3*x1 + 8*x2 <= 24,
               x2<=1;
               x1 >= 0, x2 >= 0];

% Set the options for Gurobi solver
options = sdpsettings('solver', 'gurobi');

% Solve the problem
sol = optimize(Constraints, -Objective, options);

% Check if the problem was solved successfully
if sol.problem == 0
    % Display the optimal solution
    optimal_x1 = value(x1);
    optimal_x2 = value(x2);
    optimal_value = value(Objective);
    disp('Optimal solution found:');
    disp(['x1 = ', num2str(optimal_x1)]);
    disp(['x2 = ', num2str(optimal_x2)]);
    disp(['Optimal value of Z = ', num2str(optimal_value)]);
else
    disp('Problem could not be solved:');
    disp(sol.info);
end
