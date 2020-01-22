function [weights,clusterMeans,sigmaSq,MSE] = RBF_LMS(N,data,desired,K,epochMax,eta,maxIter,Radius,width,d,randseed)
%perform kmeans to find the centroids and variances
[clusterMeans,sigmaSq] = mykmeans(data,K,N,maxIter,Radius,width,d,randseed);

phi = zeros(K,N);
%Apply the radial basis function to the data set
for n = 1:N
    for j = 1:K
        dist = (data(:,n)-clusterMeans(:,j))'*(data(:,n)-clusterMeans(:,j));
        phi(j,n) = exp(-1/(2*sigmaSq(j))*(data(:,n)-clusterMeans(:,j))'*(data(:,n)-clusterMeans(:,j)));
    end
end

%initialise
w = zeros(K,1);
MSE = zeros(1,epochMax);

eta = annealing(0.6,0.01,epochMax);

for epoch=1:epochMax
    for n = 1:N
        predicted = w'*phi(:,n);
        error(n) = desired(n) - predicted;
        wnext = w + eta(epoch)*phi(:,n)*error(n);
        w = wnext;
    end
    MSE(1,epoch) = mean(error'.^2);
end

weights = w;


