function ue = expand_spline(u,Inter)
% function ue = expand_spline(u,Inter)

[m,n] = size(u);
x =1:m; y =1:n;
xi = linspace(1,m, 2*m-1); yi = linspace(1,n, 2*n-1);
[xxi,yyi] = ndgrid(xi,yi);

ue = interpn(x,y,u,xxi,yyi,Inter);

