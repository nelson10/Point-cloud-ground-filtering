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
x = standart(x);
y = standart(y);
z = standart(z);

X = [x y z];
temp = X;

indices = knnsearch(X,X,'K',50,'Distance','euclidean');

[ind] = GroundExtraction2(N,X,indices,ptCloud,dataset);
[ind2] = naivesClassifier(N,indices,ind,ptCloud,K);
ind = ind2;
p = 0;
x = x(ind==p);
y = y(ind==p);
z = z(ind==p);
M = length(z);

indg = (ind==p);
arr = X(indg,:);

A =[x y ones(M,1)];
C = inv(A'*A);
B = C*A'*z;
close all;

[X,Y] = meshgrid(linspace(min(x),max(x),50), linspace(min(y),max(y),50));
Z = B(1)*X + B(2)*Y + B(3)*ones(size(X));
figure(1)
plot3(temp(indg==1,1),temp(indg==1,2),temp(indg==1,3),'.')
hold on
meshc(X, Y, Z)
hold off
grid on
xlabel('x(mm)'); ylabel('y(mm)'); zlabel('z(mm)');
title('Masked plot');
grid on
%text(-20, 50, 450, sprintf('Z = %.3f\\cdotX %+.3f\\cdotY %+3.0f', B))

d = (B(1)*x + B(2)*y + z +B(3))/(sqrt(sum(B)));
m = mean(d);
de = std(d);
gr = (d >= m-de) & (d <= m+de);
figure(2)
plot3(temp(:,1),temp(:,2),temp(:,3),'b.')
hold on
%meshc(X, Y, Z)
%hold on
plot3(arr(gr,1),arr(gr,2),arr(gr,3),'r.')
%plot3(temp(indg==1,1),temp(indg==1,2),temp(indg==1,3),'r.')
%meshc(X, Y, Z)
%[U,V] = results2(ptCloud,gr,N)


