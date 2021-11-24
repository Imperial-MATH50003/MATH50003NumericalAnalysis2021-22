using Weave

kwds = (out_path="notebooks/", jupyter_path="$(homedir())/.julia/conda/3/bin/jupyter", nbconvert_options="--allow-errors")

notebook("src/Julia.jmd"; kwds...)
notebook("src/Numbers.jmd"; kwds...)
notebook("src/Differentiation.jmd"; kwds...)