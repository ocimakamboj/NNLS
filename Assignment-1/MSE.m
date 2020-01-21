function mse = MSE(calculated, desired, N)
mse = 0;
for i = 1:N
    mse = mse + (desired(i)-calculated(i))^2;
end
mse = mse/N;
end
