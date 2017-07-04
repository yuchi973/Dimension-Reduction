function k=lss(A,b)

    [m,n]=size(A);
    [Q,R,P]=qr(A);
    R=R(1:n,1:n);
    mat=Q'*b;
    c=mat(1:n);
    d=mat(n-1:m);
    y=R\c;
    k=P*y;

end