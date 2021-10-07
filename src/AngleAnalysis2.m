function [idx] = AngleAnalysis2(ang)
angle = 80;
a = 30;
b = 100;
% angle = 90;
% a = 10;
% b = 10;
Deg = rad2deg(ang); %Conversion to Degrees

m = mean(Deg);
s = std(Deg);
ma= max(Deg);
mi = min(Deg);
disp("Angle mean "+ num2str(m)+" Angle std "+ num2str(s)+" Angle max "+ num2str(ma) +" Angle min "+ num2str(mi));
%if(dataset=="ajaccio_2")


idx = ((Deg>=(angle-a)).*(Deg<=(angle+b)));
idx = ~(Deg <= (angle-a));
% c = 0.5;
% idx = ~((Deg <= (m+c*s)) .* (Deg > (m-c*s)));
%elseif(dataset=="ajaccio_57")
%elseif(dataset=="dijon_9")
%end
end