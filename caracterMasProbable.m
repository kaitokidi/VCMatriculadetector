function caracter = caracterMasProbable(clasificador,  features, numero)
 [characters,scores] = predict (clasificador, features);
 max(scores(1:end))
 characters(1,1)
 groups = ['0';'1';'2';'3';'4';'5';'6';'7';'8';'9';
        'B';'C';'D';'F';'G';'H';'J';'K';'L';'M';'N';'P';
        'R';'S';'T';'V';'W';'X';'Y';'Z'];
   
numero = true;
    
 if numero
     [maxvalue, argmax] =  max(scores(1:9));
     if maxvalue >= 0.2
        caracter = groups(argmax);
     else
        caracter = strcat('~',groups(argmax));
     end
%  else
%      [maxvalue, argmax] =  max(scores(10:end));
%      if maxvalue >= 0.2
%         caracter = groups(argmax+9);
%      else
    groups(argmax+9)
     strcat('~',groups(argmax+9))
        caracter = strcat('~',groups(argmax+9));
%      end
 end

end

