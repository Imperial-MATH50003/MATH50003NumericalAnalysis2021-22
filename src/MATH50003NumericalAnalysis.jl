using Weave

nkwds = (out_path = "notebooks/", jupyter_path = "$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options = "--allow-errors")
skwds = (out_path = "sheets/", jupyter_path = "$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options = "--allow-errors")

##
# notes
##



notebook("src/Julia.jmd"; nkwds...)
notebook("src/Asymptotics.jmd"; nkwds...)
notebook("src/SpectralTheorem.jmd"; nkwds...)

notebook("src/Numbers.jmd"; nkwds...)
notebook("src/Differentiation.jmd"; nkwds...)

notebook("src/StructuredMatrices.jmd"; nkwds...)
notebook("src/Decompositions.jmd"; nkwds...)
notebook("src/SingularValues.jmd"; nkwds...)
notebook("src/DifferentialEquations.jmd"; nkwds...)

notebook("src/Fourier.jmd"; nkwds...)
notebook("src/OrthogonalPolynomials.jmd"; nkwds...)
notebook("src/Interpolation.jmd"; nkwds...)
notebook("src/Integration.jmd"; nkwds...)


##
# problem sheets
##

notebook("src/week1.jmd"; skwds...)
notebook("src/week2.jmd"; skwds...)
notebook("src/advanced1.jmd"; skwds...)
notebook("src/advanced2.jmd"; skwds...)
notebook("src/advanced3.jmd"; skwds...)

##
# solutions 
###

notebook("src/week1s.jmd"; skwds...)
notebook("src/week2s.jmd"; skwds...)
notebook("src/week3s.jmd"; skwds...)
notebook("src/week4s.jmd"; skwds...)
notebook("src/week5s.jmd"; skwds...)