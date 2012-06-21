% @brief dirty little helper - no doc for that ugly snippet.
function GC_plotWrapper(board, title)
color = 1;
set (gcf, 'Name', title);
clf;
[mine_coord_row, mine_coord_col] = find(board == color);
[opponent_coord_row, opponent_coord_col] = find(board == -color);
opponent_coord = [opponent_coord_row';opponent_coord_col']; % row 1: row coord, row 2: col coord.
mine_coord = [mine_coord_row'; mine_coord_col']; 
GC_plotBoard(mine_coord, opponent_coord);
end

% @brief Quick and dirty plot of board.
% 
% @author Martin Becker
% @date 2010-Dec-25
%
%   @param disksMe a matrix 2-by-n. Row 1 is a set of row coords, row 2 is
%   a set of corresponding column coords.
%   @param disksOpponent same format as disksMe, but plotted in another
%   color
%   @param disksMark (optional) same as disksMe, but plotted in a third
%   color.
%   @param disksMark2 (optional) same as disksMark, but another color again
%   @param myTitle (optional) argument for the title of the figure
function GC_plotBoard(disksMe, disksOpponent, disksMark, disksMark2, myTitle)

if (nargin < 5), myTitle=''; end;
if (nargin < 4), disksMark2 = []; end;
if (nargin < 3), disksMark = []; end;
if (nargin < 2), disksOpponent=[]; end;
if (nargin < 1) 
    error('GC_plotBoard(): at least one argument is needed!');
end

plot(disksMe(2,:),disksMe(1,:), 'go', 'MarkerFaceColor','g');
if ~isempty(disksOpponent) 
    hold on;  % plot all disks
    plot(disksOpponent(2,:),disksOpponent(1,:), 'ro','MarkerFaceColor','r'); 
end
if ~isempty(disksMark)
    hold on;
    plot(disksMark(2,:), disksMark(1,:), 'ksquare', 'MarkerFaceColor','k'); 
end;
if ~isempty(disksMark2)
    hold on;                                               % reference disk
    plot(disksMark2(2,:), disksMark2(1,:) , 'kx', 'MarkerSize',20); 
end

hold on;                        
plot([.5 8.5 8.5 .5 .5], [.5 .5 8.5 8.5 .5], 'k', 'LineWidth', 5);    % board boundaries
set(gca,'YDir','reverse');
set(gca, 'xaxisLocation','top');
set(gca,'xtickLabel',{'', 'A','B','C','D','E','F','G','H'});
set(gca,'DataAspectRatio',[1 1 1]);
grid on;
xlim([0 9]);
ylim([0 9]);
title(myTitle);

end