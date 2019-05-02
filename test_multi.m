clear, clc
%% generate data

true_weights = [2; 3];
true_int = 4;
%X = [1:.1:100]';
%Y = m*X + b;
num_samples = 20;
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

%% Run Multi Dimension %%

%  this will get and plot results

[Xtr,ytr,ztr,z_hat, times] = run_test_multi(X_train, Y_train);


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
    


