using DSP;
include("../commun/bruit.jl")
include("../commun/emission.jl")
include("../commun/reception.jl")
function erreur_canal(Pb,TAILLE,SURECHANTILLONNAGE,formant,filtre,canal)
    TAILLE_FORMANT = 100;
    TAILLE_CANAL = length(canal);
    message = 2 .* Int.(rand(TAILLE) .> 0.5) .- 1;
    signal = emission(message, formant, SURECHANTILLONNAGE);
    signal = signal + bruit(Pb, (formant'*formant)[1], size(signal,1));
    signal = conv(signal, canal);
    recu = reception(signal, filtre, SURECHANTILLONNAGE, (TAILLE_CANAL-1)/2+TAILLE_FORMANT*SURECHANTILLONNAGE);
    return(sum(abs.(recu-message)/2)/TAILLE);
end