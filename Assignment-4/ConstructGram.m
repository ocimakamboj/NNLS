function Gram = ConstructGram(N,data,SigmaSq,actID)
if(actID == 1)
    A = data'*data;
    B = diag(A).*ones(N);
    power = B - 2*A + B';
    power1 = -power/(2*SigmaSq);
    dist = pdist2(data',data');
    power2 = -1/(2*SigmaSq)*dist.*dist;
    Gram = exp(power2);
elseif(actID == 2)
    Gram = data'*data;
elseif(actID ==3)
    Gram = (data'*data+1).^16;
end