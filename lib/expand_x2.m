function ux2 = expand_x2(A2,b2,u1,true_u,source)
% function ux2 = expand_x2(A2,b2,u1,true_u,source)

global ax bx ay by

[m,n] = size(u1);
nx = 2*(m-1); ny = 2*(n-1);
hx2 = ((bx-ax)/nx)^2; hy2 = ((by-ay)/ny)^2;
h2  = hx2+hy2;

U = util_Poisson.mesh_values(true_u,nx,ny);
f = util_Poisson.mesh_values(source,nx,ny);

ux2 = zeros(nx+1,ny+1);
ux2(1:2:end,1:2:end) = u1;

%%--- boundary
ux2(1,:) = U(1,:); ux2(nx+1,:) = U(nx+1,:);
ux2(:,1) = U(:,1); ux2(:,ny+1) = U(:,ny+1);

%%--- expand for "Center of Cells", using xross u-values
for j = 2:2:ny, for i = 2:2:nx
    sum4u = ux2(i-1,j-1)+ux2(i+1,j-1) + ux2(i-1,j+1)+ux2(i+1,j+1);
    ux2(i,j)= (sum4u+ h2*f(i,j))/4;
end,end

%%--- expand for "Mid of Edges"
% vertical edges
for j = 2:2:ny, for i = 3:2:nx
    ux2(i,j)= (b2(i,j) -ux2(i,j-1)*A2(1,i,j) ...
             -ux2(i-1,j)*A2(2,i,j) -ux2(i+1,j)*A2(4,i,j) ...
                      -ux2(i,j+1)*A2(5,i,j)  )/A2(3,i,j);
        %sum4u = ux2(i-1,j)+ux2(i+1,j) + ux2(i,j-1)+ux2(i,j+1);
        %ux2(i,j)= (sum4u+ hx2*f(i,j))/4;
end,end
% horizontal edges
for j = 3:2:ny, for i = 2:2:nx
    ux2(i,j)= (b2(i,j) -ux2(i,j-1)*A2(1,i,j) ...
             -ux2(i-1,j)*A2(2,i,j) -ux2(i+1,j)*A2(4,i,j) ...
                      -ux2(i,j+1)*A2(5,i,j)  )/A2(3,i,j);
end,end

