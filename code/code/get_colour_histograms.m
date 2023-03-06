function [features] = get_colour_histograms(img_paths, quantisation, colour_space)
%GET_COLOUR_HISTOGRAM Summary of this function goes here
%   Detailed explanation goes here
features = zeros(size(img_paths,1), quantisation*quantisation*quantisation);
% USE THREADS FOR PARALLEL RUNNING
for i = 1:length(img_paths)
    colour_hist = zeros(quantisation, quantisation, quantisation);
    img = imread(img_paths{i});
    double_img = double(img);
    quantised_img = image_quantisation(double_img, quantisation);
    % MODIFICATION REQUIRED FOR EFFICIENCY
    for x = 1:size(quantised_img, 1)
        for y = 1:size(quantised_img, 2)
            r = quantised_img(x, y, 1);
            g = quantised_img(x, y, 2);
            b = quantised_img(x, y, 3);
            colour_hist(r, g, b) = colour_hist(r, g, b) + 1;
        end
    end
    colour_hist = colour_hist(:);
    features(i,:) = colour_hist;
end
end

