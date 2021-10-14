% PhD Nelson Eduardo Díaz
%% 3D point cloud ground filtering
clear all;
close all;
clc;

%% Add path for data and source code
addpath(genpath('./dataset1'));
addpath(genpath('./src'));

%% load pont cloud points
data = 1;
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
S = 1;
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
    [dmax]=max(Y);
    [dmin]=min(Y);
    
    d = 0.1;
    r = round((dmax-dmin)/d);
    v1 = linspace(dmin(1),dmax(1),r(1));
    v2 = linspace(dmin(2),dmax(2),r(2));
    v3 = linspace(dmin(3),dmax(3),r(3));
    
    for i=1:3
        for n=1:N
            temp = sqrt((v1-Y(n,i)).^2);
            [v,ind] = min(temp);
            idx(n,i) = ind;
        end
    end
    g = zeros(N,1);
    indi = string(idx);
    indice = indi(:,1)+indi(:,2)+indi(:,3);
    l = unique(indice);
    for n=1:length(l)
        indx = (indice==l(n));
        g(indx) = mod(n,4);
    end
    %g = boolean(g);
    figure(2)
    pcshow(ptCloud1.Location(g==0,:),[1 0 0])
    hold on;
    pcshow(ptCloud1.Location(g==1,:),[0 0 1])
    hold on;
    pcshow(ptCloud1.Location(g==2,:),[0 1 0])
        hold on;
    pcshow(ptCloud1.Location(g==3,:),[0 1 1])
    
end