% Ensure YALMIP is added to your MATLAB path
addpath(genpath('path_to_yalmip')); % Change 'path_to_yalmip' to your actual path

% Define the number of nodes and arcs
numNodes = 8;
numArcs = 11;

% Nodes: 1  2  3  4  5  6  7  8
b = [2; 5; -8; 6; 0; 0; -2; -3]; % Supply/Demand at each node

% Define each arc with start node, end node and cost
arcs = [1 2; 1 4; 2 3; 2 6; 3 4; 3 5; 4 7; 5 6; 5 7; 6 8; 7 8];
costs = [4; 14; 10; 6; 5; 5; 10; 0; 5; 6; 0];

% YALMIP Variables
flow = sdpvar(numArcs, 1);

% Objective: Minimize total cost
objective = costs' * flow;

% Constraints
constraints = [];
for i = 1:numNodes
    % Flow conservation at each node
    nodeFlow = sum(flow(arcs(:,1) == i)) - sum(flow(arcs(:,2) == i));
    constraints = [constraints, nodeFlow == b(i)];
end

% Flow non-negativity constraints
constraints = [constraints, flow >= 0];

% Solve the problem using Gurobi
options = sdpsettings('verbose', 1, 'solver', 'gurobi');
sol = optimize(constraints, objective, options);

% Check solution status
if sol.problem == 0
    % Solution found
    disp('Optimal flow values:');
    for i = 1:numArcs
        fprintf('Arc (%d -> %d): %f\n', arcs(i,1), arcs(i,2), value(flow(i)));
    end
else
    disp('Problem is infeasible.');
end
