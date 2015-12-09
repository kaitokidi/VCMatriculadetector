function features = sacaFeatures(img)
    img = im2bw(img, graythresh(img));
    img = ~img;
%     img = imclose(img,strel('disk',2));
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
    
    [B,L] = bwboundaries(img,8);
    contorno = B{1,1};
    polarSignautr = polarSignature(contorno,60);
    
%     slope = SlopeRepresentation(contorno,60);
    
%  	figure, imshow(img);
    features = [s(t).Perimeter/s(t).Area s(t).EulerNumber polarSignautr];
end

