%{
function to randomise the sequence of input data to be shown to the perceptron
inputdata is the data to be randomised
desired is the class labels matching the input data
N is the total number of samples
idataR is the randomised data sample
dR is the desired output corresponding to the randomised data
%}
function [idataR,dR] = randomiseData(inputdata,desired,N)
rng(1);
p = randperm(N);
    for i = 1 : N
        idataR(i,:) = inputdata(p(i),:);
        dR(i) = desired(p(i));
    end
end