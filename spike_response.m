function [LIF_norm] = spike_response(s,tau)
x=s./tau;
LIF_norm = x.*exp(1-x);

LIF_norm(LIF_norm<0)=0;
end

