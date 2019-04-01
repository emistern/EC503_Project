function [x,y]=make_no_noisy_data(m,b)
    x=linspace(0,1000);
    y=m.*x+b;
    scatter(x,y)
end
% 100 sample points with no noise