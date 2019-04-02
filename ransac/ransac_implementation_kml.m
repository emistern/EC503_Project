clear
close all

%% generate data

m = 3;
b = 2;
X = [1:.1:100]';
Y = m*X + b;

% Split into train and test data
% split into training and test data
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
% Parameter setting
numIterations = 10;
n_pts_in_model = 2; % linear
for k = 1:numIterations
    % 1. Draw sample of n points uniformly
    inds = randi([1 m_train],2,1);
    % 2. Train subset of data
    %p = polyfit(x,y,n); 
end