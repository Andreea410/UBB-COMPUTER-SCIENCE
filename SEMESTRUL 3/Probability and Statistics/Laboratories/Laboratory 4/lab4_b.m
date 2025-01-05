% generate the Binomial distribution
% hint: a Bino(n,p) variable is the sum of n independent Bern(p) variables

% generate a discrete random variable X

n = input("Input number of trials: ");
p = input("Input p in (0,1): ");

U = rand(n,1); % return n values, one for each Bern(p) variable
disp(U)
X = sum(U<p) % compute the sum of the n independent Bern(p) variables
             % knowing a variable Bern(p) = U < p
             
disp(X)

% generate the Binomial distribution
N = input("Input number of simulations: ");

for i = 1:N
    U = rand(n,1);
    X(i) = sum(U<p);
end

U_X = unique(X) %extract the unique values of X
frequency = hist(X, length(U_X))
relative_frequency = frequency/N

% do a graphic comparison between the simulation and the distribution
% itself
xpdf = 0:n;
ypdf = binopdf(xpdf, n, p);

tiledlayout(3,1);

nexttile
plot(xpdf, ypdf, "*");
title("Binomial distribution");

nexttile
plot(U_X, relative_frequency, "o");
title("Binomial simulation");