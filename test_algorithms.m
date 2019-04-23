run_test(@make_noisy_data1, 3, 1);
run_test(@make_noisy_data2, 3, 1);
run_test(@make_noisy_data3, 3, 1);
run_test(@make_noisy_data4, 3, 1);
run_test(@make_noisy_data5, 3, 1);
run_test(@make_noisy_data6, 3, 1);
run_test(@(m, b) make_noisy_data7(m, b, [10 100], [600 800], 0.48), 3, 1);
run_test2d(@make_single_2d_outlier, [5;2], 4);


function run_test(f, m1, b1)
    [Xtr ytr is_outlier] = f(m1, b1);
    
    figure();
    hold on;
    scatter(Xtr(~is_outlier), ytr(~is_outlier), 4, 'k');
    scatter(Xtr(is_outlier), ytr(is_outlier), 4, [.8 .8 .8]);
    
    [m, b] = repeated_median_fit(Xtr, ytr);
    rmf=refline(m, b);
    rmf.Color='blue';
    
    [m, b] = theil_sen_fit(Xtr, ytr);
    tsf=refline(m, b);
    tsf.Color='red';
    
    [m, b] = ransac_implementation(Xtr, ytr);
    rsc=refline(m,b);
    rsc.Color='green';
    
    legend('data', 'outliers', 'Repeated Median', 'Theil Sen', 'Ransac');
end

function run_test2d(f, m1, b1)
    [Xtr ytr is_outlier] = f(m1, b1);
    
    figure();
    hold on;
    scatter3(Xtr(~is_outlier,1), Xtr(~is_outlier,2), ytr(~is_outlier), 4, 'k');
    scatter3(Xtr(is_outlier,1), Xtr(is_outlier,2), ytr(is_outlier), 4, [.8 .8 .8]);
    
    [m, b] = theil_sen_fit(Xtr, ytr);
    
    plane_x1 = repmat([min(Xtr(:,1)) max(Xtr(:,1))], 2, 1);
    plane_x2 = repmat([min(Xtr(:,2)); max(Xtr(:,2))], 1, 2);
    plane_y = m(1) * plane_x1 + m(2) * plane_x2 + b;
    surf(plane_x1, plane_x2, plane_y);
    alpha 0.5;
    
    legend('data', 'outliers', 'Theil Sen');
    view([-30 30]);
end
