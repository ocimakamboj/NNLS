NGrid = 4; %Size of Grid
D = 1; %Spacing between Grid points
NoHiddenNeurons = 2*NGrid-2; %No of linear lines needed to separate the classes
surplus = 0; %surplus neurons being added to classify the data
NoNeu=NoHiddenNeurons+surplus ;

%input data related
N = NGrid*NGrid; %No of data points
datadim = 2;

%Architecture and training related
L = 2; %no of layers
noNeurons = [NoNeu,1]; %no of neurons in each layer in the form of an array
epochMax = 10000;
eta = 0.15; %learning rate
alpha = 0; %momentum factor

%activation function - See the function activation.m for details about IDs
activID = 1; 
activPar = [1];
a = 0; %Label to be given to the negative class. can be 0/-1. 
if a ==0
    threshold = 0.5;
elseif a == -1
    threshold = 0;
end

%pruning
eps = 10e-2;

%plotting countour field related
step = 0.1; %this is the step size used to divide the grid while plotting ...
         ...the contours. The smaller the step size, the smoother contour lines will look

%Flags
randomiseFlag = 1; %Whether data is randomised or not
randSeed = 0; %seed for randomisation
WeightsNorStatus = 1; %Whether the mean of weights is 0 or not
thresholdStatus = 0; %whether thresholding is being used while training
norStatus = 0; %whether inputs are normalised

%excess factor for plotting
excess = 0; %area to be visualised outside of the Grid. 

[data,desired] = generatePoints(NGrid,D,a);
if(randomiseFlag == 1)
    [dataR,desiredR] = randomiseData(data,desired,N,randSeed);
else
    dataR = data;
    desiredR = desired;
end

if(rem(NGrid,2)==0)
    xmin = -((NGrid/2-1)*D+1.5*D);
    xmax = ((NGrid/2-1)*D+1.5*D);
    ymin = -((NGrid/2-1)*D+1.5*D);
    ymax = ((NGrid/2-1)*D+1.5*D);
else
    xmin = -((NGrid-1)/2*D+D);
    xmax = ((NGrid-1)/2*D+D);
    ymin = -((NGrid-1)/2*D+D);
    ymax = ((NGrid-1)/2*D+D);
end

xmin = xmin-excess;
xmax = xmax+excess;
ymin = ymin-excess;
ymax = ymax+excess;

[B,W,MSE] = MLP(N,dataR,desiredR,datadim,eta,alpha,epochMax,L,noNeurons,WeightsNorStatus,threshold,thresholdStatus,norStatus,activID,activPar);
[prunedB,prunedW,counter] = pruneNetwork(B,W,L,noNeurons,eps);
[predicted,accuracy] = predict(N,data,desired,L,threshold,thresholdStatus,activID,activPar,W,B);
[Xc,Yc,Value] = decisionBoundary(step,xmin,xmax,ymin,ymax,L,W,B,threshold,norStatus,activID,activPar);
[PrunedPredicted,PrunedAccuracy] = predict(N,data,desired,L,threshold,thresholdStatus,activID,activPar,prunedW,prunedB);

figure('units','normalized','position', [0.3, 0.3, 0.43, 0.5]);
contourf(Xc,Yc,Value,[-1 1],'black','LineWidth',1);
map = [1 0.8 0.8;0.8 0.898 1];
colormap(map);
hold on;

if(rem(NGrid,2)==0)
    scatter(data(1,1:NGrid*NGrid/2),data(2,1:NGrid*NGrid/2),100,'filled','LineWidth',2,'DisplayName','class 1');
    %xlabel('x');
    %ylabel('y');
    %legend('FontSize',20);
    grid on;
    hold on;
    scatter(data(1,NGrid*NGrid/2+1:end),data(2,NGrid*NGrid/2+1:end),200,'x','LineWidth',2,'DisplayName','class 2');
    axis equal;
    axis([xmin xmax ymin ymax]);
else
    scatter(data(1,1:(NGrid*NGrid+1)/2),data(2,1:(NGrid*NGrid+1)/2),100,'filled','LineWidth',2,'DisplayName','class 1');
    %xlabel('x');
    %ylabel('y');
    %legend('FontSize',20);
    grid on;
    hold on;
    scatter(data(1,(NGrid*NGrid+1)/2+1:end),data(2,(NGrid*NGrid+1)/2+1:end),200,'x','LineWidth',2,'DisplayName','class 2');
    axis equal;
    axis([xmin xmax ymin ymax]);
end

hold off

acc = round(accuracy*100)/100;
for l=1:L-1
    hiddenNeu(l) = noNeurons(l);
end

pos = get(gca, 'Position');
xoffset = -0.15;
pos(1) = pos(1) + xoffset;
set(gca, 'Position', pos)

dim = [.68 .725 .5 .2];
if(activID==1)
    acname = 'Sigmoid';
elseif(activID==2)
    acname = 'tanh';
elseif(activID==3)
    acname = 'ReLU';
elseif(activID==4)
    acname = 'erf()';
elseif(activID==5)
    acname = 'heavy-side';
end
str = {['N=',num2str(NGrid)],['D=',num2str(D)],['\eta=',num2str(eta)],['epochs=',num2str(epochMax)],['H.L=',num2str(L-1)],['H.Neurons=',mat2str(hiddenNeu)],['C.A.=',num2str(acc),'%'],[acname]};
annotation('textbox',dim,'String',str,'FitBoxToText','on','FontSize',18,'Margin',5);


% 
% figure(2);
% plot(MSE,'LineWidth',2);
% xlabel('No of epochs');
% ylabel('MSE');
