% PhD Nelson Eduardo Díaz
% Point cloud filtering
clear all;
close all;
clc;

%% Add path for data and source code
addpath(genpath('./dataset1'));
addpath(genpath('./src'));

%% load pont cloud points
data = 3;
plots = 0;
if(data ==1 )
    dataset = "ajaccio_2";
elseif(data ==2)
    dataset = "ajaccio_57";
elseif(data ==3)
    dataset = "dijon_9";
end
text = dataset+".ply";
tic
ptCloud1 = pcread(text);
N = 65536;
T = 10e7;
p = round(T/N);
%indices = zeros(N,K);
%ptCloud = pcread('teapot.ply');
S = 10;
g = boolean(zeros(N*S,1));
K = 50;
for s=1:S
    %s = ;
    id = ((s-1)*N)+1:((s)*N);
    x = ptCloud1.Location(id,1); % Load x dimension
    y = ptCloud1.Location(id,2); % Load y dimension
    z = ptCloud1.Location(id,3); % Load z dimension
    %plot3(x(1:N),y(1:N),z(1:N),'.');
    %% Standarization of data
    Y = [x y z];
    x = standart(x); % normalization x dimension
    y = standart(y); % normalization y dimension
    z = standart(z); % normalization z dimension
    
    X = [x y z]; % Cloud point
    ptCloud = pointCloud(X);
    
    %% Search K-nearest neighbors
    indices = knnsearch(Y,Y,'K',50,'Distance','euclidean'); % K-nearest neighbor search
    
    %% Ground filtering
    [ind] = GroundExtraction2(N,Y,indices);
    
    if(plots ==1)
        figure(1)
        subplot(2,2,1),pcshow(ptCloud.Location(ind==1,:),[1 0 0]); %Red
        hold on
        subplot(2,2,1),pcshow(ptCloud.Location(ind==0,:),[0 0 1]); %Blue
        title('Fit PCA ')
    end
    %% Compute Näive Bayes Classifier
    [ind2] = naivesClassifier(N,indices,ind,K);
    %ind2 = ind;
    ind2 = boolean(ind2);
    % sd = std(X(ind2,3),1); % standar desviation of points in z axis
    if(plots ==1)
        subplot(2,2,2),pcshow(ptCloud.Location(ind2==1,:),[1 0 0]); %Red
        hold on
        subplot(2,2,2),pcshow(ptCloud.Location(ind2==0,:),[0 0 1]); %Blue
        title('Näive Bayes Classifier ')
    end
    %% Fit ground to plane
    [gr] = fit2plane(X,x,y,z,ind2);
    %[U,V] = results2(ptCloud,gr);
    
    if(plots ==1)
        subplot(2,2,3),pcshow(ptCloud.Location(gr==1,:),[1 0 0]); %Red
        hold on
        subplot(2,2,3),pcshow(ptCloud.Location(gr==0,:),[0 0 1]); %Blue
        title('Fit Least square ')
    end
    
    %if(sd >= 0.1)
    %     [remainPtCloud,plane] = fitRansac(ptCloud);
    %     [remainPtCloud2,plane2] = fitRansac(remainPtCloud);
    %     %% Plot fit plane using RANSAC
    %     subplot(2,2,4),pcshow(plane.Location,[1 0 0])
    %     hold on
    %     subplot(2,2,4),pcshow(plane2.Location,[1 0 0])
    %     hold on
    %     subplot(2,2,4),pcshow(remainPtCloud2.Location,[0 0 1])
    %     title('Fit using RANSAC ')
    %else
    %% Fit plane using RANSAC Algorithm
    ptCloud2 = pointCloud(X(ind2,:));
    [remainPtCloud,plane,inlierIndices] = fitRansac(ptCloud2);
    if(plots ==1)
        subplot(2,2,4),pcshow(plane.Location,[1 0 0])
        hold on
        subplot(2,2,4),pcshow(remainPtCloud.Location,[0 0 1])
        hold on
        subplot(2,2,4),pcshow(ptCloud.Location(~ind2,:),[0 0 1])
        title('Fit using RANSAC ');
    end
    timeElapsed = toc;
    disp("Computational time " + num2str(timeElapsed))
    t =find(ind2);
    g(id(t(inlierIndices)))=1;
end
figure(1)
pcshow(ptCloud1.Location(g,:),[1 0 0])
hold on;
pcshow(ptCloud1.Location(~g,:),[0 0 1])


