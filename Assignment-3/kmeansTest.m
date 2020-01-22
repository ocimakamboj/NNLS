N = 1000;
Radius = 10;
width = 6;
d = 0;
K = 6; 
maxIter = 100;
randseed = 4;
randseed1 = 0;
epochMax = 50;
lambda = 0.1;
eta = 0.15;
margin = 1;
step = 0.1;
xmin = -(Radius + width/2 + margin);
xmax = 2*Radius + width/2 + margin;
ymin = -(Radius + width/2 + d + margin);
ymax = Radius + + width/2 + margin;
rng('default');


[data, desired] = generateData(N,Radius,width,d,randseed1);
[dataR,desiredR] = randomiseData(data,desired,N,randseed1);

[clusterMeans,sigmaSq,sigmaSqCommon,clusterNumber,clusterElements] = mykmeans(data,K,N,maxIter,Radius,width,d,randseed); %seed = 4

[weightsRLS,clusterMeansRLS,sigmaSqRLS,sigmaSqCommonRLS,MSE_RLS] = RBF_RLS(N,dataR,desiredR,K,epochMax,lambda,maxIter,Radius,width,d,randseed);

[classRLS,accuracyRLS] = predict(N,data,desired,K,weightsRLS,clusterMeansRLS,sigmaSqRLS);
[Xc_RLS,Yc_RLS,Values_RLS] = decisionBoundary(step,xmin,xmax,ymin,ymax,K,weightsRLS,clusterMeansRLS,sigmaSqRLS);

figure('Position',[300 300 750 500]);

contourf(Xc_RLS,Yc_RLS,Values_RLS,[0 0],'black','LineWidth',2,'DisplayName','D.B.');
map = [1 1 1;1 1 1];
colormap(map);
hold on;

scatter(clusterElements{1}(1,:),clusterElements{1}(2,:),'+','LineWidth',1.5,'DisplayName','Cluster-1');
scatter(clusterElements{2}(1,:),clusterElements{2}(2,:),'+','LineWidth',1.5,'DisplayName','Cluster-2');
scatter(clusterElements{3}(1,:),clusterElements{3}(2,:),'+','LineWidth',1.5,'DisplayName','Cluster-3');
scatter(clusterElements{4}(1,:),clusterElements{4}(2,:),'+','LineWidth',1.5,'DisplayName','Cluster-4');
scatter(clusterElements{5}(1,:),clusterElements{5}(2,:),'+','LineWidth',1.5,'DisplayName','Cluster-5');
scatter(clusterElements{6}(1,:),clusterElements{6}(2,:),'+','LineWidth',1.5,'DisplayName','Cluster-6');
scatter(clusterMeansRLS(1,:),clusterMeansRLS(2,:),200,'k','filled','LineWidth',2,'DisplayName','Means');
legend('location','northeastoutside','FontSize',18,'NumColumns',1);
title({['\fontsize{20}d = ',num2str(d)]});
xlabel('x');
ylabel('y');
grid on;
axis equal;

% figure(2);
% plot(MSE_RLS,'LineWidth',2);
% xlabel('No of epochs');
% ylabel('MSE');

% pos = get(gca, 'Position');
% xoffset = 0;
% pos(1) = pos(1) + xoffset;
% set(gca, 'Position', pos)
% 
% dim = [.767 .14 .154 .3];
% str = {['K = ',num2str(K)],['d = ',num2str(d)],['epochs=',num2str(epochMax)],['C.A.=',num2str(accuracyRLS),'%'],['K-means, RLS']};
% annotation('textbox',dim,'String',str,'FitBoxToText','off','FontSize',18,'Margin',5);
