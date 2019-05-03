function Ut=STDP_norm(r_time,tau)
    stdp= exp(-abs(r_time)/tau);
    g=r_time;
    g(g>0)=1;
    g(g<0)=0;
    g=g.*stdp;
    pos_weight=bsxfun(@rdivide,g,sum(g));
    temp=isnan(pos_weight);
    pos_weight(temp)=0;
    g=r_time;
    g(g>0)=0;
    g(g<0)=1;
    g=g.*stdp;
    neg_weight=-1*bsxfun(@rdivide,g,sum(g));
    temp=isnan(neg_weight);
    neg_weight(temp)=0;

    Ut=pos_weight+neg_weight;
end
