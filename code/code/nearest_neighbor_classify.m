function [predictions] = nearest_neighbor_classify(train_image_feats, train_labels, test_image_feats, K)
%NEAREST_NEIGHBOR_CLASSIFY Summary of this function goes here
%   Detailed explanation goes here
test_size = size(test_image_feats);
preictions = zeros(test_size(1), 1);
for i = 1:test_size(1)
    test_feature_vector = test_image_feats(i);
    dist = pdist2(test_feature_vector, train_image_feats, 'euclidean');
    
end
end

