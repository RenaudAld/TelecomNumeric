using PyPlot
using FFTW

include("erreur_canal.jl")
include("../commun/formantcos.jl")
include("canal.jl")
SURECHANTILLONNAGE = 30;
TAILLE = 10000;
TAILLE_FORMANT = SURECHANTILLONNAGE*10+1;
TAILLE_CANAL = SURECHANTILLONNAGE*10+1;

formant = formantcos(TAILLE_FORMANT, SURECHANTILLONNAGE);
lecanal = canal(TAILLE_CANAL, SURECHANTILLONNAGE);
formantbis = conv(formant,lecanal);

FORMANTBIS = fft(formantbis)

HFORMANTBIS = FORMANTBIS
pas = Int((length(FORMANTBIS)-1)/30)
for i = 1:length(HFORMANTBIS)
    truc = sum(abs.(FORMANTBIS[(i-1)%pas+1:pas:end]).^2)
    HFORMANTBIS[i] = HFORMANTBIS[i] / truc
end
formantbis = real.(ifft(HFORMANTBIS))


filtre = formantbis[end:-1:1] / (formantbis'*formantbis);
filtre = filtre[1:end,1];
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
plot(x,courbe_max, color="black")
plot(x,courbe_min, color="black")
