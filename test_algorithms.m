run_test(@make_noisy_data1, 3, 1);
run_test(@make_noisy_data2, 3, 1);
run_test(@make_noisy_data3, 3, 1);
run_test(@make_noisy_data4, 3, 1);
run_test(@make_noisy_data5, 3, 1);

function run_test(f, m1, b1)
    figure();
    [Xtr ytr] = f(m1, b1);
    [m, b] = repeated_median_fit(Xtr.', ytr.');
    hold on;
    rmf=refline(m, b);
    rmf.DisplayName='Repeated Median';
    [m, b] = theil_sen_fit(Xtr.', ytr.');
    tsf=refline(m, b);
    tsf.DisplayName='Theil Sen';
    tsf.Color='red';
    legend();
end