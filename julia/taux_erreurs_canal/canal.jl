## Pour une taille de canal et un surechantillonage donné renvoie un canal
## de la même taille, sa forme est c(t) = 0 si t < 0 et c(t) = exp(-t) sinon
function canal(TAILLE_CANAL, SURECHANTILLONNAGE)
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
