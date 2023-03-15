function [features] = get_tiny_images(img_paths, tiny_img_size)
%GET_TINY_IMAGES Summary of this function goes here
%   img_paths = Cell array of test image paths
%   tiny_img_size = Dimension of image after downsampling
%%
% Initialise feature vectors 
features = zeros(size(img_paths,1), (tiny_img_size^2)*3);
parfor i = 1:length(img_paths)
    img = imread(img_paths{i});
    % Downsample image to size (tiny_img_size x tiny_img_size) using imresize()
    down_sampled_img = imresize(img, [tiny_img_size tiny_img_size]);
    % Normalise image using either rescale or divide the matrix
    % element-wise by 255.
    norm_img = rescale(down_sampled_img);
%     norm_img = down_sampled_img / 255;
    % Reshape the image to (1 x M)
    feature = norm_img(:)';
    features(i,:) = feature;
end
end

