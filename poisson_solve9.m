function [A9,b,ucomp,iter] = poisson_solve9(true_u,source,BC,nx,ny,level,uguess)

    %%---------------------------------------------------------------
    %% True solution: for "Boundary assignement" and "Error analysis"
    %%---------------------------------------------------------------
    U = util_Poisson.mesh_values(true_u,nx,ny);

    %%---------------------------------------------------------------
    %% Algebraic System
    %%---------------------------------------------------------------
    [A9,b] = util_Poisson.algbraic_system9(source,nx,ny,BC);

    %%---------------------------------------------------------------
    %% Initialization
    %%---------------------------------------------------------------
    if nargin==7
        u0 = uguess;
    else
        u0 = zeros(size(b));
    end
    u0 = util_Poisson.set_bdry_values(u0,U,BC);

    %%---------------------------------------------------------------
    %% Solve
    %%---------------------------------------------------------------
    [ucomp,iter] = sor_A9(A9,b,u0,level);

    %%---------------------------------------------------------------
    %% Display Error
    %%---------------------------------------------------------------
    E8 = norm(U(:)-ucomp(:),inf); E2 = norm(U(:)-ucomp(:),2)/sqrt(nx*ny);
    fprintf('  (nx,ny)=(%3d,%3d); iter=%d; (L2,L8)-error = (%.3g , %.3g)\n',...
            nx,ny,iter,E2,E8); 
end
