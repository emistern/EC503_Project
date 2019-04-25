function [best_m, best_b] = ransac_implementation(X_train, Y_train)
% RANSAC 
[m_train,d_train] = size(X_train);
ndim = length(d_train);

% Parameters setting
numIterations = 30;
n_pts_in_model = ndim + 1; % linear
dist_thresh = 4;

% Array to store number of inliers, slope, intercept
metric_data = zeros(numIterations,ndim+2);
for k = 1:numIterations
    % 1. Draw sample of n points uniformly
    inds = randi([1 m_train],n_pts_in_model,1);
    v = zeros(d_train+1,length(inds));
    for iPt = 1:length(inds)
        v(:,iPt) = [X_train(inds(iPt),:) Y_train(inds(iPt))]';
    end
    %point1 = [X_train(inds(1),:) Y_train(inds(1))];
    %point2 = [X_train(inds(2),:) Y_train(inds(2))];
    rest_of_data = [X_train Y_train];
    rest_of_data(inds,:) = [];
    % 2. Train set of data
    if ndim == 1
        [m, b] = fit_a_line(v(:,1), v(:,2));
        % 3. Compute distances to this line
        dists = all_pts_to_line(rest_of_data, v(:,1), v(:,2));
    else
        x_data = [v(1:ndim,:); ones(1,3)]';
        y_data = v(ndim+1,:)';
        m = pinv(x_data'*x_data) * x_data' * y_data;
        % 3. Compute distances to this line
        dists = all_pts_to_hyperplanes(rest_of_data, v(:,1), v(:,2), v(:,3));
    end
    % 4. Compute number of inliers vs. outliers
    num_in = sum(dists <= dist_thresh);
    metric_data(k,:) = [num_in m b];
end

% Find index with maximum number of inliers
[~, best_ind] = max(metric_data(:,1));
best_m = metric_data(best_ind,2:ndim+1);
best_b = metric_data(best_ind,ndim+2);

    
