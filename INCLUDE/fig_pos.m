function POS=fig_pos(POS,shift)
% POS=fig_pos(POS,shift);

%% Initialization
if nargin == 1, shift=350; end
%POS0=[100 600 500 400];
%%-----------------

POS(1) = POS(1)+shift;
if POS(1)>1300
   POS(1)=75; POS(2)=POS(2)-shift;
end

