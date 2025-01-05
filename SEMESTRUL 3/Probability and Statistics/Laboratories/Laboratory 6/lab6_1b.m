% b. Without the assumption on sigma, does the data suggest that, on average, the number
% of files stored exceeds 5.5? (same significance level)

% H0 - the null hypothesis
% H0: the number of files stored does not exceed 5.5
% H0: miu = 5.5
% H1 - the research hypothesis
% H1: miu > 5.5 (the number of files stored exceeds 5.5
% => we perform a right-tailed test 
fprintf("We are doing a right-tailed test for the mean with sigma unkown\n");

% alpha is the significance level -> 5%
alpha = 0.05

% data set
x = [7, 7, 4, 5, 9, 9, 4, 12, 8, 1, 8, 7, 3, 13, 2, 1, 17, 7,...
   12, 5, 6, 2, 1, 13, 14, 10, 2, 4, 9, 11, 3, 5, 12, 6, 10, 7];
   
% we want to perform a test for the population mean, the second case, 
% with a large sample but sigma unknown => ttest as TT in T(n-1)

% we know miu (the avg stored files)
miu = 5.5

% ttest -> test for the mean of a population(theta=miu), the case where sigma is unknown
% INPUT : x = the data sample 
%         miu = the population mean
%         alpha = the significance level
%         tail = right 
% OUTPUT: H = indicator which tells us if we reject or do not reject H_0
%         P = critical value of the test (p-value)
%         CI = confidence interval
%         statistics = TS_0 TS when theta = theta0. If TS_0 is in RR => reject H0.
[H,P,CI,statistics] = ttest(x, miu, 'alpha', alpha, 'tail', 'right');

% result of the test, h = 0, if H0 is NOT rejected,
% h = 1, if H0 IS rejected
fprintf('\n H is %d', H)
if H == 1
  fprintf('\n So the null hypothesis is rejected, \n')
  fprintf('i.e the data suggests that the number of files exceeds 5.5')
else
  fprintf('\nSo the null hypothesis is not rejected,\n')
    fprintf('i.e. the data suggests that the number of files stored does not exceed 5.5.\n')
end  

% building the rejection region
% RR = (tt_{1-alpha},inf) since it's a right-tailed test
% tt_alpha is the quantile for the T(n-1) distribution
tt_alpha = tinv(1-alpha, n-1)
RR = [tt_alpha, inf] % vector with 2 positions

fprintf('\nThe rejection region is (%4.4f, %4.4f)\n', RR);
fprintf('The value of the test statistic z is %4.4f\n', statistics.tstat);
fprintf('The P-value of the test is %4.4f\n\n', P);

