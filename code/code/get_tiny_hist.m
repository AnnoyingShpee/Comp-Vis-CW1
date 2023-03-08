function [features] = get_tiny_hist(img_paths, tiny_img_size, quantisation, colour_space)
%GET_TINY_HIST Summary of this function goes here
%   Detailed explanation goes here
features = zeros(size(img_paths,1), quantisation^3);
parfor i = 1:length(img_paths)
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
    down_sampled_img = imresize(img, [tiny_img_size tiny_img_size]);
    double_img = double(down_sampled_img);
    quantised_img = image_quantisation(double_img, quantisation);
    % MODIFICATION REQUIRED FOR EFFICIENCY
    colour_hist = create_colour_histogram(quantised_img, quantisation);
    feature = colour_hist(:);
    features(i,:) = feature;
end

