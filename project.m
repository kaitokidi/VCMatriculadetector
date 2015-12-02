close all
% clearvars

if ~exist('classificador','var')
    jc = rgb2gray(imread('joc_de_caracters.jpg'));
    pp = imread('Joc_de_caracters_s3.jpg');
    descriptors = [];
    tt = [];

    posiblesCaracteres = detectarCaracteres(jc);
    
    for j = 1:length(posiblesCaracteres)
        left = posiblesCaracteres(j,1);
        top = posiblesCaracteres(j,2); 
        width = posiblesCaracteres(j,3); 
        height = posiblesCaracteres(j,4);
        descriptors = [descriptors; sacaFeatures(jc(top:top+height,left:left+width))];
%         tt = [tt; sacaFeatures(pp(top:top+height,left:left+width))];
    end
    
%     for ind = 1:30
% %         descriptors (:,ind) = jc(:,uint32(22+(ind-1)*75.1));
%         left = floor(22 +(ind-1)*75.1 - 35/2);
%         top = 1;
%         width = 35;
%         height = 72;
%         descriptors = [descriptors; sacaFeatures([left, top, width, height])];
%     end;
%     descriptors = descriptors';
    groups = ['0';'1';'2';'3';'4';'5';'6';'7';'8';'9';
        'B';'C';'D';'F';'G';'H';'J';'K';'L';'M';'N';'P';
        'R';'S';'T';'V';'W';'X';'Y';'Z'];

%     classificador = TreeBagger(100, [descriptors;tt], [groups;groups]);
    classificador = TreeBagger(100, descriptors, groups);
end




% img = imread('Matricules/0945HVM.jpg');
% img = imread('Matricules/5134FFJ.jpg');
% img = imread('Matricules/5406CWR.jpg');

listing = dir('Matricules');

for i = 1:size(listing)
    if (size(strfind(listing(i).name,'.jpg'),2) == 0) 
        continue;
    end
    name = listing(i).name;
    img2 = imread(strcat('Matricules/',name));
    lecturaMatricula(img2, classificador, name);
end

% 
% name = 'muchMatriculas.jpg';
% name = listing(11).name;
% img2 = imread(strcat('Matricules/',name));
% lecturaMatricula(img2, classificador,name);



