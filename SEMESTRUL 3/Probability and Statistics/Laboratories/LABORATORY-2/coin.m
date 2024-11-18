clc
clear all

%a
n=3;
p=0.5;

k=0:n;
px=binopdf(k,n,p);


%b
kreal=0:0.01:n;
fx=binocdf(kreal,n,p);

%plot(kreal,fx);
%title("the binomial model");
%legend("cdf");

%c
fprintf("c)\nP(x=0)=%.3f\n",binopdf(0,n,p));
n=1-binopdf(1,n,p);
fprintf("c)\nP(x!=1)=%.3f\n",n);

%d
fprintf("d)\nP(x<=2)=%.3f\n",binocdf(2,n,p));



