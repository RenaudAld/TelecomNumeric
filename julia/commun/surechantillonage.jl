function surechantillonnage(MESSAGE, SURECHANTILLONNAGE)
    TAILLE = length(MESSAGE)
    new_message = zeros((TAILLE-1)*SURECHANTILLONNAGE+1)
    new_message[1:SURECHANTILLONNAGE:length(new_message)] = MESSAGE
    return new_message
end
