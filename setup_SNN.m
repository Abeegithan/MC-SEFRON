function model= setup_SNN(opts)

model.RF = opts.RF;
model.sigma =opts.efficacy_update_range/opts.precision;
model.l_rate=opts.learning_rate;
model.T = opts.Pre/opts.precision;
model.TOID = opts.Post/opts.precision;
model.t_train=0:1:model.T;
model.no_epoch=opts.epoch;
model.fun=@(A,B) exp(-(A-B).^2/(2*model.sigma^2));
model.TID = opts.Desired /opts.precision;
model.tau = opts.tau/opts.precision;
model.overlap=0.7;
model.stdp= opts.stdp/opts.precision;
model.Tm  = 0.05/opts.precision;
model.Td = model.TID;
end

