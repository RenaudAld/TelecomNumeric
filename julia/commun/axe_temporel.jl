# Cette fonction calcul un vecteur temporel
# en fonction de notre surechantillonnage et de la
# taille du formant afin d'afficher proprement nos graphes
function axe_temporel(TAILLE_MESSAGE, SURECHANTILLONAGE, DECALAGE=0)
    debut = -DECALAGE/SURECHANTILLONAGE
    fin = (TAILLE_MESSAGE-DECALAGE-1)/SURECHANTILLONAGE
    return collect(debut:1/SURECHANTILLONAGE:fin)
end
