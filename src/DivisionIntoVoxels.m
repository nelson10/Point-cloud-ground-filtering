function [g,vidx,T] = DivisionIntoVoxels(Y,N)
d = 0.1; % Voxels size
g = zeros(N,1); % Index plot voxels
vidx = zeros(N,1); % Index Voxels
idx = zeros(N,3);
[dmax]=max(Y);
[dmin]=min(Y);

r = round((dmax-dmin)/d);
v1 = linspace(dmin(1),dmax(1),r(1));
v2 = linspace(dmin(2),dmax(2),r(2));
v3 = linspace(dmin(3),dmax(3),r(3));

for i=1:3
    for n=1:N
        if(i==1)
            temp = sqrt((v1-Y(n,i)).^2);
        elseif(i==2)
            temp = sqrt((v2-Y(n,i)).^2);
         elseif(i==3)
            temp = sqrt((v3-Y(n,i)).^2);
        end
        [v,ind] = min(temp);
        idx(n,i) = ind;
    end
end
indi = string(idx);
indice = indi(:,1)+indi(:,2)+indi(:,3);
l = unique(indice);
T = length(l); % Number of Voxels

for t=1:T
    indx = (indice==l(t));
    g(indx) = mod(t,4);
    vidx(indx) = t;
end
end