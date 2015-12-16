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
    
    groups = ['0';'1';'2';'3';'4';'5';'6';'7';'8';'9';
        'B';'C';'D';'F';'G';'H';'J';'K';'L';'M';'N';'P';
        'R';'S';'T';'V';'W';'X';'Y';'Z'];
    
    v_no_se_que_pone = 0;
    lnd3xju4nker1n0 = 1;
    
    listing = dir('LetrasGeneradas');
    for i = 1:size(listing)
        if (size(strfind(listing(i).name,'.tif'),2) == 0) 
            continue;
        end
        if v_no_se_que_pone >= 4 
            v_no_se_que_pone = 0;
            lnd3xju4nker1n0 = lnd3xju4nker1n0 + 1;
        end
        
        descriptors = [descriptors; sacaFeatures( uint8(imread(strcat('LetrasGeneradas/',listing(i).name))))];
        
        groups = [groups; groups(lnd3xju4nker1n0)];
        groups(lnd3xju4nker1n0);
        
        v_no_se_que_pone = v_no_se_que_pone+ 1;
        
    end
    
%     classificador = TreeBagger(100, [descriptors;tt], [groups;groups]);
    classificador = TreeBagger(200, descriptors, groups);
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
% name = listing(12).name;
% img2 = imread(strcat('Matricules/',name));
% lecturaMatricula(img2, classificador,name);



