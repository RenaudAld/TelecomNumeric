function bruit(Pb,Eb,TAILLE)
    No = Eb/(10^(Pb/10));
    print(No)
    print("\n")
    bruit = sqrt(No/2) .* randn(TAILLE);
    return(bruit);
end