% @brief Funktionsbeschreibung:


% @autor Yuji Zhu
% @autor Jianan Shen
% @date 18.06.2012
% ...
% Inputs:
% @Brett: Aktuelles Brett, 8x8 Matrix
% @Farbe: Farbe der Steine. -1: Schwarz, +1: Weiß.
% @Tiefe: Suchtiefe bei der Baumfunktion.
% 
% Return:
% @BestBewegung: Der Zug mit dem besten Bewertungswert.
% @BestWert: Der beste Bewertungswert.
% @BestBewegungsBrett: Das Brett (8x8 Matrix) nach der besten Bewegung.


function [BestBewertung, BestZug, BestBrett ] = ...
            BaumFunktion( Brett, Farbe, Move_No)
%             BaumFunktion( Brett, Farbe, Tiefe, Store_ValidPos,RatingFarbe, Zug_Zaehler)
%         Brett, A, B, Tiefe, Move_No, Inner_Counters, Akt_Zug, Store_ValidPos
% Statische Variable Tiefe_Flag: 
% persistent Tiefe_Flag %Begin_Index;
% Begin_Index = 2;
% persistent Index_Brett Index_Zug Index_ValidPos  Index_StoreValidPos ...
%            Index_Rating Index_KnotenID Index_VorBrettID;
% Tiefe_Flag = 3;
A = -Inf;
B = Inf;
% Tiefe = 4;

Akt_Zug = [];
Store_ValidPos = [];
Inner_Counters = [];

if Farbe == -1
    if Move_No > 50
        Tiefe = 6;
    else Tiefe = 4;
    end
    [BestBewertung, BestZug, BestBrett ] = MiniMaxBlack(Brett,A,B,Tiefe,Move_No,Inner_Counters, Akt_Zug, Store_ValidPos);
else
    if Move_No <= 15
        Tiefe = 3;
    else if Move_No >= 40 && Move_No <= 50
        Tiefe = 5;
        else if Move_No > 50
                Tiefe = 6;
            else
                Tiefe = 4;
            end
        end
    end
    [BestBewertung, BestZug, BestBrett ] = MiniMaxWhite(Brett,A,B,Tiefe,Move_No,Inner_Counters, Akt_Zug, Store_ValidPos);
end


% Index_Brett = 1;
% Index_Zug =2;
% Index_ValidPos = 3;
% Index_StoreValidPos = 4;
% Index_Rating = 5;
% Index_KnotenID = 6;
% Index_VorBrettID = 7;
        
% Globale Variable ID_Vek: speichert die IDs fuer jedes Brett.
% Globale Variable Baum_Speicherung: speichert den Baum (aktuelles Brett,
% ausgefuehrter Zug, ValidPos, Store von ValidPos, Bewertungswert des 
% aktuellen Bretts, Knoten ID, ID des vorgängiges Bretts)
% Globale Variable Zug_Zaehler: zaehlt die ausgefuehrten Zuege des Spiels.
% global ID_Vek  Baum_Struct % Baum_Speicherung % Zug_Zaehler
% if length(find(Brett~=0)) == 4
%     Baum_Struct(1,1).Brett = zeros(8,8);
%     Baum_Struct(1,1).Zug = zeros(1,2);
%     Baum_Struct(1,1).ValidPos = [-1,-1];
%     Baum_Struct(1,1).StoreValidPos = [];
%     Baum_Struct(1,1).Rating = 0;
%     Baum_Struct(1,1).KnotenID = '0';
%     Baum_Struct(1,1).VorKnotenID = '0';
%     ID_Vek(1) = '0';
% %     Baum_Speicherung = {};
% %     Baum_Speicherung = Baum_Struct(1);
% end

% Zug_Zaehler = 0;


% Knoten_ID: erzeugt ID fuer jedes Brett bei aller moeglichen Zuege.
% Default: 0
% Knoten_ID = 0;
% 
% 
% [ValidPos, Feld_ValidPos] = Valid_Pos_05(Brett,Farbe,Store_ValidPos);
% % ValidPosLin = Valid_Pos_02(Brett,Farbe);
% if ValidPos(1,1) < 0
%     disp(['No valid position for this color:', num2str(Farbe)]);
%     BestBewegungBrett = Brett;
%     BestWert = 0;
%     BestBewegung = 0;
%     return
% end
% 
% 
% ValidPosNum = length(ValidPos(:,1));
% Brett_Cell = {[]};
% Brett_In_Baum = zeros(8,8);
% Bewertungswert = [];
% % BewertungsVektor = [];
% BewegungsVektor = [];
% for k = 1:ValidPosNum
% %     Zeile_Index=mod(ValidPosLin(k),8);
% %     if (Zeile_Index==0) 
% %         Zeile_Index=8;
% %     end
% %     Spalte_Index = (ValidPosLin(k)-Zeile_Index)/8+1;
% %     ValidPos(k,1) = Zeile_Index;
% %     ValidPos(k,2) = Spalte_Index;
% %     Brett_Cell{k} = Umdrehung(Brett,Farbe,ValidPos(k,:));
%     Brett_Cell{k} = Spielzug_durchfuehren_03(Brett,Farbe,ValidPos(k,:),Feld_ValidPos);
%     Zug_Zaehler = Zug_Zaehler + 1;
%     inner_stones = Inner_Counter(ValidPos(k,1), ValidPos(k,2), Brett_Cell{k});
%     Move_No = length(find((Brett_Cell{k})~=0))-4;
%     if Tiefe > 1
%         Tiefe = Tiefe - 1;
%         [BewegungsVektor(k), Bewertungswert(k), Brett_In_Baum] = ...
%             BaumFunktion( Brett_Cell{k}, -Farbe, Tiefe, Feld_ValidPos,RatingFarbe);
%     end
%     if Tiefe == 1
% %         Tiefe = Tiefe - 1;
%         Bewertungswert(k) = rating_fct(RatingFarbe,Move_No,Brett_Cell{k},inner_stones,ValidPos(k,:));
%     end
% end
% % if RatingFarbe == 1
% %     Bewertungswert = -1.*Bewertungswert; % Negamax
% %     
% % end
% [BestWert,BestIndex] = max(Bewertungswert);
% % else [BestWert,BestIndex] = min(Bewertungswert);
% 
% 
% BestBewegung = ValidPos(BestIndex);
% BestBewegungBrett = Brett_Cell{BestIndex};
% 
% 
end
