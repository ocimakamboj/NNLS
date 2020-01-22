function eta = annealing(etaStart,etaEnd,epochMax)
% Linear annealing
step = (etaEnd - etaStart)/(epochMax-1);
eta = [etaStart:step:etaEnd];