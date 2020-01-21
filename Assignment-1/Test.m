clear;
N = 2000; %total number of data points
radius = 10; %radius of inner circle
D = -12;
wstart = [0;0;1];
eta = 0.2;
maxEpoch = 100;
v = 2; %variance if noise is being added to the data

standec = sqrt(v);
[data,desired] = genPoints(radius,D,N);
% modifiedData = addNoise(data,N,0,standec);
% data = modifiedData;
[dataR,desiredR] = randomiseData(data,desired,N);

[weight_o,acc_o,emax_o,nmax_o,mse_o] = onlinePerceptron(N,dataR,desiredR,eta,wstart,maxEpoch);
[weight_oR,acc_oR,emax_oR,nmax_oR] = onlinePerceptronR(N,dataR,desiredR,eta,wstart,maxEpoch);
[weight_b,acc_b,nmax_b,mse_b] = batchPerceptron(N,dataR,desiredR,eta,wstart,maxEpoch);


figure(1);
scatter(data(1:N/2,1),data(1:N/2,2),'DisplayName','class 1');
xlabel('x');
ylabel('y');
legend('FontSize',20);
title({['\fontsize{20}Accuracy Online = ',num2str(acc_o),'%'],['\fontsize{20}Accuracy Batch = ',num2str(acc_b),'%']});
grid on;
hold on;
scatter(data(N/2+1:end,1),data(N/2+1:end,2),'x','DisplayName','class 2');
axis equal;

syms f(x);
f(x) = -weight_o(2)/weight_o(3)*x-weight_o(1)/weight_o(3);
fplot(f,[min(data(:,1)),max(data(:,1))],'LineWidth',2,'Color','k','DisplayName','online');

syms g(x);
g(x) = -weight_b(2)/weight_b(3)*x-weight_b(1)/weight_b(3);
fplot(g,[min(data(:,1)),max(data(:,1))],'LineWidth',2,'Color',[0 0.6 0],'DisplayName','batch');

syms h(x);
h(x) = -weight_oR(2)/weight_oR(3)*x-weight_oR(1)/weight_oR(3);
%fplot(h,[-3*radius,3*radius],'LineWidth',2,'Color',[0.6 0 0.6],'LineStyle','-.','DisplayName','random');

hold off;