%{
N is the total number of data points
Radius is the central radius
w is the width (outer radius - inner radius)
d is the distance
%}
function [data, desired] = generateData(N,Radius,width,d,randseed)
rng(randseed);
data = zeros(2,N);
desired = zeros(1,N);

for n = 1: N/2
    R = width * rand + (Radius - width/2);
    theta = pi*rand;
    data(1,n) = R*cos(theta);
    data(2,n) = R*sin(theta);
    desired(n) = 1;
end

for n = N/2+1 : N
    
    R = width * rand + (Radius - width/2);
    theta = -pi*rand;
    data(1,n) = R*cos(theta) + Radius;
    data(2,n) = R*sin(theta) - d;
    desired(n) = -1;
end
