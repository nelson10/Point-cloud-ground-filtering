function [D] = Descriptor2(e)
sigma = sqrt(e);
%D(1) = (sigma(3)-sigma(2))/sigma(3); % Volumetric
%D(2) = (sigma(2)-sigma(1))/sigma(3); % Planar
%D(3) = (sigma(1))/sigma(3); % Linear

D(1) = sigma(3); % Pared
%D(2) = (sigma(3)+sigma(1)); % Pared
D(2) = (sigma(1)+sigma(2)); % Pared
end