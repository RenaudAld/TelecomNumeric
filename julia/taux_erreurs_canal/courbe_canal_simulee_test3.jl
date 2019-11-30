using PyPlot
include("erreur_canal.jl")
include("../commun/formantcos.jl")
include("canal.jl")

SURECHANTILLONNAGE = 30;
TAILLE = 10000;
TAILLE_FORMANT = SURECHANTILLONNAGE*10+1;

formant = formantcos(TAILLE_FORMANT, SURECHANTILLONNAGE);
filtre = formant[end:-1:1] / (formant'*formant); # Ici il faudrait regler le gain pour avoir un gain de 1 mais vu que les symboles interferent entre eux c'est compliqué, on passe pour l'instant
filtre = filtre[1:end,1];
#lecanal = canal();
lecanal = [0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 0.0, 0.0, 0.0, 0.0, 0.0];

courbe_min = [];
courbe_max = [];
x = [];
for Pb = 0:0.25:8
    err_min = 1000;
    err_max = 0;
    for i = 1:10
        err = erreur_canal(Pb,TAILLE,SURECHANTILLONNAGE,formant,filtre,lecanal);
        if(err>err_max)
            err_max = err;
        end
        if(err<err_min)
            err_min = err;
        end
    end
    global x = [x; Pb]
    global courbe_min = [courbe_min; err_min];
    global courbe_max = [courbe_max; err_max];
end
plot(x,courbe_max, color="green")
plot(x,courbe_min, color="green")
