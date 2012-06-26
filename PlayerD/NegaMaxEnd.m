function [Bewertung BrettNeu] = NegaMaxEnd(Brett, A, B, Tiefe, Farbe, Inner_Counters, Store_ValidPos)

if  Tiefe <= 0
%         Bewertung = rating_fct(b, color);
%         Move_No = length(find(Brett~=0))-4;
%         Bewertung = GC_getBoardEvalBetter(Brett,Farbe,Move_No);
%         Bewertung = rating_fct(Farbe,Move_No,Brett,Inner_Counters);
%         Bewertung = rating_complex_table(Brett,Farbe);
    Bewertung = rating_simple_table(Brett,Farbe);
    return;
end
    
Bewertung = -inf;
[ValidPos, Store_ValidPos] = Valid_Pos_05(Brett,Farbe,Store_ValidPos);
ValidPosNum = size(ValidPos,1);

if ValidPosNum == 1 && ValidPos(1,1) < 0
    Bewertung = 0;
    BrettNeu = Brett;
%         Move_No = length(find(Brett~=0))-4;
%         Bewertung = rating_fct(Farbe,Move_No,Brett,Inner_Counters);
    return;
end
    
    
BrettTemp = zeros(8,8,ValidPosNum);
for k = 1:ValidPosNum
    BrettTemp(:,:,k) = Spielzug_durchfuehren_03(Brett,Farbe,ValidPos(k,:),Store_ValidPos);
    inner_stones = Inner_Counter(ValidPos(k,1), ValidPos(k,2), BrettTemp(:,:,k));
    %   Rekursiver Aufruf!
    BewertungTemp = -NegaMaxTest(BrettTemp(:,:,k), -B, -A, Tiefe-1, -Farbe, inner_stones, Store_ValidPos);
    if BewertungTemp > Bewertung
        Bewertung = BewertungTemp;
        BrettBestIndex = k;
    end
        
    if Bewertung > A
        A = Bewertung;
    end
        
    if A >= B     % Pruning!
        Bewertung = A;
        BrettNeu = BrettTemp(:,:,BrettBestIndex);
        return;
    end
end
    
BrettNeu = BrettTemp(:,:,BrettBestIndex);

end

