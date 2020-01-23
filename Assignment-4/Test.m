inputs = [];
inputs.N = 500;
N = inputs.N;
inputs.d3 = 0.2;
inputs.d2 = 0.5;
inputs.d1 = 0.8;
inputs.actID = 1;
lim = -100;
inputs.randseed = 0;
C = 2500;
SigmaSq = 0.1;
tol = 1e-3;
inputs.margin = 0.1;
inputs.step = 0.02;
inputs.xmin = -(inputs.d1 + inputs.margin);
inputs.xmax = -inputs.xmin;
inputs.ymin = inputs.xmin;
inputs.ymax = inputs.xmax;
rng('default');

[data, desired] = genTightFist(inputs.N,inputs.d1,inputs.d2,inputs.d3,inputs.randseed);
[testData, testDesired] = genTightFist(2*inputs.N,inputs.d1,inputs.d2,inputs.d3,inputs.randseed+1);

outputSVM = SVM(inputs.N, data, desired, C, SigmaSq, tol,inputs.actID);

[y,class,acc] = predict(inputs.N,data,desired,outputSVM,SigmaSq,inputs.actID);
[yTest,classTest,accTest] = predict(2*inputs.N,testData,testDesired,outputSVM,SigmaSq,inputs.actID);
[Xc,Yc,Values,ValuesTh] = decisionBoundary(inputs.step,inputs.xmin,inputs.xmax,inputs.ymin,inputs.ymax,outputSVM,SigmaSq,inputs.actID);

figure('units','normalized','Position',[0.3 0.3 0.5 0.6]);
contourf(Xc,Yc,Values, [lim 0],'black','LineWidth',1.5);
caxis =  [lim 0];
map = [1 0.8 0.8;0.8 0.898 1];
colormap(map);
hold on;

contour(Xc,Yc,Values,[1 1],'black','linestyle','--','LineWidth',0.8);
contour(Xc,Yc,Values,[-1 -1],'black','linestyle','--','LineWidth',0.8);

scatter(data(1,1:N/2),data(2,1:N/2),'s','DisplayName','class 1','LineWidth',1.5);
xlabel('x');
ylabel('y');
grid on;
hold on;
scatter(data(1,N/2+1:end),data(2,N/2+1:end),'o','DisplayName','class 2','LineWidth',1.5);
axis equal;

scatter(data(1,outputSVM.USindex),data(2,outputSVM.USindex),100,'o','filled','MarkerEdgeColor','k','MarkerFaceColor','w','DisplayName','class 1','LineWidth',1.5);

pos = get(gca, 'Position');
xoffset = -0.15;
pos(1) = pos(1) + xoffset;
set(gca, 'Position', pos)

if(inputs.actID==1)
    stringName = 'RBF';
elseif(inputs.actID==3)
    stringName = 'Polynomial';
end
dim = [.7 .725 .5 .2];
if(inputs.actID ==1)
    str = {['N = ',num2str(N)],['C = ',num2str(C)],['C.A.=',num2str(acc),'%'],['T.A.=',num2str(accTest),'%'],['N_s=',num2str(outputSVM.numberS(1))],['N_{us}=',num2str(outputSVM.numberUS(1))],stringName,'Kernel',['\sigma^2 = ',num2str(SigmaSq)]};
elseif(inputs.actID==3)
    str = {['N = ',num2str(N)],['C = ',num2str(C)],['C.A.=',num2str(acc),'%'],['T.A.=',num2str(accTest),'%'],['N_s=',num2str(outputSVM.numberS(1))],['N_{us}=',num2str(outputSVM.numberUS(1))],stringName,'Kernel'};
end
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',18,'Margin',5);
