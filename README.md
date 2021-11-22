# MATH50003NumericalAnalysis
Notes and course material for MATH50003 Numerical Analysis


What is numerical analysis? Broadly speaking, numerical analysis is the study of approximating
solutions to _continuous problems_ in mathematics, for example, integration, differentiation, 
and solving differential equations. There are three key topics in numerical analysis:

1. Design of algorithms: discuss the construction of algorithms and their implmentation in
software.
2. Convergence of algorithms: proving under which conditions algorithms converge to the
true solution, and the rate of convergence.
2. Stability of algorithms: the study of robustness of algorithms to small perturbations in
data, for example, those that arise from measurement error, errors if data are themselves computed using
algorithms, or simply errors arising from the way computers represent real numbers.

The modern world is built on numerical algorithms:


1. [Fast Fourier Transform (FFT)](https://en.wikipedia.org/wiki/Fast_Fourier_transform): Gives a highly efficient way of computing Fourier  coefficients from function samples,
and is used in many places, e.g., the mp3 format for compressing audio and JPEG image format. 
(Though, in a bizarre twist, GIF, a completely uncompressed format, has made a remarkable comeback.)
2. [Singular Value Decomposition (SVD)](https://en.wikipedia.org/wiki/Singular_value_decomposition): Allows for approximating matrices by those with low rank. This is related to the [PageRank algorithm](https://en.wikipedia.org/wiki/PageRank) underlying Google.
5. Stochastic Gradient Descent (SGD): Minima of high-dimensional functions can be effectively computed using gradients
in a randomised algorithm. This is used in the training of machine learning algorithms.

This is not to say that numerical analysis is only important in applied mathematics. 
It is playing an increasing important role in pure mathematics with important proofs based on numerical computations:

1. [The Kepler conjecture](https://en.wikipedia.org/wiki/Kepler_conjecture). This 400 year conjecture on optimal sphere packing
was finally proved in 2005 by Thomas Hales using numerical linear programming.
2. [Numerical verification of the Riemann Hypothesis](https://en.wikipedia.org/wiki/Riemann_hypothesis#Numerical_calculations). 
It has been proved that there are no zeros of the Riemann zeta function off the critical line provided the imaginary part is
less than 30,610,046,000.
3. [Steve Smale's 14th problem](https://en.wikipedia.org/wiki/Lorenz_system) on the stability of the Lorenz system was solved
using interval arithmetic. 

Note these proofs are _rigorous_: as we shall see it is possible to obtain precise error bounds in numerical
calculations, and the computations themselves can be computer-verified 
(a la [The Lean Theorem Prover](https://leanprover.github.io)).
As computer-verified proofs become increasingly important, the role of numerical analysis in
pure mathematics will also increase, as it provides the theory for rigorously controlling errors in
computations. Note that there are many computer-assisted proofs that do not fall under numerical analysis because
they do not involve errors in computations or approximation or involve discrete problems, for 
example, the proof the [Four Colour Theorem](https://en.wikipedia.org/wiki/Four_color_theorem).

In this course we will use the programming language [Julia](https://julialang.org). This is a modern, compiled, high-level,
open-source language developed at MIT. It is becoming increasingly important in high-performance computing and
AI, including by Astrazeneca and Pfizer in drug development, IBM for medical diagnosis, and MIT for robot
locomotion.

It is ideal for a course on numerical analysis because it both allows
_fast_ implementation of algorithms but also has support for _fast_ automatic-differentiation, a feature 
that is of increasing importance in machine learning. It also is low level enough that we can
really understand what the computer is doing. As a bonus, it is easy-to-read and fun to write. 

A rough overview of the course is as follows:

1. [Introduction to Julia](notebooks/Julia.ipynb): we introduce the basic features of the Julia language.
2. [Floating point arithmetic](notebooks/FloatingPoint.ipynb): we discuss how computers approximate and manipulate real numbers.
3. [Differentiation](notebooks/Differentiation.ipynb): we discuss ways of approximating derivatives, including automatic differentiation, 
which is essential to stochastic gradient descent and machine learning.
3. [Numerical Linear Algebra](notebooks/NumericalLinearAlgebra.ipynb): we discuss algorithms for solving linear systems.
5. [Orthogonal Polynomials](notebooks/OrthogonalPolynomials.ipynb): we discuss orthogonal polynomial—polynomials orthogonal 
with respect to a proscribed weight—and their usage in numerical computations.
6. [Integration](notebooks/Integration.ipynb): we discuss ways to approximate integrals, both definite and indefinite, using orthogonal polynomials.
7. [Differential Equations](notebooks/DifferentialEquations.ipynb): we discuss the numerical solution of differential equations, 
including both time-dependent ordinary differential equations, boundary value problems, and (time-permitting) partial differential equations.

Note some readers may wish to start with Chapter 2 and pick up the information about Julia in Chapter 1 along the way.
