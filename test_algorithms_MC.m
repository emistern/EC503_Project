nMC = 100;
var_noise = [100 100].^2;
mu_noise = [400 2500];
n_total_pts = 1000;
nfrac_outliers = [0:.05:.7]; %round(.50*n_inliers);
%run_test_MC(@make_noisy_data1, 3, 1, nMC, noise_var, noise_mean);
run_test_MC(@make_noisy_data_MC, 3, 1, nMC, mu_noise, var_noise, n_total_pts, nfrac_outliers);
% run_test_MC(@make_noisy_data3, 3, 1, nMC, noise_var, noise_mean);
% run_test_MC(@make_noisy_data4, 3, 1, nMC, noise_var, noise_mean);
% run_test_MC(@make_noisy_data5, 3, 1, nMC, noise_var, noise_mean);
% run_test_MC(@make_noisy_data6, 3, 1, nMC, noise_var, noise_mean);
%run_test_MC(@(m, b) make_noisy_data7(m, b, [10 100], [600 800], 0.48), 3, 1);
%run_test2d(@make_single_2d_outlier, [5;2], 4);


function run_test_MC(f, m1, b1, nMC, mu_noise, var_noise, n_total_pts, nfrac_outliers)
    % Initialize arrays to store output statistics
    % Average MSE
    ols_avg_mse = zeros(length(nfrac_outliers),1);
    theil_avg_mse = zeros(size(ols_avg_mse));
    medmed_avg_mse = zeros(size(ols_avg_mse));
    ransac_avg_mse = zeros(size(ols_avg_mse));
    % Average Time
    ols_avg_time = zeros(length(nfrac_outliers),1);
    theil_avg_time = zeros(size(ols_avg_mse));
    medmed_avg_time = zeros(size(ols_avg_mse));
    ransac_avg_time = zeros(size(ols_avg_mse));
    % Standard deviation of MSE
    ols_std_mse = zeros(size(ols_avg_mse));
    theil_std_mse = zeros(size(ols_std_mse));
    medmed_std_mse = zeros(size(ols_std_mse));
    ransac_std_mse = zeros(size(ols_std_mse));
    for i_outliers = 1:length(nfrac_outliers)
        frac_outlier = nfrac_outliers(i_outliers);
            % initialize temporary array to store information to compute
            % mean and standard deviation across all runs
            mc_ols = zeros(nMC,1);
            mc_ransac = zeros(nMC,1);
            mc_theil = zeros(nMC,1);
            mc_medmed = zeros(nMC,1);
            % Run all Monte-Carlo Runs
            for iMC = 1:nMC
                [Xtr, ytr] = f(m1, b1, mu_noise, var_noise, n_total_pts, frac_outlier);
                [Nb_samples, ~] = size(Xtr);
                %Xtr = [Xtr;  10];
                %ytr = [ytr; 2];
                tic;
                [m,b] = OLS(Xtr,ytr);
                y_ols = Xtr*m+b;
                ols_avg_time(iMC) = toc;
                
                tic;
                [m, b] = repeated_median_fit(Xtr, ytr);
                y_rmf = Xtr*m + b;
                medmed_avg_time(iMC) = toc;
                
                tic;
                [m, b] = theil_sen_fit(Xtr, ytr);
                y_tsf = Xtr*m+b;
                theil_avg_time(iMC) = toc;
                
                tic;
                [m, b] = ransac_implementation(Xtr, ytr);
                y_rsc = Xtr*m+b;
                ransac_avg_time(iMC) = toc;
                
                % Calculate mean_squared_error
                y_true = Xtr*m1 + b1;
                mc_ols(iMC) = (1/Nb_samples)*(y_true - y_ols)'*(y_true - y_ols);
                mc_medmed(iMC) = (1/Nb_samples)*(y_true - y_rmf)'*(y_true - y_rmf);
                mc_theil(iMC) = (1/Nb_samples)*(y_true - y_tsf)'*(y_true - y_tsf);
                mc_ransac(iMC) = (1/Nb_samples)*(y_true - y_rsc)'*(y_true - y_rsc);
            end
            % After computing MSE for all MC, find average and standard
            % deviation
            ols_avg_mse(i_outliers) = mean(mc_ols);
            theil_avg_mse(i_outliers) = mean(mc_theil);
            medmed_avg_mse(i_outliers) = mean(mc_medmed);
            ransac_avg_mse(i_outliers) = mean(mc_ransac);
            ols_std_mse(i_outliers) = std(mc_ols);
            theil_std_mse(i_outliers) = std(mc_theil);
            medmed_std_mse(i_outliers) = std(mc_medmed);
            ransac_std_mse(i_outliers) = std(mc_ransac);
    end
    figure
    hold on
    plot(nfrac_outliers, ols_avg_mse, 'r')
    plot(nfrac_outliers, theil_avg_mse, 'g')
    plot(nfrac_outliers, medmed_avg_mse, 'b')
    plot(nfrac_outliers, ransac_avg_mse, 'c')
    title('Average MSE Over 100 Monte-Carlo Runs vs. Number of Outliers')
    legend('OLS', 'Theil-Sen', 'Median-Median', 'RANSAC')
    plot(nfrac_outliers, ols_avg_mse + ols_std_mse, 'r-')
    plot(nfrac_outliers, ols_avg_mse - ols_std_mse, 'r-')
    plot(nfrac_outliers, theil_avg_mse + theil_std_mse, 'g-')
    plot(nfrac_outliers, theil_avg_mse - theil_std_mse, 'g-')
    plot(nfrac_outliers, medmed_avg_mse + medmed_std_mse, 'b-')
    plot(nfrac_outliers, medmed_avg_mse - medmed_std_mse, 'b-')
    plot(nfrac_outliers, ransac_avg_mse + ransac_std_mse, 'c-')
    plot(nfrac_outliers, ransac_avg_mse - ransac_std_mse, 'c-')
    
    n_percent_outliers = nfrac_outliers*100;
    figure
    hold on
    semilogy(n_percent_outliers, log(ols_avg_mse), 'r')
    semilogy(n_percent_outliers, log(theil_avg_mse), 'g')
    semilogy(n_percent_outliers, log(medmed_avg_mse), 'b')
    semilogy(n_percent_outliers, log(ransac_avg_mse), 'c')
    title('Average MSE Over 100 Monte-Carlo Runs vs. Percent of Outliers')
    legend('OLS', 'Theil-Sen', 'Median-Median', 'RANSAC')
    semilogy(n_percent_outliers, log(ols_avg_mse + ols_std_mse), 'r--','HandleVisibility','off')
    semilogy(n_percent_outliers, log(ols_avg_mse - ols_std_mse), 'r--','HandleVisibility','off')
    semilogy(n_percent_outliers, log(theil_avg_mse + theil_std_mse), 'g--','HandleVisibility','off')
    semilogy(n_percent_outliers, log(theil_avg_mse - theil_std_mse), 'g--','HandleVisibility','off')
    semilogy(n_percent_outliers, log(medmed_avg_mse + medmed_std_mse), 'b--','HandleVisibility','off')
    semilogy(n_percent_outliers, log(medmed_avg_mse - medmed_std_mse), 'b--','HandleVisibility','off')
    semilogy(n_percent_outliers, log(ransac_avg_mse + ransac_std_mse), 'c--','HandleVisibility','off')
    semilogy(n_percent_outliers, log(ransac_avg_mse - ransac_std_mse), 'c--','HandleVisibility','off')
    set(gca, 'FontSize', 18')
    xlabel('Percent of Outliers in Training Data')
    ylabel('Log of Average MSE')
    xtickformat('percentage')
    
    figure
    plot(Xtr,ytr, '.')
    set(gca, 'FontSize', 18')
    xlabel('X training data')
    ylabel('Y training data')
    title('Training Data Used for MC Results')
    
    Time = [mean(ols_avg_time) mean(theil_avg_time) mean(medmed_avg_time) mean(ransac_avg_time)]';
    Algorithm_Type = {'OLS';'Theil_Sen';'Repeated Median';'RANSAC'};

    T = table(Algorithm_Type,Time)
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
