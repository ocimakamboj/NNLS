function K = CalculateKernel(x1,x2,SigmaSq,actID)
if(actID == 1)
    var1 = diag(x1'*x1);
    var2 = 2*x1'*x2;
    var3 = (diag(x2'*x2))';
    power = var1 - var2 + var3;
    power = -power/(2*SigmaSq);
    dist = pdist2(x1',x2');
    power2 = -1/(2*SigmaSq)*dist.*dist;
    K = exp(power2);
elseif(actID == 2)
    K = x1'*x2;
elseif(actID == 3)
    K = (x1'*x2+1).^16;
end