# Script qui affiche le signal en sortie de l'emetteur

using PyPlot
using DSP

include("../commun/emission.jl")
include("../commun/formantcos.jl")

TAILLE_MESSAGE = 1000;
SURECHANTILLONNAGE = 30;
TAILLE_FORMANT = 30;

message = 2 .* Int.(rand(TAILLE_MESSAGE) .> 0.5) .- 1;
formant = formantcos(SURECHANTILLONNAGE*TAILLE_FORMANT+1, SURECHANTILLONNAGE);
signal = emission(message, formant, SURECHANTILLONNAGE);

time = collect(-TAILLE_FORMANT/2 : 1/SURECHANTILLONNAGE : TAILLE_FORMANT/2+TAILLE_MESSAGE-1)
plot(time, signal)

