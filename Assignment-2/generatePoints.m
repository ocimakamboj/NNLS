%N is the size of the N*N grid
%a is 0/-1, the label to be given to the negative class
function [data,desired] = generatePoints(NGrid,D,a)
if(rem(NGrid,2)==0)
    x = -((NGrid/2-1)*D+D/2):D:((NGrid/2-1)*D+D/2);
    y = ((NGrid/2-1)*D+D/2):-D:-((NGrid/2-1)*D+D/2);
else
    x = -((NGrid-1)/2*D):D:((NGrid-1)/2*D);
    y = ((NGrid-1)/2*D):-D:-((NGrid-1)/2*D);
end
[X,Y] = meshgrid(x,y);
for i = 1:NGrid
    for j=1:NGrid
        if(rem(i+j,2)==0)
            label(i,j) = 1;
        else
            label(i,j) = a;
        end
    end
end

n = 1;
for i=1:NGrid
    for j = 1:NGrid
        if (label(i,j) == 1)
            data(1,n) = X(i,j);
            data(2,n) = Y(i,j);
            desired(n) = 1;
            n = n+1;
        end
    end
end

for i=1:NGrid
    for j = 1:NGrid
        if (label(i,j) == a)
            data(1,n) = X(i,j);
            data(2,n) = Y(i,j);
            desired(n) = a;
            n = n+1;
        end
    end
end

    