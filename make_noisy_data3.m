function [x,y]=make_noisy_data3(m,b)
%generates all noisy data within a threshold of 100*slope above or below a line
% makes every jth data point=0 (ie because of a data collection error)
    x=linspace(0,1000);
    y=m.*x+b;
    for i=1:100
        noisei=randi([-abs(m*100),abs(m*100)]);
        y(i)=(noisei)+y(i);
    end
    data_coll_error=randi([2,10]);
    for j=1:data_coll_error:100
        y(j)=0;
    end
    scatter(x,y)
end
    
    