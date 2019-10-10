using DSP;
function reception(signal,filtre,SURECHANTILLONNAGE,decalage)
    int_decalage = Int(decalage)
    signal_conv = conv(signal,filtre);
    signal_tronc = signal_conv[int_decalage*2+1:1:length(signal_conv)-int_decalage*2+1]
    signal_echant = signal_tronc[1:SURECHANTILLONNAGE:end]
    return(signal_echant);
end