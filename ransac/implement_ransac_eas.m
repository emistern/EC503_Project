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

X = linspace(0, 100, 1000);
y = m*X + b;


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

%% Plot the data to visualize it
figure
plot(X, y, 'ro')
hold on
plot(X, 3*X+32, 'bo')
plot(X, 3*X-16, 'co')

%% Implement RANSAC %%
% Distance to point
x1 = 2;
x2 = 6;
plot(x1, x1*3+8, 'b*')
plot(x2, x2*3+8, 'b*')
plot(4, 4*3-16, 'r^')

v1 = [x1, x1*3+8];
v2 = [x2, x2*3+8];
pt = [4,4*3-16];

distance = point_to_line_dist(pt, v1, v2);


