function [Xc,Yc,Values,ValuesTh] = decisionBoundary(step,xmin,xmax,ymin,ymax,outputSVM,SigmaSq,actID)
xvalues = xmin:step:xmax;
yvalues = ymax:-step:ymin;
[Xc,Yc] = meshgrid(xvalues,yvalues);

noxsteps = (xmax-xmin)/step+1;
noysteps = (ymax-ymin)/step+1;
noxsteps = round(noxsteps);
noysteps = round(noysteps);

for i = 1: noxsteps
    for j = 1:noysteps
        data(:,i+noxsteps*(j-1)) = [Xc(j,i);Yc(j,i)];
    end
end

NPr = size(data,2);
[y,class] = predict(NPr,data,ones(NPr,1),outputSVM,SigmaSq,actID);

for i = 1:noxsteps
    for j = 1:noysteps
        Values(j,i) = y(i+noxsteps*(j-1));
        ValuesTh(j,i) = class(i+noxsteps*(j-1));
    end
end
        
   
