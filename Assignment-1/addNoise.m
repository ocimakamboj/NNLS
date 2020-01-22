%{
function to add noise to the input data.
this takes as input the data which has to be made noisy, the no. of
samples N,
the mean mu and the standard deviation sigma of the gaussian noise to be
added
it gives as output the modified data set
%}
function dataModified = addNoise(inputData,N,mu,sigma)
rng(1); %sets the seed for random number generation
    for i = 1:N
        r1 = sigma*randn + mu;
        r2 = sigma*randn + mu;
        dataModified(i,1) = inputData(i,1) + r1;
        dataModified(i,2) = inputData(i,2) + r2;
    end
end