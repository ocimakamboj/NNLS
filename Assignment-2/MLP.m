%{
N is the number of training examples
L is the number of layers in the MLP (excluding the source layer)
noNeurons is an array of size L that stores how many neurons are in each layer
B is a cell array of size L, B{l} is a vector of size noNeurons[l] that
stores the biases applied to each neuron
W is a cell array of size L, W{l} is a matrix of size noNeurons[l]*noNeurons[l-1], 
W[i][j] connects neuron-j in layer-(l-1) to neuron-i in layer-l 
%activID gives the id for deciding which activation function to use
%activPar is a column vector for storing the parameters of activation
function
%}
function [B,W,MSE] = MLP(N,data,desired,datadim,eta,alpha,epochMax,L,noNeurons,WeightsNorStatus,threshold,thresholdStatus,norStatus,activID,activPar)
rng(0);
%initialise B
B = cell(1,L);
for i = 1:L
    B{i} = rand(noNeurons(i),1);
end

%initialise W
W = cell(1,L);
for i = 1:L
    if(i==1)
        W{i} = rand(noNeurons(i),datadim);
    else
        W{i} = rand(noNeurons(i),noNeurons(i-1));
    end
end

%Making the weights mean 0
if(WeightsNorStatus==1)
    for i = 1:L
        B{i} = B{i}-0.5; 
        W{i} = W{i}-0.5;
    end
end

%initialise a cell array Y for storing the output vector of each layer
Y = cell(1,L);

%initialise a cell array to store local gradients
dell = cell(1,L);

%normalise data
if(norStatus==1)
    max1  = [max(abs(data(:,:)'))'];
    for i = 1:N
        nor_data(:,i) = data(:,i)./max1;
    end
    data = nor_data;
end

for epoch = 1:epochMax
    for n = 1:N
        %start forward pass
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
        if(thresholdStatus==1)
            if(Y{L}>threshold)
                predicted = 1;
            elseif(Y{L}<threshold)
                predicted = 2*threshold-1;
            else
                predicted = threshold;
            end
        else
            predicted = Y{L};
        end
        
        %calculate error vector 
        E(n) = desired(:,n) - predicted;
        
        %start backward pass
        for l = L:-1:1
            if l == L
                dell{l} = E(n).*activationDer(Y{l},activID,activPar);
            else
                dell{l} = activationDer(Y{l},activID,activPar).*(W{l+1}'*dell{l+1});
            end
        end
        %update the weights
        for l = 1:L
            if l == 1
                BUpdate{l} = eta*dell{l}*[1];
                WUpdate{l} = eta*dell{l}*data(:,n)';
            else
                BUpdate{l} = eta*dell{l}*[1];
                WUpdate{l} = eta*dell{l}*Y{l-1}';
            end
            if(epoch==1)
                B{l} = B{l} + BUpdate{l};
                W{l} = W{l} + WUpdate{l};
                oldBUpdate{l} = BUpdate{l};
                oldWUpdate{l} = WUpdate{l};
            else
                B{l} = B{l} + alpha*oldBUpdate{l} + BUpdate{l};
                W{l} = W{l} + alpha*oldWUpdate{l} + WUpdate{l};
                oldBUpdate{l} = BUpdate{l};
                oldWUpdate{l} = WUpdate{l};
            end     
        end
    end
    MSE(epoch) = mean(E'.^2);
end

                

