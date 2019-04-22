clear
close all

%% generate data

m = 3;
b = 2;
%X = [1:.1:100]';
%Y = m*X + b;
num_samples = 1000;
[X,Y]=make_noisy_data3(m,b,num_samples);
X = X';
Y = Y';
% Split into train and test data
[m,d] = size(X);
all_data = [X Y];
c = randperm(m);
train_ind = c(1:floor(.8*m));
test_ind = c(floor(.8*m)+1:end);

train_data = all_data(train_ind,:);
X_train = train_data(:,1:end-1);
Y_train = train_data(:,end);
test_data = all_data(test_ind,:);
X_test = test_data(:,1:end-1);
Y_test = test_data(:,end);

figure
plot(X_train,Y_train, 'r.')
hold on
plot(X_test, Y_test, 'go')
legend('Train data', 'test data')

% RANSAC 
[m_train,d_train] = size(X_train);

% Parameters setting
numIterations = 3;
n_pts_in_model = 2; % linear
dist_thresh = 1;

% Array to store number of inliers, slope, intercept
metric_data = zeros(numIterations,3); 
for k = 1:numIterations
    % 1. Draw sample of n points uniformly
    inds = randi([1 m_train],n_pts_in_model,1);
    point1 = [X_train(inds(1),:) Y_train(inds(1))];
    point2 = [X_train(inds(2),:) Y_train(inds(2))];
    rest_of_data = [X_train Y_train];
    rest_of_data(inds,:) = [];
    % 2. Train set of data
    [m, b] = fit_a_line(point1, point2);
    % 3. Compute distances to this line
    dists = all_pts_to_line(rest_of_data, point1, point2);
    % 4. Compute number of inliers vs. outliers
    num_in = sum(dists <= dist_thresh);
    metric_data(k,:) = [num_in m b];
end

% Find index with maximum number of inliers
[~, best_ind] = max(metric_data(:,1));
best_m = metric_data(best_ind,2);
best_b = metric_data(best_ind,3);
% Plot results
x_tmp = linspace(min(X_train), max(X_train), 1000);
plot(x_tmp, best_m*x_tmp + best_b)

% TODO: plot the inliers and the outliers

function [x,y]=make_noisy_data3(m,b,num_sample)
%generates all noisy data within a threshold of 100*slope above or below a line
% makes every jth data point=0 (ie because of a data collection error)
    x=linspace(0,1000,num_sample);
    y=m.*x+b;
    for i=1:num_sample
        noisei=randi([-abs(m*100),abs(m*100)]);
        y(i)=(noisei)+y(i);
    end
    data_coll_error=randi([2,1000]);
    for j=1:data_coll_error:num_sample
        y(j)=0;
    end
end
    
