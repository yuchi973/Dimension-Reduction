clear all
%Specify the dimension
m=2;
%Specify the sample no.
N=20;
Xjhat=2*rand(N,m)-1;
%Generate model for y

%coeff=10*rand(m,1);
%bias=10*rand(1,1);
%y=Xjhat*coeff+bias;

y=zeros(N,1);
for i=1:N
    y(i)=exp(Xjhat(i,1))*exp(Xjhat(i,2));
end


%Generate upper and lower bounds
Xup=50*rand(N,m)+50;
Xlo=50*rand(N,m)-50;
%Generate updated samples
Xspl=((Xup-Xlo).*Xjhat+Xup+Xlo)/2;
%Generate the parameter matrix
Xhat=[ones(N,1),Xjhat];
%Perform LSS
a=lss(Xhat,y);
adash=a(2:m+1);
w=adash/norm(adash);
plot(Xjhat*w,y,'o');


