function y = activationDer(x,ID,parameters)
    if(ID == 1)
        y = logisticDer(x,parameters);
    elseif (ID == 2)
        y = hyperbolicTanDer(x,parameters);
    elseif (ID==3)
        y = x > 0;
    elseif (ID==4)
        v = erfinv(x);
        y = 2/sqrt(pi).*exp(-v.*v);
    elseif (ID == 5)
        y = logisticDer(x,parameters);
    else
        error('incorrect ID');
    end
end

function y = hyperbolicTanDer(x,parameters)
    if(size(parameters,1)~=2)
        disp('Error in tanh Der');
        y = 0;
    else
        a = parameters(1);
        b = parameters(2);
        y = (b/a)*(a-x).*(a+x);
    end
end

function y = logisticDer(x,parameters)
    if(size(parameters,1)~=1)
        disp('Error in logistic derivation');
        y = 0;
    else
        a = parameters(1);
        y = a*x.*(1-x);
    end
end

