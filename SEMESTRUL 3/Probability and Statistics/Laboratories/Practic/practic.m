clc
clear all

% A food store owner receives 1-liter water bottles from two suppliers.
% After some complaints from customers, he wants to check the accuracy
% of the weights of 1-liter water bottles. He finds the following
% weights(the two populations are approximately normally distributed):

%            !                            Heat loss                            !
% Supplier A ! 1021 980 1017 988 1005 998 1014 985 995 1004 1030 1015 995 1023 !
% Supplier B ! 1070 970 993 1013 1006 1002 1014 997 1002 1010 975              !
% -----------------------------------------------------------------------------

% a. At the 5% significance level, do the population variances seem to differ?
A = [1021, 980, 1017, 988, 1005, 998, 1014, 985, 995, 1004, 1030, 1015, 995, 1023];
B = [1070, 970, 993, 1013, 1006, 1002, 1014, 997, 1002, 1010, 975];
n1 = length(A);
n2 = length(B);
alpha = 0.05;
tail = 0;
% H0 : varA = varB
% H1 : varA != varB
% => two-tailed test
% test variances => vartest2
[H, P, CI, STATS] = vartest2(A, B, alpha, tail);
fprintf("a)\n");
fprintf("H = %d\n", H);
if H == 1
    fprintf("The hypothesis is rejected, \n")
    fprintf(" the two populations variances seem to differ.\n")
else
    fprintf("The hypothesis is NOT rejected, \n")
    fprintf(" the two populations variances seem to be the same.\n")
end

tt_alpha1 = finv(alpha/2, n1-1, n2-1);
tt_alpha2 = finv(1-alpha/2, n1-1, n2-1);
RR1 = [-inf, tt_alpha1];
RR2 = [tt_alpha2, inf]; 

fprintf('\nThe rejection region is (%4.4f, %4.4f) U (%4.4f, %4.4f)\n', RR1, RR2);
fprintf('The value of the test statistic z is %4.4f\n', STATS.fstat);
fprintf('The P-value of the test is %4.4f\n\n', P);

% Find a 95% significance interval for the difference of the average weights

mean_A = mean(A); %returns the average weight
mean_B = mean(B); %returns the average weight
var_A = var(A); % calculates the variances
var_B = var(B);

SE = sqrt(var_A/n1 + var_B/n2); %we calculate the standard error to measure how much the samples are expected to vary

df = ((var_A/n1 + var_B/n2)^2) / ((var_A^2 / (n1^2 * (n1 - 1))) + (var_B^2 / (n2^2 * (n2 - 1)))); %The degrees of freedom 
% help determine the appropriate critical value from the t-distribution.

t_critical = tinv(1 - alpha/2, df); % calculates the critical value from the t-distribution

diff_mean = mean_A - mean_B;
CI = diff_mean + [-1, 1] * t_critical * SE; %calculates the confidence interval


fprintf("b)\n");
fprintf("The 95%% confidence interval for the difference of the average weights is: [%.4f, %.4f]\n", CI(1), CI(2));
