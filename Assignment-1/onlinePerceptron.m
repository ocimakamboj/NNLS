%{
This is the Perceptron programmed in online mode with sequential inputs.
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
nmax - the number of steps in which our perceptron converged. If the number
of epochs taken to converge is e, and the number of steps required in the
last epoch after which no update is made to the weight vector is n, then
the number of steps nmax is eN+n.
%}
function [w,acc,emax,nmax,mse] = onlinePerceptron(N,data,desired,eta,wstart,epochMax)
    emax = inf;
    nmax = inf;
    w = wstart;
    flag = 0; %flag=1 implies that the weights haven't changed from the last iteration
    for epoch = 1:epochMax
        wold = w;
        for n = 1:N
            woldin = w;
            v(n) = w'*[1 data(n,:)]';
            if(v(n)>0)
                y(n) = 1;
            else
                y(n) = -1;
            end
            w = w + eta*(desired(n)-y(n))*[1 data(n,:)]';
            if(norm(w-woldin)==0)
                if(flag==1)
                    if(nmax>(n+(epoch-1)*N))
                        nmax = n+(epoch-1)*N;
                    end
                else
                    nmax = n+(epoch-1)*N;
                end
                flag = 1;
            else
                flag = 0;
            end
        end
        if(norm(w-wold)==0)
            if(emax>epoch)
                emax = epoch;
            end
        end
        mse(epoch) = MSE(y,desired,N);
    end
    acc = accuracy(y,desired,N);
    if(norm(w-wold)~=0)
        disp('online mode did not converge');
    end
end