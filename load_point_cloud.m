% PhD Nelson Eduardo Díaz
% Point cloud filtering
clear all;
close all;
clc;

addpath(genpath('./dataset'));
addpath(genpath('./indices'));

% load point cloud points
data = 1;
if(data ==1 )
    dataset = "ajaccio_2";
elseif(data ==2)
    dataset = "ajaccio_57";
elseif(data ==3)
    dataset = "dijon_9";
end
text = dataset+".ply";
angle = 90;
%ptCloud = pcread('ajaccio_2.ply');
ptCloud = pcread(text);
%ptCloud = pcread('dijon_9.ply');

N = 1e7;%65536;
N = 65536;
%ptCloud = pcread('teapot.ply');
K = 50;
n = 0;
x = ptCloud.Location(:,1); % Load x dimension
y = ptCloud.Location(:,2); % Load y dimension
z = ptCloud.Location(:,3); % Load z dimension
%plot3(x(1:N),y(1:N),z(1:N),'.');
%% Standarization of data
x = standart(x);
y = standart(y);
z = standart(z);

ang = zeros(N,1);
pl = zeros(N,1);
indices = zeros(N,K);
%plot3(x,y,z,'.');
%plot3(x(1:N),y(1:N),z(1:N),'.');
%ptCloud = pcread('teapot.ply');
%pcshow(ptCloud.Location(:,:));

%% find k=50 nearest neighbourhood
for i=1:N
    point  = ptCloud.Location(n*N+i,:); % Selection of point
    [indices(i,:),] = findNearestNeighbors(ptCloud,point,K);
end
%text2 = dataset+num2str(n)+"_indices.mat";
% textpath = "./indices/";
% save(textpath+text2,'indices');
%load(text2)


%% Compute normal between the eigenvector corresponding to the smalles eigenvalue and the normalize eigenvalues
for i=1:N
    %X = ptCloud.Location(indices(i,:),:);
    id = indices(i,:)';
    X = [x(id) y(id) z(id)];
    %X = [x y z];
    Xm = X - mean(X);  % subtract the mean of the point in the neighbourhood
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
    [e, ind] = sort(e,'ascend'); % Sort in ascending order
    ne = e./sum(e); % Normalize eigenvalues
    normal1 = V(:,ind(1));
    v1 = ne; % first vector
    v2 = normal1; % second vector
    %ang(i) = acos(dot(v1 / norm(v1), v2 / norm(v2))); % compute the angle
    ang(i) = atan2(norm(cross(v1,v2)), dot(v1,v2));
    %CosTheta = max(min(dot(v1,v2)/(norm(v1)*norm(v2)),1),-1);
    %Deg(i) = real(acosd(CosTheta));
end
[idx] = AngleAnalysis(ptCloud,ang,angle,dataset,N);
%load('Indices_1.mat')
%pcshow(ptCloud.Location(idx==1,:),[1 0 0])
%pcshow(ptCloud.Location(idx==0,:),[0 0 1])

%[xu] = naivesClassifier(U,V,N,indices,idx);
% indices N x K
% idx 

%pcshow(ptCloud.Location(n*N+i(idx==0),:),[0 1 0]); %Green
%pcshow(ptCloud.Location(n*N+i(idx==1),:),[0 0 1]); %Yellow
