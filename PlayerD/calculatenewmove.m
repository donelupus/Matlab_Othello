function [ newmove ] = calculatenewmove( newmovedez, diagflag )
%CALCULATENEWMOVE Summary of this function goes here
%   Detailed explanation goes here
%  Berechnet neuen Zug nach Matrixnotation, Eingabe ist Neuer Zug in
%  Dezimalnotation  ( z.B. 3,4 Matrixnotation ist 43 Dezimalnotation)

    % for DEBUG
    % str = sprintf('-calc- nmdez %d diagflag %d \n',newmovedez,diagflag);
    % disp(str);
    % ----------
    
    switch diagflag
        case 0  
                newmove.col = floor(newmovedez/10);
                newmove.row = newmovedez - (newmove.col*10);
        case 1  
                newmove.row = floor(newmovedez/10);                % entspricht von D3 nach C4
                newmove.col = newmovedez - (newmove.row*10);
        case 2  
                newmove.col = 9-floor(newmovedez/10);              % entspricht von D3 nach E6
                newmove.row = 9-(newmovedez - ((9-newmove.col)*10));
        otherwise                                                   
                newmove.row = 9-floor(newmovedez/10);              % entspricht von D3 nach F5 
                newmove.col = 9-(newmovedez - ((9-newmove.row)*10));
    end
    
end

