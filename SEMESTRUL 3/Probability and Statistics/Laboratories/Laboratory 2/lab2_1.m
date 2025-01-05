# Plot the graphs of the pdf and the cdf of a random variable X having a binomial
# distribution of parameters n and p (given by the user).

n = input("Input number of values: ")
p = input("Input probability: ")

values = 0:1:n;
y = binopdf(values, n, p);
subplot(2, 1, 1);
plot(values, y, 'r*');

values2 = 0: 0.001: n;
z = binocdf(values2, n, p);
subplot(2, 1, 2);
plot(values2, z);