# Script qui affiche un formant en cosinus de 10 secondes

using PyPlot

include("../commun/formantcos.jl");

SURECHANTILLONNAGE = 10;
TAILLE_FORMANT=10 * SURECHANTILLONNAGE + 1;
formant = formantcos(TAILLE_FORMANT,SURECHANTILLONNAGE);
x = collect(1:1:length(formant));
x = (x .- (length(formant) + 1) / 2) ./ SURECHANTILLONNAGE;
plot(x,formant)
