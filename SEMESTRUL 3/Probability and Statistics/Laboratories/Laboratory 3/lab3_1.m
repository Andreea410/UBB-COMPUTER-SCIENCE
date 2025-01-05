% ------------- Normal distribution
mu=input('mu(in R)= ');
sigma=input('sigma(>0)= ');
alpha = input("alpha = ");
beta = input("beta = ");

# a) P(X <= 0) and P(X >= 0);
pa1 = normcdf(0, mu, sigma);
pa2 = 1 - pa1;  % P(X >= 0) = 1 - P(X <= 0)

# b) P(-1 <= X <= 1) and P(X <= -1 or X >= 1); 
# P(-1 <= X <= 1) = P(x <= 1) - P(X < -1) = P(X <= 1) - P(x < -1)
pb1=normcdf(1,mu,sigma)-normcdf(-1,mu,sigma);
# P( X <= -1 or X >= 1) = 1 - P(-1 <= X <= 1)
pb2 = 1 - pb1

# c) P(X < x_alpha) = alpha
# x = norminv(p,mu,sigma) returns the inverse of the normal cdf with mean mu and standard deviation sigma, evaluated at the probability values in p.
pc1 = norminv(alpha, miu, sigma)

# d) P(X > x_beta) = beta
pd1 = norminv(1 - beta, miu, sigma)

# ------------------ t Distribution
n = input("Degrees of freedom = ");
alpa = input("Alpha = ");
beta = input("Beta = ");
# a) P(X <= 0) and P(X >= 0);
pa3 = tcdf(0, n)
pa4 = 1-pa3;

# b) P(-1 <= X <= 1) = P(x <= 1) - P(X < -1) = P(X <= 1) - P(x < -1) 
pb3 = tcdf(1, n) - tcdf(-1, n)

# P(X<= -1 or x >= 1) = 1 - P(-1 <= X <= 1)
pb4 = 1 - pb3

# c) P(X < x_alpha) = alpha
pc2 = tinv(alpha, n)

# d) P(X > x_beta) = beta
pd2 = tinv(1 - beta, n)

#-------------------------- x=x^2(n)
n = input("Degrees of freedom = ");
alpa = input("Alpha = ");
beta = input("Beta = ");

# a) P(X <= 0)
pa1 = chi2cdf(0, n)
# P(X >= 0) = 1 - P(X <= 0)
pa2 = 1 - chi2cdf(0, n)

# b) P(-1 <= X <= 1) = P(x <= 1) - P(X < -1) = P(X <= 1) - P(x < -1) 
pb1 = chi2cdf(1, n) - chi2cdf(-1, n)

# P(X<= -1 or x >= 1) = 1 - P(-1 <= X <= 1)
pb2 = 1 - pb1

# c) P(X < x_alpha) = alpha
ansc = chi2inv(alpha, n)

# d) P(X > x_beta) = beta
ansd = chi2inv(1 - beta, n)

#---------------------------- Fischer
n = input("Degrees of freedom numerator = ");
m = input("Degrees of freedom denumerator = ");
alpa = input("Alpha = ");
beta = input("Beta = ");

# a) P(X <= 0)
pa1 = fcdf(0, n, m)
# P(X >= 0) = 1 - P(X <= 0)
pa2 = 1 - fcdf(0, n, m)

# b) P(-1 <= X <= 1) = P(x <= 1) - P(X < -1) = P(X <= 1) - P(x < -1) 
pb1 = fcdf(1, n, m) - fcdf(-1, n, m)

# P(X<= -1 or x >= 1) = 1 - P(-1 <= X <= 1)
pb2 = 1 - pb1

# c) P(X < x_alpha) = alpha
ansc = finv(alpha, n, m)

# d) P(X > x_beta) = beta
ansd = finv(1 - beta, n, m)