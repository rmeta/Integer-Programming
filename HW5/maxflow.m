% Add YALMIP and Gurobi to the MATLAB path
addpath(genpath('path_to_yalmip')); % Replace with the actual path to YALMIP
addpath(genpath('path_to_gurobi')); % Replace with the actual path to Gurobi

% Define the number of nodes and arcs
numNodes = 8;
numArcs = 11;

% Define arcs and capacities (adjusting to 1-based indexing)
arcs = [2 1; 1 4; 2 3; 2 6; 3 4; 3 5; 4 7; 5 6; 5 7; 6 8; 7 8];
capacities = [4; 14; 10; 6; 5; 5; 10; 0; 5; 6; 0]; % Example capacities, adjust as needed

% Source and sink
source = 1;
sink = 8;

% Create incidence matrix
A = zeros(numNodes, numArcs);
for k = 1:numArcs
    A(arcs(k, 1), k) = 1;
    A(arcs(k, 2), k) = -1;
end

% Define decision variables
x = sdpvar(numArcs, 1);  % Flow on each arc
v = sdpvar(1);  % Total flow from source to sink

% Define constraints
% Non-negativity and capacity constraints
Constraints = [x >= 0, x <= capacities];

% Flow conservation constraints
flow_conservation = A * x;
Constraints = [Constraints, flow_conservation == [zeros(source-1, 1); v; zeros(sink-source-1, 1); -v; zeros(numNodes-sink, 1)]];

% Define objective
Objective = -v; % We maximize the flow 'v' by minimizing '-v'

% Set up the options for Gurobi
options = sdpsettings('solver', 'gurobi');

% Solve the problem
sol = optimize(Constraints, Objective, options);

% Check for solution status
if sol.problem == 0
    % Extract and display the results
    maxFlow = value(v);
    flowValues = value(x);

    disp('Maximum Flow:');
    disp(maxFlow);

    disp('Flow Distribution:');
    disp(table(arcs, flowValues, 'VariableNames', {'Arc', 'Flow'}));
else
    disp('Solver encountered an issue:');
    sol.info
end
