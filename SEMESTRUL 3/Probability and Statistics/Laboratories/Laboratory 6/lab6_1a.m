% Lab6 - Hypothesis and significance testing for means and variances

% find the rejection rejection, the value of the test statistic and the
% P-value of the test. Make it clear what H0 and H1 are and interpret the
% result in words.

% 1. In a study of the size of various computer systems, the random variable
% X, the number of files stored is considered. 

% a. Assuming that past experience indicates that sigma=5, at the 5%
% significance level, does the data suggest that the standard is met? What
% about at 1%?

% average number => CI for a population mean, miu

% H0 - the null hypothesis
% H0: the standard is met(it stores at least 9 on avg)
% H0: miu = 9 
% H1 - the research hypothesis
% H1: the standard is not met
% H1: miu < 9 
% => we perform a left-tailed test 
fprintf("We are doing a left-tailed test for the mean (sigma known)\n");


% alpha is the significance level -> 5%
alpha = 0.05
% alpha =0.01;

% data set
x = [7, 7, 4, 5, 9, 9, 4, 12, 8, 1, 8, 7, 3, 13, 2, 1, 17, 7,...
   12, 5, 6, 2, 1, 13, 14, 10, 2, 4, 9, 11, 3, 5, 12, 6, 10, 7];
n = length(x);

%the standard deviation -> it is known
sigma = 5; 

% declare the value of the known parameter
M0 = 9;

% we want to perform a test for the population mean, the second case, 
% with a large sample(n>30) snd sigma known => ztest as TT in N(0,1)

% ztest -> test for the mean of a population(theta=miu), the case where sigma is known
% INPUT : x = the data sample 
%         m0 = the population mean
%         sigma = the standard deviation
%         alpha = the significance level
%         tail = right 
% OUTPUT: H = indicator which tells us if we reject or do not reject H_0
%         P = critical value of the test (p-value)
%         CI = confidence interval
%         statistics(z val) = TS_0 TS when theta = theta0. If TS_0 is in RR => reject H0.


[H,P,CI,statistics] = ztest(x, M0, sigma, 'alpha', alpha, 'tail', 'left');

% result of the test, h = 0, if H0 is NOT rejected,
% h = 1, if H0 IS rejected
fprintf('\n H is %d', H)
if H == 1 
    fprintf('\nSo the null hypothesis is rejected,\n')
    fprintf('i.e. the data suggests that the standard IS NOT met.\n')
else
    fprintf('\nSo the null hypothesis is not rejected,\n')
    fprintf('i.e. the data suggests that the standard IS  met.\n')
end   

% build the rejection region
% RR = (-inf, tt_alpha) (because left tail)
% tt_alpha is the quantile for the normal distribution
tt_alpha = norminv(alpha);
RR = [-inf, tt_alpha]; % vector with 2 positions 


% print statistics, P and RR on the screen
fprintf('\nThe rejection region is (%4.4f, %4.4f)\n', RR)
fprintf('The value of the test statistic z is %4.4f\n', statistics)
fprintf('The P-value of the test is %4.4f\n\n', P)




% output for significance level alpha = 0.05
% We are doing a left-tailed test for the mean (sigma known)

% H is 1
% So the null hypothesis is rejected,
% i.e. the data suggests that the standard IS NOT met.
 
% The rejection region is (-Inf, -1.6449)
% The value of the test statistic z is -2.2667
% The P-value of the test is 0.0117

% do the same when alpha = 0.01 (1%)

% We are doing a left-tailed test for the mean (sigma known)

% H is 0
% So the null hypothesis is not rejected,
% i.e. the data suggests that the standard IS  met.

% The rejection region is (-Inf, -2.3263)
% The value of the test statistic z is -2.2667
% The P-value of the test is 0.0117