function [idx] = AngleAnalysis(ptCloud,ang,angle,dataset,N)
Deg = rad2deg(ang); %Conversion to Degrees
if(dataset=="ajaccio_2")
    nm = 10;
    idx = ((Deg>=(angle-nm)).*(Deg<=(angle+nm)));%.*idx1;
    [U,V] = results(ptCloud,idx,N);
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