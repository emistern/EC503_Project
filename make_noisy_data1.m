function [x,y,is_outlier]=make_noisy_data1(m,b)
    % data
    x=linspace(0,1000).';
    y=m.*x+b;
    for i=1:100
        noise=rand(1);
        y(i)=noise.*y(i);
    end
    is_outlier = false(size(y));
end
% Adds noise to every point in dataset
    
    