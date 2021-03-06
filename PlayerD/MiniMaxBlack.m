function [BestBewertung, BestZug, BestBrett] = MiniMaxBlack(Brett, A, B, Tiefe, Move_No, Akt_Zug, Store_ValidPos)
minimal = Inf;
BestZug = [];
BestZugIndex = [];
BestBrett = [];

if Tiefe <= 0
    Move_No = length(find(Brett~=0))-4;
%     BestBewertung = GC_getBoardEvalBetter(Brett,1,Move_No);
    BestBewertung = rating_complex_table(Brett,-1);
%     BestBewertung = rating_fct_2(-1,Brett);
else
    [ValidPos, Store_ValidPos] = Valid_Pos_05(Brett,-1,Store_ValidPos);
    ValidPosNum = size(ValidPos,1);
    if ValidPosNum == 1 && ValidPos(1,1) < 0
        BestBewertung = 0;
        BestZug = [0,0];
        BestBrett = Brett;
        return
    else if ValidPosNum == 1 % Nur eine m�gliche Position --> nicht mehr weiter suchen
            BestBewertung = 0;
            BestZug = ValidPos;
            BestBrett = Spielzug_durchfuehren_03(Brett,-1,ValidPos,Store_ValidPos);
            return
        else
            Temp_Brett = zeros(8,8,ValidPosNum);
            for k = 1:ValidPosNum
                Temp_Brett(:,:,k) = Spielzug_durchfuehren_03(Brett,-1,ValidPos(k,:),Store_ValidPos);
              %  inner_stones = Inner_Counter(ValidPos(k,1), ValidPos(k,2), Temp_Brett(:,:,k));
                Temp_Bewertung = MiniMaxWhite(Temp_Brett(:,:,k), A, B, Tiefe-1, Move_No+1,ValidPos(k,:),Store_ValidPos);
                if Temp_Bewertung < minimal
                    minimal = Temp_Bewertung;
                    BestZugIndex = k;
                end;
                
                if  Temp_Bewertung < B
                    B = Temp_Bewertung;
                end;
                if  minimal <= A
                   break;
                end;
            end
            BestBewertung = minimal;
            BestZug = ValidPos(BestZugIndex,:);
            BestBrett = Temp_Brett(:,:,BestZugIndex);
        end
    end
    
end

end