function [x,y]=make_noisy_data_MC(m,b, mu_noise, var_noise, nPts_tot, frac_nPts_Out)
%generates all noisy data within a threshold of 100*slope above or below a line
    nPts_in = nPts_tot - (round(nPts_tot*frac_nPts_Out));
    nPts_out = nPts_tot - nPts_in;
    x=linspace(0,1000, nPts_in).';
    y=m.*x+b;
    % A little bit of Gaussian noise to the original line
    y = y + (rand(size(y))*10);
    % create new points
    theta = atan(m);
    rotate_m = eye(2); %[cos(theta) -sin(theta);
                %sin(theta) cos(theta)];
    R = mvnrnd(mu_noise,diag(var_noise),nPts_out);
    R = R*rotate_m;
    x = [x; R(:,1)];
    y = [y; R(:,2)];
    % Add cluster of outliers
    
%     for i=1:100
%         noisei=randi([-abs(m*100),abs(m*100)]);
%         y(i)=(noisei)+y(i);
%     end
end
    
    

