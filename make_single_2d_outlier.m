% Example usage:
% [X,Y] = make_single_2d_outlier([3;2], 1);
% [m, b] = theil_sen_fit(X, Y)
function [X,Y,is_outlier] = make_single_2d_outlier(m, b)
%MAKE_SINGLE_2D_OUTLIER Summary of this function goes here
%   One point is way off. Should mess up OLS, but others should be okay.
    [X1 X2] = meshgrid(1:10);
    X = [X1(:) X2(:)];
    Y = X*m + b;
    Y(92) = Y(92) * 10;
    is_outlier=false(size(Y));
    is_outlier(92) = true;
end

