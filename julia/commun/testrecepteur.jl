# Ce script simule la chaine de transmission sans bruit et affiche son
# taux d'erreur binaire

using PyPlot
using Printf

include("../commun/reception.jl")
include("../commun/emission.jl")
include("../commun/formantcos.jl")
include("../commun/axe_temporel.jl")

TAILLE_MESSAGE = 1000;
SURECHANTILLONNAGE = 30;
TAILLE_FORMANT = 30;

message = 2.0 .* Int.(rand(TAILLE_MESSAGE) .> 0.5) .- 1;
formant = formantcos(SURECHANTILLONNAGE * TAILLE_FORMANT + 1, SURECHANTILLONNAGE);
signal = emission(message, formant, SURECHANTILLONNAGE);
filtre = formant[end:-1:1] / (formant' * formant);
filtre = filtre[1:end,1];
recu = reception(signal, filtre, SURECHANTILLONNAGE, (1 + TAILLE_FORMANT * SURECHANTILLONNAGE)/2);

print("Taux d'erreur binaire: ")
sum(abs.(recu-message) / 2)
