% Generate linear data with noise and outliers
% e.g. [X, Y] = make_noisy_data7(2, 6, [10 100], [1000 4000], 0.05);
function [X, y, is_outlier] = make_noisy_data7(m, b, noise_bounds, outlier_offset_bounds, outlier_probability)
% GENERATE_LINEAR_DATA  Generate linear data with random noise and random outliers
%   [X, Y, IS_OUTLIER] = GENERATE_LINEAR_DATA(M,B,NOISE_BOUNDS,OUTLIER_OFFSET_BOUNDS,OUTLIER_PROBABILITY)
%   Generates linear data, mapping X to Y with slope M and intercept B.
%
%   The data contains noise in Y bounded by NOISE_BOUNDS.
%
%   The data contains outliers that are offset from the center of
%   non-outlier data, which are bounded by OUTLIER_OFFSET_BOUNDS.
%
%   The probability of generating an outlier is specified by
%   OUTlIER_PROBABILITY.
    X = [1:1000].';
    noise = (noise_bounds(2) - noise_bounds(1)) .* rand(size(X, 1), 1) + noise_bounds(1);
    all_outliers = (outlier_offset_bounds(2) - outlier_offset_bounds(1)) .* rand(size(X, 1), 1) + outlier_offset_bounds(1);
    filtered_outliers = all_outliers .* (rand(size(X, 1), 1) < outlier_probability);
    y = m * X + b + noise + filtered_outliers;
    is_outlier = filtered_outliers > 0;
end