function representation = SlopeRepresentation( contorno, k )

 [x, y] = size(contorno);
 
 step = x/k;
 
 representation = zeros(1,k);
 anterior = [contorno(1,1) contorno(1,2)];
 
 for i=step+1:step:x
       current = [contorno(floor(i),1) contorno(floor(i),2)];
       % Angulo entre el punto anteior y el actual
       representation(1,floor(i/step)) = atan2(current(1)-anterior(1),current(2)-anterior(2))*180/pi; 
       anterior = current;
 end

%  figure, plot(representation);
 
end

