function output = SVM(N, data, desired, C, SigmaSq, tol, actID)
output = [];
desDiagonal = diag(desired);
Gram = ConstructGram(N,data,SigmaSq,actID);
H = desDiagonal*Gram*desDiagonal;

f = ones(N,1);
f = f*-1;

Aeq = desired;
beq = 0;

lb = zeros(N,1);
ub = C.*ones(N,1);

alpha = quadprog(H,f,[],[],Aeq,beq,lb,ub,[],optimset('display','off','largescale', 'off','MaxIter',100));

USindex = find(alpha > tol & alpha <(C - tol));
Sindex = find(alpha > tol);

numberUS = size(USindex);
numberS = size(Sindex);

alphaTimesDes = alpha'.*desired;

GramUS = ConstructGram(N,data,SigmaSq,actID);

bias = desired(USindex) - alphaTimesDes*GramUS(:,USindex);
bias = mean(bias);

output.alpha = alpha;
output.alphaTimesDes = alphaTimesDes;
output.USindex = USindex;
output.Sindex = Sindex;
output.numberS = numberS;
output.numberUS = numberUS;
output.bias = bias;
output.data = data;
output.desired = desired;
