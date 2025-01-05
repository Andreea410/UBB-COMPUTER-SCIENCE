% b. Assuming nothing is known about sigma, find a 100*(1-alpha)%
% confidence interval for the average number of files stored


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

% sigma is unknown -> second case
% sigma is the standard deviation
% In this case, sigma is the standard deviation of the sample (lecture 9 pag 4)
sigma = std(X);

% FORMULA FOR CASE 1.2
% miu in (xbar - sigma/sqrt(n)*t_{1-alpha/2}, xbar - sigma/sqrt(n)*t_{alpha/2}
% where
% t_{1-alpha/2}, t_{alpha/2} are quantiles referring to the T(n-1) distribution

% and now compute the quantiles referring to the T(n-1) distribution
t1 = tinv(1-alpha/2,n-1);
t2 = tinv(alpha/2,n-1);

% now compute the confidence limits
limit1 = xbar - sigma/sqrt(n)*t1;
limit2 = xbar - sigma/sqrt(n)*t2;

fprintf('The confidence interval for the average number of stored files is: (%6.3f,%6.3f)\n',limit1,limit2);

