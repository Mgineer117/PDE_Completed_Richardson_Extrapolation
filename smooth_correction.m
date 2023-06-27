function cs = smooth_correction(u0,u1,order,Inter,BC)
% function cs = smooth_correction(u0,u1,Inter,BC)
% input: u0: coarse grid solution
%        u1: fine grid solution
%        order: the order of current solutions
%        Inter: Interpolation methods: "spline", "cubic", "pchip"
%                Octave: only "spline"

%%---------------------------
c0 = (1/(2^order-1))*(u1(1:2:end,1:2:end)-u0);
cs = expand_spline(c0,Inter);

