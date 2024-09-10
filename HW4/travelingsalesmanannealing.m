clc;
clear;
tsp_simulated_annealing

function tsp_simulated_annealing

% City names for reference
cities = {'New York', 'Los Angeles', 'Chicago', 'Houston', 'Phoenix'};

% Define distances between each pair of cities
% The matrix is symmetric and the diagonal is zero (distance from a city to itself)
distances = [
    0, 2445, 790, 1627, 2145;
    2445, 0, 1744, 1374, 357;
    790, 1744, 0, 940, 1445;
    1627, 1374, 940, 0, 1174;
    2145, 357, 1445, 1174, 0
];

% Initial path (randomly generated)
path = randperm(length(cities));

% Calculate the initial path length using a helper function
L = calc_path_length(path, distances);

% Simulated annealing parameters
T = 1000;    % Initial temperature
T_min = 1;  % Minimum temperature
alpha = 0.95; % Cooling rate

% Annealing loop
while T > T_min
    for i = 1:1000  % Number of iterations at each temperature
        % Generate a new path by swapping two cities
        newpath = path;
        swapIdx = randperm(length(cities), 2);
        newpath(swapIdx(1)) = path(swapIdx(2));
        newpath(swapIdx(2)) = path(swapIdx(1));
        
        % Calculate new length
        newL = calc_path_length(newpath, distances);
        
        % Change acceptance probability
        if (newL < L || rand() < exp((L - newL) / T))
            path = newpath;
            L = newL;
        end
    end
    
    % Cool down
    T = T * alpha;
end

% Display the final path and length
disp('Final path (city indices):');
disp(path);
disp('Final path (city names):');
disp(cities(path));
disp('Final path length:');
disp(L);

end

% Helper function to calculate path length
function L = calc_path_length(path, distances)
    L = 0;
    for i = 1:length(path)-1
        L = L + distances(path(i), path(i+1));
    end
    L = L + distances(path(end), path(1)); % return to the start point
end
