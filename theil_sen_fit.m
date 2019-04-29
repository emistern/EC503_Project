function [m, b, breakdown_point] = theil_sen_fit(Xtr, ytr, max_samples)
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
        breakdown_point = 1-(0.5)^(1/2);
    else
        % 2+D input and output. Use spatial (L1) median. Analysis at:
        %   http://home.olemiss.edu/~xdang/papers/MTSE.pdf
        % The 1D case is a specialization of this, where subsample_size=2.
        % Keeping both implementations to illustrate the simplicity of the
        % specialized/original case.
        
        % Have at least as many samples as features so OLS subproblems are
        % not underdefined. Greater subsample sizes require fewer OLS
        % subproblems, but have a lower breakdown point. The MTSE paper
        % suggests staying moderately small, on the order of 50.
        %
        % Note, in terms of unknowns: x1+x2+b=y1+y2 ==> x1+x2+b-y1=y2
        subsample_size = d + size(ytr, 2) + 1;
        
        % With small subsample sizes, the number of required samples grows
        % very fast at nchoosek(samples, subsamples).
        samples = nchoosek(size(Xtr, 1), subsample_size);
        
        % Limit resource usage by limiting our sample count.
        if nargin == 3
            samples = min([samples, max_samples]);
        else
            samples = min([samples, 1e4]);
        end
        
        % From MSEE paper. It is asymptotic breakdown scaled down by
        % our increased chances of hitting too many outliers due to using
        % larger subsample sizes.
        breakdown_point = max([0, (1 - (0.5)^(1/subsample_size)) * (samples - subsample_size + 1) / samples]);
        
        estimates = zeros(samples, (d+1) * size(ytr, 2)); % Extra column for bias
        for i=1:samples
            % Perform OLS on a subsample of X. Add a ones column so we also
            % get the intercept.
            [x_subsample, subsample_idx] = datasample(Xtr, subsample_size, 'Replace', false);
            estimate = [ones(size(x_subsample, 1), 1), x_subsample] \ ytr(subsample_idx,:);
            % Flatten to a vector if not one already. We will rexpand to a
            % matrix later if needed. This allows multiple dependent
            % variables in a single regression operation.
            estimates(i,:) = reshape(estimate.', 1, []);
        end

        % Take the spatial median of our sampled coefficients.
        % Distance to a sample point is convex, and a sum of convex
        % functions is convex, so we can use a gradient-based minimizer.
        % Note: Seems like Weiszfeld's algorithm is recommended instead
        coefficients = fminunc(@(estimate) sum(pdist2(estimates, estimate, 'euclidean')), zeros(1, size(estimates, 2)) ).';
        coefficients = reshape(coefficients, [], d+1).';
        m = coefficients(2:end,:);
        b = coefficients(1,:);
    end
end