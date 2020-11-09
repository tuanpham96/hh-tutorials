function a = alpha_n(V)
a = 0.01 * (V + 50) / (1 - exp(-(V + 50) / 10));
end