function [ diagflag ] = calculatediag(lastmove)
%CALCULATEDIAG Summary of this function goes here
%   Detailed explanation goes here
%   Diagonalflag 
%   Moveliste geht immer von Spielzug D3 also Dezimal 43 aus.
%   falls nun erster Zug F5 also 65 war, dann wird F5 auf D3 umgerechnet und
%   in der Moveliste nach dem entprechenden Zug gesucht und danach wieder
%   umgerechnet um den neuen Zug nach F5 zu machen.


    if lastmove.row == 3 && lastmove.col == 4       %% ist D3
        diagflag = 0;
    elseif lastmove.row == 4 && lastmove.col == 3   %% ist C4
        diagflag = 1;
    elseif lastmove.row == 6 && lastmove.col == 5   %% ist E6
        diagflag = 2;
    else                                            %% kann nur F5 noch gewesen sein !!!
        diagflag = 3;
    end

end

