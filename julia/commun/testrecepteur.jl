using PyPlot# Une seule fois au lancement de Julia
using Printf
include("../commun/reception.jl")
include("../commun/emission.jl")
include("../commun/formantrect.jl")
TAILLE_MESSAGE = 1000;
SURECHANTILLONNAGE = 30;
TAILLE_FORMANT = 100;
message = 2.0 .* Int.(rand(TAILLE_MESSAGE) .> 0.5) .- 1;
formant = formantrect(SURECHANTILLONNAGE*TAILLE_FORMANT+1, SURECHANTILLONNAGE);
signal = emission(message, formant, SURECHANTILLONNAGE);
filtre = formant[end:-1:1] / (formant'*formant);
filtre = filtre[1:end,1];
recu = reception(signal, filtre, SURECHANTILLONNAGE, 1+TAILLE_FORMANT*SURECHANTILLONNAGE/2);
recu
#sum(abs.(recu-message)/2)
