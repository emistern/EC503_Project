% function [m] = implement_ransac_eas(x, y, s, T, p)
% x and y are the data set to build a linear model from
% s is the smallest number of points required for each individual model (2)
% N is the number of iterations required, calculated from P?
% p is the probability hat we have chosen N samples and not all of them 
% are contaminated. there is at least one inliar in our data

%% Create the synthetic Data %%
% Set the fake data
m = 3;
b = 2;
Nb_samples = 1000;

X=linspace(0,1000, Nb_samples);

y=m.*X+b;
for i=1:Nb_samples
    noisei=randi([-abs(m*100),abs(m*100)]);
    y(i)=(noisei)+y(i);
    noise=rand(1);
    y(i)=y(i)-(noise.*y(i));
end

[~, nb_samples] = size(X);

%% Plot the data to visualize it
figure
plot(X, y, 'ro')
hold on

%% Implement RANSAC %%

% RANSAC Parameters
% p = 0.99; % Probability that you have at least one inlier in your data
% u = .33; % Probability that a point is an outlier
Nb_iters = ceil(nb_samples/6); % Number of iterations to do
d_threshold = 10;

[all_combos] = ransac_eas(X, y, d_threshold, Nb_iters);

% Get the best performing points
[~, best_index] = max(all_combos(:,5));
v1_best = all_combos(best_index, 1:2);
v2_best = all_combos(best_index, 3:4);

[slope, b] = fit_a_line(v1_best, v2_best);
refline(slope, b)
