# Completed Richardson Extrapolation for Higher-Order Numerical Solutions of Partial Differential Equations

# Authors:

Dr. Kim, Seongjai, Professor at Mathematics, Mississippi State University <br />
Mr. Cho, Minjae, Junior Undergraduate Student, Mississippi State University <br />

# Abstract:
Richardson extrapolation is a numerical analysis technique used to improve
the rate of convergence of the error in the solution by solving the problem with
two or more different grid sizes. When applied for numerical solutions of partial
differential equations (PDEs), Richardson extrapolation produces a higher-order
solution on the coarse grid by combining two solutions on the fine grid and the
coarse grid. This article discusses a simple strategy, a symmetric high-order interpolation of the correction term, for completing the higher-order solution on the fine grid. It has been verified from various numerical experiments that the suggested
strategy performs better than existing completing methods. Various numerical
examples are given to confirm the claim.

# Algorithm Development:
The algorithm was developed by Mr. Minjae Cho, with valuable advice from Dr. Seongjai Kim. During the algorithm's development, various pre-existing algorithms, including **Completed Richardson extrapolation**, **Operator-based iterative interpolation**, and **Multiple coarse grid extrapolation**, were thoroughly investigated. **Through careful analysis, it was determined that Completed Richardson, which employs the average value for higher-order correction, outperformed the other algorithms in terms of both simplicity and efficiency.** **Additionally, several interpolation techniques were suggested, resulting in noticeable performance improvements.** For a more comprehensive understanding, we recommend readers to refer to our article.


# Copyright: 
I hereby release the entire grant of license, allowing individuals to freely use the algorithm.

# Note:
NM means Neumann Boundary condition which assumes the first derivative equal to 0 on the boundary.
# Last Update: 06/27/2023

