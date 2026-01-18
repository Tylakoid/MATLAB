close all 
clear all
%Design01
N = 200;
B = zeros(6);
C = [0;0;0;0;0;0];
T=readtable('Design01.csv');
data=table2array(T);
x=data(:,1);
y=data(:,2);
z=data(:,3);


%Inputting Matrix in Least Square Regression Equation
for i = 1:N
    B = B + [1 x(i) y(i) (x(i))^2 (y(i))^2 x(i)*y(i);
         x(i) (x(i))^2 y(i)*x(i) (x(i))^3 x(i)*(y(i))^2 y(i)*(x(i))^2;
         y(i) x(i)*y(i) (y(i))^2 y(i)*(x(i))^2 (y(i))^3 x(i)*(y(i))^2;
         (x(i))^2 (x(i))^3 y(i)*(x(i))^2 (x(i))^4 ((y(i))^2)*(x(i))^2 y(i)*(x(i))^3;
         (y(i))^2 x(i)*(y(i))^2 (y(i))^3 ((y(i))^2)*(x(i))^2 (y(i))^4 x(i)*(y(i))^3;
         x(i)*y(i) y(i)*(x(i))^2 x(i)*(y(i))^2 y(i)*(x(i))^3 x(i)*(y(i))^3 ((y(i))^2)*(x(i))^2];
end

for i = 1:N
    C = C + [z(i); x(i)*z(i); y(i)*z(i); z(i)*(x(i))^2; z(i)*(y(i))^2; x(i)*y(i)*z(i)];
end

%Solving for z_model using inverse
inverse_B = MyInverse(B);
z_model_coefficient = inverse_B*C;

x = linspace(-1,1,10);
y = linspace(-4,4,10);
[X,Y] = meshgrid(x,y);
z_model = @(X,Y) z_model_coefficient(1) + z_model_coefficient(2)*X + z_model_coefficient(3)*Y + z_model_coefficient(4)*X.^2 + z_model_coefficient(5)*Y.^2 + z_model_coefficient(6)*X.*Y+2;


%Integration value of Design01
Integration_value_1 = simpsons_double(z_model,-1,1,-1,1) 

close all
clear all
%Design02
N = 200;
B = zeros(6);
C = [0;0;0;0;0;0];
T=readtable('Design02.csv');
data=table2array(T);
x=data(:,1);
y=data(:,2);
z=data(:,3);


%Inputting Matrix in Least Square Regression Equation
for i = 1:N
    B = B + [1 x(i) y(i) (x(i))^2 (y(i))^2 x(i)*y(i);
         x(i) (x(i))^2 y(i)*x(i) (x(i))^3 x(i)*(y(i))^2 y(i)*(x(i))^2;
         y(i) x(i)*y(i) (y(i))^2 y(i)*(x(i))^2 (y(i))^3 x(i)*(y(i))^2;
         (x(i))^2 (x(i))^3 y(i)*(x(i))^2 (x(i))^4 ((y(i))^2)*(x(i))^2 y(i)*(x(i))^3;
         (y(i))^2 x(i)*(y(i))^2 (y(i))^3 ((y(i))^2)*(x(i))^2 (y(i))^4 x(i)*(y(i))^3;
         x(i)*y(i) y(i)*(x(i))^2 x(i)*(y(i))^2 y(i)*(x(i))^3 x(i)*(y(i))^3 ((y(i))^2)*(x(i))^2];
end

for i = 1:N
    C = C + [z(i); x(i)*z(i); y(i)*z(i); z(i)*(x(i))^2; z(i)*(y(i))^2; x(i)*y(i)*z(i)];
end

%Solving for z_model using inverse
inverse_B = MyInverse(B);
z_model_coefficient = inverse_B*C;

x = linspace(-1,1,100);
y = linspace(-4,4,100);
[X,Y] = meshgrid(x,y);
z_model = @(X,Y) z_model_coefficient(1) + z_model_coefficient(2)*X + z_model_coefficient(3)*Y + z_model_coefficient(4)*X.^2 + z_model_coefficient(5)*Y.^2 + z_model_coefficient(6)*X.*Y+2;


%Integration value of Design02
Integration_value_2 = simpsons_double(z_model,-1,1,-1,1) 




function [integration_y] = simpsons_double(f,x0,x2, y0,y2) %Where f is a function in terms of two variables
    x = linspace(x0,x2,7);
    delta_x = x(2)-x(1);
    integration_x = @(y) (delta_x/3)*(f(x0,y)+4*f(x(2),y)+2*f(x(3),y)+4*f(x(4),y)+2*f(x(5),y)+4*f(x(6),y)+f(x2,y));

    y1 = linspace(y0,y2,7);
    delta_y = y1(2)-y1(1);
    integration_y = (delta_y/3)*(integration_x(y0)+4*integration_x(y1(2))+2*integration_x(y1(3))+4*integration_x(y1(4))+2*integration_x(y1(5))+4*integration_x(y1(6))+integration_x(y2));
end


function [Ainv] = MyInverse(A)
    [n,n]=size(A);
    C= eye(n);
    Ainv = zeros(n);
    [L,U]=LUDecomposition(A);
    for i = 1:n
        R=LowerTriangularSolver(L,C(:,i));
        X=UpperTriangularSolver(U,R);
        Ainv(:,i) = X;
    end
end

function [L,U]=LUDecomposition(A)
[n,n]=size(A);
L=zeros(n,n);
U=zeros(n,n);

for i=1:n
    L(i,1)=A(i,1);
end
for j=2:n
    U(1,j)=A(1,j)/L(1,1);
end

for j=2:n
    for i=j:n
        sum=0;
        for k=1:j-1
            sum=sum+L(i,k)*U(k,j);
        end
        L(i,j)=A(i,j)-sum;
    end
        
    for k=j+1:n
        sum=0;
        for i=1:j-1
            sum=sum+L(j,i)*U(i,k);
        end
        U(j,k)=(A(j,k)-sum)/L(j,j);
    end
end

for i=1:n
   U(i,i)=1.0; 
end
end

function x=UpperTriangularSolver(A,C)
[n,n]=size(A); % Finding the size of the problem
x=zeros(n,1); % set up  x vector with elements initially set to zero
x(n)=C(n)/A(n,n);
 for i=n-1:-1:1
    sum=0;
    for j=i+1:n
        sum=sum+A(i,j)*x(j);
    end
    x(i)=(C(i)-sum)/A(i,i);
end
end

function x=LowerTriangularSolver(A,C)
[n,n]=size(A); % Finding the size of the problem
x=zeros(n,1); % set up  x vector with elements initially set to zero
x(1)=C(1)/A(1,1);
for i=2:n
    sum=0;
    for j=1:i-1
        sum=sum+A(i,j)*x(j);
    end
    x(i)=(C(i)-sum)/A(i,i);
end
end