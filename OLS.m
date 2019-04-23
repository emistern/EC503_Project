%Ordinary Least Squares regression not for classification
function [m,b] = OLS(Xtrain,ytrain)
    [n,~]=size(Xtrain);
    % make a design matrix where first column is ones
    X_design = [ones(n,1), Xtrain];
    mat_inv = pinv(X_design'*X_design);
    w_ols = mat_inv*X_design'*ytrain; 
    b = w_ols(1);
    m = w_ols(2:length(w_ols));
end