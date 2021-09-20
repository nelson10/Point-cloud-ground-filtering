function [xhat] = standart(x)
xm = mean(x);
xs = std(x);
r = 1;
beta = (x-xm)./(r*xs);
xhat = 1 ./(1 + exp(-beta));
end