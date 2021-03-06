function signature = polarSignature( contorno, k)

    [x, y] = size(contorno);

    result = zeros(x,y);

    means = [mean(contorno(1:end,1)) mean(contorno(1:end,2))];

    % centroide
    xs = means(1)-contorno(1:end,1); 
    ys = means(2)-contorno(1:end,2);

    result(1:end,1) = mod((atan2(xs,ys)*180/pi),360); % Theta
    result(1:end,2) = sqrt(xs.^2 + ys.^2); % Radio

    signature = zeros(1,k);
    
    for i = 1:x
        if result(i,2) > signature(1+floor(result(i,1)/(360/k)))
            signature(1+floor(result(i,1)/(360/k))) = result(i,2);
        end
    end
    
    sumTotal = sum(signature);
    signature(1:end) = signature(1:end)/sumTotal;
%     figure, plot(signature,'.');
end

