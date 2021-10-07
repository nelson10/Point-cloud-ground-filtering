function [indg]= fit2plane(Xp,x,y,z,ind)

p = 0;
x = x(ind==p);
y = y(ind==p);
z = z(ind==p);
M = length(z);

indg = (ind==p);
Xg = Xp(indg,:);

A =[x y ones(M,1)];
% C = inv(A'*A);
% B = C*A'*z;
%AA =[ones(M,1) y x];
coeffs = A\z; % solving least squares
B = coeffs; % Coeffients of the plane
close all;

[X,Y] = meshgrid(linspace(min(x),max(x),50), linspace(min(y),max(y),50));
Z = B(1)*X + B(2)*Y + B(3)*ones(size(X));
figure(1)
plot3(Xp(indg==1,1),Xp(indg==1,2),Xp(indg==1,3),'.')
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
%plot3(Xp(:,1),Xp(:,2),Xp(:,3),'b.')
plot3(Xg(~gr,1),Xg(~gr,2),Xg(~gr,3),'b.')
hold on
%meshc(X, Y, Z)
%hold on
plot3(Xg(gr,1),Xg(gr,2),Xg(gr,3),'r.')

Xg = Xp(indg,:);
id = find(indg);
indg(id) = gr;
%plot3(temp(indg==1,1),temp(indg==1,2),temp(indg==1,3),'r.')
%meshc(X, Y, Z)
%[U,V] = results2(ptCloud,gr,N)
end


