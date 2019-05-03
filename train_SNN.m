function Trained_model = train_SNN(model,Tr,Te)
Train_class = Tr(:,end);
Train = Tr(:,1:end-1);
train_size=size(Train,1);

Test_class = Te(:,end);
Test = Te(:,1:end-1);
test_size=size(Test,1);

model.no_class = max(Train_class);
model.dim = size(Train,2);  
model.t = ones(model.dim*model.RF,1)*(0:1:model.TOID);

Encoding_neurons = generate_population(model);                 % Creating population encoding neurons
Spike_Train=population_encoding(Train,Encoding_neurons,model); % converting real-valued Training dataset to spike times
Spike_Test=population_encoding(Test,Encoding_neurons,model);   % converting real-valued Testing dataset to spike times


Trained_model=MC_SEFRON(model,Spike_Train,Train_class,train_size,Spike_Test,Test_class);

end

