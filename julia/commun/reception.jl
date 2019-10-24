using DSP;
function reception(signal,filtre,SURECHANTILLONNAGE,decalage)
    int_decalage = Int(decalage)
    print(int_decalage);
    print("\n");
    signal_conv = conv(signal,filtre);
    signal_tronc = signal_conv[int_decalage:1:length(signal_conv)-int_decalage+1]
    signal_echant = signal_tronc[1:SURECHANTILLONNAGE:length(signal_tronc)]
    signal_seuil = (signal_echant .> 0) .* 2 .- 1 
    return(signal_seuil);
end