function [features] = get_tiny_images(img_paths, tiny_img_size)
%GET_TINY_IMAGES Summary of this function goes here
%   Detailed explanation goes here
features = zeros(size(img_paths,1), (tiny_img_size^2)*3);
parfor i = 1:length(img_paths)
    img = imread(img_paths{i});
    down_sampled_img = imresize(img, [tiny_img_size tiny_img_size]);
    norm_img = rescale(down_sampled_img);
%     norm_img_size = size(norm_img);
%     feature = reshape(norm_img, [norm_img_size(1) * norm_img_size(2),3]);
    feature = norm_img(:)';
    features(i,:) = feature;
end
end

