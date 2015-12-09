close all

jc = rgb2gray(imread('joc_de_caracters.jpg'));
posiblesCaracteres = detectarCaracteres(jc);

groups = ['0';'1';'2';'3';'4';'5';'6';'7';'8';'9';
        'B';'C';'D';'F';'G';'H';'J';'K';'L';'M';'N';'P';
        'R';'S';'T';'V';'W';'X';'Y';'Z'];

 for j = 1:length(posiblesCaracteres)
        left = posiblesCaracteres(j,1);
        top = posiblesCaracteres(j,2); 
        width = posiblesCaracteres(j,3); 
        height = posiblesCaracteres(j,4);
        name = strcat('LetrasGeneradas/',groups(j));
        generar(jc(top:top+height,left:left+width),name);
 end