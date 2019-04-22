function [x,y,is_outlier]=make_noisy_data4(m,b)
%generates all noisy data within a threshold of 100*slope above or below a line
% makes every jth data point erroneous
    x=linspace(0,1000).';
    y=m.*x+b;
    is_outlier=false(size(y));
    for i=1:100
        noisei=randi([-abs(m*100),abs(m*100)]);
        y(i)=(noisei)+y(i);
    end
    data_coll_error=randi([2,10]);
    for j=1:data_coll_error:100
        noise=rand(1);
        y(j)=y(j)+(noise.*y(j));
        is_outlier(j)=1;
        %notice how outliers are always same sign as each other. should be
        %random?
    end
end
    
    