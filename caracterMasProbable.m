function caracter = caracterMasProbable(clasificador,  features)
 [characters,scores] = predict (clasificador, features);
 max(scores(1:end))
 if max(scores(1:end)) >= 0.25
    caracter = characters(1,1);
 else
    caracter = 'Ñ';
 end
end

