function quad_dr(x,y)

n=size(x,1);
N=size(x,2);
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
[U,S,~] = svd(cov);

%Truncate the eigenvectors
U1=U(:,1:2);

plot3(x*U1(:,1),x*U1(:,2),y,'o');

end
