include("../commun/bruit.jl")
include("../commun/emission.jl")
include("../commun/reception.jl")

function erreur(Pb, TAILLE, SURECHANTILLONNAGE, formant, filtre)
    TAILLE_FORMANT = length(formant);
    message = 2 .* Int.(rand(TAILLE) .> 0.5) .- 1;
    signal = emission(message, formant, SURECHANTILLONNAGE);
    signal = signal + bruit(Pb, (formant' * formant)[1], size(signal, 1));
    recu = reception(signal, filtre, SURECHANTILLONNAGE, (TAILLE_FORMANT-1) / 2);
    return(sum(abs.(recu-message) / 2) / TAILLE);
end
