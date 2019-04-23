%Ordinary Least Squares regression not for classification
function yguess = OLS(Xtrain,ytrain,Xtest)
    [m,~]=size(Xtrain);
    % make a design matrix where first column is ones
    X_design = [ones(m,1), Xtrain];
    mat_inv = pinv(X_design'*X_design);
    b = mat_inv*X_design'*ytrain; 
    b_0 = b(1);
    b = b(2:length(b));
    yguess = b_0 + Xtest*b;
end