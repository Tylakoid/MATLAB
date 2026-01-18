clear all;
close all;
Delta_t=1;
t=0:Delta_t:8.0;

%Preallocating memory
x=zeros(size(t));

%Initial condition
x(1)=0.0;
 
for n=1:length(t)-1
    dxdt = 1-x(n);
    x(n+1)=x(n) + (Delta_t)*(dxdt);
    t(n+1) = t(n) + Delta_t;
end
 
plot(t,x,'o-','linewidth',2,'Markersize',5)
hold on
xlabel('t');
ylabel('x');
axis([0 8 0 1])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Delta_t=0.5;
t=0:Delta_t:8.0;

%Preallocating memory
x=zeros(size(t));

%Initial condition
x(1)=0.0;
 
for n=1:length(t)-1
    dxdt = 1-x(n);
    x(n+1)=x(n) + (Delta_t)*(dxdt);
    t(n+1) = t(n) + Delta_t;
end
 
plot(t,x,'o-','linewidth',2,'Markersize',5)
hold on
xlabel('t');
ylabel('x');
axis([0 8 0 1])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Delta_t=0.1;
t=0:Delta_t:8.0;

%Preallocating memory
x=zeros(size(t));

%Initial condition
x(1)=0.0;
 
for n=1:length(t)-1
    dxdt = 1-x(n);
    x(n+1)=x(n) + (Delta_t)*(dxdt);
    t(n+1) = t(n) + Delta_t;
end
 
plot(t,x,'o-','linewidth',2,'Markersize',5)
hold on
xlabel('t');
ylabel('x');
axis([0 8 0 1])
legend("Delta t = 1","Delta t = 0.5", "Delta t = 0.1");
grid on
title("Explicit Euler Solution of dx/dt = 1-x")
