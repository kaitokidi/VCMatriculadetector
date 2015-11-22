close all
clearvars

% img = imread('Matricules/0945HVM.jpg');
% img = imread('Matricules/5134FFJ.jpg');
img = imread('Matricules/5406CWR.jpg');

listing = dir('Matricules');

for i = 1:size(listing)
    if (size(strfind(listing(i).name,'.jpg'),2) == 0) 
        continue;
    end
    name = listing(i).name;
    img2 = imread(strcat('Matricules/',name));
    imgray = rgb2gray(img2);

    posiblesMatriculas = deteccioMatricula(img2);
    [xMatriculas yMatriculas] = size(posiblesMatriculas);
    if xMatriculas == 0
         msgbox(strcat('No hay ninguna posible matricula para la imagen ', name ), 'icon', 'error')
         break;
    end

    figure, imshow(img2);

    for j = 1:xMatriculas
        left = posiblesMatriculas(j,1);
        top = posiblesMatriculas(j,2); 
        width = posiblesMatriculas(j,3); 
        height = posiblesMatriculas(j,4);
        posiblesCaracteres = detectarCaracteres(imgray(top:top+height,left:left+width));
        if length(posiblesCaracteres) <= 4
            continue;
        end
        hold on
        rectangle('Position',[left top width height],'Curvature',0.05,'EdgeColor', 'b')
        for k = 1:length(posiblesCaracteres)
            posiblesCaracteres(k);
            rectangle('Position',[posiblesCaracteres(k,1)+left posiblesCaracteres(k,2)+top posiblesCaracteres(k,3) posiblesCaracteres(k,4)],'Curvature',0.05,'EdgeColor', 'r');
        end
        hold off
    end
end


% name = 'muchMatriculas.jpg';
% name = listing(15).name;
% img2 = imread(strcat('Matricules/',name));
% imgray = rgb2gray(img2);
% 
% posiblesMatriculas = deteccioMatricula(img2);
% [xMatriculas yMatriculas] = size(posiblesMatriculas);
% if xMatriculas == 0
%      msgbox(strcat('No hay ninguna posible matricula para la imagen ', name ), 'icon', 'error')
%      break;
% end
% 
% figure, imshow(img2);
% 
% for j = 1:xMatriculas
%     left = posiblesMatriculas(j,1);
%     top = posiblesMatriculas(j,2); 
%     width = posiblesMatriculas(j,3); 
%     height = posiblesMatriculas(j,4);
%     posiblesCaracteres = detectarCaracteres(imgray(top:top+height,left:left+width));
%     if length(posiblesCaracteres) <= 4
%         continue;
%     end
%     hold on
%     rectangle('Position',[left top width height],'Curvature',0.05,'EdgeColor', 'b')
%     for k = 1:length(posiblesCaracteres)
%         posiblesCaracteres(k);
%         rectangle('Position',[posiblesCaracteres(k,1)+left posiblesCaracteres(k,2)+top posiblesCaracteres(k,3) posiblesCaracteres(k,4)],'Curvature',0.05,'EdgeColor', 'r');
%     end
%     hold off
% end




