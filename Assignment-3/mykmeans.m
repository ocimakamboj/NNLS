%{
k is the number of clusters
%}
function [clusterMeans,sigmaSq,sigmaSqCommon,clusterNumber,clusterElements] = mykmeans(data,K,N,maxIter,Radius,width,d,randseed)
rng(randseed);

%initial means
randIndex = randi(N,1,K);
for j = 1:K
    %clusterMeans(:,j) = data(:,randIndex(j));
    clusterMeans = generateData(K,Radius,width,d,randseed);
end

clusterIndex = zeros(1,N); %stores cluster index of each data point
dist = zeros(1,K); %stores the distance of a point from a cluster k

for noIter = 1:maxIter
    %assignment step
    for n = 1:N
        for j = 1:K
            dist(j) = (data(:,n)-clusterMeans(:,j))'*(data(:,n)-clusterMeans(:,j));
        end
        [minDistance,minDistIndex] = min(dist);
        clusterIndex(n) = minDistIndex;
    end
    
    %updateMeans
    for j = 1:K
        clusterNumber(:,j) = sum(clusterIndex==j);
        clusterMeans(1,j) = sum(data(1,:).*(clusterIndex==j))/clusterNumber(:,j);
        clusterMeans(2,j) = sum(data(2,:).*(clusterIndex==j))/clusterNumber(:,j);
    end 
end

%find variances
sigmaSq = zeros(1,K);
for n = 1:N
    distance = data(:,n)-clusterMeans(:,clusterIndex(n));
    sigmaSq(1,clusterIndex(n)) = sigmaSq(1,clusterIndex(n)) + distance'*distance;
end
sigmaSq = sigmaSq./clusterNumber;

%find variance according to (5.49)
dmax = 0;
for j = 1:K
    for jj = j+1:K
        dist = clusterMeans(:,j) - clusterMeans(:,jj);
        if(dist'*dist > dmax)
            dmax = dist'*dist;
            a = j;
            b = jj;
        end
    end
end

sigmaSqCommon = dmax / (2*K) /K;

clusterElements = cell(1,K);
for j = 1:K
    for n = 1:N
        if clusterIndex(n) == j
            clusterElements{j} = [clusterElements{j} data(:,n)];
        end
    end
end

%{
sumDist = 0;
for n = 1:N
    sumDist = sumDist + (data(:,n)-clusterMeans(:,clusterIndex(n)))'*(data(:,n)-clusterMeans(:,clusterIndex(n)));
end
%}


        
    