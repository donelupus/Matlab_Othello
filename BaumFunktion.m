function [ BestBewegung, BestWert, BestBewegungBrett ] = BaumFunktion( Brett, Farbe, Tiefe)
persistent Tiefe_Flag;
Tiefe_Flag = 4;
ValidPosLin = Valid_Pos_02(Brett,Farbe);
if ValidPosLin < 0
    disp(['no valid position for color:', num2str(Farbe)]);
    BestBewegungBrett = Brett;
    BestWert = 0;
    BestBewegung = 0;
    return
end
ValidPosNum = length(ValidPosLin);
ValidPos = [];
Brett_Cell = {[]};
Brett_In_Baum = zeros(8,8);
Bewertungswert = [];
% BewertungsVektor = [];
BewegungsVektor = [];
for k = 1:ValidPosNum
    Zeile_Index=mod(ValidPosLin(k),8);
    if (Zeile_Index==0) 
        Zeile_Index=8;
    end
    Spalte_Index = (ValidPosLin(k)-Zeile_Index)/8+1;
    ValidPos(k,1) = Zeile_Index;
    ValidPos(k,2) = Spalte_Index;
%     Brett_Cell{k} = Umdrehung(Brett,Farbe,ValidPos(k,:));
    Brett_Cell{k} = Spielzug_druchfuehren_01(Brett,Farbe,ValidPosLin(k));
    if Tiefe > 0
        Tiefe = Tiefe - 1;
        [BewegungsVektor, Bewertungswert, Brett_In_Baum] = BaumFunktion( Brett_Cell{k}, -Farbe, Tiefe);
    end
    if Tiefe == 0
        Tiefe = Tiefe - 1;
        Bewertungswert(k) = rating_fct(Farbe,Brett_Cell{k});
    end
end
% if Farbe == -1
%     Bewertungswert = -1.*Bewertungswert; % Negamax
    [BestWert,BestIndex] = max(Bewertungswert);
% else [BestWert,BestIndex] = min(Bewertungswert);
% end
BestBewegung = ValidPos(BestIndex);
BestBewegungBrett = Brett_Cell{BestIndex};

end

