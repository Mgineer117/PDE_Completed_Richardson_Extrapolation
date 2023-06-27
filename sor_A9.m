function [u,iter] = sor_A9(A9,b,u0,level)
    global omega tol itmax
    [m,n] = size(u0); u = u0;

    %%--- Updata interior points --------------
    for iter = 1:itmax
        err = 0;
        for j=1:n, for i=1:m
            if i~=1 || j~=1
                gs = Nm_oper_sor(i,j,A9,u,b);

                correction = omega*(gs - u(i,j));
                u(i,j) = u(i,j)+correction;
                err = max(err,abs(correction));
            end
        end, end

        if err<tol,
            if level>=3, fprintf('  sor_A9: done @ iter = %d\n',iter); end
            break; end
    end
end

