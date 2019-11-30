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
TAILLE_FORMANT = SURECHANTILLONNAGE * 10 + 1;
TAILLE_CANAL = SURECHANTILLONNAGE * 10 + 1;

formant = formantcos(TAILLE_FORMANT, SURECHANTILLONNAGE);
lecanal = canal(TAILLE_CANAL, SURECHANTILLONNAGE);
formantbis = conv(formant,lecanal);

filtre_naif = formantbis[end:-1:1];
filtre_naif = filtre_naif[1:end,1];
dirac = [0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0];
message = 2 .* Int.(rand(TAILLE) .> 0.5) .- 1;
signal = emission(message, formant, SURECHANTILLONNAGE);
signal = conv(signal, lecanal);
interference = reception_sans_seuil(signal, filtre_naif, SURECHANTILLONNAGE, (TAILLE_CANAL - 1 + TAILLE_FORMANT - 1)/2);
# print(length(formantbis))
# print("\n")
# print(length(lecanal))
# print("\n")
# print(length(signal))
# print("\n")
# print(length(interference))
# print("\n\n")
# plot(interference);
INTERFERENCE = fft(interference)
INTERFERENCE_INV = 1 ./ INTERFERENCE;
interference_inv = real.(ifft(INTERFERENCE_INV));
#plot(interference_inv)
filtre = formantbis[end:-1:1];
filtre = filtre[1:end,1];
courbe_min = [];
courbe_max = [];
x = [];

for Pb = 0:0.25:8
    err_min = 1000;
    err_max = 0;
    for i = 1:10
        recu_echant = sortie_canal_interference(Pb,TAILLE,SURECHANTILLONNAGE,formant,filtre,lecanal,message);
        print(length(recu_echant))
        print("\n")
        recu = conv(recu_echant, interference_inv);
        recu = (recu .> 0) .* 2 .- 1;
        decalage = (length(interference_inv)-1)/2;
        decalage = Int(decalage);
        start_tronc = decalage + 1;
        end_tronc = length(recu) - decalage;
        recu = recu[start_tronc:1:end_tronc]
        print(length(recu))
        print("\n")
        print(length(message))
        print("\n\n")
        err = sum(abs.(recu-message)/2)/TAILLE
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
