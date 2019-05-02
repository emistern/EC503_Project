function  [Xtr,ytr,ztr,z_hat, times] = run_test_multi(x_in, y)
    Xtr = x_in(:,1);
    ytr = x_in(:,2);
    ztr = y;
    tic;
    [theta1, theta2, theta3] = mult_RM_func(Xtr, ytr, ztr);
    times = toc;
    plane_x = repmat([min(Xtr(:,1)) max(Xtr(:,1))],2,1);
    plane_y = repmat([min(ytr(:,1)) max(ytr(:,1))],1,2);
    z_hat = theta1.*Xtr + theta2.*ytr + theta3;
    
    figure();
  
    Xtr = reshape(Xtr,numel(Xtr),1);
    ytr = reshape(ytr,numel(ytr),1);
    ztr = reshape(ztr,numel(ztr),1);
    z_hat = reshape(z_hat,numel(z_hat),1);


    plot3(Xtr,ytr,ztr,'.r',Xtr,ytr,z_hat,'.b');
    title('Repeated Median in 3D', 'FontSize', 18);
    legend({'Training Data', 'Predicted Data'});
    set(gca,'fontsize', 18);
end
% function  [Xtr,ytr,ztr,z_hat,is_outlier] = run_test_multi(f,m,b)
% 
%     [Xtr, ytr, ztr] = f(m,b);