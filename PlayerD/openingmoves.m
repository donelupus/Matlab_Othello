function b = openingmoves(table,color)
%OPENINGMOVES Summary of this function goes here
%   Detailed explanation goes here

%   Spielbrett Adressierung
%   -------------------------
%   | 1,1 | 1,2 | ... | 1,8 | 
%   -------------------------
%   | 2,1 | ...       | 2,8 |
%   -------------------------
%   | ...                   |
%   -------------------------
%   | 8,1 | ...       | 8,8 |
%   -------------------------
%  
%   !!! ****************************************************************!!!
%   Dies entspricht der row col Entsprechung
%   Dezimal wird aber zusammengeschrieben colrow verwendet. !!!!
%   Beispielsweise ist 3,4 in dezimal 43 also D3 !!
%
%   !!! ****************************************************************!!!
%
%  Rückgabe ist ein aktualisiertes Brett falls Eröffnungszüge vorhanden
%  sind ansonsten wird 0 zurückgegeben !!
%   

%% Variablen erstellen 
% -----------------------------------------------------------------------
persistent lastmovetable;               % letztes Spielbrett  
persistent lastmove;                    % letzer Spielzug vom Gegner
persistent diagflag;                    % legt in abhängigkeit von D3(also 34) in der moveliste die anfangszüge fest
persistent startindex;                  % Startindex in der Suchliste am Anfang 1
persistent stopindex;                   % Stopindex in der Suchliste am Anfang Ende der Liste

persistent finishflag;                 % Zeigt das Ende der
                                        %Eröffnungszüge an und muss am Ende einer Partie wieder freigegeben werden

%% je nach Farbe wird eine bestimmte Movetabelle geladen bei schwarz wir beginnen --> mlfirst
if color == -1
    persistent mlfirst;
else
    persistent mlsecond;
end
% ------------------------------------------------------------------------

%% Eröffnungszüge -- prüfen ob bereits vollendet
if isempty(finishflag)                
    finishflag = 0;
end

if ((finishflag == 1) && ((sum(sum(abs(table),1)) == 4) || (sum(sum(abs(table),1)) == 5)))

    finishflag = 0;

end

% --------------------------------------------------------------------------


%% solange finishflag == 0 dann werden Eröffnungszüge gesucht
  if finishflag == 0                  


%% Initialisierung
%--------------------------------------------------------------------------
    if color == -1
       [lastmove mlfirst startindex stopindex lastmovetable,diagflag] = init_var(lastmove, mlfirst, startindex, stopindex,...
                                                                                 lastmovetable, color,diagflag);
    else
       [lastmove mlsecond startindex stopindex lastmovetable,diagflag] = init_var(lastmove, mlsecond, startindex, stopindex,...
                                                                                  lastmovetable, color, diagflag);
    end
    %--------------------------------------------------------------------------

    %% Hauptteil
    %-------------------------------------------------------------------------

    % berechne letzen Zug        
    [lastmove diagflag] = lastmovecal(table,lastmovetable,lastmove,diagflag,color);       


    if color == -1
        if lastmove.count == 1      
            newmovedez = 43;               %% ist immer 43 in mlfirst(1,1) entspricht D3;
            diagflag = randi(4,1,1)-1;     %% zufalls zahl 0 -3 für Anfangszugvarianten
        else                               %% ab dem 2. eigenen Zug
            [newmovedez startindex stopindex] = findnewmove(mlfirst, startindex, stopindex, lastmove);
        end
    else   %% --> Gegner hat angefangen
            [newmovedez startindex stopindex] = findnewmove(mlsecond, startindex, stopindex, lastmove);
    end

    %--------------------------------------------------------------------------

        if startindex == stopindex
            b = 0;                   %% Ende der Anfangszüge gibt 0 zurück
            finishflag = 1;
            if color == -1               %% gebe Speicher frei
                clear mlfirst;
            else
                clear mlsecond;
            end
            clear lastmovetable;
            clear lastmove;
            clear diagflag;
            clear startindex;
            clear stopindex;
            disp('opening moves finished');
            return;
        end
    %--------------------------------------------------------------------------


    %% Schlussteil 
    % neuen Zug berechnen von dezimal auf Matrixnotation und neue Brett berechnen
    % 

    newmove = calculatenewmove(newmovedez,diagflag);
    b = calculatenewtable(table,newmove,color);
    lastmovetable = b;
    if ~((color == -1) && (lastmove.count == 1))       %% falls wir beginnen dann war kein letzer Move --> nicht hochzählen
        lastmove.count = lastmove.count + 1;
    end

%--------------------------------------------------------------------------    
  else % falls finishflag == 1 ist
       b = 0;   %% Ende der Eröffnungszüge gibt 0 zurück
  end

end








%% Initialisierung
%--------------------------------------------------------------------------
function [lastmove movelist startindex stopindex lastmovetable, diagflag] = init_var(lastmove, movelist, startindex,...
                                                                           stopindex, lastmovetable, color, diagflag)

    % initialisierung
        if isempty(lastmove)
            lastmove.row = 0;
            lastmove.col = 0;
            lastmove.count = 0;
        end
        
        if color == -1
            if isempty(movelist)
               load('mlfirstnum.mat');
               movelist = mlfirstnum;
            end
        else
            if isempty(movelist)
               load('mlsecondnum.mat');
               movelist = mlsecondnum;
            end
        end
        

        if isempty(startindex)
            startindex = 1;
            stopindex = length(movelist);
        end

        if isempty(diagflag)
            diagflag = 0;
        end
        
        if isempty(lastmovetable)

            lastmovetable =  [0  0  0  0  0  0  0  0; ...
                              0  0  0  0  0  0  0  0; ...
                              0  0  0  0  0  0  0  0; ...
                              0  0  0  1 -1  0  0  0; ...
                              0  0  0 -1  1  0  0  0; ...
                              0  0  0  0  0  0  0  0; ...  
                              0  0  0  0  0  0  0  0; ...
                              0  0  0  0  0  0  0  0;];
        end



end
%--------------------------------------------------------------------------



