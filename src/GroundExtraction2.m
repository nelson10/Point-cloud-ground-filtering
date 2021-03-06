function [idx] = GroundExtraction2(N,X,indices)
ang = zeros(N,1);
pl = zeros(N,1);
%% Compute normal between the eigenvector corresponding to the smalles eigenvalue and the normalize eigenvalues
for i=1:N
    %X = ptCloud.Location(indices(i,:),:);
    id = indices(i,:)';
    Xs = [X(id,1) X(id,2) X(id,3)];
    %X = [x y z];
    Xm = Xs - mean(Xs);  % subtract the mean of the point in the neighbourhood
    S = Xm'*Xm; % Compute the covariance matrix
    [V, E] = eig(S); % Compute the descomposition in eigenvalues and eigenvectors
    %[D] = Descriptor2(diag(E));
    e = diag(E);
    %diag(E)
    [D] = Descriptor(e); % Compute descriptors
    [a,b]=max(D);
    if(b==1)
        pl(i,1) = 0;
    elseif(b==2)
        pl(i,1) = 1;
    else
        pl(i,1) = 2;
    end
    [es, ind] = sort(e,'ascend'); % Sort in ascending order
    ne = e./sum(e); % Normalize eigenvalues
    normal1 = V(:,ind(1)); % eigenvector of the smallest eigenvalue
    v2 = ne; % first vector
    v1 = normal1; % second vector
    %ang(i) = atan2(norm(cross(v1,v2)), dot(v1,v2));
    den = sqrt(sum(v1.^2)) * sqrt(sum(v2.^2));
    num = dot(v1,v2);
    ang(i) = acos(num/den);
end

[idx] = AngleAnalysis2(ang);
idx = ~idx;
end