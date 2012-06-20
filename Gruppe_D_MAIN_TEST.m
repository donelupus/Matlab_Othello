% Ganz einfach um die BaumFunktion mit der Tiefe 1 zu testen
function [ BestBewegungBrett ] = Gruppe_D_Main( Brett, Farbe, t )
% addpath(['players' filesep 'Hauptprojekt']);
persistent Move_No;
Move_No = 0;
% global Tiefe RatingFarbe
% Tiefe = 4;
% RatingFarbe = -1;
% Feld_ValidPos = [];
% [ BestBewegung, BestWert, BestBewegungBrett ] = BaumFunktion(Brett,Farbe, Tiefe, Feld_ValidPos,RatingFarbe);


b = zeros(8,8);
b(4,4) = 1;
b(4,5) = -1;
b(5,4) = -1;
b(5,5) = 1;
BestBewegungBrett = b;
% Tiefe = 1; % Im Moment noch nicht implementiert, spielt hier noch keine Rolle
EigFarbe = -1; % Schwarz, hat den ersten Zug, wir spielen zuerst.
GegFarbe = 1; % Wei?
tic
if EigFarbe == -1
    for k = 1:31
        [ BestWert, BestBewegung, BestBewegungBrett ] = ...
            BaumFunktion(BestBewegungBrett,EigFarbe, Move_No);
        Move_No = Move_No + 1;
        if k == 31
            continue
        end
        [ BestWert, BestBewegung, BestBewegungBrett ] = ...
            BaumFunktion(BestBewegungBrett,GegFarbe, Move_No);
        Move_No = Move_No + 1;
    end
else
    for k = 1:31
        [ BestWert, BestBewegung, BestBewegungBrett ] = ...
            BaumFunktion(BestBewegungBrett,EigFarbe, Move_No);
        Move_No = Move_No + 1;
        if k == 31
            continue
        end
        [BestWert, BestBewegung, BestBewegungBrett ] = ...
            BaumFunktion(BestBewegungBrett,GegFarbe, Move_No);
        Move_No = Move_No + 1;
    end
end
SpielDauer = toc
disp('Endbrett nach dem Spiel: ');
BestBewegungBrett
EigSteine = length(find(BestBewegungBrett(:) == EigFarbe))
GegSteine = length(find(BestBewegungBrett(:) == GegFarbe))
if EigSteine > GegSteine
    disp('Gewonnen!');
else
    disp('Verloren!');
end
end


