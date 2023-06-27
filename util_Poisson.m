classdef util_Poisson, methods(Static)
%================================================

function F = mesh_values(f,nx,ny)
    global ax bx ay by
    x = linspace(ax,bx,nx+1); y = linspace(ay,by,ny+1);
    [X,Y] = meshgrid(x,y);
    F = f(X',Y');
end

function [A,b] = algbraic_system5(source,nx,ny,BC)
    global ax bx ay by
    %-------------------------
    h2 = ((bx-ax)/nx)^2;
    b = h2*util_Poisson.mesh_values(source,nx,ny);
    %-------------------------
    A = zeros(5,nx+1,ny+1);
    for j = 1:ny+1, for i = 1:nx+1
        A(:,i,j) =[-1,-1,4,-1,-1];
    end,end
    %--- BC: No flux ----------
    i=1;    A(4,i,:) = A(4,i,:)+A(2,i,:); A(2,i,:) =0;
    i=nx+1; A(2,i,:) = A(2,i,:)+A(4,i,:); A(4,i,:) =0;
    j=1;    A(5,:,j) = A(5,:,j)+A(1,:,j); A(1,:,j) =0;
    j=ny+1; A(1,:,j) = A(1,:,j)+A(5,:,j); A(5,:,j) =0;
end

function [A,b] = set_Dirichlet(A,b,BC,U)
    [m,n] = size(b);
    if BC(1)==1, i=1; A(:,i,:)=0; A(3,i,:)=1; b(i,:)=U(i,:); end
    if BC(2)==1, i=m; A(:,i,:)=0; A(3,i,:)=1; b(i,:)=U(i,:); end
    if BC(3)==1, j=1; A(:,:,j)=0; A(3,:,j)=1; b(:,j)=U(:,j); end
    if BC(4)==1, j=n; A(:,:,j)=0; A(3,:,j)=1; b(:,j)=U(:,j); end
end

function u0 = set_bdry_values(u0,U,BC)
    if BC(1)==1, u0(1,1)   = U(1,1); end
    if BC(2)==1, u0(end,1) = U(end,1); end
    if BC(3)==1, u0(end,end)   = U(end,end); end
    if BC(4)==1, u0(1,end) = U(1,end); end
end

function b = eval4_rhs(source,nx,ny)
    F = util_Poisson.mesh_values(source,nx,ny);
    b = F;
    %w = [1 10 1]/12; wgt = w'*w;
    for j = 1:ny+1, for i = 1:nx+1
        %b(i,j) = sum(sum( F(i-1:i+1,j-1:j+1).*wgt ));
        b(i,j) = Nm_oper_b(i,j,F);
    end,end
end

function [A,b] = algbraic_system9(source,nx,ny,BC)
    global ax bx ay by
    %-------------------------
    hx2 = ((bx-ax)/nx)^2; hy2 = ((by-ay)/ny)^2;
    gam2 = hx2/hy2;
    %-------------------------
    c = 10*(1+gam2); sn=gam2-5; we=1-5*gam2; d=-(1+gam2)/2;
    %-------------------------
    A = zeros(9,nx+1,ny+1);
    for j = 1:ny+1, for i = 1:nx+1
        A(:,i,j) =[d, sn, d,  we, c, we,  d, sn, d];
    end,end
    %--------------------------
    b = util_Poisson.eval4_rhs(source,nx,ny);
    b = (6*hx2)*b;
end

%================================================
end,end

