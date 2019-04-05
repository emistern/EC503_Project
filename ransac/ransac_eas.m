function [b, m] = ransac_eas()

% Count number of inliers
for a_sample = 1:nb_samples
    pt = [X(a_sample), y(a_sample)];
    distance = point_to_line_dist(pt, v1, v2);
    if distance < d_threshold
        number_inliers = number_inliers + 1;
    end
end