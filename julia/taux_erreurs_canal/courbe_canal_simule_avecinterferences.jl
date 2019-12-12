using PyPlot
using FFTW

include("sortie_canal_interference.jl")
include("../commun/formantcos.jl")
include("../commun/emission.jl")
include("../commun/reception_sans_seuil.jl")
include("../commun/bruit.jl")
include("canal.jl")

SURECHANTILLONNAGE = 30;
TAILLE = 10001;
TAILLE_FORMANT = SURECHANTILLONNAGE * 11 + 1;
TAILLE_CANAL = SURECHANTILLONNAGE * 30 + 1;

formant = formantcos(TAILLE_FORMANT, SURECHANTILLONNAGE);
lecanal = canal(TAILLE_CANAL, SURECHANTILLONNAGE);
formantbis = conv(formant,lecanal);
filtre = formantbis[end:-1:1];
Ef = (filtre'*filtre)/SURECHANTILLONNAGE;

dirac = [0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0];

signal = emission(dirac, formant, SURECHANTILLONNAGE);
signal = conv(signal, lecanal);
interference = reception_sans_seuil(signal, filtre, SURECHANTILLONNAGE, (TAILLE_CANAL - 1 + TAILLE_FORMANT - 1)/2);
INTERFERENCE = fft(interference)

#Evaluation de eb en l'absence de bruit
message_sans_bruit = 2 .* Int.(rand(TAILLE) .> 0.5) .- 1;
signal_sans_bruit = emission(message_sans_bruit, formant, SURECHANTILLONNAGE);
signal_sans_bruit = conv(signal_sans_bruit,lecanal);
Eb = ((signal_sans_bruit'*signal_sans_bruit)/TAILLE)[1]

courbe_min = [];
courbe_max = [];
x = [];

for Pb = 0:0.25:8
    err_min = 1000;
    err_max = 0;
    print(Pb)
    print("\n")
    N0 = (Ef/(10^(Pb/10))) / 2;
    INTERFERENCE_INV = 1 ./ (N0 .+ INTERFERENCE);
    interference_inv = [real.(ifft(INTERFERENCE_INV))[2:end];0]

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
plot(x,courbe_max, color="magenta")
plot(x,courbe_min, color="magenta")
