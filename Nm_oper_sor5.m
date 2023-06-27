function [output] = Nm_oper_sor5(i,j,A5,u,b)
[m,n] = size(b);
            if i > 1 && i < m, if j > 1 && j < n
                sum4 = A5(1,i,j)*u(i,j-1) ...
                  +A5(2,i,j)*u(i-1,j) ...
                  +A5(4,i,j)*u(i+1,j) ...
                  +A5(5,i,j)*u(i,j+1);
                output = (b(i,j)-sum4)/A5(3,i,j);
            end, end

%             if i ==1, if j == 1
%                 sum4 = A5(4,i,j)*u(i+1,j) ...
%                       +A5(5,i,j)*u(i,j+1);
%                 output = (b(i,j)-sum4)/A5(3,i,j);
%                 correction = omega*(output - u(i,j));
%                 u(i,j) = u(i,j)+correction;
%                 err = max(err,abs(correction));
%             end,end

            if i == m, if j == 1
                sum4 = A5(2,i,j)*u(i-1,j) ...
                      +A5(5,i,j)*u(i,j+1);
                output = (b(i,j)-sum4)/A5(3,i,j);
            end, end

            if i == 1, if j == n
                sum4 = A5(1,i,j)*u(i,j-1) ...
                      +A5(4,i,j)*u(i+1,j);
                output = (b(i,j)-sum4)/A5(3,i,j);
            end,end
        
            % (m ,n)
            if i == m, if j == n
                sum4 = A5(1,i,j)*u(i,j-1) ...
                      +A5(2,i,j)*u(i-1,j);
                output = (b(i,j)-sum4)/A5(3,i,j);
            end, end

%             left-hand side
            if i ~= 1 && i ~= m, if j == 1
                sum4 = A5(2,i,j)*u(i-1,j) ...
                       +A5(4,i,j)*u(i+1,j) ...
                       +A5(5,i,j)*u(i,j+1);
                output = (b(i,j)-sum4)/A5(3,i,j);
            end,end
            
%             right-hand side
            if i ~= 1 && i ~= m, if j == n
                sum4 = A5(1,i,j)*u(i,j-1) ...
                      +A5(2,i,j)*u(i-1,j) ...
                      +A5(4,i,j)*u(i+1,j);
                output = (b(i,j)-sum4)/A5(3,i,j);
            end,end
            
%             up-hand side
            if i == 1, if j ~= 1 && j ~= n
                sum4 = A5(1,i,j)*u(i,j-1) ...
                      +A5(4,i,j)*u(i+1,j) ...
                      +A5(5,i,j)*u(i,j+1);
                output = (b(i,j)-sum4)/A5(3,i,j);
            end,end

%             down-hand side
            if i == m, if j ~= 1 && j ~= n
                sum4 = A5(1,i,j)*u(i,j-1) ...
                      +A5(2,i,j)*u(i-1,j) ...
                      +A5(5,i,j)*u(i,j+1);
                output = (b(i,j)-sum4)/A5(3,i,j);
            end,end

end