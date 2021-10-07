function [U,V] = results2(ptCloud,idx)
pcshow(ptCloud.Location(idx==1,:),[0 1 0]); %Red
hold on
pcshow(ptCloud.Location(idx==0,:),[0 0 1]); %Blue
title('Fit Least square ')
% figure(1)
% plot3(X(idx==0,1),X(idx==0,2),X(idx==0,3),'b.'); %Red
% hold on
% plot3(X(idx==1,1),X(idx==1,2),X(idx==1,3),'r.'); %Blue
U = sum(idx==0);
V = sum(idx==1);
end