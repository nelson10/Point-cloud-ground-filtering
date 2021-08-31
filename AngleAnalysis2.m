function [idx] = AngleAnalysis2(ptCloud,ang,dataset,N)
angle = 80;
Deg = rad2deg(ang); %Conversion to Degrees
if(dataset=="ajaccio_2")
    nm1 = 30;
    nm2 = 100;
    idx = ((Deg>=(angle-nm1)).*(Deg<=(angle+nm2)));%.*idx1;
    [U,V] = results2(ptCloud,idx,N);
    %[U,V]= results(ptCloud,idx,0,N);
elseif(dataset=="ajaccio_57")
    nm = 10;
    idx = ((Deg>=(angle-nm)).*(Deg<=(angle+nm)));
    [U,V]= results(ptCloud,idx,N);
elseif(dataset=="dijon_9")
    nm = 2;
    idx = ((Deg>=(angle-nm)).*(Deg<=(angle+nm)));
    [U,V]= results(ptCloud,idx,N);
end
end