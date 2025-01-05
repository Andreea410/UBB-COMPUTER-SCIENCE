% b. assuming sigma_1 != sigma_2, find a 100*(1 - alpha)% confidence
% interval for the difference of the true means

% data samples
X1 = [22.4, 21.7,24.5,23.4,21.6,23.3,22.4,21.6 ,24.8,20.0];
X2 = [17.7, 14.8,19.6, 19.6, 12.1, 14.8,15.4, 12.6,14.0 ,12.2];
  
% compute the size of the samples and their means
n1 = length(X1);
xbar1 = mean(X1);

n2 = length(X2);
xbar2 = mean(X2);

% find alpha by entering a value of the confidence level
% alpha = 1 - confidence level
alpha = 1 - input("Input the confidence level: ");

% ---- CASE 3.3 ----
% for the difference of two population means, miu1-miu2, for large samples
% (n1+n2 > 40) or normal underlying populations, independent samples
% sigma1, sigma2 unknown (the standard deviations) and NOT equal

% FORMULA: 
% miu1-miu2 in (xbar1 - xbar2 - t_{1-alpha/2}*sqrt(s_1^2/n1 + s_1^2/n2),
% xbar1 - xbar2 + t_{1-alpha/2}*sqrt(s_1^2/n1 + s_1^2/n2) )
% where the quantiles refer to the T(n) distribution
% 1/n = c^2/(n1-1) + (1-c)^2/(n_2-1)
% c = (s_1^2/n1)/(s_1^2/n1 + s_2^2/n2);
% s_1^2, s_2^2 are the variances of the sample


% compute the sample variances
var1 = var(X1);
var2 = var(X2);

% compute c and n
c = (var1/n1)/(var1/n1+var2/n2);
n = 1/((c^2/(n1-1) + (1-c)^2/(n2-1)));

% and now the quantiles referring to the T(n) distribution
t1 = tinv(1-alpha/2, n);

% compute the limits of the confidence interval
limit1 = xbar1 - xbar2 - t1*sqrt((var1/n1)+(var2/n2));
limit2 = xbar1 - xbar2 + t1*sqrt((var1/n1)+(var2/n2));

fprintf('The confidence interval for the difference of true means is: (%6.3f,%6.3f)\n',limit1, limit2);