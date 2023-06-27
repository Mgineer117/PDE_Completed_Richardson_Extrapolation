    tx = linspace(ax,bx,nx/2+1); ty = linspace(ay,by,ny/2+1);
    TIT = sprintf('%s-%d Error: Problem %d, n=%d',METHOD,order+2,problem,nx/2);
    FIG = sprintf('fig-%s-Error-P%d-n=%d-order-%d.png',...
            METHOD,problem,nx/2,order+2);

    figure, mesh(tx,ty,U1E-us1,'linewidth',2); axis ("tight");
    xlabel('x'); ylabel('y');
    title(TIT,'fontsize',15);

    print(FIG, "-dpng")

