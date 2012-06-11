% Diese Funktion fuehrt den Spielzug durch.
% 
% PARAMETER:
% ==========
%   board: 8x8 Matrix, aktuelles Spielfeld vor Spielzug.
%   col: Farbe des gesetzten Steins.
%   ValidPositions_linear: Positions des gesetzten Steins.
%
%  R�ckgabe: 
%  boardNew: 8x8 Matrix, neues aktuelles Spielfeld nach Spielzug
%
% Das Feld wird folgendermassen durchnummeriert:
%
% +----+----+----+----+----+----+----+----+
% |  1 |  9 |    |    |    |    |    |    |
% +----+----+----+----+----+----+----+----+
% |  2 | 10 |    |    |    |    |    |    |
% +----+----+----+----+----+----+----+----+
% |  3 | 11 |    |    |    |    |    |    |
% +----+----+----+----+----+----+----+----+
% |  4 |....|    |    |    |    |    |    |
% +----+----+----+----+----+----+----+----+
% |  5 |    |    |    |    |    |    |    |
% +----+----+----+----+----+----+----+----+
% |  6 |    |    |    |    |    |    |    |
% +----+----+----+----+----+----+----+----+
% |  7 |    |    |    |    |    |    |    |
% +----+----+----+----+----+----+----+----+
% |  8 |    |    |    |    |    |    |    |
% +----+----+----+----+----+----+----+----+

function [ boardNew ] = Spielzug_druchfuehren_01( board, col, ValidPositions_linear)




tic;

% Umrechung in zweidimensionale Koordinaten:
divMatrix = 8;
if rem(ValidPositions_linear,divMatrix) == 0;
    y = ValidPositions_linear / divMatrix;
    x = 8;
else
    y = ValidPositions_linear / divMatrix;
    y = fix(y);
    x = ValidPositions_linear - (8*y);
    y = y+1; 
end

Dir = [  0  1;...
         0 -1;...
         1  0; ...
        -1  0; ...
         1  1; ...
        -1 -1; ...
         1 -1; ...
        -1  1; ...
        ];
    
    
boardNew = board;
boardNew(x,y) = col;
for dir = 1:8 % richtung auswählen
    Step_in_dir = Dir(dir,:);
    Neighbour = [x + Step_in_dir(1), y+Step_in_dir(2)];

    if max(Neighbour) > 8 | min(Neighbour) < 1
        continue % vom Rand gefallen, nächste Richtung
    end

    if board(Neighbour(1), Neighbour(2)) == -col
        % Wir haben einen -col als Nachbar
        run = true;
        Next = Neighbour;
        while run
            Next = Next + Step_in_dir;
            if max(Next) > 8 | min(Next) < 1
                run = false;
                break;
            end
            if board(Next(1), Next(2)) == col
                % freies Feld gefunden
                previous = Next - Step_in_dir;
                run2 = true;
                while run2 
                    % steinchen umdrehen
                    boardNew(previous(1),previous(2)) = col; 
                    if previous == Neighbour;
                        run2 = false;
                    else
                        previous = previous - Step_in_dir;
                    end
                end
                run = false;
             elseif board(Next(1), Next(2)) == 0
                run = false;
            end
        end
    end
end
 
toc;   
end
