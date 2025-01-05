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

%b

% H0 - the null hypothesis
% H0: The gas mileage is not higher, on average, when premium gasoline is used
% H0: miu_premium = miu_regular 
% H1 - the research hypothesis
% H1: The gas mileage seem to be higher, on average, when premium gasoline
% H1: miu_premium > miu_regular 
% => we perform a right-tailed test 
fprintf("We perform a right-tailed test for the difference of two population means\n");

% we want to perform a test for the difference of two population means,
% based on a), the standard deviations are equal so the second case
% => ttest2 as TT in T(n_1+n_2-2)


% ttest2 -> test for the mean of a population(theta=miu), the case where sigma is unknown
% INPUT : x1 = the first data sample 
%         x2 = the second data sample 
%         alpha = the significance level
%         tail = right 
% OUTPUT: H = indicator which tells us if we reject or do not reject H_0
%         P = critical value of the test (p-value)
%         CI = confidence interval
%         statistics = TS_0 TS when theta = theta0. If TS_0 is in RR => reject H0.
[H,P,CI,statistics] = ttest2(x_premium, x_regular, 'alpha', alpha, 'tail', 'right');

% result of the test, h = 0, if H0 is NOT rejected,
% h = 1, if H0 IS rejected
fprintf('\n H is %d', H)
if H == 1 
    fprintf('\nSo the null hypothesis is rejected,\n')
    fprintf('i.e. the data suggests that the gas mileage is higher when premium gasoline is used.\n')
else
    fprintf('\nSo the null hypothesis is not rejected,\n')
    fprintf('i.e. the data suggests that the gas mileage is not higher when the premium gasoline is used.\n')
end


% building the rejection region
% RR = (-inf, tt_{alpha/2}) U (tt_{1-alpha/2},inf) since it's a two-tailed test
% tt_alpha is the quantile for the F(n_1-1, n2_-1) distribution

tt_alpha = tinv(1-alpha, n1+n2-2)
RR = [tt_alpha, inf]% vector with 2 positions

% print ZVAL, P and RR on the screen
fprintf('\nThe rejection region is (%4.4f, %4.4f)\n', RR);
fprintf('The value of the test statistic z is %4.4f\n', statistics.tstat);
fprintf('The P-value of the test is %e\n', P);

