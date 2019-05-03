function Sample = Spike_code(Spike_train,class,param)

Sample.Spike_Time=Spike_train;
Sample.Esto=spike_response(bsxfun(@minus, param.TID,Spike_train'),param.tau);
Sample.U_TID=STDP_norm((param.TID-Spike_train),param.stdp)'; 
Sample.class=class;

end

