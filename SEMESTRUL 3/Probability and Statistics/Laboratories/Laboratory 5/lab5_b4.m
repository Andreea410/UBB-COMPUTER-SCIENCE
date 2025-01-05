% It is thought that the gas mileage obtained by a particular model of automo-
% bile will be higher if unleaded premium gasoline is used in the vehicle rather than
% regular unleaded gasoline. To gather evidence in this matter, 10 cars are randomly se-
% lected from the assembly line and tested using a specified brand of premium gasoline;
% 10 others are randomly selected and tested using the brand's regular gasoline. Tests
% are conducted under identical controlled conditions and gas mileages for both types
% of gas are assumed independent and (approximately) normally distributed.
% The data results are given

%   Premium            Regular
% 22.4  21.7    |    17.7  14.8 
% 24.5  23.4    |    19.6  19.6 
% 21.6  23.3    |    12.1  14.8 
% 22.4  21.6    |    15.4  12.6 
% 24.8  20.0    |    14.0  12.2  

% a. Assuming sigma_1 = sigma_2, find a 100*(1 - alpha)% confidence
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


% ---- CASE 3.2 ----
% for the difference of two population means, miu1-miu2, for large samples
% (n1+n2 > 40) or normal underlying populations, independent samples
% sigma1, sigma2 unknown (the standard deviations) and equal

% FORMULA: 
% miu1-miu2 in (xbar_1 - xbar_2 - t_{1-alpha/2}*s_p*sqrt(1/n1+1/n2) ,
% xbar_1 - xbar_2 + t_{1-alpha/2}*s_p*sqrt(1/n1+1/n2) )
% where the quantiles refer to the T(n1+n2-2) distribution
% s_p^2 = ((n1-1)*s_1^2 + (n2-1)*s_2^2))/(n1+n2-2);
% s_1^2, s_2^2 are the sample variances


% compute the sample variances for s_p
var1 = var(X1);
var2 = var(X2);

% now compute s_p
sp = sqrt(((n1-1)*var1 + (n2-1)*var2)/(n1+n2-2));

% compute the quantile
t1 = tinv(1-alpha/2,n1+n2-2);

% and the limits of the confidence interval
limit1 = xbar1 - xbar2 - t1*sp*sqrt(1/n1+1/n2);
limit2 = xbar1 - xbar2 + t1*sp*sqrt(1/n1+1/n2);

fprintf('The confidence interval for the difference of true means is: (%6.3f,%6.3f)\n',limit1, limit2);