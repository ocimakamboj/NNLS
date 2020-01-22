function [weights,clusterMeans,sigmaSq,sigmaSqCommon,MSE] = RBF_RLS(N,data,desired,K,epochMax,lambda,maxIter,Radius,width,d,randseed)
%perform kmeans to find the centroids and variances
[clusterMeans,sigmaSq,sigmaSqCommon] = mykmeans(data,K,N,maxIter,Radius,width,d,randseed);

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
P = eye(K)/lambda;
MSE = zeros(1,epochMax);

for epoch=1:epochMax
    for n = 1:N
        Pnext = P - (P*phi(:,n)*phi(:,n)'*P)/(1+phi(:,n)'*P*phi(:,n));
        g = Pnext*phi(:,n);
        alpha = desired(n) - w'*phi(:,n);
        wnext = w + g*alpha;
        predicted = w'*phi(:,n);
        error(n) = desired(n) - predicted;
        P = Pnext;
        w = wnext;
    end
    MSE(1,epoch) = mean(error'.^2);
end

weights = w;


