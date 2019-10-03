using DSP;
function reception(signal,filtre,SURECHANTILLONAGE,sync)
    signal_conv = conv(signal,filtre);
    signal_conv_synced = [sync:length(signal_conv)];
    signal_echantillone = [] ;
    for i = 1:SURECHANTILLONAGE:length(signal_conv_synced)
        push!(signal_echantillone,signal_conv_synced[i]);
    end
    for i=length(signal_echantillone):length(signal)
        push!(signal_echantillone,0);
    end
    return(signal_echantillone);
end