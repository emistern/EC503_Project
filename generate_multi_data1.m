function [X,Y,is_outlier] = generate_multi_data1(m, b)
%With noise
%     [X1 X2] = meshgrid(1:5);
%     X = [X1(:) X2(:)];
%     Y = X.*m + b;
%     Y(11) = Y(11) * 10;
%     is_outlier=false(size(Y));
%     is_outlier(11) = true;
if noise == 1
    number_outliers = randi(1, ceil(nb_samples/3));
    for an_outlier = 1:number_outliers
        bad_sample = randi([1 nb_samples]);
        y_unshuf(bad_sample) = y_unshuf(bad_sample) + randi([-10 10])*rand(1,1);
    end
end
end
