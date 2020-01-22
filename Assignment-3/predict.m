function [class,accuracy] = predict(NTest,data,desired,K,weights,clusterMeans,sigmaSq)
phi = zeros(K,NTest);
%Apply the radial basis function to the data set
for n = 1:NTest
    for j = 1:K
        dist = (data(:,n)-clusterMeans(:,j))'*(data(:,n)-clusterMeans(:,j));
        phi(j,n) = exp(-1/(2*sigmaSq(j))*dist);
    end
end

numberCorrect = 0;
for n = 1:NTest
    y = weights'*phi(:,n);
    if(y>0)
        class(n) = 1;
    else
        class(n) = -1;
    end
    if(class(n) == desired(n))
        numberCorrect = numberCorrect+1;
    end
end

accuracy = numberCorrect/NTest*100;