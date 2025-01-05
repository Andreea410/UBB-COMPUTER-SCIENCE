% It is thought that the gas mileage obtained by a particular model of 
% automobile will be higher if unleaded premium gasoline is used in the 
% vehicle rather than regular unleaded gasoline. To gather evidence in 
% this matter, 10 cars are randomly selected from the assembly line and 
% tested using a specified brand of premium gasoline; 10 others are 
% randomly selected and tested using the brand's regular gasoline. Tests 
% are conducted under identical controlled conditions and gas mileages 
% for both types of gas are assumed independent and (approximately) 
% normally distributed. These data result

%   Premium            Regular
% 22.4  21.7    !    17.7  14.8 
% 24.5  23.4    !    19.6  19.6 
% 21.6  23.3    !    12.1  14.8 
% 22.4  21.6    !    15.4  12.6 
% 24.8  20.0    !    14.0  12.2  
% Let 0 < alpha < 1.

% a. At the alpha significance level, is there evidence that the variances
% of the two populations are equal?
% b. Based on the result in part  a., at the same significance level, 
% does gas mileage seem to be higher, on average, when premium gasoline 
% is used?

% data sets
x_premium = [22.4, 21.7, 24.5, 23.4, 21.6, 23.3, 22.4, 21.6, 24.8, 20.0]
x_regular = [17.7, 14.8, 19.6, 19.6, 12.1, 14.8, 15.4, 12.6, 14.0, 12.2]

n1 = length(x_premium);
n2 = length(x_regular);
  
% the significance level is 5% => alpha = 0.05
alpha = 0.05;

%a

% H0 - the null hypothesis
% H0: the variances of the two populations are equal
% H0: sigma_premium^2 = sigma_regular^2  
% H1 - the research hypothesis
% H1: the variances of the two populations are not equal
% H1: sigma_premium^2 != sigma_regular^2 
% => we perform a two-tailed test 
fprintf("We perform a two-tailed test for the ratio of two population variances\n");

% we want to perform a test for the ratio of two population variances
% => vartest2 as TT in F(n_1-1, n_2-1)


% vartest2 -> test for the ratio of two population variances
% INPUT : x1 = the first data sample 
%         x2 = the second data sample 
%         alpha = the significance level
% OUTPUT: H = indicator which tells us if we reject or do not reject H_0
%         P = critical value of the test (p-value)
%         CI = confidence interval
%         statistics = TS_0 TS when theta = theta0. If TS_0 is in RR => reject H0.

[H, P, CI, stats] = vartest2(x_premium, x_regular,"alpha", alpha);


% result of the test, h = 0, if H0 is NOT rejected,
% h = 1, if H0 IS rejected
fprintf('\n H is %d', H)
if H == 1
  fprintf('\n So the null hypothesis is rejected, \n')
  fprintf('i.e the data suggests that the variances of the two populations are not equal')
else
  fprintf('\nSo the null hypothesis is not rejected,\n')
  fprintf('i.e. the data suggests that the variances of the two populations are equal.\n')
end  

% building the rejection region
% RR = (-inf, tt_{alpha/2}) U (tt_{1-alpha/2},inf) since it's a two-tailed test
% tt_alpha is the quantile for the F(n_1-1, n2_-1) distribution

tt_alpha1 = finv(alpha/2, n1-1, n2-1)
tt_alpha2 = finv(1-alpha/2, n1-1, n2-1)
RR1 = [-inf, tt_alpha1]
RR2 = [tt_alpha2, inf] % vector with 2 positions

% print ZVAL, P and RR on the screen
fprintf('\nThe rejection region is (%4.4f, %4.4f) U (%4.4f, %4.4f)\n', RR1, RR2);
fprintf('The value of the test statistic z is %4.4f\n', stats.fstat);
fprintf('The P-value of the test is %4.4f\n\n', P);


