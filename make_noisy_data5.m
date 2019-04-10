function [x,y,is_outlier]=make_noisy_data5(m,b)
% generates all noisy data 
% noise generated in 2 stages: y value is within a threshold of 100*slope above or below a
% line defined by y=mx+b, then subtract some random percentage of that y value from itself 
    x=linspace(0,1000).';
    y=m.*x+b;
    is_outlier=false(size(y));
    for i=1:100
        noisei=randi([-abs(m*100),abs(m*100)]);
        y(i)=(noisei)+y(i);
        noise=rand(1);
        y(i)=y(i)-(noise.*y(i));
    end
end
    
    