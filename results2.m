function [U,V] = results2(ptCloud,idx,N)
id = 1:N;
figure(1);
pcshow(ptCloud.Location(id(idx==0),:),[1 0 0]); %Red
hold on
pcshow(ptCloud.Location(id(idx==1),:),[0 0 1]); %Blue
% figure(1)
% plot3(X(idx==0,1),X(idx==0,2),X(idx==0,3),'b.'); %Red
% hold on
% plot3(X(idx==1,1),X(idx==1,2),X(idx==1,3),'r.'); %Blue
U = sum(idx==0);
V = sum(idx==1);
end