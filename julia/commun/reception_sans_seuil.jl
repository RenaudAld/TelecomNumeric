# Cette fonction renvoie le message en sortie du recepteur avant d'avoir ete
# seuille. Elle prend en parametre le decalage temporel insuit par le elements
# en amont du recepteur

using DSP;

function reception_sans_seuil(signal, filtre, SURECHANTILLONNAGE, decalage)
    signal_conv = conv(signal, filtre);
    decalage = decalage + (length(filtre)-1) / 2;
    decalage = Int(decalage);
    start_tronc = decalage + 1;
    end_tronc = length(signal_conv) - decalage;
    signal_tronc = signal_conv[start_tronc:1:end_tronc]
    signal_echant = signal_tronc[1:SURECHANTILLONNAGE:end]
    return(signal_echant);
end
