% PhD Nelson Eduardo Díaz
% Point cloud filtering
clear all;
close all;
clc;

%% Add path for data and source code
addpath(genpath('./dataset1'));
addpath(genpath('./src'));

%% load point cloud points
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
ptCloud = pcread(text);
N = 65536;
%N = 10e7;
%indices = zeros(N,K);
%ptCloud = pcread('teapot.ply');
K = 50;
n = 0;
id = 1:N;
x = ptCloud.Location(id,1); % Load x dimension
y = ptCloud.Location(id,2); % Load y dimension
z = ptCloud.Location(id,3); % Load z dimension
%plot3(x(1:N),y(1:N),z(1:N),'.');
%% Standarization of data
x = standart(x); % normalization x dimension
y = standart(y); % normalization y dimension
z = standart(z); % normalization z dimension

X = [x y z]; % Cloud point

indices = knnsearch(X,X,'K',50,'Distance','euclidean');

[ind] = GroundExtraction2(N,X,indices,ptCloud,dataset);
[ind2] = naivesClassifier(N,indices,ind,ptCloud,K);
[gr] = fit2plane(X,x,y,z,ind2);
[U,V] = results2(ptCloud,gr,N);
[modelRANSAC, inlierIdx] = ransac(X,fitLineFcn,evalLineFcn,sampleSize,maxDistance);
disp('Hola')
