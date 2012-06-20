function [ newmovedez startindex stopindex] = findnewmove(mlist, startindex, stopindex, lastmove)
%FINDNEWMOVE Summary of this function goes here
%   Detailed explanation goes here
%   Findet in mlist den nächsten passenden Zug und schränkt auch den Start-
%   und Stopindex ein um nicht die gesamte Tabelle zu durchsuchen 
    
        lastmovedez = lastmove.col*10+lastmove.row;
        
        % for DEBUG
        % str = sprintf('lmdez %d - lmcount %d start %d stop %d \n',lastmovedez,lastmove.count,startindex, stopindex);
        % disp(str);
        % ---------
        
        [row col] = find(mlist(startindex:stopindex,lastmove.count)==lastmovedez);      %% finde letzen Zug im Indexbereich
        if ~isempty(row)
            stopindex =  startindex + row(end) - 1;                                     %% Setze neuen Indexbereich
            startindex = startindex + row(1) - 1;
            [trash index] = max(mlist(startindex:stopindex,65));                        %% in Spalte 65 sind die Steinüberzahl des Spieles gespeichert
            newmovedez = mlist(startindex + index -1,lastmove.count+1);                 %% schreibe neuen Zug mit max. Punktzahl
            [row col] = find(mlist(startindex:stopindex,lastmove.count+1)==newmovedez); %% berechne neune Indexbereich
            stopindex =  startindex + row(end) - 1;                                     %% für neuen Zug !!
            startindex = startindex + row(1) - 1;
        else
            startindex = stopindex;
            newmovedez = 0;
        end
        
        % for DEBUG
        % str = sprintf('nmdez %d - lmcount %d start %d stop %d \n',newmovedez,lastmove.count,startindex, stopindex);
        % disp(str);
        % ------------
end

