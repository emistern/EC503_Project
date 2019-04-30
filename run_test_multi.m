function run_test(f,num_sample,m,b)
   % [Xtr ytr ztr is_outlier] = f(num, m, b);
    [Xtr, ytr, ztr] = f(num_sample,m,b);
    
       
    [theta1, theta2, theta3] = mult_RM_func(Xtr, ytr, ztr);
    
    z_hat = theta1.*Xtr + theta2.*ytr + theta3;
    
    figure();
   
    plot3(Xtr,ytr,ztr,'r.');
    hold on;
    plot3(Xtr,ytr,z_hat,'b.');

end