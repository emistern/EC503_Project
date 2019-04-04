function [m, b] = theil_sen_fit(Xtr, ytr)
%THEIL_SEN_FIT Use the Theil-Sen algorithm for regression.
%   Uses the median of slopes between any 2 points
    n_samples = size(Xtr, 1);
    slopes=zeros(n_samples, n_samples);
    for idx=1:n_samples
        slopes(idx, idx+1:end) = (ytr(idx+1:end) - ytr(idx)) ./ (Xtr(idx+1:end, 1) - Xtr(idx, :));
    end
    
    % Only use the upper right part of the matrix so we ignore duplicates
    % from symmetric points, and avoid self-comparisons on the diagonal.
    upper_right_idx = triu(true(size(slopes)), 1);
    m = median(slopes(upper_right_idx));
    b = median(ytr - m * Xtr);
end