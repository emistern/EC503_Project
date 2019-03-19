% Generate linear data with noise and outliers
m = 2;
b = 6;
noise_min = 10;
noise_max = 100;
min_outlier_offset = 1000;
max_outlier_offset = 4000;
outlier_probability = 0.05;

X = [1:1000].';
noise = (noise_max - noise_min) .* rand(size(X, 1), 1) + noise_min;
all_outliers = (max_outlier_offset - min_outlier_offset) .* rand(size(X, 1), 1) + min_outlier_offset;
filtered_outliers = all_outliers .* (rand(size(X, 1), 1) < outlier_probability);
Y = m * X + b + noise + filtered_outliers;

scatter(X, Y, '.');