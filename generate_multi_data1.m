function [x,y,z] = generate_multi_data1(num_sample,m,b)

    x =linspace(1,100,num_sample);
    x = repmat(x,num_sample ,1);
    y = x';
    z = x.*m(1) + y.*m(2) + b;

end