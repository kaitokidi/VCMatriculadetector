function features = sacaFeatures(img)
    img = im2bw(img, graythresh(img));
    img = ~img;
    img = imclose(img,strel('disk',2));
    [L, n] = bwlabel(img);
    s = regionprops(L,'perimeter','area','EulerNumber');
    t = 1;
    if n > 1
         for i = 2:n
            if s(i).Area > s(t).Area
                t = i;
            end
         end
    end
 	figure, imshow(img);
    features = [s(t).Perimeter/s(t).Area s(t).EulerNumber];
end

