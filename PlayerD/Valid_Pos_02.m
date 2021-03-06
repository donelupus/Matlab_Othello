% Diese Funktion liefert eine Liste (Vektor) an gueltigen Spielzuegen.
% 
% PARAMETER:
% ==========
%   board: 8x8 Matrix, ein aktuelles Spielfeld.
%   col:   Unsere Spielfarbe, 1 oder -1
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

function [ ValidPositions_linear ] = Valid_Pos_02( board, col )

tic;
    i = 0;
    Already_Found = zeros(8,8);
    Dir = [  0  1;...
         0 -1;...
         1  0; ...
        -1  0; ...
         1  1; ...
        -1 -1; ...
         1 -1; ...
        -1  1; ...
        ];
    
    %Unsere Spielfarbe
%     col=1;
    ValidPositions = [-1,-1];
    for x_w = 1:8
        for y_w = 1:8
            board(x_w, y_w)
            if board(x_w, y_w) == col
                for dir = 1:8 % richtung auswaehlen
                   Step_in_dir = Dir(dir,:);
                   Neighbour = [x_w + Step_in_dir(1), y_w+Step_in_dir(2)];

                   if max(Neighbour) > 8 | min(Neighbour) < 1
                       continue % vom Rand gefallen, naechste Richtung
                   end

                   if board(Neighbour(1), Neighbour(2)) == -col
                       % Wir haben einen Schwarzen als Nachbar
                       run = true;
                       Next = Neighbour;
                       while run
                            Next = Next + Step_in_dir;
                            if max(Next) > 8 | min(Next) < 1
                                run = false;
                                break;
                            end
                            if board(Next(1), Next(2)) == 0
                                % Gueltige Position gefunden
                                if Already_Found(Next(1),Next(2)) == 0
                                    i = i+1;
                                    ValidPositions(i,1) = Next(1);
                                    ValidPositions(i,2) = Next(2);
                                    Already_Found(Next(1),Next(2)) = 1;
                                end
                                run = false;
                            elseif board(Next(1), Next(2)) == col
                                run = false;
                            end
                       end
                   end
                end
            end
        end
    end

        
    % Umrechnung der zweidimensionalen Koordinaten in lineare Koordinaten:
    n = size(ValidPositions,1);
    ValidPositions_linear = zeros(n,1);
    for i = 1:n
        ValidPositions_linear(i) = ValidPositions(i,1) + (ValidPositions(i,2)-1)*8;
    end
 
toc;   
end

