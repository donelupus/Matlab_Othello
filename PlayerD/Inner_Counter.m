% function [ output_args ] = Inner_Counter( input_args )
function inner_stones=Inner_Counter(x, y, BOARD_MAT_ABS)
    
    %Falls kein innerer Punkt
    inner_stones_no = 0;
     inner_stones=[0,0];
     
    %Pr�fen, ob Punkt am Rand horizontal
        if ((x-2)<2)
            l_r=1;
            h_r=x+2;
        elseif ((x+2)>7)
            l_r=x-2;
            h_r=8;
        else
            l_r=x-2;
            h_r=x+2;
        end 


    %Pr�fen, ob Punkt am Rand vertikal
        if ((y-2)<2)
            l_c=1;
            h_c=y+2;
        elseif ((y+2)>7)
            l_c=y-2;
            h_c=8;
        else
            l_c=y-2;
            h_c=y+2;
        end 

        buffer_r=x;

    %Pr�fe, ob Summe der Zeilen > 3
    while buffer_r<h_r
        if (sum(BOARD_MAT_ABS(buffer_r, l_c:h_c))<3)
            break;
        end
        buffer_r=buffer_r+1;
    end
    h_r=buffer_r;
    buffer_r=x;

    while( buffer_r>l_r)

        if (sum(BOARD_MAT_ABS(buffer_r, l_c:h_c))<3)
            break;
        end
        buffer_r=buffer_r-1;
    end

    l_r=buffer_r;

    %Finden der inneren Punkte
    if ((h_r-l_r)>2)

        k=1;

        for i=l_r:(h_r-2)

            %Ersten 3 Zeilen aufsummieren
            if(i==l_r)
                test_vek=BOARD_MAT_ABS(i, l_c:h_c)+BOARD_MAT_ABS(i+1, l_c:h_c)+BOARD_MAT_ABS(i+2, l_c:h_c);

            %Folgenden 3 Zeilen aufsummieren
            else
                test_vek= test_vek+BOARD_MAT_ABS(i+2, l_c:h_c)-BOARD_MAT_ABS(i-1, l_c:h_c);
            end

            %3 aufeinander folgende Glieder aufsummieren
            for j=(2):(h_c-l_c)
                if (j==2)
                    testsum=sum(test_vek(j-1:j+1));
                else
                    testsum=testsum+test_vek(j+1)-test_vek(j-2);

                end

                %Innerer Punkt, falls Summe=9
                if (testsum>8)
                    inner_stones(k, 1)=i+1; 
                    inner_stones(k, 2)=j+l_c-1;
                    k=k+1;
                end
            end
        end

    end
%     if inner_stones(1,1) > 0
%         inner_stones_no = length(inner_stones(:,1));
%     end
end

