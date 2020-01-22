%{
ID=1 is sigmoid activation
ID=2 is hyperbolic tangent activation
ID=3 is ReLU
ID=4 is erf activation
ID=5 is heavyside function. Same as logistic with a large value of
parameter
%}
function y = activation(x,ID,parameters)
    if(ID == 1)
        y = logistic(x,parameters);
    elseif (ID == 2)
        y = hyperbolicTan(x,parameters);
    elseif(ID == 3)
        y = max(0,x);
    elseif(ID==4)
        y = erf(x);
    elseif(ID==5)
        y = logistic(x,parameters);
    else
        error('incorrect id');
    end
end

function y = hyperbolicTan(x,parameters)
    if(size(parameters,1)~=2)
        disp('Error in tanh');
        y = 0;
    else
        a = parameters(1);
        b = parameters(2);
        y = a*tanh(b*x);
    end
end

function y = logistic(x,parameters)
    if(size(parameters,1)~=1)
        disp('Error in logistic');
        y = 0;
    else
        y = 1./(1+exp(-parameters*x));
    end
end