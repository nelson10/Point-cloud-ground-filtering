% PhD Nelson Eduardo Díaz
%% 3D point cloud ground filtering
clear all;
close all;
clc;

%% Add path for data and source code
addpath(genpath('./dataset'));
addpath(genpath('./src'));

%% load pont cloud points
data = 7;
plots = 0;
if(data ==1 )
    dataset = "ajaccio_2";
elseif(data ==2)
    dataset = "ajaccio_57";
elseif(data ==3)
    dataset = "dijon_9";
elseif(data ==4)
    dataset = "Lille2";
    load('classLille2.mat');
elseif(data ==5)
    dataset = "Paris";
    load('classParis.mat');
elseif(data ==6)
    dataset = "Lille1_1";
    load('classLille1_1.mat');
elseif(data ==7)
    dataset = "Lille1_2";
    load('classLille1_2.mat');
end

text = dataset+".ply";
tic
ptCloud1 = pcread(text);
N = 65536;
gr = zeros(N,1);
gr2 = zeros(N,1);
NT = 10e7;
p = round(NT/N);
S = 20;
g = boolean(zeros(N*S,1));
label = labels(1:N*S);
K = 50;
rg = 0.04;
plots = 0;
tic
% profile on
for s=1:S
    id = ((s-1)*N)+1:((s)*N);
    x = ptCloud1.Location(id,1); % Load x dimension
    y = ptCloud1.Location(id,2); % Load y dimension
    z = ptCloud1.Location(id,3); % Load z dimension
    %% Standarization of data
    Y = [x y z];
    x = standart(x); % normalization x dimension
    y = standart(y); % normalization y dimension
    z = standart(z); % normalization z dimension
    
    X = [x y z]; % Cloud point
    Y = X;
    ptCloud = pointCloud(Y);
    
    %% Division into Voxels
    [vidx,T] = DivisionIntoVoxels(Y,N);
    
    if(plots ==1)
        plotVoxels(ptCloud,mod(vidx,4));
        title('Division into voxels ');
    end
    
    C = zeros(T,3); % centroids
    for t=1:T
        temp = Y(vidx==t,:);
        for j=1:3
            ma(t,j) = max(temp(:,j));
            mi(t,j) = min(temp(:,j));
            range(t,j) = ma(t,j) - mi(t,j);
            C(t,j) = (ma(t,j) + mi(t,j))/2; % centroid computation
        end
        gr(vidx==t) = (range(t,3) < rg);
    end
    
    if(plots ==1)
        figure(1)
        subplot(2,2,2),pcshow(ptCloud.Location(gr==1,:),[1 0 0]); %Red
        hold on
        subplot(2,2,2),pcshow(ptCloud.Location(gr==0,:),[0 0 1]); %Blue
        title('Voxel selection by ranges of height ');
    end
    
    %% Threshold
    m_z = mean(Y(gr==1,3)) + 1; %
    mm_z = mean(C(:,3)) + 1;
    
    for t=1:T
        gr2(vidx==t) = (C(t,3) < m_z);
    end
    
    if(plots ==1)
        subplot(2,2,3),pcshow(ptCloud.Location(gr2==1,:),[1 0 0]); %Red
        hold on
        subplot(2,2,3),pcshow(ptCloud.Location(gr2==0,:),[0 0 1]); %Blue
        title('Statistical filter by height ');
    end
    
    tid =find(gr2);  % ground indexes before fit to RANSAC
    ptCloud2 = pointCloud(X(tid,:));
    [remainPtCloud,plane,inlierIndices1,outlierIndices1] = fitRansac(ptCloud2);
    g(id(tid(inlierIndices1))) = 1; % ground indexes after fit to RANSAC
    
    if(plots ==1)
        %figure(2)
        subplot(2,2,4),pcshow(plane.Location,[1 0 0])
        hold on
        subplot(2,2,4),pcshow(remainPtCloud.Location,[0 0 1])
        hold on
        subplot(2,2,4),pcshow(ptCloud.Location(~gr2,:),[0 0 1])
        title('Fit using RANSAC ');
    end
    
    timeElapsed = toc;
    disp(num2str(s) +" Computation time " + num2str(timeElapsed))
    %% plot Voxels
    %plotVoxels(ptCloud1,g);
end
% profile viewer
% profile off
figure(2)
subplot(1,2,1), pcshow(ptCloud1.Location(g,:),[1 0 0])
hold on;
subplot(1,2,1), pcshow(ptCloud1.Location(~g,:),[0 0 1])
title("Result of the proposed algorithm")
subplot(1,2,2), pcshow(ptCloud1.Location(label~=1,:),[0 0 1])
hold on;
subplot(1,2,2), pcshow(ptCloud1.Location(label==1,:),[1 0 0])
title("established groundtruth")

alg1 = g; % Ground
alg2 = ~g; % Non-ground
gt1 = label==1; % ground
gt2 = label~=1; % Non-ground
trueMat = gt1;
predictedMat = alg1;

[TP, FP, TN, FN] = calError(trueMat, predictedMat);
disp("TP=" + TP + " FP=" + FP + " TN=" + TN + " FN " + FN);
Accuracy = (TP + TN) / (TP+FP+TN+FN);
disp("Accuracy " + Accuracy*100 +"%");

TypeIerror = FP / (TP + FP);
TypeIIerror = FN / (FN + TN);
Totalerror = (FP + FN) / (TP + FP + FN + TN);

disp("TypeIerror= " + TypeIerror*100 +"% TypeIIerror= "+ TypeIIerror*100 +"% Totalerror= "+ Totalerror*100 + "%")

precision = TP / (TP + FP);
Recall = TP / (TP + FN);
b = 1;
Fmeasure = ((1 + b^2)*TP)/ ((1+b^2)*TP + b^2*FN + FP);
IoU = TP /(TP + FP + FN);

disp("Precision= " + precision*100 +"% Recall= "+ Recall*100 +"% Fmeasure= "+ Fmeasure*100 + " IoU= " + IoU*100)