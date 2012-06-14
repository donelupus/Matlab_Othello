function [ BestBewegung, BestWert, BestBewegungBrett ] = BaumFunktion( Brett, Farbe, Tiefe )
Tiefe =1;
ValidPosLin = Valid_Pos_02(Brett,Farbe);
ValidPosNum = length(ValidPosLin);
ValidPos = [];
Brett_Cell = {[]};
Bewertungswert = [];
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
    
    Bewertungswert(k) = rating_fct(Farbe,Brett_Cell{k});
end
[BestWert,BestIndex] = max(Bewertungswert);
BestBewegung = ValidPos(BestIndex);
BestBewegungBrett = Brett_Cell{BestIndex};

end

