clear all;  % removes all variables, globals, and functions.
close all;  % closes all the open figure windows.
%clc;        % clear the Command Window
format compact; format long

try, pkg load image; end %octave
%%---------------------------------------------------------------
%% Read User Parameters && Setting
%%---------------------------------------------------------------
if ~exist('hline'), path(path,'./INCLUDE'); end
USER_PAR;
    fprintf("Domain=[%g,%g]x[%g,%g]; (nx,ny)=(%d,%d)\n",ax,bx,ay,by,nx,ny)
    fprintf("  order=%d; problem=%d; omega=%g; tol=%g; itmax=%d\n",...
               order,problem,omega,tol,itmax);
    hline
Inter = "spline";

%%---------------------------------------------------------------
%% Exact values, for comparisons
%%---------------------------------------------------------------
U0E = util_Poisson.mesh_values(true_u,nx/4,ny/4);
U1E = util_Poisson.mesh_values(true_u,nx/2,ny/2);
U2E = util_Poisson.mesh_values(true_u,nx,ny);

%%---------------------------------------------------------------
%% Poisson Solve
%%---------------------------------------------------------------
if order==2
        if nx==32, omega = OM32(1); end
    [A0,b0,u0,iter] = poisson_solve5(true_u,source,BC,nx/4,ny/4,level);
        uguess = expand_spline(u0,Inter);
        if nx==32, omega = OM32(2); end
    [A1,b1,u1,iter] = poisson_solve5(true_u,source,BC,nx/2,ny/2,level,uguess);
        uguess = expand_spline(u1,Inter);
        if nx==32, omega = OM32(3); end
    [A2,b2,u2,iter] = poisson_solve5(true_u,source,BC,nx,ny,level,uguess);
else
    [A0,b0,u0,iter] = poisson_solve9(true_u,source,BC,nx/4,ny/4,level);
        uguess = expand_spline(u0,Inter);
    [A1,b1,u1,iter] = poisson_solve9(true_u,source,BC,nx/2,ny/2,level,uguess);
        uguess = expand_spline(u1,Inter);
    [A2,b2,u2,iter] = poisson_solve9(true_u,source,BC,nx,ny,level,uguess);
end

%%---------------------------------------------------------------
%% Completed Richardson Extrapolation (CR)
%%---------------------------------------------------------------
if iCR, CR_Extrapolation; end

%%===============================================================
% Error before interpolation
%%===============================================================
RE = (1/(2^order-1))*(2^order*u1(1:2:end,1:2:end)-u0);
RE_E10 = norm(U0E(:)-RE(:),inf);
RE = (1/(2^order-1))*(2^order*u2(1:2:end,1:2:end)-u1);
RE_E21 = norm(U1E(:)-RE(:),inf);
hline
fprintf(' RE: Coarse Grid Error on Omega(4h,2h) = (%.3g, %.3g)\n',RE_E10,RE_E21)

%%===============================================================
% Smooth Interpolation: Extrapolation first
%%===============================================================
hline;
METHOD = 'SCI';

cs = smooth_correction(u0,u1,order,Inter,BC);
us1 = u1+cs;
    if level>=4, save_figure1; end
    Es1 = norm(U1E(:)-us1(:),inf);
    fprintf(' Extrapol first, %s (nx,ny)=(%3d,%3d); L8-error= %.3g\n',...
          Inter,nx/2,ny/2,Es1);
%-----------------------
cs = smooth_correction(u1,u2,order,Inter,BC);
us2 = u2+cs;
    if level>=2 && nx<=64, save_figure2; end
    Es2 = norm(U2E(:)-us2(:),inf);
    fprintf(' Extrapol first, %s (nx,ny)=(%3d,%3d); L8-error= %.3g\n',...
          Inter,nx,ny,Es2);
    fprintf(2,'                    Their L8-error Ratio = %.3f\n',Es1/Es2)

%%===============================================================
% Smooth Interpolation: Expansion first
%%===============================================================
%expansion_first;

%%===============================================================
% Recursive Application of Richardson, for Extra Accuracy
%%===============================================================
hline;
cs = smooth_correction(us1,us2,order+2,Inter,BC);
usR = us2+cs;
ERR = U2E-usR;
EsR = norm(ERR(:),inf);
fprintf(' Xta-Accuracy: %s interpol (nx,ny)=(%3d,%3d); L8-error= %.3g\n',...
        Inter,nx,ny,EsR);

margin=4; ERR0 = ERR(margin+1:end-margin,margin+1:end-margin);
EsR = norm(ERR0(:),inf);
fprintf('       @ interoir points, with margin = %d; L8-error= %.3g\n',...
        margin,EsR);


%%===============================================================
%% Figuring
%%---------------------------------------------------------------
if level>=3, figure, surf(u2), title('Computed u'); end
