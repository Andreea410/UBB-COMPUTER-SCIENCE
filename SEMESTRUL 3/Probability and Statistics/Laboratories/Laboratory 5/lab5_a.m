% A. Correlation and regression
% frequency distribution of X and Y are

X = [20*ones(1,2),21,22*ones(1,3),23*ones(1,6),24*ones(1,5),25*ones(1,9),26*ones(1,2),27*ones(1,2)];
Y = [75*ones(1,3),76*ones(1,2),77*ones(1,2),78*ones(1,5),79*ones(1,8),80*ones(1,8),81,82];

% a. find the means of X and Y

meanX = mean(X);
meanY = mean(Y);

fprintf("The mean of X = %3.4f \n",meanX);
fprintf("The mean of Y = %3.4f \n",meanY);

%b. the variances sigma^2_X and sigma^2_Y 

varX = var(X);
varY = var(Y);

fprintf("The variance of X = %3.4f \n",varX);
fprintf("The variance of Y = %3.4f \n",varY);

%c. the covariance cov(X,Y)

fprintf("The covariance of X and Y: ");
covXY = cov(X,Y)
fprintf("\n");

%d. the correlation coefficient ro_{XY} 
% corcoeff(x,y) = cov(x,y)/sqrt(varx*vary)

fprintf("The correlation coefficient of X and Y is: ");
correlation_coefficient = corrcoef(X,Y)