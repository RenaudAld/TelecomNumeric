
function emission(message,formant,SURECHANTILLONNAGE)
    signal = zeros((TAILLE_MESSAGE-1)*SURECHANTILLONNAGE+1);
    signal[1:SURECHANTILLONNAGE:end] = message;
    signal = conv(signal, formant)
end