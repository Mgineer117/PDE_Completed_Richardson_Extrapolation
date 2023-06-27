%%===============================================================
% Smooth Interpolation: Expansion first
%%===============================================================
ue = expand_spline(u0,Inter);
us1 = (1/(2^order-1))*(2^order * u1 - ue);
Es1 = norm(U1E(:)-us1(:),inf);
fprintf(' Expansion first, %s (nx,ny)=(%3d,%3d); L8-error= %.3g\n',...
          Inter,nx/2,ny/2,Es1);
%-----------------------
ue = expand_spline(u1,Inter);
us2 = (1/(2^order-1))*(2^order * u2 - ue);
Es2 = norm(U2E(:)-us2(:),inf);
fprintf(' Expansion first, %s (nx,ny)=(%3d,%3d); L8-error= %.3g\n',...
          Inter,nx,ny,Es2);
    fprintf(2,'                    Their L8-error Ratio = %.3f\n',Es1/Es2)
hline;

