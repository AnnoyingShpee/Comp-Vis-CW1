function [features] = get_colour_histograms(img_paths, quantisation, colour_space)
%GET_COLOUR_HISTOGRAM Summary of this function goes here
%   Detailed explanation goes here
features = zeros(size(img_paths,1), quantisation^3);
% USE THREADS FOR PARALLEL RUNNING
parfor i = 1:length(img_paths)
%     colour_hist = zeros(quantisation, quantisation, quantisation);
    img = imread(img_paths{i});
    switch lower(colour_space)
        case "hsv"
            img = rgb2hsv(img);
        case "lab"
            img = rgb2xyz(img);
        case "ycbcr"
            img = rgb2ycbcr(img);
        case "yiq"
            img = rgb2ntsc(img);
    end
    double_img = double(img);
    quantised_img = image_quantisation(double_img, quantisation);
    % MODIFICATION REQUIRED FOR EFFICIENCY
    colour_hist = create_colour_histogram(quantised_img, quantisation);
    colour_hist = colour_hist(:);
    features(i,:) = colour_hist;
end
end

