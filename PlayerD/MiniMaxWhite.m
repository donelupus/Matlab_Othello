function [BestBewertung, BestZug, BestBrett] = MiniMaxWhite(Brett, A, B, Tiefe, Move_No, Inner_Counters, Akt_Zug, Store_ValidPos)
maximal = -Inf;
BestZug = [];
BestZugIndex = [];
BestBrett = [];

if Tiefe <= 0
    Move_No = length(find(Brett~=0))-4;    
%     BestBewertung = GC_getBoardEvalBetter(Brett,1,Move_No);
    BestBewertung = rating_fct(1,Move_No,Brett,Inner_Counters);
%     BestBewertung = rating_fct_2(1,Brett);
else
    [ValidPos, Store_ValidPos] = Valid_Pos_05(Brett,1,Store_ValidPos);
    ValidPosNum = size(ValidPos,1);
    if ValidPosNum == 1 && ValidPos(1,1) < 0
        BestBewertung = 0;
        BestZug = [0,0];
        BestBrett = Brett;
        return
    else if ValidPosNum == 1 % Nur eine mögliche Position --> nicht mehr weiter suchen
            BestBewertung = 0;
            BestZug = ValidPos;
            BestBrett = Spielzug_durchfuehren_03(Brett,1,ValidPos,Store_ValidPos);
            return
        else
            Temp_Brett = zeros(8,8,ValidPosNum);
            for k = 1:ValidPosNum
                Temp_Brett(:,:,k) = Spielzug_durchfuehren_03(Brett,1,ValidPos(k,:),Store_ValidPos);
                inner_stones = Inner_Counter(ValidPos(k,1), ValidPos(k,2), Temp_Brett(:,:,k));
                Temp_Bewertung = MiniMaxBlack(Temp_Brett(:,:,k), A, B, Tiefe-1, Move_No+1,inner_stones,ValidPos(k,:),Store_ValidPos);
                if Temp_Bewertung > maximal
                    maximal = Temp_Bewertung;
                    BestZugIndex = k;
                end;
                
                if  Temp_Bewertung > A
                    A = Temp_Bewertung;
                end;
                if  maximal >= B
                   break;
                end;
            end
            BestBewertung = maximal;
            BestZug = ValidPos(BestZugIndex,:);
            BestBrett = Temp_Brett(:,:,BestZugIndex);
        end
    end
    
end

end