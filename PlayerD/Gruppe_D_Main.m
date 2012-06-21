% Ganz einfach um die BaumFunktion mit der Tiefe 1 zu testen
function [ BestBewegungBrett ] = Gruppe_D_Main( Brett, Farbe, t )
addpath(['players' filesep 'Matlab_Othello']);
% global Tiefe RatingFarbe Zug_Zaehler
% if ~exist('Zug_Zaehler','var')
%     Zug_Zaehler = 0;
% end
% Tiefe = 3;
% RatingFarbe = Farbe;
% Store_ValidPos = [];
% [ BestBewegung, BestWert, BestBewegungBrett ] = BaumFunktion(Brett, Farbe, Tiefe, Store_ValidPos,RatingFarbe, Zug_Zaehler);
% tic
% Move_No = Get_Move_No(t);
% t1 = toc
% save
% tic
% Move_No = length(find(Brett~=0))-4;
% t2 = toc
% save('T.mat', 't1','t2');
[ BestWert, BestBewegung, BestBewegungBrett ] = BaumFunktion(Brett,Farbe, Move_No);
% Tiefe = 3;
% 
% b = zeros(8,8);
% b(4,4) = 1;
% b(4,5) = -1;
% b(5,4) = -1;
% b(5,5) = 1;
% BestBewegungBrett = b;
% % Tiefe = 1; % Im Moment noch nicht implementiert, spielt hier noch keine Rolle
% EigFarbe = 1; % Schwarz, hat den ersten Zug, wir spielen zuerst.
% GegFarbe = -1; % Wei?
% tic
% if EigFarbe == -1
%     for k = 1:31
%         [ BestBewegung, BestWert, BestBewegungBrett ] = ...
%             BaumFunktion(BestBewegungBrett,EigFarbe, Tiefe, Feld_ValidPos,RatingFarbe);
%         if k == 31
%             continue
%         end
%         [ BestBewegung, BestWert, BestBewegungBrett ] = ...
%             BaumFunktion(BestBewegungBrett,GegFarbe, Tiefe, Feld_ValidPos,RatingFarbe);
%     end
% else
%     for k = 1:31
%         [ BestBewegung, BestWert, BestBewegungBrett ] = ...
%             BaumFunktion(BestBewegungBrett,GegFarbe, Tiefe, Feld_ValidPos,RatingFarbe);
%         if k == 31
%             continue
%         end
%         [ BestBewegung, BestWert, BestBewegungBrett ] = ...
%             BaumFunktion(BestBewegungBrett,EigFarbe, Tiefe, Feld_ValidPos,RatingFarbe);
%     end
% end
% SpielDauer = toc
% disp('Endbrett nach dem Spiel: ');
% BestBewegungBrett
% EigSteine = length(find(BestBewegungBrett(:) == EigFarbe))
% GegSteine = length(find(BestBewegungBrett(:) == GegFarbe))
% if EigSteine > GegSteine
%     disp('Gewonnen!');
% else
%     disp('Verloren!');
% end
end


