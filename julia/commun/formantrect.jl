# Fonction qui renvoie un formant en cosinus
# TAILLE: nombre de points du formant
# SURECHANTILLONNAGE: taux de surechantillonage du formant

function formantrect(TAILLE, SURECHANTILLONNAGE)
    PI = 3.1415926535;
    formant = zeros(TAILLE);
    t = (collect(1:1:TAILLE) .- Int(floor((TAILLE + 1) / 2))) / SURECHANTILLONNAGE;
    for i=1:TAILLE
        if t[i] == 0
            formant[i] = 1;
        else
            formant[i] = sin(PI * t[i]) ./ (PI * t[i]);
        end
    end
    return formant;
end
