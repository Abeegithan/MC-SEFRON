function [tc,V] = FiringTime(Output_neuron,Sample,param) 
             
        linearInd = sub2ind(size(Output_neuron.weight), repmat([1:param.dim*param.RF],1,param.no_class), repmat(Sample.Spike_Time,1,param.no_class),reshape(repmat([1:param.no_class],param.dim*param.RF,1),1,[]));
        W_sample=Output_neuron.weight(linearInd);
        wh=reshape(W_sample,param.dim*param.RF,param.no_class);
        V=wh'*spike_response(bsxfun(@minus, param.t,Sample.Spike_Time'),param.tau);
        firing=(V>Output_neuron.theta');
        [~,firing_time]=max(firing');
        firing_time(firing_time==1)=param.TOID;
        tc = firing_time;          

end

