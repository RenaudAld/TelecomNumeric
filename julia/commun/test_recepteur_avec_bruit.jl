include("../commun/bruit.jl")
include("../commun/formantcos.jl")
include("../commun/emission.jl")
include("../commun/reception.jl")

TAILLE_MESSAGE = 1000;
SURECHANTILLONNAGE = 30;
TAILLE_FORMANT = SURECHANTILLONNAGE * 30 - 1;

message = 2 .* Int.(rand(TAILLE_MESSAGE) .> 0.5) .- 1;
formant = formantcos(TAILLE_FORMANT, SURECHANTILLONNAGE);
signal = emission(message, formant, SURECHANTILLONNAGE);
signal = signal + bruit(5, (formant' * formant)[1], size(signal,1));
filtre = formant[end:-1:1] / (formant' * formant);
filtre = filtre[1:end,1];
recu = reception(signal, filtre, SURECHANTILLONNAGE, (TAILLE_FORMANT - 1) / 2);

print("Taux d'erreur binaire: ")
sum(abs.(recu - message) / 2) / TAILLE_MESSAGE
