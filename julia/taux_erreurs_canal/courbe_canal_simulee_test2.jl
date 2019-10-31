using PyPlot
include("erreur_canal.jl")
include("../commun/formantcos.jl")
include("canal.jl")

SURECHANTILLONNAGE = 30;
TAILLE = 10000;
TAILLE_FORMANT = 100;

formant = formantcos(SURECHANTILLONNAGE*TAILLE_FORMANT+1, SURECHANTILLONNAGE);
filtre = formant[end:-1:1] / (formant'*formant); # Ici il faudrait regler le gain pour avoir un gain de 1 mais vu que les symboles interferent entre eux c'est compliqué, on passe pour l'instant
filtre = filtre[1:end,1];
#lecanal = canal();
lecanal = [0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0];
Pb = 4;
err = erreur_canal(Pb,TAILLE,SURECHANTILLONNAGE,formant,filtre,lecanal);

print(err);
