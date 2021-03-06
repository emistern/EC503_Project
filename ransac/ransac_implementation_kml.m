clear
close all

%% generate data

true_weights = [2; 3];
true_int = 4;
%X = [1:.1:100]';
%Y = m*X + b;
num_samples = 100;
%[X,Y]=make_noisy_data3(m,b,num_samples);
ndim = length(true_weights); % number of x dimensions
[X,Y] = make_noisy_data3_MD(true_weights,true_int,num_samples, ndim);
%X = X';
%Y = Y';
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

if ndim == 1
    figure
    plot(X_train,Y_train, 'r.')
    hold on
    plot(X_test, Y_test, 'go')
    legend('Train data', 'test data')
elseif ndim == 2
    figure
    plot3(X_train(:,1),X_train(:,2),Y_train, 'r.')
    hold on
    plot3(X_test(:,1),X_test(:,2), Y_test, 'go')
    legend('Train data', 'test data')
else
    disp('don''t know how to plot higher dimension data')
end
grid on

% RANSAC 
[m_train,d_train] = size(X_train);

% Parameters setting
numIterations = 3;
n_pts_in_model = ndim +1; %2; % linear
dist_thresh = 1;

% Array to store number of inliers, slope, intercept
metric_data = zeros(numIterations,ndim+3); 
for k = 1:numIterations
    % 1. Draw sample of n points uniformly
    inds = randi([1 m_train],n_pts_in_model,1);
    v = zeros(d_train+1,length(inds));
    for iPt = 1:length(inds)
        v(:,iPt) = [X_train(inds(iPt),:) Y_train(inds(iPt))]';
    end
    rest_of_data = [X_train Y_train];
    rest_of_data(inds,:) = [];
    % 2. Train set of data
    if ndim == 1
        [m, true_int] = fit_a_line(v);
        % 3. Compute distances to this line
        dists = all_pts_to_line(rest_of_data, point1, point2);
    else
        %[m, b] = fit_a_hyperplane(v);
        x_data = [v(1:ndim,:); ones(1,3)]';
        y_data = v(ndim+1,:)';
        m = pinv(x_data'*x_data) * x_data' * y_data;
        % 3. Compute distances to this line
        [dists] = all_pts_to_hyperplanes(rest_of_data, v(:,1), v(:,2), v(:,3));
    end
    % 4. Compute number of inliers vs. outliers
    num_in = sum(dists <= dist_thresh);
    metric_data(k,:) = [num_in m' true_int];
end

% Find index with maximum number of inliers
[~, best_ind] = max(metric_data(:,1));
best_m = metric_data(best_ind,2:ndim+1);
best_b = metric_data(best_ind,ndim+3);
% Plot results
x_tmp = linspace(0, 1000, 1000);
x1_tmp = repmat(x_tmp, length(x_tmp),1);
x2_tmp = x1_tmp';
%plot(x_tmp, best_m*x_tmp + best_b)
plot3(x1_tmp, x2_tmp, x1_tmp.*best_m(1) + x2_tmp.*best_m(2)+best_b)
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

function [x,y]=make_noisy_data3_MD(m,b,num_sample, ndim)
%generates all noisy data within a threshold of 100*slope above or below a line
% makes every jth data point=0 (ie because of a data collection error)
    x1 =linspace(0,1000,num_sample);
    x1 = repmat(x1, num_sample,1);
    x2 = x1';
    y=x1.*m(1) + x2.*m(2)+b;
    m_norm = round(norm(m));
    noise_unif = randi([-abs(m_norm*100),abs(m_norm*100)],size(y));
    y = y + noise_unif;
    %for i=1:num_sample
    %    noisei=randi([-abs(m*100),abs(m*100)],2,1);
    %    y(i)= noisei+y(i);
    %end
    data_coll_error=randi([2,200]);
    n_data = length(y(:));
    ind_zero = randi([1,n_data],data_coll_error,1);
    y = y(:);
    y(ind_zero)=0;
    x = [x1(:) x2(:)];
    %for j=1:data_coll_error:num_sample
    %    y(j)=0;
    %end
end
    
