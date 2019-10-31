using DSP;
include("../commun/bruit.jl")
include("../commun/emission.jl")
include("../commun/reception.jl")
function erreur_canal(Pb,TAILLE,SURECHANTILLONNAGE,TAILLE_FORMANT,formant,filtre,canal)
    TAILLE_CANAL = length(canal);
    message = 2 .* Int.(rand(TAILLE) .> 0.5) .- 1;
    signal = emission(message, formant, SURECHANTILLONNAGE);
    signal = conv(signal, canal);
    signal = signal + bruit(Pb, (formant'*formant)[1], size(signal,1));
    recu = reception(signal, filtre, SURECHANTILLONNAGE, (TAILLE_CANAL - 1) + (TAILLE_FORMANT) * SURECHANTILLONNAGE);
    print(length(recu))
    print("\n")
    return(sum(abs.(recu-message)/2)/TAILLE);
end
