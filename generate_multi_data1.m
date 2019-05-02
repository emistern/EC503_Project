function [X,Y,is_outlier] = generate_multi_data1(m, b)
%With noise
    [X1 X2] = meshgrid(1:5);
    X = [X1(:) X2(:)];
    Y = X.*m + b;
    Y(11) = Y(11) * 10;
    is_outlier=false(size(Y));
    is_outlier(11) = true;
end
