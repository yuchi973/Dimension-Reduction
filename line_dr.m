function line_dr(x,y)

n=size(x,1);
N=size(x,2);
B=zeros(n,N+1);
 
for i=1:n
    counter=0;
    %Add in the first order terms
    for q=1:N
        B(i,counter+1)=x(i,q);
        counter=counter+1;
    end
    %Add in the bias term
    B(i,N+1)=1;
end
%Perform LSS to find the coefficients    
k=lss(B,y);
%Recover the model    
   
counter=0;
crev=zeros(N,1);
for i=1:N
    crev(i)=k(counter+1);
    counter=counter+1;
end
drev=k(counter+1);
    
%Covariance matrix of gradient
cov=crev*crev';
[U,S,~] = svd(cov);

%Truncate the eigenvectors
U1=U(:,1:2);

plot3(x*U1(:,1),x*U1(:,2),y,'o');

end