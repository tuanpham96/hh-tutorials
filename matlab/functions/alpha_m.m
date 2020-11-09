function a = alpha_m(V)
a = 0.1 * (V + 35) / (1 - exp(-(V + 35) / 10));
end