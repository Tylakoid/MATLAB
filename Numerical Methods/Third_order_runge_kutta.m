close all
clear all
%variables
delta = 1;
t = 0:delta:8;
N = length(t);
%initial condition
x(1) = 0;

for n = 1:N-1
    k1 = 1-x(n);
    k2 = 1-(x(n) + (delta*k1)/2);
    k3 = 1 - (x(n) - delta*k1 + 2*delta*k2);
    x(n+1) = x(n) + (k1/6 + 4*k2/6 + k3/6)*delta;
end


plot(t, x, '-o')
xlabel('t')
ylabel('x(t)')
title('RK3 Solution of dx/dt = 1 - x')
grid on
