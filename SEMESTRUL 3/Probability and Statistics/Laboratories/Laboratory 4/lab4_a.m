%2. Using a standard uniform random number generator, generate the common
%discrete probability distributions 

%a. Bernoulli Distribution - Bern(p), p in (0,1)
p = input("Input probability of success in (0,1): ");

if(p<0 || p>1)
    fprintf("Invalid value");
end


% Generate the Bernoulli distribution
N = input("Number of simulations: ") # how many trials

for i = 1:N
    U = rand;     # generate a nr between (0, 1)
    X(i) = (U<p); # it either returns 0 or 1 based on "U<p"(the nr generates needs tobe smaller than the given probability)
    # X is either failure or success, 0 or 1. It will also be an array
    end

# C = unique(A) returns the same data as in A, but with no repetitions. C is in sorted order.
UX = unique(X)
fr = hist(X, length(UX))
relative_frequency = fr/N