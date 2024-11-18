clc

n=3;
p=0.5;

S=input("number of simulations= ");

U=rand(n,S);
U=U<0.5
x=sum(U)

hist(x);
C=hist(x,n+1)/S