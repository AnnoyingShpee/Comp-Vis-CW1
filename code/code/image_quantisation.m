function [quantised_image] = image_quantisation(image, quantisation)
%IMAGE_QUANTISATION Summary of this function goes here
%   Detailed explanation goes here
quantised_image = image/255;
quantised_image = round(quantised_image * (quantisation-1)) + 1;
end

