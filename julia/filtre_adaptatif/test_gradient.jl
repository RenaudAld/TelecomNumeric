using PyPlot
using DSP
include("./adaptatif_gradient.jl")

function test_gradient(taille_filtre, taille_signal, mu, filtre)
    signal = randn(taille_signal);
    signal_filtre = conv(signal, filtre);
    signal_filtre = signal_filtre[Int32(floor(length(filtre)/2)+1) : end];
    filtre_gradient = adaptatif_gradient_init(taille_filtre, mu);
    convergence = []
    for i = collect(1:length(signal))
        err = adaptatif_gradient(signal[i], signal_filtre[i], filtre_gradient);
        convergence = [convergence; err];
    end
    return convergence
end
