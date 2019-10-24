# Cette fonction renvoie un bruit de taille TAILLE, sachant que
# l'energie pqr bits du message vaut Eb et que le rapport Eb/No
# vaut Pb

function bruit(Pb, Eb, TAILLE)
    No = Eb/(10^(Pb/10));
    bruit = sqrt(No/2) .* randn(TAILLE);
    return(bruit);
end
