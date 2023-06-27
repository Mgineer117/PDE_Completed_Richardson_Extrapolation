function u = sor5_expand_oper_ave(u,A5,b,omega,tol,itmax)
% function u = sor5_expand_oper_ave(u,A5,b,omega,tol,itmax)

[m,n] = size(u);

for iter =1:itmax
    err=0;
    for j=2:n-1, for i=2:m-1
        if ( mod(i,2)==0 || mod(j,2)==0 )
            gs = - ( A5(1,i,j)*u(i,j-1) +A5(2,i,j)*u(i-1,j) ...
                    +A5(4,i,j)*u(i+1,j) +A5(5,i,j)*u(i,j+1) )/A5(3,i,j);
            correction = omega*(gs - u(i,j));
            u(i,j) = u(i,j)+correction;
            err = max(err,abs(correction));
        end
    end,end
    if err<tol,
        fprintf('  sor5_expand_oper_ave: done @ iter = %d\n',iter);
    break; end

end
