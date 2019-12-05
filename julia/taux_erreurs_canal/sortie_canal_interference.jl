using DSP;
include("../commun/bruit.jl")
include("../commun/emission.jl")
include("../commun/reception_sans_seuil.jl")
function sortie_canal_interference(Pb,TAILLE,SURECHANTILLONNAGE,formant,filtre,canal,interference_inv)
    TAILLE_CANAL = length(canal);
    message = 2 .* Int.(rand(TAILLE) .> 0.5) .- 1;
    signal = emission(message, formant, SURECHANTILLONNAGE);
    signal = conv(signal, canal);
    signal = signal + bruit(Pb, (signal'*signal)[1]/length(message), size(signal,1));
    recu = reception_sans_seuil(signal, filtre, SURECHANTILLONNAGE, (TAILLE_CANAL-1 + TAILLE_FORMANT-1)/2);
    print(length(recu))
    print("\n")
    recu = conv(recu, interference_inv);
    decalage = (length(interference_inv)-1)/2;
    decalage = Int(decalage);
    start_tronc = decalage + 1;
    end_tronc = length(recu) - decalage;
    recu = recu[start_tronc:1:end_tronc]
    recu = (recu .> 0) .* 2 .- 1;
    print(length(recu))
    print("\n")
    print(length(message))
    print("\n\n")
    err = sum(abs.(recu-message)/2)/TAILLE
    return(err);
end
