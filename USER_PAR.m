%% Set Parameters
%%---------------------------------------------------------------
global ax bx ay by
global omega tol itmax

problem = 3;
order = 2;
nx= 64; ny=nx;
tol=1.e-14; itmax=35000;
omega=1.90;  %nx=50: 1.89; nx=100: 1.94; nx=200: 1.97
OM32 = [1.45 1.70 1.825];  %nx=ny=32

BC = [1, 0, 0, 0];  %==1: Dirichlet; ==2: No flux

level = 2;
iCR = 1;
%%---------------------------------------------------------------
if problem == 1
    ang_freq = 2*pi;
    ax=0; bx=1.; ay=0; by=1.;
    true_u = @(x,y) (exp(-x).*sin(ang_freq*y));
    source = @(x,y) (ang_freq^2-1)*true_u(x,y);
       %true_u = @(x,y) (cos(ang_freq*x).*cos(ang_freq*y));
       %source = @(x,y) (2*ang_freq^2)*true_u(x,y);
elseif problem == 2
    ang_freq = 2*pi;
    ax=0; bx=2.; ay=0; by=1.;
    true_u = @(x,y) (sin(ang_freq*x)+cos(ang_freq*y));
    source = @(x,y) (ang_freq^2)*true_u(x,y);
        %true_u = @(x,y) (sin(ang_freq*x).*cos(ang_freq*y));
        %source = @(x,y) (2*ang_freq^2)*true_u(x,y);
elseif problem == 3
    syms x y

    ang_freq = 2*pi;
    ax=0; bx=1.; ay=0; by=1.;
    true_u(x,y) = cos(ang_freq*x).*cos(2*ang_freq*y);
    source = -1 * laplacian(true_u); 
    
    source = matlabFunction(source);
    true_u = matlabFunction(true_u);
    clear x y
end
