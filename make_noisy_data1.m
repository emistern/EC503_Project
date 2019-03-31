function [x,y]=make_noisy_data1(m,b)
    x=linspace(0,1000);
    y=m.*x+b;
    for i=1:100
        noise=rand(1);
        y(i)=noise.*y(i);
    end
    scatter(x,y)
end
    
    