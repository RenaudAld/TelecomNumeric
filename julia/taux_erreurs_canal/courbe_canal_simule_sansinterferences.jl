using PyPlot
using FFTW

include("sortie_canal_interference.jl")
include("../commun/formantcos.jl")
include("../commun/emission.jl")
include("../commun/reception_sans_seuil.jl")
include("../commun/bruit.jl")
include("canal.jl")

SURECHANTILLONNAGE = 6;
TAILLE = 10001;
TAILLE_FORMANT = SURECHANTILLONNAGE * 11 + 1;
TAILLE_CANAL = SURECHANTILLONNAGE * 30 + 1;

formant = formantcos(TAILLE_FORMANT, SURECHANTILLONNAGE);
lecanal = canal(TAILLE_CANAL, SURECHANTILLONNAGE);
formantbis = conv(formant,lecanal);
filtre = formantbis[end:-1:1];
filtre = filtre[1:end,1];

dirac = [0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0];

signal = emission(dirac, formant, SURECHANTILLONNAGE);
signal = conv(signal, lecanal);
interference = reception_sans_seuil(signal, filtre, SURECHANTILLONNAGE, (TAILLE_CANAL - 1 + TAILLE_FORMANT - 1)/2);
INTERFERENCE = fft(interference)
INTERFERENCE_INV = 1 ./ INTERFERENCE;
interference_inv = [real.(ifft(INTERFERENCE_INV))[2:end];0]

courbe_min = [];
courbe_max = [];
x = [];

for Pb = 0:0.25:8
    err_min = 1000;
    err_max = 0;
    for i = 1:10
        err = sortie_canal_interference(Pb,TAILLE,SURECHANTILLONNAGE,formant,filtre,lecanal,interference_inv);
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
