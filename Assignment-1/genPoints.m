%{
function to generate the data points.
it takes as input R the radius of innermost circle, D is the given Distance
N is the total number of points to be generated
The coordinates of the points are stored in inputdata
and the desired output stored in desired.
%}
function [inputdata,desired] = genPoints(R,D,N)
rng(0); %to set the seed so that the input points are same in all the experiments
i = 1;
    while(i<=N/2)
        inputdata(i,1) = 2*R*rand-R;
        inputdata(i,2) = 2*R*rand-R;
        desired(i,1) = 1;
        if((inputdata(i,1)^2 + inputdata(i,2)^2) < R^2)
            i = i + 1;
        end
    end
Rin = 2*R;    
Rout = 1.5*Rin;
    while(i<=N)
        inputdata(i,1) = 2*Rout*rand-Rout;
        inputdata(i,2) = 2*Rout*rand-Rout;
        desired(i,1) = -1;
        if((inputdata(i,1)^2 + inputdata(i,2)^2) < ((Rout)^2) && (inputdata(i,1)^2 + inputdata(i,2)^2) > ((Rin)^2))
            if(inputdata(i,2) <= D)
                i = i + 1;
            end
        end
    end   
end