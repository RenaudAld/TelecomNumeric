# Cette fonction renvoie le message en sortie du recepteur un fois qu'il a ete`
# seuille. Elle prend en parametre le decalage temporel insuit par le elements
# en amont du recepteur

using DSP;

function reception(signal, filtre, SURECHANTILLONNAGE, decalage)
    signal_conv = conv(signal, filtre);
    start_tronc = decalage;
    end_tronc = length(signal_conv) - decalage + 1;
    signal_tronc = signal_conv[start_tronc:1:end_tronc]
    signal_echant = signal_tronc[1:SURECHANTILLONNAGE:end]
    signal_seuil = (signal_echant .> 0) .* 2 .- 1
    return(signal_seuil);
end
