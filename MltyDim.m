clear all
%Define dimension and data points
N=5;
n=100;
%Start generating model
A=0.25*ones(N,N);
A(1,1)=3;
A(2,2)=2;
A(3,3)=2;
A(4,4)=1;
A(5,5)=4;
%A=eye(N);
%c=10*rand(N,1)-5;
%d=10*rand(1,1);
c=zeros(N,1);
d=5;
y=zeros(n,1);
x=10*rand(n,N);
%Now start generating data
for i=1:n
    xtemp=x(i,:)';
    y(i,1)=xtemp'*A*xtemp+c'*xtemp+d;
end
    
%Now start processing the data generated

B=zeros(n,0.5*N^2+1.5*N+1);
 
for i=1:n
    counter=0;
    %Add in the second order terms
    for j=1:N
        for l=j:N
            B(i,counter+1)=x(i,j)*x(i,l);
            counter=counter+1;
        end
    end
    %Add in the first order terms
    for q=1:N
        B(i,counter+1)=x(i,q);
        counter=counter+1;
    end
    %Add in the bias term
    B(i,0.5*N^2+1.5*N+1)=1;
end
%Perform LSS to find the coefficients    
k=lss(B,y);
%Recover the model    
Arev=zeros(N,N);    
counter=0;
for i=1:N
    for j=i:N
        Arev(i,j)=Arev(i,j)+0.5*k(counter+1);
        Arev(j,i)=Arev(j,i)+0.5*k(counter+1);
        counter=counter+1;
    end
end
crev=zeros(N,1);
for i=1:N
    crev(i)=k(counter+1);
    counter=counter+1;
end
drev=k(counter+1);
    
%Covariance matrix of gradient
cov=2/3*Arev*Arev+crev*crev';
[U,S,V] = svd(cov);

%Truncate the eigenvectors
U1=U(:,1:2);

plot3(x*U1(:,1),x*U1(:,2),y,'o');
colorbar


    
