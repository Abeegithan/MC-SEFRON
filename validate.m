function accuracy = validate(Spike_data,Class,Trained_model)
 Output_class=zeros(size(Class));
 
    for j=1:size(Spike_data,1)        
        Sample=Spike_code(Spike_data(j,:),Class(j),Trained_model);        
        [tc,Fire_vk] =FiringTime(Trained_model.Output_neuron,Sample,Trained_model);
         
            firing_index=find(tc~=Trained_model.TOID);
            val=find(min(tc)==tc);
            vd1=min(tc);
            if(vd1~=Trained_model.TOID && size(val,1)==1)
              [~,Output_class(j)] = min(tc);
            elseif(size(val,1)~=1 && vd1~=Trained_model.TOID)
                fire_precision=Fire_vk(val,vd1-1:vd1);
                ds=bsxfun(@minus,fire_precision,Trained_model.Output_neuron.theta(val));
                temp_ds=(zeros(size(val))-ds(:,1))./(ds(:,2)-ds(:,1));
                [~,f]=min(temp_ds);
                Output_class(j) = val(f);
           end

    end

    correct=find(Output_class==Class);
    accuracy= size(correct,1)/size(Spike_data,1)*100;
end

