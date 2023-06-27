    tx = linspace(ax,bx,nx+1); ty = linspace(ay,by,ny+1);
    TIT = sprintf('%s-%d Error: Problem %d, n=%d',METHOD,order+2,problem,nx);
    FIG = sprintf('fig-%s-Error-P%d-n=%d-order-%d.png',...
            METHOD,problem,nx,order+2);

    figure, mesh(tx,ty,U2E-us2,'linewidth',2); axis ("tight");
    xlabel('x'); ylabel('y');
    title(TIT,'fontsize',15);

    print(FIG, "-dpng")

