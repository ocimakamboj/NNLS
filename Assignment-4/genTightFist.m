function [data, desired] = genTightFist(N,d1,d2,d3,randseed)
rng(randseed);
data = zeros(2,N);
desired = zeros(1,N);

n = 1;
while n<=N/2
    R = d1 * sqrt(rand);
    if(R<=d3 || R>=d2)
        theta = pi*rand;
        data(1,n) = R*cos(theta);
        data(2,n) = R*sin(theta);
        desired(n) = 1;
        n = n+1;
    else
        theta = -pi*rand;
        data(1,n) = R*cos(theta);
        data(2,n) = R*sin(theta);
        desired(n) = 1;
        n = n+1;
    end
end


while n<=N
    R = d1 * sqrt(rand);
    if(R<=d3 || R>=d2)
        theta = -pi*rand;
        data(1,n) = R*cos(theta);
        data(2,n) = R*sin(theta);
        desired(n) = -1;
        n = n+1;
    else
        theta = pi*rand;
        data(1,n) = R*cos(theta);
        data(2,n) = R*sin(theta);
        desired(n) = -1;
        n = n+1;
    end
end