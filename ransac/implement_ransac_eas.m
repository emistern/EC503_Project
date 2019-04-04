% function [m] = implement_ransac_eas(x, y, s, T, p)
% x and y are the data set to build a linear model from
% s is the smallest number of points required for each individual model (2)
% N is the number of iterations required, calculated from P?
% p is the probability hat we have chosen N samples and not all of them 
% are contaminated. there is at least one inliar in our data

%% Create the synthetic Data %%
% Set the fake data
m = 3;
b = 8;

X = linspace(0, 100, 200);
y = m*X + b;
X = [X, 101];
y = [y, 361];


% data_unshuffled = [X y];
% 
% shuffled = data_unshuffled(randperm(size(data_unshuffled,1)),:);
% 
% X_shuff = shuffled(:,1:end-1);
% y_shuff = shuffled(:,end);
% 
% % Split the Data into training (80%) and test (20%) data
% train_size = round(0.8*size(X_shuff,1));
% train_x = X_shuff(1:train_size, :);
% train_y = y_shuff(1:train_size, :);
% test_x = X_shuff(train_size+1:end, :);
% test_y = y_shuff(train_size+1:end, :);
[~, nb_samples] = size(X);

%% Plot the data to visualize it
figure
plot(X, y, 'ro')
hold on
plot(X, 3*X+32, 'bo')
plot(X, 3*X-16, 'co')

%% Implement RANSAC %%

% RANSAC Parameters
p = 0.99; % Probability that you have at least one inlier in your data
u = .33; % Probability that a point is an outlier
N_iters = ceil(nb_samples/6); % Number of iterations to do
d_threshold = 10;

% Sample two points Randomly
samples = randi(nb_samples, 2,1);

% Sample Points
v1 = [X(samples(1)), y(samples(1))];
v2 = [X(samples(2)), y(samples(2))];
% Fit a line to those two points
[slope, b] = fit_a_line(v1, v2);
plot(X(samples(1)), y(samples(1)), 'b*')
plot(X(samples(2)), y(samples(2)), 'b*')

number_inliers = 0;

% Count number of inliers
for a_sample = 1:nb_samples
    pt = [X(a_sample), y(a_sample)];
    distance = point_to_line_dist(pt, v1, v2);
    if distance < d_threshold
        number_inliers = number_inliers + 1;
    end
end

% Questions about RANSAC
% - how to choose the threshold, should you look at the data first? maybe
%   if you can't visualize it you can look at the std for a few different
%   sample sets and start from there?


