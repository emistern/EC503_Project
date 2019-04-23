% Regression with regularization parameter lambda
% In lecture, formulation had m*lambda. in book p64, no m
function yguess = Ridge_Regression(Xtrain,ytrain,Xtest,lambda)
    [m,~]=size(Xtrain);
    % make a design matrix where first column is ones
    X_design = [ones(m,1), Xtrain];
    reg_term = eye(m)*lambda*m;
    mat_inv = pinv(X_design'*X_design+reg_term);
    b = mat_inv*X_design'*ytrain; 
    b_0 = b(1);
    b = b(2:length(b));
    yguess = b_0 + Xtest*b;
end