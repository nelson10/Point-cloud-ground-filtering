%% PhD Nelson Díaz
% 3D point cloud ground filtering
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
T = 10e7;
p = round(T/N);
S = 20;
g = boolean(zeros(N*S,1));
if(data >= 4)
    label = labels(1:N*S);
end
K = 50;
for s=1:S
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
    indices = knnsearch(X,X,'K',50,'Distance','euclidean'); % K-nearest neighbor search
    
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
    
    %% Fit plane using RANSAC Algorithm
    if(data >= 4)
        t =find(ind2);  % ground indexes before fit to RANSAC
        ptCloud2 = pointCloud(X(t,:));
        [remainPtCloud,plane,inlierIndices,outlierIndices] = fitRansac(ptCloud2);
        
        if(plots ==1)
            subplot(2,2,4),pcshow(plane.Location,[1 0 0])
            hold on
            subplot(2,2,4),pcshow(remainPtCloud.Location,[0 0 1])
            hold on
            subplot(2,2,4),pcshow(ptCloud.Location(~ind2,:),[0 0 1])
            title('Fit using RANSAC ');
        end
        
        timeElapsed = toc;
        disp(num2str(s) +" Computation time " + num2str(timeElapsed))
        g(id(t(inlierIndices)))=1; % ground indexes after fit to RANSAC
    else
        t =find(ind2);  % ground indexes before fit to RANSAC
        ptCloud2 = pointCloud(X(t,:));
        [remainPtCloud,plane,inlierIndices1,outlierIndices1] = fitRansac(ptCloud2);
        t2 = outlierIndices1;
        [remainPtCloud2,plane2,inlierIndices2,outlierIndices2] = fitRansac(remainPtCloud);
        g(id(t(inlierIndices1))) = 1; % ground indexes after fit to RANSAC
        g(id(t(t2(inlierIndices2)))) = 1; % ground indexes after fit to RANSAC
        
        if(plots ==1)
            %% Plot fit plane using RANSAC
            subplot(2,2,4),pcshow(plane.Location,[1 0 0])
            hold on
            subplot(2,2,4),pcshow(plane2.Location,[1 0 0])
            hold on
            subplot(2,2,4),pcshow(remainPtCloud2.Location,[0 0 1])
            title('Fit using RANSAC ')
        end
        
        timeElapsed = toc;
        disp(num2str(s) +" Computation time " + num2str(timeElapsed))
    end
end
figure(2)
subplot(1,2,1), pcshow(ptCloud1.Location(g,:),[1 0 0])
hold on;
subplot(1,2,1), pcshow(ptCloud1.Location(~g,:),[0 0 1])
title("Result of the proposed algorithm")

if(data >= 4)
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
end