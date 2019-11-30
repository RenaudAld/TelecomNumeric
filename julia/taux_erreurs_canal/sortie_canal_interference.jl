using DSP;
include("../commun/bruit.jl")
include("../commun/emission.jl")
include("../commun/reception_sans_seuil.jl")
function sortie_canal_interference(Pb,TAILLE,SURECHANTILLONNAGE,formant,filtre,canal,message)
    TAILLE_CANAL = length(canal);
    signal = emission(message, formant, SURECHANTILLONNAGE);
    signal = conv(signal, canal);
    signal = signal + bruit(Pb, (signal'*signal)[1]/length(message), size(signal,1));
    recu = reception_sans_seuil(signal, filtre, SURECHANTILLONNAGE, (TAILLE_CANAL-1 + TAILLE_FORMANT-1)/2);
    return(recu);
end
