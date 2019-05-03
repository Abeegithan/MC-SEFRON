function Encoding_neurons = generate_population(param)
RF=param.RF;
dim=param.dim;
overlap=param.overlap;
Imin = 0;
Imax = 1;
Encoding_neurons.centre(1:RF*dim) = repmat((Imin+(2*(1:RF)-3)/2*(Imax-Imin)/(RF-2)),1,dim);
Encoding_neurons.width(1:RF*dim) = 1/overlap*(Imax-Imin)/(RF-2);
Encoding_neurons.RF=RF;
end

