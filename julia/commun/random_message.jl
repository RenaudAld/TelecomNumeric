function message_aleatoire(TAILLE)
    message = 2 .* Int.(rand(TAILLE) .> 0.5) .- 1;
    return message
end
