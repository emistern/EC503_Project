% Regression with regularization parameter lambda
% In lecture, formulation had n*lambda. in book p64, no n
function [m,b] = Ridge_Regression(Xtrain,ytrain,lambda)
    [n,d]=size(Xtrain);
    % make a design matrix where first column is ones
    X_design = [ones(n,1), Xtrain];
    reg_term = eye(d+1)*lambda;
    mat_inv = pinv(X_design'*X_design+reg_term);
    B = mat_inv*X_design'*ytrain; 
    b = B(1);
    m = B(2:length(B));
end