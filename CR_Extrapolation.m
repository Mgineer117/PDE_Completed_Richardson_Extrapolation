%%---------------------------------------------------------------
%% Completed Richardson Extrapolation (CR)
%%---------------------------------------------------------------
hline
METHOD = 'CR';

c = zeros(size(u1));
c(1:2:end,1:2:end) = (1/(2^order-1))*(u1(1:2:end,1:2:end)-u0);
cx = expand_X_plus(c,BC);
us1 = u1+cx;
    if level>=4, save_figure1; end
    E81x = norm(U1E(:)-us1(:),inf);
    fprintf(' CR-%d: (nx,ny)=(%3d,%3d); L8-error= %.3g\n',...
        order+2,nx/2,ny/2,E81x)

c = zeros(size(u2));
c(1:2:end,1:2:end) = (1/(2^order-1))*(u2(1:2:end,1:2:end)-u1);
cx = expand_X_plus(c,BC);
us2 = u2+cx;
    if level>=2 && nx<=64, save_figure2; end
    E82x = norm(U2E(:)-us2(:),inf);
    fprintf(' CR-%d: (nx,ny)=(%3d,%3d); L8-error= %.3g\n',...
           order+2,nx,ny,E82x)
    fprintf(2,'                    Their L8-error Ratio = %.3f\n',E81x/E82x)

%--- recursive -------
c = zeros(size(u2));
c(1:2:end,1:2:end) = (1/(2^(order+2)-1))*(us2(1:2:end,1:2:end)-us1);
cx = expand_X_plus(c,BC); u2R = us2+cx;
E2R = norm(U2E(:)-u2R(:),inf);
fprintf(' Recursive: CR-%d (nx,ny)=(%3d,%3d); L8-error= %.3g\n',...
          order+4,nx,ny,E2R);

