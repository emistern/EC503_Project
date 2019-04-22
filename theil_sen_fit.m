function [m, b] = theil_sen_fit(Xtr, ytr)
%THEIL_SEN_FIT Use the Theil-Sen algorithm for regression.
%   Uses the median of slopes between any 2 points
    ydiffs = pdist2(ytr, ytr, @minus);
    xdiffs = pdist2(Xtr, Xtr, @minus);
    slopes = ydiffs ./ xdiffs;
    
    % Only use the upper right part of the matrix so we ignore duplicates
    % from symmetric points, and avoid self-comparisons on the diagonal.
    upper_right_idx = triu(true(size(slopes)), 1);
    m = median(slopes(upper_right_idx));
    b = median(ytr - m * Xtr);
end