% c. Assuming the number of stored files are approximately normally
% distributed, find 100*(1-alpha)% confidence intervals for the variance
% and standard deviation


% data sample 
X = [7 7 4 5 9 9 ...
   4 12 8 1 8 7 ...
   3 13 2 1 17 7 ...
   12 5 6 2 1 13 ...
   14 10 2 4 9 11 ...
   3 5 12 6 10 7];

% xbar is the mean, n is the size of the sample
n = length(X);
xbar = mean(X);

% 1 - alpha is called confidence level/confidence coefficient
% alpha     is the significance level
% 1 - alpha = confidence level => alpha = 1 - confidence level
alpha = 1 - input("Input the confidence level: ");


% FORMULA FOR CASE 2
% population variance in ( (n-1)*variance / x_{1-alpha/2}, (n-1)*variance / x_{alpha/2})
% where
% x_{1-alpha/2}, x_{alpha/2} are quantiles referring to the X^2(n-1) distribution

% compute the SAMPLE variance
variance = var(X);

% compute the chi square distributions X^2(n-1)
chi1 = chi2inv(1-alpha/2, n-1);
chi2 = chi2inv(alpha/2, n-1);

% now compute the confidence interval for the variance
limit1v = (n-1)*variance/chi1;  % x_{1-alpha/2}
limit2v = (n-1)*variance/chi2;  % x_{alpha/2}

fprintf('The confidence interval for the variance is: (%6.3f,%6.3f)\n',limit1v,limit2v);

% and for the standard deviation
fprintf('The confidence interval for the standard deviation is: (%6.3f,%6.3f)\n',sqrt(limit1v), sqrt(limit2v));

