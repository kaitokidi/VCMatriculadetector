function [] = generar(img,name)
    [x, y] = size(img);
    
    factor = 0.95;
    m = ~im2bw(img, graythresh(img));
    m = imresize(m,[x, y*factor]);
    m = imrotate(m, 5);
    m = ~m;
    imwrite(m,strcat(strcat(name,'_1'),'.tif'));

    factor = 0.95;
    m = ~im2bw(img, graythresh(img));
    m = imresize(m,[x, y*factor]);
    m = imrotate(m, -5);
    m = ~m;
    imwrite(m,strcat(strcat(name,'_2'),'.tif'));
    
    factor = 0.9;
    m = ~im2bw(img, graythresh(img));
    m = imresize(m,[x, y*factor]);
    m = imrotate(m, 10);
    m = ~m;
    imwrite(m,strcat(strcat(name,'_3'),'.tif'));
    
    factor = 0.9;
    m = ~im2bw(img, graythresh(img));
    m = imresize(m,[x, y*factor]);
    m = imrotate(m, -10);
    m = ~m;
    imwrite(m,strcat(strcat(name,'_4'),'.tif'));
end

