function [dataR,desiredR] = randomiseData(data,desired,N,randSeed)
rng(randSeed);
p = randperm(N);
    for i = 1 : N
        dataR(:,i) = data(:,p(i));
        desiredR(i) = desired(p(i));
    end
end