function [output] = Nm_oper_b(i,j,F)
[m,n] = size(F);
    if i > 1 && i < m, if j > 1 && j < n
        output = ( 8*F(i,j)+F(i-1,j)+F(i+1,j)+F(i,j-1)+F(i,j+1) )/12;
    end, end

    if i ==1, if j == 1
        output = ( 8*F(i,j)+2*F(i+1,j)+2*F(i,j+1) )/12;
    end,end

    % (m, 1)
    if i == m, if j == 1
        output = ( 8*F(i,j)+2*F(i-1,j)+2*F(i,j+1) )/12;
    end, end

    % (1, n)
    if i == 1, if j == n
        output = ( 8*F(i,j)+2*F(i+1,j)+2*F(i,j-1) )/12;
    end,end

    % (m ,n)
    if i == m, if j == n
        output = ( 8*F(i,j)+2*F(i-1,j)+2*F(i,j-1) )/12;
    end, end

%             left-hand side
    if i ~= 1 && i ~= m, if j == 1
        output = ( 8*F(i,j)+F(i-1,j)+F(i+1,j)+2*F(i,j+1) )/12;
    end,end
    
%             right-hand side
    if i ~= 1 && i ~= m, if j == n
        output = ( 8*F(i,j)+F(i-1,j)+F(i+1,j)+2*F(i,j-1) )/12;
    end,end
    
%             up-hand side
    if i == 1, if j ~= 1 && j ~= n
        output = ( 8*F(i,j)+2*F(i+1,j)+F(i,j-1)+F(i,j+1) )/12;
    end,end

%             down-hand side
    if i == m, if j ~= 1 && j ~= n
        output = ( 8*F(i,j)+2*F(i-1,j)+F(i,j-1)+F(i,j+1) )/12;
    end,end

end