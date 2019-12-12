# Script qui affiche un formant en rectangle de 10 secondes

using PyPlot

include("../commun/formantrect.jl");

SURECHANTILLONNAGE = 10;
TAILLE_FORMANT=10 * SURECHANTILLONNAGE - 1;
formant = formantrect(TAILLE_FORMANT,SURECHANTILLONNAGE);
x = collect(1:1:length(formant));
x = (x .- (length(formant) + 1) / 2) ./ SURECHANTILLONNAGE;
plot(x,formant)
