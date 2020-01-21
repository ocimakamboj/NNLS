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