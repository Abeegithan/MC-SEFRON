function spiketime = population_encoding(Data,Encorder,param)

    spiketime=zeros(size(Data,1),size(Data,2)*Encorder.RF);    
    for j=1:size(Data,1)
        target = reshape(repmat(Data(j,:),Encorder.RF,1),[1,Encorder.RF*size(Data,2)]);
        Firing_Strength = exp(-((target - Encorder.centre).^2) ./ (2*(Encorder.width.^2)));
        spiketime(j,:) = round(param.T*(1-Firing_Strength))+1;        
    end

end

