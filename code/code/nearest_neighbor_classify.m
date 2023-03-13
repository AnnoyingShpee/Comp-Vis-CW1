function [predictions] = nearest_neighbor_classify(train_image_feats, train_labels, test_image_feats, K, dist_measure)
%NEAREST_NEIGHBOR_CLASSIFY Summary of this function goes here
%   Detailed explanation goes here
test_size = size(test_image_feats);
predictions = strings(test_size(1), 1);
for i = 1:test_size(1)
    test_feature_vector = test_image_feats(i,:);
    train_size = size(train_image_feats);
    distances = cell([train_size(1), 2]);
    for j = 1:train_size(1)
        dist = pdist2(test_feature_vector, train_image_feats(j,:), dist_measure);
        distances{j, 1} = dist;
        distances{j, 2} = train_labels{j};
    end
    %%
    [sort_dist, sort_index] = sort([distances{:,1}]);
    sort_dist = sort_dist';
    sort_index = sort_index';
    k_nearest_index = sort_index(1:K);
    k_labels = strings(K, 1);
    for k = 1:K
        k_labels(k,:) = train_labels{k_nearest_index(k)};
    end
    [count, element] = groupcounts(k_labels(:,1));
    [highest_count, index] = max(count);
    multi_highest_indexes = find(count==highest_count);
    if size(multi_highest_indexes, 1) == 1
        predictions(i,:) = element(index);
    else
        k_dist = sort_dist(1:K);
        sums = zeros(size(multi_highest_indexes, 1), 1);
        sums_labels = strings(size(multi_highest_indexes, 1), 1);
        for s = 1:size(multi_highest_indexes, 1)
            matches = ismember(k_labels(:,1), element(multi_highest_indexes(s)));
            sums(s, 1) = sum(k_dist(matches,1));
            sums_labels(s, 1) = k_labels(s);
        end
        [~, index] = min(sums, [], 1);
        predictions(i, :) = sums_labels(index);
    end
end
end

