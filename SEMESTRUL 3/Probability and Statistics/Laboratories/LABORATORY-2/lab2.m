clear all
clc

%   ;-is used so the output won t be shown
n=input("Number of trails: ");
p=input("Probability of succes: ");

k=0:n;
px=binopdf(k,n,p);
kreal=0:0.01:n;
fx=binocdf(kreal,n,p);

plot(k,px,'*');
hold on;
plot(kreal,fx);
title("The binomial model");
legend("pdf","cdf");
hold off;





