function [all_combos] = ransac_eas(X, y, d_threshold, Nb_iters)

number_inliers = 0;
all_combos = zeros(Nb_iters, 5);
[~, nb_samples] = size(X);

for an_iter = 1:Nb_iters
    % Sample two points Randomly
    samples = randi(nb_samples, 2,1);

    % Sample Points
    v1 = [X(samples(1)), y(samples(1))];
    v2 = [X(samples(2)), y(samples(2))];
    
    number_inliers = 0;
    
    % Count number of inliers
    for a_sample = 1:nb_samples
        pt = [X(a_sample), y(a_sample)];
        distance = point_to_line_dist(pt, v1, v2);
        if distance < d_threshold
            number_inliers = number_inliers + 1;
        end
    end
    all_combos(an_iter, :) = [v1, v2, number_inliers];
end