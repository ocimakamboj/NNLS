%{
This is the Perceptron programmed in batch mode.
The inputs are - 
N - total number of data points
data - values of inputs
desired - the desired output of the samples
eta - learning rate
wstart - the starting weight
epochMax - the maximum number of epochs allowed
The outputs are - 
w - the final weights
acc - accuracy of the classification
emax - the number of epochs in which the our solution converged
%}
function [w,acc,emax,mse] = batchPerceptron(N,data,desired,eta,wstart,epochMax)
    w = wstart;
    emax = inf;
    for epoch = 1:epochMax
        wold = w;
        sumMisclassified = 0;
        for n = 1:N
            v(n) = w'*[1 data(n,:)]';
            if(v(n)>0)
                y(n) = 1;
            else
                y(n) = -1;
            end
            if(y(n)~=desired(n))
                sumMisclassified = sumMisclassified + desired(n)*[1 data(n,:)]';
            end
        end
        w = w + eta*sumMisclassified;
        if(norm(w-wold)==0)
            if(emax>epoch)
                emax = epoch;
            end
        end
        mse(epoch) = MSE(y,desired,N);
    end
    acc = accuracy(y,desired,N);
    if(norm(w-wold)~=0)
        disp('batch mode did not converge');
    end
end

function mse = MSE(calculated, desired, N)
mse = 0;
for i = 1:N
    mse = mse + (desired(i)-calculated(i))^2;
end
mse = mse/N;
end

%{
function to calculate accuracy of the perceptron
Take as input the calculated and desired responses, and the total number of
points
%}
function ans = accuracy(calculated, desired, N)
ans = 0;
    for i = 1:N
        if(calculated(i)~=desired(i))
            ans = ans+1;
        end
    end
ans = (N-ans)/N*100;
end
