function vectorPosibleMatricula = deteccioMatricula( texture )
% % % % % img = texture;
img = rgb2gray(texture);

[x y] = size(img);

midx = floor(x/2);
midy = floor(y/2);

% % Binarizar con regiones NOT BROKEN AT ALL
% img0 = img(1:midx,1:midy);
% img1 = img(1:midx,midy+1:end);
% img2 = img(midx+1:end,1:midy);
% img3 = img(midx+1:end,midy+1:end);
% img0 = im2bw(img0, graythresh(img0));
% img1 = im2bw(img1, graythresh(img1));
% img2 = im2bw(img2, graythresh(img2));
% img3 = im2bw(img3, graythresh(img3));
% img(1:midx,1:midy) = img0;
% img(1:midx,midy+1:end) = img1;
% img(midx+1:end,1:midy) = img2;
% img(midx+1:end,midy+1:end) = img3;

% % binarizacion local

% % Primero laplacian

% img = imgaussfilt3(img);
% figure, imshow(img,[]);

% img = imfilter(img,fspecial('gaussian'));
% figure, imshow(img,[]);
% 
img = imclearborder(img);
% figure, imshow(img,[]);
img = im2bw(img, graythresh(img));
% % % % % img = efficientLBP(img);
% % % % % img = rgb2gray(img);
% % % % % img = im2bw(img, graythresh(img));
% % % % % img = ~img;
% figure, imshow(img,[]);
img = imopen(img,strel('square',3));

% % figure, imshow(img,[]);
[L, n] = bwlabel(img);
s = regionprops(L,'centroid','area','MajorAxisLength','MinorAxisLength','Orientation','BoundingBox');


% eliminamos los que son demasiado grandes o demasiado pequeños o estan en
% vertical
aux = [];
for i = 1:n
   if s(i).BoundingBox(4) > 0.03*y && s(i).BoundingBox(3) < 0.95*x % && s(i).Orientation < 45 && s(i).Orientation > -45
       aux = [aux;s(i)];
   end
end
[n p] = size(aux);
if n == 0
    vectorPosibleMatricula = [[]];
    return;
end
s = aux;

% % Eliminamos los que tienen un ratio fuera del intervalo
% % TODO: intervalo en funcion de la orientacion
% [n p] = size(s);
% aux = []
% for i = 1:n
%    ratio = s(i).MajorAxisLength / s(i).MinorAxisLength;
%    if ratio < 5 && ratio > 4 %&& ratioArea > outputoutput.Area/(outputoutput.MajorAxisLength * outputoutput.MinorAxisLength)
%         aux = [aux s(i)];
%    end
% end
% 
% % Si hemos eliminado todos, nos quedamos con el mas cercano al intervalo
% [n2 p2] = size(aux);
% if n2 ~= 0
%     s = aux;
% else
%     aux = s(1);
%     dist = abs(4.5-(s(1).MajorAxisLength / s(1).MinorAxisLength));
%     for i = 2:n
%        ratio = s(i).MajorAxisLength / s(i).MinorAxisLength;
%        if abs(4.5-ratio) < dist
%             aux = s(i);
%             dist = abs(4.5-ratio);
%        end
%     end
%     s = [aux];
% end

% Pillamos el que tiene mayor area
[n p] = size(s);

aux2 = s(1);
maxRatioArea = 100*s(1).Area/(s(1).MajorAxisLength * s(1).MinorAxisLength);
dist = 100*abs(4.5-(s(1).MajorAxisLength / s(1).MinorAxisLength));
for i = 2:n
    ratioArea = 100*s(i).Area/(s(i).MajorAxisLength * s(i).MinorAxisLength);
    ratio = s(i).MajorAxisLength / s(i).MinorAxisLength;
   if ratioArea-100*abs(4.5-ratio) > maxRatioArea-dist 
        aux2 = s(i);
        maxRatioArea = ratioArea;
        dist = 100*abs(4.5-ratio);
   end
end
% s = [aux];


output = aux2;

% area = s(i).MajorAxisLength * s(i).MinorAxisLength;
% ratioArea = s(i).Area/area;




% % hold on
% % 
% % for k = 1:length(s)
% %     text(s(k).Centroid(1), s(k).Centroid(2), int2str(100.0*s(k).Area/(s(k).MajorAxisLength * s(k).MinorAxisLength)),'Color','red','FontSize',14);
% %     text(s(k).Centroid(1), s(k).Centroid(2)+25, int2str(abs(4.5-s(k).MajorAxisLength / s(k).MinorAxisLength)*100),'Color','green','FontSize',14);
% %     text(s(k).Centroid(1), s(k).Centroid(2)+50, int2str(100.0*s(k).Area/(s(k).MajorAxisLength * s(k).MinorAxisLength)-abs(4.5-s(k).MajorAxisLength / s(k).MinorAxisLength)*100),'Color','blue','FontSize',14);
% %     
% %     rectangle('Position',s(k).BoundingBox,'Curvature',0.05,'EdgeColor', 'r')
% % end
% % rectangle('Position',aux2.BoundingBox,'Curvature',0.05,'EdgeColor', 'b')
% % hold off

left = output.BoundingBox(1);
top = output.BoundingBox(2); 
width = output.BoundingBox(3); 
height = output.BoundingBox(4);

vectorPosibleMatricula = zeros(length(s),4);
for k = 1:length(s)
    vectorPosibleMatricula(k,1:4) = s(k).BoundingBox;
end

% imshow(img);
end

