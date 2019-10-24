# Cette fonction revoie le message en sortie de l'emetteur (modelise avec
# le formant), surechantillonne d'un facteur SURECHANTILLONNAGE

function emission(message, formant, SURECHANTILLONNAGE)
    TAILLE_MESSAGE = size(message, 1)
    signal = zeros((TAILLE_MESSAGE - 1) * SURECHANTILLONNAGE + 1);
    signal[1:SURECHANTILLONNAGE:end] = message;
    signal = conv(signal, formant)
end
