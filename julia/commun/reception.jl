# Cette fonction renvoie le message en sortie du recepteur un fois qu'il a ete`
# seuillé. Elle prend en paramètre le décalage temporel induit par les élements
# en amont du recepteur

using DSP;

function reception(signal, filtre, SURECHANTILLONNAGE, decalage)
    signal_conv = conv(signal, filtre);
    decalage = decalage + (length(filtre) - 1) / 2;
    decalage = Int(decalage);
    start_tronc = decalage + 1;
    end_tronc = length(signal_conv) - decalage;
    signal_tronc = signal_conv[start_tronc:1:end_tronc]
    signal_echant = signal_tronc[1:SURECHANTILLONNAGE:end]
    signal_seuil = (signal_echant .> 0) .* 2 .- 1
    return(signal_seuil);
end
