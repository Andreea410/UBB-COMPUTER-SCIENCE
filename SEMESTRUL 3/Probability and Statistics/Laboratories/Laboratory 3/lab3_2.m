# -------------- Normal
p = input("p = ") # p (0:05 <= p = 0:95)

for n = 1:20:500
    values = 1:n;
    bd = binopdf(values, n, p);
    subplot(2, 1, 1)
    plot(values, bd);
    nd = normpdf(values, n * p, sqrt(n * p *(1 - p)));
    subplot(2, 1, 2)
    plot(values, nd);
    pause(1);
    hold off;
endfor


# ---------- Poisson
n = input("n (>=30) = ")
p = input("p (<=0.05) = ")

val = 0:n;
bd = binopdf(val, n, p);
pd = poisspdf(val, n * p);

plot(val, bd);
hold on;
plot(val, pd);