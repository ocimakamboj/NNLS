function [class,acc] = predict(N,data,desired,L,threshold,thresholdStatus,activID,activPar,W,B)
count = 0;
%start forward pass
for n=1:N
    for l = 1:L %l signifies the layer
        if(l==1)
            v = [B{l} W{l}]*[1;data(:,n)];
            Y{l} = activation(v,activID,activPar);
        else
            v = [B{l} W{l}]*[1;Y{l-1}];
            Y{l} = activation(v,activID,activPar);
        end
    end

    %find the predicted class
    %if(thresholdStatus==1)
        if(Y{L}>threshold)
            class(n) = 1;
        elseif(Y{L}<threshold)
            class(n) = 2*threshold-1;
        else
            class(n) = threshold;
        end
    %else
    %    class(n) = Y{l};
    %end
    if(class(n)==desired(n))
        count = count+1;
    end
    acc = count/N*100;
end
end