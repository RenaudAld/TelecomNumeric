# Cette fonction calcul un vecteur temporel
# en fonction de notre surechantillonnage et de la
# taille du formant afin d'afficher proprement nos graphes
function axe_temporel(TAILLE_MESSAGE, SURECHANTILLONAGE, DECALLAGE=0)
    debut = -(DECALLAGE-1)/SURECHANTILLONAGE
    fin = (TAILLE_MESSAGE-DECALLAGE)/SURECHANTILLONAGE
    return collect(debut:1/SURECHANTILLONAGE:fin)
end
