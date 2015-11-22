jc = rgb2gray(imread('joc_de_caracters.jpg'));

descriptors = zeros(72,30);

for ind = 1:30
    descriptors (:,ind) = jc(:,uint32(22+(ind-1)*75.1));
end;
descriptors = descriptors';
groups = ['0';'1';'2';'3';'4';'5';'6';'7';'8';'9';
    'B';'C';'D';'F';'G';'H';'J';'K';'L';'M';'N';'P';
    'R';'S';'T';'V';'W';'X';'Y';'Z'];

classificador = TreeBagger(100, descriptors, groups);
[characters,scores] = predict (classificador, descriptors)