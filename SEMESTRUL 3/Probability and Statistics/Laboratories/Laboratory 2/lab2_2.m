# A coin is tossed 3 times. Let X denote the number of heads that appear.

# ------------------------------------------------------------------------------------------
# a) Find the probability distribution function of X. What type of distribution 
# does X have?

# HOW TO SOLVE A)?
# - the trials are independent (tossing now doesn't affect the toss in the future)
# - each trial has only 2 possible outcomes (success and failure) (p = 0.5)
# - the probability of success is the same for each trial (because you just toss a coin)
# "Given 3 Bernoulli trials with probability of success 0.5, find the probability P(3,k) of exactly k successes" -> it works with Binomial model
# it is a binomial distribution (see lecture 4): "Given 3 Bernoulli trials withprobability of success 0.5, let X denote the nr of successes"
# If we were to solve it on a paper, it will look like this: (calculations below)
# The pdf looks like: X = ( 0     1     2     3     ) (See Lecture 3 pages 7 and 8)
#                         ( 0.125 0.375 0.375 0.125 )
# (See formula on Lecture 2 pag 7 (1.7)): 
# P(3, 0) = 1 * (0.5)^0 * (0.5)^3 = 0.125
# P(3, 1) = 3 * (0.5)^1 * (0.5)^2 = 0.375
# P(3, 2) = 3 * (0.5)^2 * (0.5)^2 = 0.375
# P(3, 3) = 1 * (0.5)^3 * (0.5)^0 = 0.125
# Add them up: 0.125+0.375+0.375+0.125 = 1 => it's ok
# We can either make this calculations, or just use octave and plot the result:

x = 0:3                # "something = x:y:z" means that something is between [x,z] and y is the step, so x will be 0, 1, 2, 3
p = binopdf(x, 3, 0.5) # y = binopdf(x,n,p) computes the binomial probability density function at each of the values in x using the corresponding number of trials in n and probability of success for each trial in p.
subplot(2, 1, 1);      # subplot(m,n,p) divides the current figure into an m-by-n grid and creates axes in the position specified by p
stem(x, p, 'b');       # stem(X,Y) plots the data sequence, Y, at values specified by X. stem(___,LineSpec) specifies the line style, marker symbol, and color.('b'=blue)
hold on;               # hold on retains plots in the current axes so that new plots added to the axes do not delete existing plots.


# ------------------------------------------------------------------------------------------
# b) Find the cumulative distribution function of X, FX.

# HOW TO SOLVE B) ?
# we don;t have binomial cdf formula in the lectures.
p2 = binocdf(x, 3, 0.5) # y = binocdf(x,n,p) computes a binomial cumulative distribution function at each of the values in x using the corresponding number of trials in n and the probability of success for each trial in p.
subplot(2, 1, 2);
stairs(x, p2, 'k');

# ------------------------------------------------------------------------------------------
# c) Find P(X = 0) and P(X != 1). <-- x = something is pdf

p3 = binopdf(0, 3, 0.5)     # P(X = 0)
p4 = 1 - binopdf(1, 3, 0.5) # P(X != 1)
#fprintf('p3 = %f', p3)

# ------------------------------------------------------------------------------------------
# d) Find P(X <= 2), P(X < 2).  <-- x <= something is cdf

p5 = binocdf(2, 3, 0.5)                      # P(X <= 2)
p6 = binocdf(2, 3, 0.5) - binopdf(2, 3, 0.5) # P(X < 2) = P(X <= 2) - P(X = 2)

# ------------------------------------------------------------------------------------------
# e) Find P(X >= 1), P(X > 1).
p7 = 1 - binocdf(1, 3, 0.5)                        # P(x > 1) = 1 - P(x <= 1)
p8 = 1 - (binocdf(1, 3, 0.5) - binopdf(1, 3, 0.5)) # P(x >= 1) = 1 - P(x < 1) = 1 - (P(x <= 1) - P(x = 1))


