using DSP;
include("../commun/bruit.jl")
include("../commun/emission.jl")
include("../commun/reception.jl")
function erreur_canal(Pb,TAILLE,SURECHANTILLONNAGE,formant,filtre,canal)
    TAILLE_FORMANT = 100;
    TAILLE_CANAL = length(canal);
    message = 2 .* Int.(rand(TAILLE) .> 0.5) .- 1;
    signal = emission(message, formant, SURECHANTILLONNAGE);
    signal = conv(signal, canal);
    signal = signal + bruit(Pb, (signal'*signal)[1]/length(message), size(signal,1));
    recu = reception(signal, filtre, SURECHANTILLONNAGE, (TAILLE_CANAL + TAILLE_FORMANT*SURECHANTILLONNAGE)/2);
    return(sum(abs.(recu-message)/2)/TAILLE);
end