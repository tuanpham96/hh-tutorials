function [dV_dt, dm_dt, dh_dt, dn_dt, I_Na, I_K, I_L, total_I] = dsys_hh(V,m,h,n,I)
global E_Na E_K E_L; 
global gbar_Na gbar_K gbar_L;
global C;

I_Na    = gbar_Na * m^3 * h * (E_Na - V);
I_K     = gbar_K  * n^4 * (E_K - V); 
I_L     = gbar_L  * (E_L - V); 

total_I = I + I_Na + I_K + I_L; 
dV_dt   = total_I / C;

dm_dt   = alpha_m(V) * (1-m) - beta_m(V) * m;
dh_dt   = alpha_h(V) * (1-h) - beta_h(V) * h;
dn_dt   = alpha_n(V) * (1-n) - beta_n(V) * n;

end







