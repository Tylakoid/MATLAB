close all 
clear all
%Variables
E = 2.5e7;
I = 610;
S = 1000;
l = 120;
a=0;
b=0;
q = 5;
delta = 24; %Change delta as needed
nodes = l/delta;
A_matrix = zeros(nodes+1,nodes+1);
Q = zeros(nodes+1,1);
Q(1) = 0;
A_matrix(1,1) = 1;

%Defining the matrices in our equation
a = 1/delta^2;
b = (-2/delta^2) - S/(E*I);
r = 1/delta^2;
x(2) = delta;

for y = 2:nodes
    A_matrix(y,y-1) = a;
    A_matrix(y,y) = b;
    A_matrix(y,y+1) = r;
    x(y+1) = x(y) + delta;
    Q(y) = (q/(2*E*I))*x(y)*(x(y)-l);
end
Q(nodes+1) = 0;
A_matrix(nodes+1,nodes+1) = 1;

%Solving system
Y_matrix = MyInverse(A_matrix)*Q;

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