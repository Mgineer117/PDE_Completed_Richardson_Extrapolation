function c = expand_grid_line(c,BC)
% function c = expand_grid_line(c,BC)
% Interpolation as in CR

[m,n] = size(c);

%%------------------------
% +
%%------------------------
for j=1:2:n, for i=2:2:m
   c(i,j) = ( c(i-1,j)+c(i+1,j) )/2;
end, end

for j=2:2:n, for i=1:2:m
   c(i,j) = ( c(i,j-1)+c(i,j+1) )/2;
end, end

for j=2:2:n-1, for i=2:2:m-1
   %c(i,j) = ( c(i-1,j)+c(i+1,j)+c(i,j-1)+c(i,j+1) )/4;
   c(i,j) = ( c(i-1,j)+c(i+1,j) )/2;  %the same as the above
end, end

