function vectorPosiblesCaracteres = detectarCaracteres( texture )
img = texture;
img = im2bw(img, graythresh(img));
img = ~img;
[L, n] = bwlabel(img);
s = regionprops(L,'centroid','area','MajorAxisLength','MinorAxisLength','Orientation','BoundingBox');
% % % figure, imshow(img,[]);

unidadArbitrariaDeTamanyio = 2*3;
sum = 0;
for i = 1:n
  sum = sum + s(i).BoundingBox(4);
end

avg = sum / n;

aux = [];
for i = 1:n
   pnis =  s(i).Orientation;
   if (s(i).Orientation > 45 || s(i).Orientation < -45) && s(i).Area > 2*unidadArbitrariaDeTamanyio %&& s(i).BoundingBox(4) > avg - unidadArbitrariaDeTamanyio &&   s(i).BoundingBox(4) < avg + unidadArbitrariaDeTamanyio
       aux = [aux;s(i)];
   end
end

s = aux;

% % % hold on
% % % for k = 1:length(s)
% % %     rectangle('Position',s(k).BoundingBox,'Curvature',0.05,'EdgeColor', 'r');
% % % end
% % % hold off

vectorPosiblesCaracteres = zeros(length(s),4);
for k = 1:length(s)
    vectorPosiblesCaracteres(k,1:4) = s(k).BoundingBox;
end
vectorPosiblesCaracteres
end