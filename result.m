function [U,V] = result(ptCloud,idx,n,N)
figure(1)
i = 1:N;
hold on
pcshow(ptCloud.Location(n*N+i(idx==0),:),[1 0 0]); %Red
pcshow(ptCloud.Location(n*N+i(idx==1),:),[0 0 1]); %Blue
%pcshow(ptCloud.Location(i(idx==0),:),[1 0 0]); %Red
%pcshow(ptCloud.Location(i(idx==1),:),[0 0 1]); %Blue
U = sum(idx==0);
V = sum(idx==1);
end