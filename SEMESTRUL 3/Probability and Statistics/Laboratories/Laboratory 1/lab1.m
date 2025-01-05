A = [1,0,-2;2,1,3;0,1,0]
B = [2,1,1;1,0,-1;1,1,0]
C = A-B
D = A*B
E = A.*B
disp(E)
%For x e [0; 3], graph on the same set of axes the functions x^5/10, x sin x and cos x,
%in different colors and linestyles. Display a title and a legend on your graph. Then
%plot them on different pictures, but in the same window.

x = linspace(0,3,100) %vector
f1 = x.^5/10; 
f2 = x.*sin(x);
f3 = cos(x);

figure(1);
plot(x,f1)
hold on
plot(x,f2);
plot(x,f3);
hold off;
title('Functions Plot');
legend('x^5/10','x sin(x)','cos(x)');
xlabel('x');
ylabel('f(x)');
