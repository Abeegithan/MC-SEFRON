clear all
%% Load training and testing data
Tr= csvread('iris_train_1.csv');    
Te = csvread('iris_test_1.csv');

%% Choose learning algorithm  paramters

opts.RF        = 6;                   % Number of receptive feild neuron in population encoding scheme
opts.Pre       = 3;                   % Presynaptic spike interval in ms
opts.Post      = 4;                   % Postsynaptic spike interval in ms
opts.Desired   = 2;                   % Desired postsynaptic firing time in ms
opts.precision = 0.01;                % Precision of time-step
opts.learning_rate    = 0.5;          % learning rate of weight update
opts.efficacy_update_range = 0.55;    % sigma of time-varying weight kernal in ms
opts.tau            = 3;              % Time constant of spike response function in ms
opts.epoch          = 100;            % number of maximum epochs
opts.stdp = 1.6;                      % time-constant of STDP learning window


%% Train MC-SEFRON 

model=setup_SNN(opts);         

Trained_model=train_SNN(model,Tr,Te);

