using Weave

kwds = (out_path="notebooks/", jupyter_path="$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options="--allow-errors")

notebook("src/1Overview.jmd"; kwds...)
notebook("src/2Julia.jmd"; kwds...)
notebook("src/3FloatingPoint.jmd"; kwds...)