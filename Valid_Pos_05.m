% In Baum gespeichert:
% ====================
% Store_from_Tree.Randfeld_Liste;
% Store_from_Tree.Randfeld_Board;
% Store_from_Tree.Randfeld_Cnt;
% Store_from_Tree.Board;




function [ ValidPos, Store_to_Tree ] = Valid_Pos_05(Aktuelles_Board, col, Store_from_Tree )
% Incrementelle Implementierung von Valid Pos.
% Falls Funktion ohne Store_from_Tree aufgerufen wird, muss dafuer eine
% leere Cell uebergeben werden.

% Inkrementell rechnen oder nur mit dem aktuellen Board?
Incremental = ~isempty(Store_from_Tree);


Dir = [  0  1;...
         0 -1;...
         1  0; ...
        -1  0; ...
         1  1; ...
        -1 -1; ...
         1 -1; ...
        -1  1; ...
        ];
    
   

% 1. Berechne aktuelle Liste der Randfelder
if ~Incremental
    Randfeld_Liste = zeros(64,2);
    Randfeld_Board = zeros(8,8);
    Randfeld_Cnt = 0;
    
    % Aktuelle Randfelder berechnen aus gesamten Brett.
    for y=1:8
        for x=1:8
            if Aktuelles_Board(x,y) ~= 0 | Randfeld_Board(x,y) ~= 0
                continue
            end
            for n = 1:8 % Nachbar für Nachbar
                X = x+Dir(n,1);
                Y = y+Dir(n,2);
                if X > 8 | X < 1 | Y > 8 | Y < 1
                    continue
                end
                if Aktuelles_Board(X,Y) ~= 0
                    Randfeld_Cnt = Randfeld_Cnt + 1;
                    Randfeld_Board(x,y) = 1;
                    Randfeld_Liste(Randfeld_Cnt,1) = x;
                    Randfeld_Liste(Randfeld_Cnt,2) = y;
                    break
                end
            end
        end
    end
    
    
else
    % Liste der aktuellen Randfelder mit aktuellem Zug updaten.
    
    Randfeld_Liste = Store_from_Tree.Randfeld_Liste;
    Randfeld_Board = Store_from_Tree.Randfeld_Board;
    Randfeld_Cnt   = Store_from_Tree.Randfeld_Cnt;
    Altes_Board    = Store_from_Tree.Board;
    
    % Aktuellen Zug berechnen:
    Diff = abs(Altes_Board - Aktuelles_Board);
    Letzter_Zug = [0,0];
    for y=1:8
        for x = 1:8
            if Diff(x,y) ~= 0
                Letzter_Zug = [x,y];
                break;
            end
        end
        if Letzter_Zug(1) ~= 0
            break
        end
    end
    
    % neuen Stein aus der Randliste Loeschen:
    Randfeld_Board(Letzter_Zug(1), Letzter_Zug(2)) = 0;
    for i = 1:Randfeld_Cnt
        if Randfeld_Liste(i,1) == Letzter_Zug(1) & Randfeld_Liste(i,2) == Letzter_Zug(2)
            if(Randfeld_Cnt > 1)
                Randfeld_Liste(i,1) = Randfeld_Liste(Randfeld_Cnt,1);
                Randfeld_Liste(i,2) = Randfeld_Liste(Randfeld_Cnt,2);
                Randfeld_Liste(Randfeld_Cnt,1) = 0;
                Randfeld_Liste(Randfeld_Cnt,2) = 0;
                Randfeld_Cnt = Randfeld_Cnt - 1;
            else
                Randfeld_Cnt = 0;
                Randfeld_Liste(1,1) = 0;
                Randfeld_Liste(1,2) = 0;
            end
        end
    end
    
    % Pruefe ob Nachbarn des neuen Zuges Randfelde sind.
    for n = 1:8 % Nachbar fuer Nachbar
        X = Letzter_Zug(1,1)+Dir(n,1);
        Y = Letzter_Zug(1,2)+Dir(n,2);
        if X > 8 | X < 1 | Y > 8 | Y < 1
            continue
        end
        if Randfeld_Board(X,Y) == 1
            continue
        end
        if Aktuelles_Board(X,Y) == 0
            Randfeld_Cnt = Randfeld_Cnt + 1;
            Randfeld_Board(X,Y) = 1;
            Randfeld_Liste(Randfeld_Cnt,1) = Y;
            Randfeld_Liste(Randfeld_Cnt,2) = Y;
            continue
        end
    end
end
    
    
ValPos = zeros(64,2);
ValPos_cnt = 0;
FlipPos = zeros(2,25,64);

% Pruefe, ob Randfelder auch Valid Positions sind:
for i = 1:Randfeld_Cnt   
    isvalid = false; % ist Randfeld valid Position
    
    for dir = 1:8 % richtung auswählen
       Step_in_dir = Dir(dir,:);
       Neighbour = [Randfeld_Liste(i,1) + Step_in_dir(1), Randfeld_Liste(i,2)+Step_in_dir(2)];

       if Neighbour(1) > 8 | Neighbour(1) < 1 | Neighbour(2) > 8 | Neighbour(2) < 1
           continue % vom Rand gefallen, naechste Richtung
       end

       templist = zeros(6,2); % Zu flippende Gegner-Steine in einer Richtung
       templist_cnt = 0;

       if Aktuelles_Board(Neighbour(1), Neighbour(2)) == -col
           % Wir haben einen Schwarzen als Nachbar
           templist_cnt = templist_cnt + 1;
           templist(templist_cnt,1) = Neighbour(1);
           templist(templist_cnt,2) = Neighbour(2);
           run = true;
           Next = Neighbour;
           while run
                Next = Next + Step_in_dir;
                if Next(1) > 8 | Next(1) < 1 | Next(2) > 8 | Next(2) < 1
                    run = false;
                    break;
                end
                if Aktuelles_Board(Next(1), Next(2)) == 0
                    run = false;
                    break;
                elseif Aktuelles_Board(Next(1), Next(2)) == -col
                    % Weiterer potenzieller flip-stein:
                    templist_cnt = templist_cnt + 1;
                   templist(templist_cnt,1) = Next(1);
                   templist(templist_cnt,2) = Next(2);
                elseif Aktuelles_Board(Next(1), Next(2)) == col
                    % Randlist ist valid position.
                    if ~isvalid
                        ValPos_cnt = ValPos_cnt + 1;
                        ValPos(ValPos_cnt, 1) = Randfeld_Liste(i,1);
                        ValPos(ValPos_cnt, 2) = Randfeld_Liste(i,2);
                        isvalid = true;
                    end
                    
                    % Flipfelder noch anfuegen:
                    for j = 1:templist_cnt
                        FlipPos(1,FlipPos(1,1,ValPos_cnt)+j+1,ValPos_cnt) = templist(j,1);
                        FlipPos(2,FlipPos(1,1,ValPos_cnt)+j+1,ValPos_cnt) = templist(j,2);
                    end
                    FlipPos(1,1,ValPos_cnt) = FlipPos(1,1,ValPos_cnt) + templist_cnt;
                    run = false;
                end
           end
       end
    end
end
    
Store_to_Tree.Randfeld_Liste = Randfeld_Liste;
Store_to_Tree.Randfeld_Board = Randfeld_Board;
Store_to_Tree.Randfeld_Cnt   = Randfeld_Cnt;
Store_to_Tree.Board          = Aktuelles_Board;


ValidPos =  ValPos(1:ValPos_cnt,:);
    
    


