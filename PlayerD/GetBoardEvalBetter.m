function [eval] = GetBoardEvalBetter(board, color, moveNo)

%Gewichtungen

scoreC = -1; %Spielstand

corFieldC = 100; %Ecke
cFieldC = -80; %C-Feld
xFieldC = -80; % X-Feld
fieldC = 20; %Felder um X- und C-Felser
diagCornerC = 1.5; %Faktor, um den die Gewichtung der gegen�berliegenden Ecke "hervorgehoben" wird

frontC = -5; %Frontire

stableC = 110; %Stabile Steine

edgeC = -5; %L�cken ungerader L�nge

%parityC = 10; %Parit�t

%Initialisierung einider Parameter (Falls diese in der Runde nicht ausgerechnet werden)

%fields = 0; %Spezifische Felder
stable = 0; %Stabile Steine
edge = 0; %L�cken ungerader L�nge
%parity = 0; %Parit�t



%Nummer des aktuellen Zuges berechnen
%moveNo = sum(sum(board ~= 0)) - 3;

%if (moveNo < 60)
    
    
    %Spielstand minimieren
    score = sum(board(:))*color;
    
    %Frontire 
    
    b_all = double(board~=0);

%% FRONSTEINE: Nachbarn z�hlen (imfilter() nachgebaut)

    % INTEGERS ARE FASTER!
    filt = int8([ 1 1 1; 1 0 1; 1 1 1]);
    numMin = 8;    

    %--rely that game is 8x8    
    frontM = int8(zeros(8));    % prealloc        
    % pad edges with ones
    b_all1 = int8(ones(10));
    b_all1 (2:9,2:9) = int8(b_all);        
           
    % 8x8 spielfeld   
    for xx = 2:9
        for yy=2:9
            frontM(yy-1,xx-1)=sum(sum(b_all1(yy-1:yy+1, xx-1:xx+1) .* filt));
        end
    end
        
    % remove opponent's
    frontM = ((frontM < numMin) & board);
    frontM = frontM.*board;

    front = sum(frontM(:))*color;
    
%% Bewertuing Spezifischer Felder
%             
%             tmp = [corFieldC,  cFieldC,  fieldC;
%                    cFieldC,    xFieldC,  fieldC;
%                    fieldC,     fieldC,   fieldC]
%                
               
            
        M = [corFieldC,  cFieldC,  fieldC,  0,  0,  fieldC,  cFieldC,  corFieldC; ...
             cFieldC,    xFieldC,  fieldC,  0,  0,  fieldC,  xFieldC,  cFieldC; ...
             fieldC,     fieldC,   fieldC,  0,  0,  fieldC,  fieldC,   fieldC; ...
             0,          0,        0,       0,  0,  0,       0,        0; ...
             0,          0,        0,       0,  0,  0,       0,        0; ...
             fieldC,     fieldC,   fieldC,  0,  0,  fieldC,  fieldC,   fieldC; ...
             cFieldC,    xFieldC,  fieldC,  0,  0,  fieldC,  xFieldC,  cFieldC; ...
             corFieldC,  cFieldC,  fieldC,  0,  0,  fieldC,  cFieldC,  corFieldC];
        
        for k = 1:4
            if (board(1,1) ~= 0)
                M(1:3, 1:3) = zeros(3,3);
                M(6:8, 6:8) = M(6:8, 6:8)*diagCornerC; %Diagonal liegende Ecke schnappen
            end
            M = rot90(M);
            board = rot90(board);
        end
         
        fields = sum(sum(board.*M))*color;
    
    if (moveNo > 20)

        %Stabile steine
        stableM = zeros(8,8); %Enth�lt stabile Steine
        
        for k = 1:4
            if (board(1,1) ~= 0)
                col = board(1,1);
                ii = 1;
                stop = 9;
                while (ii < 9)
                    jj = 1;
                    while (jj < stop)
                        if (board(ii,jj) == col)
                            stableM(ii,jj) = col;
                        else
                            stop = jj;
                        end
                        jj = jj + 1;
                    end
                    if (stop == 1)
                        ii = 9;
                    else
                        ii = ii + 1;
                    end
                    
                end
            end
            board = rot90(board);
            stableM = rot90(stableM);
        end
        
        stable = sum(stableM(:));
        
        %L�cken ungerader L�nge na den Kanten
        
        %"L�ckenmatrix" erstellen
        holesM = [board(1,:); board(8, :); board(:, 1)'; board(:, 8)'];
        holes1 = (holesM ~= color);
        holes2 = (holesM ~= -color);
        
        counter = zeros(4,2);
        edgeV = zeros(4,2);
        
        
        for ii = 1:8
            
            %Z�hler der L�ckenl�ngen aktualisieren
            holes = [holes1(:,ii) holes2(:,ii)];
            counter = counter + holes;
            
            %Wenn L�cke zuende ist, Bewertung aktualisieren
            edgeV = edgeV + mod(counter.*(holes ~= 1),2);
            %edgeV(:,2) = edgeV(:,2) + mod(counter(:,2).*(holes2(:,ii) ~= 1),2);
            
            %Z�hler F�r "fertige" L�cken zur�cksetzen
            counter = counter .* holes;
        end
        
        edgeV = edgeV + mod(counter,2);
        
        edgeV(:,2) = -edgeV(:,2);
        edge = sum(edgeV(:));
        
    end
    
    
%    if (moveNo > 40)
        
        
        
%        %Parit�t
        
%         % get all free areas
%         emptyAreas = (board == 0);
%         
%         % get connected components
%         [L,num]=bwlabel(emptyAreas, 4);
%         for k = 1:num
%             that = (L==k);
%             numFree = sum(sum(that));
%             if (rem(numFree,2))
%                 % areas with odd number of free fields are bad
%                 parity = parity - 1;
%                 %disp(['Parity: found an odd free area -> -1']);
%             else
%                 % areas with even number of feee fields are good
%                 parity = parity + 1;
%                 %disp(['Parity: found an even free area -> +1']);
%             end
%         end
        
%    end
    
    eval = score*scoreC + front*frontC + fields + stable*stableC + edge*edgeC; % + parity*parityC;

% M.Becker moveNo is in [1,30]-. But because this works wo well, I will
% just out-comment that never-executing IF-statement
% else
%     if (color*sum(board(:)) > 0);
%         eval = inf;
%     else
%         eval = -inf;
%     end
% end

end
%nur Steine eigener Farbe auf dem Feld lassen
%board+color*abs(board)/2; % liefert doppelte Matrix!
