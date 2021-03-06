function matricula = lecturaMatricula( img, clasificador,name )
imgray = rgb2gray(img);

posiblesMatriculas = deteccioMatricula(img);
[xMatriculas yMatriculas] = size(posiblesMatriculas);
if xMatriculas == 0
     msgbox(strcat('No hay ninguna posible matricula para la imagen ', name ), 'icon', 'error')
     matricula = '0';
     return;
end

figure, imshow(img);
matriculaEncontrada = false;
for j = 1:xMatriculas
    left = posiblesMatriculas(j,1);
    top = posiblesMatriculas(j,2); 
    width = posiblesMatriculas(j,3); 
    height = posiblesMatriculas(j,4);
    posiblesCaracteres = detectarCaracteres(imgray(top:top+height,left:left+width));
    if length(posiblesCaracteres) <= 4
        continue;
    end
    caracteres = [];
    for k = 1:length(posiblesCaracteres)
        leftPC = posiblesCaracteres(k,1)+left;
        topPC = posiblesCaracteres(k,2)+top;
        widthPC = posiblesCaracteres(k,3);
        heightPC = posiblesCaracteres(k,4);
        features = sacaFeatures(imgray(topPC:topPC+heightPC,leftPC:leftPC+widthPC));
        caracteres = [caracteres; (caracterMasProbable(clasificador,features, true))];
    end
    % pintar si hay letras
    pintarRecuadro = false;
    hold on
    for k = 1:length(posiblesCaracteres)
        if ~strcmp(caracteres(k),'-')
            rectangle('Position',[posiblesCaracteres(k,1)+left posiblesCaracteres(k,2)+top posiblesCaracteres(k,3) posiblesCaracteres(k,4)],'Curvature',0.05,'EdgeColor', 'r');
            text(posiblesCaracteres(k,1)+left+posiblesCaracteres(k,3)/2,posiblesCaracteres(k,2)+top+posiblesCaracteres(k,4)/2,caracteres(k),'color', 'r');
            pintarRecuadro = true;
        end
    end
    if pintarRecuadro
        rectangle('Position',[left top width height],'Curvature',0.05,'EdgeColor', 'b')
        matriculaEncontrada = true;
    end
    hold off
end

if ~matriculaEncontrada
    msgbox(strcat('No se ha encontrado ninguna matricula para la imagen ', name ), 'icon', 'error')
end

matricula = '1';
end

