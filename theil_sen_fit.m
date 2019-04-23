function [m, b] = theil_sen_fit(Xtr, ytr)
%THEIL_SEN_FIT Use the Theil-Sen algorithm for regression.
%   Uses the median of slopes between any 2 points
    d = size(Xtr, 2); % Dimesions of X

    if d == 1
        % 1D input. Use traditional Theil-Sen
        ydiffs = pdist2(ytr, ytr, @minus);
        xdiffs = pdist2(Xtr, Xtr, @minus);
        slopes = ydiffs ./ xdiffs;

        % Only use the upper right part of the matrix so we ignore duplicates
        % from symmetric points, and avoid self-comparisons on the diagonal.
        upper_right_idx = triu(true(size(slopes)), 1);
        m = median(slopes(upper_right_idx));
        b = median(ytr - m * Xtr);
    else
        % 2+D input. Use spatial (L1) median. Analysis at:
        %   http://home.olemiss.edu/~xdang/papers/MTSE.pdf        
        
        % Algorithm says to use submatrices of a selected (by us) size that are
        % invertible. TODO: How do we select just those?
        samples = 100;
        subsample_size = 50;
        estimates = zeros(samples, size(Xtr, 2)+1); % Extra space for 1s column
        for i=1:samples
            % Perform OLS on a subsample of X. Add a ones column so we also
            % get the intercept.
            [x_subsample, subsample_idx] = datasample(Xtr, subsample_size);
            estimates(i,:) = [ones(size(x_subsample, 1), 1), x_subsample] \ ytr(subsample_idx);
        end
        
        % Take the spatial median of our sampled coefficients.
        % Distance to a sample point is convex, and a sum of convex
        % functions is convex, so we can use a gradient-based minimizer.
        % Note: Seems like Weiszfeld's algorithm is recommended instead
        coefficients = fminunc(@(estimate) sum(pdist2(estimates, estimate, 'euclidean')), zeros(1, size(estimates, 2)) ).';
        m = coefficients(2:end);
        b = coefficients(1);
    end
end