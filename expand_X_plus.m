function c = expand_X_plus(c,BC)
% function c = expand_X_plus(c,BC)
% Interpolation as in CR

[m,n] = size(c);

%%------------------------
% X
%%------------------------
for j=2:2:n-1, for i=2:2:m-1
   c(i,j) = ( c(i-1,j-1)+c(i+1,j-1)+c(i-1,j+1)+c(i+1,j+1) )/4;
end, end

%%------------------------
% +
%%------------------------
for j=2:2:n-1, for i=1:2:m
   if i == 1
        c(i,j) = ( 2*c(i+1,j)+c(i,j-1)+c(i,j+1) )/4;
   elseif i == m
        c(i,j) = ( 2*c(i-1,j)+c(i,j-1)+c(i,j+1) )/4;
   else
        c(i,j) = ( c(i-1,j)+c(i+1,j)+c(i,j-1)+c(i,j+1) )/4;
   end
end, end

for j=1:2:n, for i=2:2:m-1
   if j == 1
       c(i,j) = ( c(i-1,j)+c(i+1,j)+2*c(i,j+1) )/4;
   elseif j == n
       c(i,j) = ( c(i-1,j)+c(i+1,j)+2*c(i,j-1) )/4;
   else
       c(i,j) = ( c(i-1,j)+c(i+1,j)+c(i,j-1)+c(i,j+1) )/4;
   end
end, end

