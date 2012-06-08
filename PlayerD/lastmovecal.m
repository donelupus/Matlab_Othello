function [lmove ] = lastmovecal(acttable, lasttable)

%LASTMOVE Summary of this function goes here
%   Detailed explanation goes here

difftable = abs(acttable - lasttable);
if sum(max(difftable,[],1)) ~= 0
[row, col] = find(difftable == 1,1);
col = char(col+96);        
lmove.row = row;
lmove.col = col;
else
lmove.row = 0;
lmove.col = 0;
end

end

