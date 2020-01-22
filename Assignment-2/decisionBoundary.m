function [Xc,Yc,Values] = decisionBoundary(step,xmin,xmax,ymin,ymax,L,W,B,threshold,norStatus,activID,activPar)
%form the grid
xvalues = xmin:step:xmax;
yvalues = ymax:-step:ymin;
[Xc,Yc] = meshgrid(xvalues,yvalues);

noxsteps = (xmax-xmin)/step+1;
noysteps = (ymax-ymin)/step+1;
noxsteps = round(noxsteps);
noysteps = round(noysteps);

if(norStatus==1)
    maxX  = [max(abs(Xc),[],'all')];
    maxY  = [max(abs(Yc),[],'all')];
    for i = 1:noxsteps
        XcN = Xc./maxX;
    end
    for i = 1:noysteps
        YcN = Yc./maxY;
    end
else
    XcN = Xc;
    YcN = Yc;
end

Y = cell(1,L);
V = cell(1,L);
for i = 1: noxsteps
    for j = 1:noysteps
        for l = 1:L %l signifies the layer
            if(l==1)
                V{l} = [B{l} W{l}]*[1;XcN(i,j);YcN(i,j)];
                Y{l} = activation(V{l},activID,activPar);
            else
                V{l} = [B{l} W{l}]*[1;Y{l-1}];
                Y{l} = activation(V{l},activID,activPar);
            end
        end
        
        %find the predicted class
        if(Y{L}>threshold)
            predicted = 1;
        elseif(Y{L}<threshold)
            predicted = 2*threshold-1;
        else
            predicted = threshold;
        end
     
        Values(j,i) = predicted;
    end
end
end

