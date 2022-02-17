# MATH50003NumericalAnalysis
Notes and course material for MATH50003 Numerical Analysis

Lecturer: [Dr Sheehan Olver](https://www.ma.imperial.ac.uk/~solver/)

Problem Classes: 2–4pm Thursdays, Huxley 340–342

Overview lecture: 10–11am Fridays, Clore

Q&A: 9:50–10:30 Mondays, 10:40–11:20 Tuesdays on Teams



## Course notes

**Background material**

1. [Introduction to Julia](https://nbviewer.org/github/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notebooks/Julia.ipynb): we introduce  the basic features of the Julia language.
2. [Asymptotics and Computational Cost](https://nbviewer.org/github/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notebooks/Asymptotics.ipynb): we review Big-O, little-o and asymptotic to notation,
and their usage in describing computational cost.

**Part I: Computing with numbers**

1. [Numbers](https://nbviewer.org/github/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notebooks/Numbers.ipynb): we discuss how computers represent integers and real numbers, as well as their arithmetic operations.
2. [Differentiation](https://nbviewer.org/github/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notebooks/Differentiation.ipynb): we discuss ways of approximating derivatives, including automatic differentiation, 
which is essential to  machine learning.

**Part II: Computing with matrices**

1. [Structured Matrices](https://nbviewer.org/github/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notebooks/StructuredMatrices.ipynb): we discuss types of structured matrices (permutations, orthogonal matrices, triangular, banded).
3. [Decompositions](https://nbviewer.org/github/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notebooks/Decompositions.ipynb): we discuss algorithms for computing matrix decompositions (QR and PLU decompositions) and their use in solving linear systems.
3. [Singular values and condition numbers](https://nbviewer.org/github/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notebooks/SingularValues.ipynb): we discuss vector and
matrix norms, and condition numbers for matrices, and the singular value decomposition.
7. [Differential Equations](https://nbviewer.org/github/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/notebooks/DifferentialEquations.ipynb): we discuss the numerical solution of linear differential equations, 
including both time-dependent ordinary differential equations and boundary value problems, by reduction to linear systems.


**Part III: Computing with functions**

1. Fourier series: we discuss Fourier series and their usage in numerical computations
via the fast Fourier transform.
2. Orthogonal Polynomials: we discuss orthogonal polynomials—polynomials orthogonal 
with respect to a prescribed weight—and their usage in numerical computations.
3. Integration: we discuss ways to approximate integrals, both definite and indefinite, using orthogonal polynomials and interpolation.

## Assessment

1. Practice late-term exam (computer-based Julia exam, not for credit): 4 March 2022 (TBC)
2. Late-term exam (computer-based Julia exam): 18 March 2022
3. Practice final exam (pen-and-paper, not for credit): Summer Term (TBC)
3. Final exam (pen-and-paper): Summer Term (TBC)

## Problem sheets

1. [Week 1](https://nbviewer.org/github/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/week1.ipynb) ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/week1s.ipynb)): Binary representation, integers, floating point numbers, and interval arithmetic
2. [Week 2](https://nbviewer.org/github/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/week2.ipynb) ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/week2s.ipynb)): Finite-differences, dual numbers, and Newton iteration
3. [Week 3](https://nbviewer.org/github/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/week3.ipynb) ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/week3s.ipynb)): dense, triangular, banded, permutation, rotation and reflection matrices
4. [Week 4](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/week4.ipynb) ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/week4s.ipynb)): least squares, QR and PLU decompositions
4. [Week 5](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/week5.ipynb) ([Solutions](https://github.com/Imperial-MATH50003/MATH50003NumericalAnalysis/blob/main/sheets/week5s.ipynb)): positive definite matrices, Cholesky, and SVD


## Reading List

1. Nicholas J. Higham, [Accuracy and Stability of Numerical Algorithms](https://epubs.siam.org/doi/book/10.1137/1.9780898718027?mobileUi=0), Chapters 1–3
1. Michael L. Overton, [Numerical Computing with IEEE Floating Point Arithmetic](https://epubs.siam.org/doi/book/10.1137/1.9780898718072), Chapters 2–6
2. Lloyd N. Trefethen & David Bau III, [Numerical Linear Algebra](https://my.siam.org/Store/Product/viewproduct/?ProductId=950/&ct=c257a1956367c57b599612fbf383d0d3c674af4f9181d827444b5cdaca95b0686d6d20467a7c1e3290fb5b31c310ce74f5b2ede375934b844b1171bc734358e2), Chapters 1–4
3. Lloyd N. Trefethen, [Approximation Theory and Approximation Practice](https://people.maths.ox.ac.uk/trefethen/ATAP/ATAPfirst6chapters.pdf), Chapters 1–4, 17–19
4. [The Julia Documentation](https://docs.julialang.org)
5. [The Julia–Matlab–Python Cheatsheet](https://cheatsheets.quantecon.org)


## Notes from lectures

1. [Integers](lectures/Integers.png)
2. [Floating Point Numbers](lectures/FloatingPoint.jpg)
3. [Floating Point Arithmetic](lectures/Arithmetic.jpg)
4. [Bounding Errors in Rounding](lectures/Rounding.jpg)
5. [Finite Differences](lectures/FiniteDifferences.jpg)
6. [Dual Numbers](lectures/DualNumbers.jpg)
7. [Structured Matrices](lectures/StructuredMatrices.jpg)
7. [Permutations](lectures/Permutations.jpg)
7. [Orthogonal Matrices](lectures/OrthogonalMatrices.jpg)
7. [Least Squares](lectures/LeastSquares.jpg)
7. [Gram Schmidt and Reduced QR](lectures/GramSchmidt.jpg)
7. [Householder and QR](lectures/Householder.jpg)
7. [PLU Decomposition](lectures/PLU.jpg)



## What is numerical analysis? 

Broadly speaking, numerical analysis is the study of approximating
solutions to _continuous problems_ in mathematics, for example, integration, differentiation, 
and solving differential equations. There are three key topics in numerical analysis:

1. Design of algorithms: discuss the construction of algorithms and their implmentation in
software.
2. Convergence of algorithms: proving under which conditions algorithms converge to the
true solution, and the rate of convergence.
3. Stability of algorithms: the study of robustness of algorithms to small perturbations in
data, for example, those that arise from measurement error, errors if data are themselves computed using
algorithms, or simply errors arising from the way computers represent real numbers.

The modern world is built on numerical algorithms:


1. [Fast Fourier Transform (FFT)](https://en.wikipedia.org/wiki/Fast_Fourier_transform): Gives a highly efficient way of computing Fourier  coefficients from function samples,
and is used in many places, e.g., the mp3 format for compressing audio and JPEG image format. 
(Though, in a bizarre twist, GIF, a completely uncompressed format, has made a remarkable comeback.)
2. [Singular Value Decomposition (SVD)](https://en.wikipedia.org/wiki/Singular_value_decomposition): Allows for approximating matrices by those with low rank. This is related to the [PageRank algorithm](https://en.wikipedia.org/wiki/PageRank) underlying Google.
3. [Stochastic Gradient Descent (SGD)](https://en.wikipedia.org/wiki/Stochastic_gradient_descent): Minima of high-dimensional functions can be effectively computed using gradients
in a randomised algorithm. This is used in the training of machine learning algorithms.
4. [Finite element method (FEM)](https://en.wikipedia.org/wiki/Finite_element_method):
used to solve many partial differential equations including  in aerodynamics and
weather prediction. [Firedrake](https://firedrakeproject.org) is a major project based at
Imperial that utilises finite element method. 


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

## The Julia Programming Language

In this course we will use the programming language [Julia](https://julialang.org). This is a modern, compiled, high-level,
open-source language developed at MIT. It is becoming increasingly important in high-performance computing and
AI, including by Astrazeneca, Moderna and Pfizer in drug development and clinical trial accelleration, IBM for medical diagnosis, MIT for robot
locomotion, and elsewhere.

It is ideal for a course on numerical analysis because it both allows
_fast_ implementation of algorithms but also has support for _fast_ automatic-differentiation, a feature 
that is of increasing importance in machine learning. It also is low level enough that we can
really understand what the computer is doing. As a bonus, it is easy-to-read and fun to write. 

To run Julia in a Jupyter notebook on your own machine:

1. Download [Julia v1.7.1](https://julialang.org/downloads/)
2. Open the Julia app which will launch a new window
3. Install the needed packages by typing (`]` will change the prompt to a package manager):
```julia
] add IJulia Plots ColorBitstring SetRounding
```
3. Build Jupyter via
```julia
] bulid IJulia
```
4. Launch Jupyter by typing
```julia
using IJulia
notebook()
```
