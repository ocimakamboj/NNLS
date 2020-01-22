N = 1000;
Radius = 10;
width = 6;
d = -4;
K = 20; 
maxIter = 100;
randseed = 0;
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
M=1;


[data, desired] = generateData(N,Radius,width,d,randseed);
[dataR,desiredR] = randomiseData(data,desired,N,randseed);
[testData, testDesired] = generateData(2*N,Radius,width,d,randseed);

timerStart = tic;
for i=1:M
    [weightsRLS,clusterMeansRLS,sigmaSqRLS,sigmaSqCommonRLS,MSE_RLS] = RBF_RLS(N,dataR,desiredR,K,epochMax,lambda,maxIter,Radius,width,d,randseed);
end
timeRLS = toc(timerStart)/M*1000; %average time in ms
timeRLS = round(timeRLS);

[classRLS,accuracyRLS] = predict(N,data,desired,K,weightsRLS,clusterMeansRLS,sigmaSqRLS);
[testclassRLS,accuracyRLSTest] = predict(N,testData,testDesired,K,weightsRLS,clusterMeansRLS,sigmaSqRLS);
[Xc_RLS,Yc_RLS,Values_RLS] = decisionBoundary(step,xmin,xmax,ymin,ymax,K,weightsRLS,clusterMeansRLS,sigmaSqRLS);

figure('Position',[300 300 1000 500]);
contourf(Xc_RLS,Yc_RLS,Values_RLS,[-1 1],'black','LineWidth',1.5);
map = [1 0.8 0.8;0.8 0.898 1];
colormap(map);
hold on;

scatter(data(1,1:N/2),data(2,1:N/2),'s','DisplayName','class 1','LineWidth',1.5);
xlabel('x');
ylabel('y');
grid on;
hold on;
scatter(data(1,N/2+1:end),data(2,N/2+1:end),'+','DisplayName','class 2','LineWidth',1.5);
scatter(clusterMeansRLS(1,:),clusterMeansRLS(2,:),200,'filled','MarkerEdgeColor','k','MarkerFaceColor','w','LineWidth',2);
axis equal;

pos = get(gca, 'Position');
xoffset = -0.1;
pos(1) = pos(1) + xoffset;
set(gca, 'Position', pos)

dim = [.78 .725 .5 .2];
str = {['K = ',num2str(K)],['d = ',num2str(d)],['epochs=',num2str(epochMax)],['C.A.=',num2str(accuracyRLS),'%'],['T.A.=',num2str(accuracyRLSTest),'%'],['Time = ',num2str(timeRLS),' ms'],['K-means, RLS']};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',18,'Margin',5);

figure(2);
plot(MSE_RLS,'LineWidth',2);
xlabel('No of epochs');
ylabel('MSE');


timerStart = tic;
for i=1:M
    [weightsLMS,clusterMeansLMS,sigmaSqLMS,MSE_LMS] = RBF_LMS(N,dataR,desiredR,K,epochMax,eta,maxIter,Radius,width,d,randseed);
end
timeLMS = toc(timerStart)/M*1000; %average time in ms
timeLMS = round(timeLMS);
    
[classLMS,accuracyLMS] = predict(N,data,desired,K,weightsLMS,clusterMeansLMS,sigmaSqLMS);
[testclassLMS,accuracyLMSTest] = predict(N,testData,testDesired,K,weightsLMS,clusterMeansLMS,sigmaSqLMS);
[Xc_LMS,Yc_LMS,Values_LMS] = decisionBoundary(step,xmin,xmax,ymin,ymax,K,weightsLMS,clusterMeansLMS,sigmaSqLMS);

figure('Position',[300 300 1000 500]);
contourf(Xc_LMS,Yc_LMS,Values_LMS,[-1 1],'black','LineWidth',1.5);
map = [1 0.8 0.8;0.8 0.898 1];
colormap(map);
hold on;

scatter(data(1,1:N/2),data(2,1:N/2),'s','DisplayName','class 1','LineWidth',1.5);
xlabel('x');
ylabel('y');
grid on;
hold on;
scatter(data(1,N/2+1:end),data(2,N/2+1:end),'+','DisplayName','class 2','LineWidth',1.5);
scatter(clusterMeansLMS(1,:),clusterMeansLMS(2,:),200,'filled','MarkerEdgeColor','k','MarkerFaceColor','w','LineWidth',2);
axis equal;

pos = get(gca, 'Position');
xoffset = -0.1;
pos(1) = pos(1) + xoffset;
set(gca, 'Position', pos)

dim = [.78 .725 .5 .2];
str = {['K = ',num2str(K)],['d = ',num2str(d)],['epochs=',num2str(epochMax)],['C.A.=',num2str(accuracyLMS),'%'],['T.A.=',num2str(accuracyLMSTest),'%'],['Time = ',num2str(timeLMS),' ms'],['K-means, LMS']};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',18,'Margin',5);


figure(4);
plot(MSE_LMS,'LineWidth',2);
xlabel('No of epochs');
ylabel('MSE');

