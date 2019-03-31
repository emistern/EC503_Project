function [x,y]=make_noisy_data2(m,b)
%generates all noisy data within a threshold of 100*slope above or below a line
    x=linspace(0,1000);
    y=m.*x+b;
    for i=1:100
        noisei=randi([-abs(m*100),abs(m*100)]);
        y(i)=(noisei)+y(i);
    end
    scatter(x,y)
end
    
    