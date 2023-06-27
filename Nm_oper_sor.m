function [output] = Nm_oper_sor(i,j,A9,u,b)
[m,n] = size(b);
    if i > 1 && i < m, if j > 1 && j < n
            gs = b(i,j) ...
             -(A9(1,i,j)*u(i-1,j-1) +A9(2,i,j)*u(i-1,j) +A9(3,i,j)*u(i-1,j+1)...
              +A9(4,i,j)*u(i,j-1  )                     +A9(6,i,j)*u(i,j+1  )...
              +A9(7,i,j)*u(i+1,j-1) +A9(8,i,j)*u(i+1,j) +A9(9,i,j)*u(i+1,j+1) );
            output = gs/A9(5,i,j);
    end, end

    if i ==1, if j == 1
            gs = b(i,j) ...
             -(A9(1,i,j)*0      +A9(2,i,j)*0          +A9(3,i,j)*0 ...
              +A9(4,i,j)*0                            +2*A9(6,i,j)*u(i,j+1  )...
              +A9(7,i,j)*0      +2*A9(8,i,j)*u(i+1,j) +4*A9(9,i,j)*u(i+1,j+1) );
            output = gs/A9(5,i,j);
    end,end

    % (m, 1)
    if i == m, if j == 1
            gs = b(i,j) ...
             -(A9(1,i,j)*0      +2*A9(2,i,j)*u(i-1,j)  +4*A9(3,i,j)*u(i-1,j+1) ...
              +A9(4,i,j)*0                             +2*A9(6,i,j)*u(i,j+1  )...
              +A9(7,i,j)*0      +A9(8,i,j)*0           +A9(9,i,j)*0 );
            output = gs/A9(5,i,j);
    end, end

    % (1, n)
    if i == 1, if j == n
            gs = b(i,j) ...
             -(A9(1,i,j)*0                +A9(2,i,j)*0            +A9(3,i,j)*0 ...
              +2*A9(4,i,j)*u(i,j-1)                               +A9(6,i,j)*0 ...
              +4*A9(7,i,j)*u(i+1,j-1)     +2*A9(8,i,j)*u(i+1,j)   +A9(9,i,j)*0 );
            output = gs/A9(5,i,j);
    end,end

    % (m ,n)
    if i == m, if j == n
            gs = b(i,j) ...
             -(4*A9(1,i,j)*u(i-1,j-1)     +2*A9(2,i,j)*u(i-1,j)       +A9(3,i,j)*0 ...
              +2*A9(4,i,j)*u(i,j-1)                                   +A9(6,i,j)*0 ...
              +A9(7,i,j)*0                +A9(8,i,j)*0                +A9(9,i,j)*0 );
            output = gs/A9(5,i,j);
    end, end

%             left-hand side
    if i ~= 1 && i ~= m, if j == 1
            gs = b(i,j) ...
             -(A9(1,i,j)*0    +A9(2,i,j)*u(i-1,j)  +2*A9(3,i,j)*u(i-1,j+1)...
              +A9(4,i,j)*0                         +2*A9(6,i,j)*u(i,j+1  )...
              +A9(7,i,j)*0    +A9(8,i,j)*u(i+1,j)  +2*A9(9,i,j)*u(i+1,j+1) );
            output = gs/A9(5,i,j);
    end,end
    
%             right-hand side
    if i ~= 1 && i ~= m, if j == n
            gs = b(i,j) ...
             -(2*A9(1,i,j)*u(i-1,j-1) +A9(2,i,j)*u(i-1,j) +A9(3,i,j)*0 ...
              +2*A9(4,i,j)*u(i,j-1  )                     +A9(6,i,j)*0 ...
              +2*A9(7,i,j)*u(i+1,j-1) +A9(8,i,j)*u(i+1,j) +A9(9,i,j)*0 );
            output = gs/A9(5,i,j);
    end,end
    
%             up-hand side
    if i == 1, if j ~= 1 && j ~= n
            gs = b(i,j) ...
             -(A9(1,i,j)*0            +A9(2,i,j)*0          +A9(3,i,j)*0 ...
              +A9(4,i,j)*u(i,j-1  )                         +A9(6,i,j)*u(i,j+1  )...
              +2*A9(7,i,j)*u(i+1,j-1) +2*A9(8,i,j)*u(i+1,j) +2*A9(9,i,j)*u(i+1,j+1) );
            output = gs/A9(5,i,j);
    end,end

%             down-hand side
    if i == m, if j ~= 1 && j ~= n
            gs = b(i,j) ...
             -(2*A9(1,i,j)*u(i-1,j-1) +2*A9(2,i,j)*u(i-1,j)  +2*A9(3,i,j)*u(i-1,j+1)...
              +A9(4,i,j)*u(i,j-1  )                          +A9(6,i,j)*u(i,j+1  )...
              +A9(7,i,j)*0            +A9(8,i,j)*0           +A9(9,i,j)*0 );
            output = gs/A9(5,i,j);
    end,end

end