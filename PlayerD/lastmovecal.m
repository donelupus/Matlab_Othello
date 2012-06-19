function [lmove,diagflag] = lastmovecal(acttable, lasttable,lmove,diagflag,color)

%LASTMOVE Summary of this function goes here
%   Detailed explanation goes here
%   Berechnet letzen Spielzug
%   Übergabe aktuelles Brett, letztes uns bekanntes Brett, letzer Zug,
%   Diagonalflag und aktuelle Farbe

    difftable = abs(acttable - lasttable);
    if sum(max(difftable,[],1)) ~= 0
        [lmove.row, lmove.col] = find(difftable == 1,1);    % finde den Wert == 1 --> hier war letzter Zug
        lmove.count = lmove.count + 1;                      % Zähle den Counter für den letzten Zug um eins hoch
        if lmove.count == 1                                 % falls lmove.count == 1 --> Gegner ist schwarz und hat begonnen 
            diagflag = calculatediag(lmove);                % damit muss das Diagonalflag berechnet werden
        end
    else
        lmove.row = 0;
        lmove.col = 0;
        lmove.count = lmove.count + 1;
    end
       
    %%% DEBUG
    %    str = sprintf('real %d%d \n',lmove.col,lmove.row);
    %    disp(str);
    %%% END DEBUG
    
    if diagflag ~= 0                                        % Diagonalflag ungleich 0 --> Umrechnung auf internen Wert      
        lastmovedez = lmove.col*10+lmove.row;               % bezüglich D3
        buffer = calculatenewmove(lastmovedez, diagflag);
        lmove.row = buffer.row;
        lmove.col = buffer.col;
    %%% DEBUG
    %        str = sprintf('intern %d%d \n',lmove.col,lmove.row);
    %        disp(str);
    %%% END DEBUG
    end
    
    
    
    
    
end

