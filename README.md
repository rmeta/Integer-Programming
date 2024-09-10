<h1>Homework Summaries</h1>

<h2>Homework 2: Linearization of the Binary Quadratic Assignment Problem (QAP)</h2>
<ul>
  <li><strong>Reformulation Linearization Technique (RLT):</strong> This technique transforms quadratic terms into linear terms by introducing auxiliary variables, enabling the use of linear programming solvers. It ensures the correct representation of binary decision variables.</li>
  <li><strong>Modified Linearization (Zhnag et al. 2010):</strong> This modification improves the computational time of QAP instances, reducing the average execution time by using more efficient branching strategies.</li>
  <li><strong>Gurobi Solver Implementation:</strong> The problem is solved using Gurobi in MATLAB with optimal solutions found and execution times measured over multiple trials.</li>
</ul>

<h2>Homework 3: Integer Linear Programming Using Branch and Bound</h2>
<ul>
  <li><strong>Branch and Bound Algorithm:</strong> The algorithm divides the problem into subproblems, solves them iteratively by branching and bounding, and prunes non-optimal solutions.</li>
  <li><strong>Example Problem:</strong> A relaxed problem is solved first, followed by branching based on fractional variables, ultimately yielding an integer solution with maximum objective value.</li>
  <li><strong>Conclusion:</strong> The Branch and Bound method finds the optimal solution efficiently by exploring branches systematically and using bounds to prune unnecessary calculations.</li>
</ul>

<h2>Homework 4: Optimization with Simulated Annealing</h2>
<ul>
  <li><strong>Function Optimization:</strong> Simulated annealing is used to minimize a quadratic function, gradually cooling the system to converge to the global minimum.</li>
  <li><strong>Traveling Salesman Problem (TSP):</strong> The algorithm is applied to solve the TSP by iteratively swapping cities in a randomly generated path, with the optimal path and total distance calculated.</li>
  <li><strong>Conclusion:</strong> Simulated annealing effectively avoids local minima in both continuous and combinatorial problems, converging to near-optimal solutions.</li>
</ul>

<h2>Homework 5: Minimum Cost Flow and Maximum Flow Problems</h2>
<ul>
  <li><strong>Minimum Cost Flow Problem:</strong> This problem involves minimizing transportation costs in a network of nodes and arcs, with supply and demand constraints satisfied by optimizing flow variables.</li>
  <li><strong>Maximum Flow Problem:</strong> The goal is to maximize the flow from a source to a sink in a network while respecting arc capacities, solved by using incidence matrices and flow conservation constraints.</li>
  <li><strong>Conclusion:</strong> Both problems are solved using YALMIP and Gurobi, demonstrating efficient network optimization under cost and capacity constraints.</li>
</ul>
