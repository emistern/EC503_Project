function [best_m, best_b] = ransac_implementation(X_train, Y_train)
% Parameters setting
numIterations = 3;
n_pts_in_model = 2; % linear
dist_thresh = 1;

% RANSAC 
[m_train,d_train] = size(X_train);

% Array to store number of inliers, slope, intercept
metric_data = zeros(numIterations,3); 
for k = 1:numIterations
    % 1. Draw sample of n points uniformly
    inds = randi([1 m_train],n_pts_in_model,1);
    point1 = [X_train(inds(1),:) Y_train(inds(1))];
    point2 = [X_train(inds(2),:) Y_train(inds(2))];
    rest_of_data = [X_train Y_train];
    rest_of_data(inds,:) = [];
    % 2. Train set of data
    [m, b] = fit_a_line(point1, point2);
    % 3. Compute distances to this line
    dists = all_pts_to_line(rest_of_data, point1, point2);
    % 4. Compute number of inliers vs. outliers
    num_in = sum(dists <= dist_thresh);
    metric_data(k,:) = [num_in m b];
end

% Find index with maximum number of inliers
[~, best_ind] = max(metric_data(:,1));
best_m = metric_data(best_ind,2);
best_b = metric_data(best_ind,3);

    
