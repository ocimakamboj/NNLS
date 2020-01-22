function [Xc,Yc,Values] = decisionBoundary(step,xmin,xmax,ymin,ymax,K,weights,clusterMeans,sigmaSq)
xvalues = xmin:step:xmax;
yvalues = ymax:-step:ymin;
[Xc,Yc] = meshgrid(xvalues,yvalues);

noxsteps = (xmax-xmin)/step+1;
noysteps = (ymax-ymin)/step+1;
noxsteps = round(noxsteps);
noysteps = round(noysteps);

for i = 1: noxsteps
    for j = 1:noysteps
        data = [Xc(j,i);Yc(j,i)];
        phi = zeros(K,1);
        %Apply the radial basis function to the data set 
        for l = 1:K
            dist = (data-clusterMeans(:,l))'*(data-clusterMeans(:,l));
            phi(l,:) = exp(-1/(2*sigmaSq(l))*dist);
        end
        
        y = weights'*phi;
        if(y>0)
            predicted = 1;
        else
            predicted = -1;
        end
        
        Values(j,i) = predicted;
    end
end
