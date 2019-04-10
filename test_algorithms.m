run_test(@make_noisy_data1, 3, 1);
run_test(@make_noisy_data2, 3, 1);
run_test(@make_noisy_data3, 3, 1);
run_test(@make_noisy_data4, 3, 1);
run_test(@make_noisy_data5, 3, 1);
run_test(@make_noisy_data6, 3, 1);
run_test(@(m, b) make_noisy_data7(m, b, [10 100], [300 400], 0.2), 3, 1);

function run_test(f, m1, b1)
    [Xtr ytr is_outlier] = f(m1, b1);
    
    figure();
    hold on;
    scatter(Xtr(~is_outlier), ytr(~is_outlier), 'b');
    scatter(Xtr(is_outlier), ytr(is_outlier), 'r');
    
    [m, b] = repeated_median_fit(Xtr, ytr);
    rmf=refline(m, b);
    rmf.Color='blue';
    
    [m, b] = theil_sen_fit(Xtr, ytr);
    tsf=refline(m, b);
    tsf.Color='red';
    
    legend('data', 'outliers', 'Repeated Median', 'Theil Sen');
end