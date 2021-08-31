function [idxn] = naivesClassifier(N,indices,ind,ptCloud,K)
U = sum(ind);
V = N-U;
PU = U/N;
PV = V/N;
PUK = zeros(N,1);
PVK = zeros(N,1);
ppu = zeros(N,1);
ppv = zeros(N,1);
idxn = zeros(N,1);
for i=1:N
    id =indices(i,:)';
    PUK(i)= sum(ind(id))/K;
    PVK(i)= (K -sum(ind(id)))/K;
    ppu(i) = PU*PUK(i);
    ppv(i) = PV*PVK(i);
    idxn(i) = (ppu(i)>ppv(i));
end
[U,V] = results2(ptCloud,idxn,N);


end