#Function qui renvoie un formant f(x) = sinc(pi*x) si x != 0 et 1 sinon.

function formantrect(TAILLE, SURECHANTILLONNAGE)
    PI = 3.1415926535;
    formant = zeros(TAILLE);
    t = (collect(1:1:TAILLE) .- Int(floor((TAILLE+1)/2))) / SURECHANTILLONNAGE;
    for i=1:TAILLE
        if t[i] == 0
            formant[i] = 1;
        else
            formant[i] = sin(PI*t[i]) ./ (PI*t[i]);
        end
    end
    return formant;
end