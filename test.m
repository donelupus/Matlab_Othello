% Ganz einfach um die BaumFunktion mit der Tiefe 1 zu testen
b = zeros(8,8);
b(4,4) = 1;
b(4,5) = -1;
b(5,4) = -1;
b(5,5) = 1;
BestBewegungBrett = b;
Tiefe = 1; % Im Moment noch nicht implementiert, spielt hier noch keine Rolle
EigFarbe = -1; % Schwarz, hat den ersten Zug, wir spielen zuerst.
GegFarbe = 1; % Weiß
tic
if EigFarbe == -1
    for k = 1:30
        [ BestBewegung, BestWert, BestBewegungBrett ] = ...
            BaumFunktion(BestBewegungBrett,EigFarbe,Tiefe);
        if k == 30
            continue
        end
        [ BestBewegung, BestWert, BestBewegungBrett ] = ...
            BaumFunktion(BestBewegungBrett,GegFarbe,Tiefe);
    end
else
    for k = 1:30
        [ BestBewegung, BestWert, BestBewegungBrett ] = ...
            BaumFunktion(BestBewegungBrett,GegFarbe,Tiefe);
        if k == 30
            continue
        end
        [ BestBewegung, BestWert, BestBewegungBrett ] = ...
            BaumFunktion(BestBewegungBrett,EigFarbe,Tiefe);
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