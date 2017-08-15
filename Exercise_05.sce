clc; clear; //clears the console and all previously stored variables
function V0 = BinMod_EuPut_CF(S0, r, sigma, T, M, K)
    delta_t=T./M;    //calculation of delta_t (note: .^ is used throughout 
    //the function for elementwise calculation as input for M is given in 
    //vector form)
    
    //calculation of beta for CRR
    Beta=(exp(-r.*delta_t)+exp((r+sigma^2).*delta_t))/2; 
    u=Beta+sqrt((Beta.^2)-1); //so u>d is true        
    d=u.^-1; //because ud=1
    p=(exp(r.*delta_t)-d)./(u-d); //calculation of successs probability_Bond
    p_tilde=p.*u./exp(r.*delta_t); //calculation of successs probability_Stock
    a=ceil((log(K/S0)-M.*log(d))./log(u./d)); //smallest integer >= a
    //calculation of option value at time t=0 with the given formula
    V0 = K.*exp(-r*T).*cdfbin("PQ",a-1,M,p,1-p)-S0.*cdfbin("PQ",a-1,M,p_tilde,1-p_tilde);
endfunction

S0=100; r=0.05; sigma=0.2; T=1, K=100; M=10:500;
scf(0)
clf()
V0 = BinMod_EuPut_CF(S0, r, sigma, T, M, K);
plot(M,V0,"b.")

