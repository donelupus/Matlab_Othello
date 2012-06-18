% generiere Anfangs-Board:
clear all
clc

board = zeros(8,8);
board(4,4) = 1;
board(5,4) = -1;
board(4,5) = -1;
board(5,5) = 1;

col = 1;

board



for i=1:50
    disp('================ NEUER SPIELZUG =================')
    col
    if i == 1
        [ValPos, Store] = Valid_Pos_05(board, col, []);
    else
        [ValPos, Store] = Valid_Pos_05(board, col, [Store]);
    end
    if ValPos(1,1) == 0
        disp('SPIELENDE!')
        break;
    end
    board = Spielzug_durchfuehren_03(board, col, ValPos(1,:),Store);
    disp(['Spieler col=' num2str(col) ' zieht auf ' num2str(ValPos(1,:))])
    % board
    col = -col;
end
board