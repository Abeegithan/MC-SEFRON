function Trained_model = MC_SEFRON(model,Spike_Train,Train_class,train_size,Spike_Test,Test_class)


rng('shuffle')
no_epoch=model.no_epoch;
Output_size=0;
model.theta=[];
Train_accu=zeros(1,no_epoch);
Test_accu=zeros(1,no_epoch);
Output_neuron.weight=zeros(model.dim*model.RF,model.T+1,model.no_class);
Output_neuron.theta=zeros(1,model.no_class);
% order=randperm(train_size);
order=1:train_size;

%Initialize weith and firing threshlod
for j=1:train_size
             Sample=Spike_code(Spike_Train(order(j),:),Train_class(order(j)),model);             
             if (all(Output_neuron.weight(:,:,Sample.class))==0)
                Output_size = Output_size+1;
                Output_neuron.weight(:,:,Sample.class)=bsxfun(@times,bsxfun(model.fun,model.t_train,Sample.Spike_Time'),Sample.U_TID);               
                Output_neuron.theta(Sample.class)=Sample.U_TID'*Sample.Esto;
             end
             if(Output_size==model.no_class)
                 break
             end               
end

%% Training MC_SEFRON

for epoch=1:no_epoch
    
        for j=1:train_size
             Sample=Spike_code(Spike_Train(order(j),:),Train_class(order(j)),model);             
                             
             tc=FiringTime(Output_neuron,Sample,model);                 %determine the firing time of all the output neurons
             Other_class = setdiff(1:model.no_class,Sample.class);
             tcc = tc(Sample.class);
             tmc = min(tc(Other_class));
             reference_time=tc;

             if(tmc<tcc+model.Tm)                        
                %% Determine reference postsynaptic spike time  
                if( tcc>model.Td) 
                    reference_time(Sample.class)=model.Td;
                end
                trf_mc=min(model.TOID,tcc+model.Tm);
                Wrng_class=find(tc(Other_class)<tcc+model.Tm);
                reference_time(Other_class(Wrng_class))=trf_mc;  
                
                %% Weight Update                 
                 r_time=bsxfun(@minus,tc,Sample.Spike_Time');
                 Ut=STDP_norm(r_time,model.stdp);                                                                                           % normailzed STDP with respect to actual firing time
                 r_time=bsxfun(@minus,reference_time,Sample.Spike_Time');
                 Ut_de=STDP_norm(r_time,model.stdp);                                                                                        % normailzed STDP with respect to reference firing time
                 w_tf=Output_neuron.theta./sum(Ut.*spike_response(bsxfun(@minus, tc, Sample.Spike_Time'),model.tau));
                 w_td=Output_neuron.theta./sum(Ut_de.*spike_response(bsxfun(@minus,reference_time,Sample.Spike_Time'),model.tau));
                 delta_W = bsxfun(@times,Ut_de,(w_td-w_tf));                                                                                % change in weight
                 delta_wx=bsxfun(@times,bsxfun(model.fun,(0:1:model.T),repmat(Sample.Spike_Time,1,model.no_class)'),reshape(delta_W,[],1)); % Embedding the change in a time-varying function
                 Output_neuron.weight=Output_neuron.weight+model.l_rate*permute(reshape(delta_wx',[model.T+1,model.dim*model.RF,model.no_class]),[2,1,3]);              
               
             end  
                
        end
        Trained_model=model;
        Trained_model.Output_neuron=Output_neuron;        
        Train_accu(epoch)= validate(Spike_Train,Train_class,Trained_model); 
        Test_accu(epoch)=validate(Spike_Test,Test_class,Trained_model); 
        disp(['Epoch: ', num2str(epoch)])
        disp(['Training accuracy: ', num2str(Train_accu(epoch))])
        disp(['Testing accuracy: ', num2str(Test_accu(epoch))])
end
plot(Train_accu)
hold on
plot(Test_accu)
end

