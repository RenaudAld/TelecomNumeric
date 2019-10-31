function canal(TAILLE_CANAL, SURECHANTILLONNAGE)
    TAILLE_CANAL = 2 * TAILLE_CANAL + 1;
    TAILLE_CANAL = (TAILLE_CANAL - 1) * SURECHANTILLONNAGE + 1;
    canal = zeros(TAILLE_CANAL);
    for i=1:TAILLE_CANAL
        if i < (TAILLE_CANAL - 1) / 2
            canal[i] = 0;
        else
            canal[i] = exp(-i / SURECHANTILLONNAGE);
        end;
    end
return canal
end
