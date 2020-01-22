function [prunedB,prunedW,counter] = pruneNetwork(B,W,L,noNeurons,eps)
counter = 0;
prunedB = cell(1,L);
prunedW = cell(1,L);

prunedB = B;
prunedW = W;

for l =1:L
    v = [B{l} W{l}];
    max = norm(v);
    for j = 1:noNeurons(l)
        if ((norm(v(j,:))/max)< eps)
            counter = counter+1;
            prunedB{l}(j) = 0;
            prunedW{l}(j,:) = zeros(1,size(W{l},2));
        end
    end
end
       