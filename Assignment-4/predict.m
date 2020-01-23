function [y,class,acc] = predict(NTest,dataTest,desiredTest,outputSVM,SigmaSq,actID)
dataS = outputSVM.data(:,outputSVM.Sindex);
var1 = CalculateKernel(dataS,dataTest,SigmaSq,actID);
var2 = outputSVM.alphaTimesDes(outputSVM.Sindex);
wtimesphi = var2*var1;

y = wtimesphi + outputSVM.bias;

class1 = y>=0;
class2 = y<0;
class = class1 - class2;

numberCorrect = (class == desiredTest);

acc = sum(numberCorrect)/NTest * 100;

