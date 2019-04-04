function [m, b] = repeated_median_fit(Xtr, ytr)
%REPEATED_MEDIAN_FIT Use the repeated median algorithm for regression.
%   Calculates the median of slopes between a point and all others, then 
%   uses the median of those slopes.
    n_samples = size(Xtr, 1);
    slopes = zeros(n_samples, 1);
    for idx=1:n_samples
        slopes(idx) = median((ytr(1:end ~= idx) - ytr(idx)) ./ (Xtr(1:end ~= idx, 1) - Xtr(idx, :)));
    end
    
    m = median(slopes);
    
    intercepts = zeros(n_samples, 1);
    for idx=1:n_samples
        intercepts(idx) = median((Xtr(1:end ~= idx) .* ytr(idx) - ...
            (Xtr(idx, :) .* ytr(1:end ~= idx, 1))) ./ ...
            (Xtr(1:end ~= idx) - Xtr(idx, :)));
    end
    
    b = median(intercepts);
end

