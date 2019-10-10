using DSP;
function reception(signal,filtre,SURECHANTILLONNAGE,decalage)
    int_decalage = Int(decalage)
    signal_conv = conv(signal,filtre);
    signal_tronc = signal_conv[int_decalage*2-1:1:length(signal_conv)-int_decalage*2+1+SURECHANTILLONNAGE] #A voir le troncage, c'est fait a la main je comprend pas pourquoi faut rajouter 1+SURECHANTILLONNAGE
    signal_echant = signal_tronc[1:SURECHANTILLONNAGE:length(signal_tronc)]
    signal_seuil = (signal_echant .> 0) .* 2 .- 1 
    return(signal_seuil);
end