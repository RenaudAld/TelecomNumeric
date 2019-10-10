using PyPlot# Une seule fois au lancement de Julia
using DSP# Une seule fois au lancement de Julia

include("../commun/emission.jl")
include("../commun/formantcos.jl")
TAILLE_MESSAGE = 1000;
SURECHANTILLONNAGE = 30;
TAILLE_FORMANT = 30;
message = 2 .* Int.(rand(TAILLE_MESSAGE) .> 0.5) .- 1;
formant = formantcos(SURECHANTILLONNAGE*TAILLE_FORMANT+1, SURECHANTILLONNAGE);
signal = emission(message, formant, SURECHANTILLONNAGE);
plot(collect(-TAILLE_FORMANT/2:1/SURECHANTILLONNAGE:TAILLE_FORMANT/2+TAILLE_MESSAGE-1), signal)