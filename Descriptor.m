function [D] = Descriptor(e)
sigma = sqrt(e);
D(1) = (sigma(1)-sigma(2))./sigma(1); % Volumetric
D(2) = (sigma(2)-sigma(3))./sigma(1); % Planar
%D(3) = (sigma(3))./sigma(1); % Linear
end