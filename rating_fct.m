function  [rating]=rating_fct(color, BOARD_MAT)
    STATIC_WEIGHT_MAT=[10000, 3000, 1000, 800, 800, 1000, -3000, 10000;
                       -3000, -5000, -450, -500, -500, -450, -5000, -3000;
                       1000, -450, 30, 10, 10, 30, -450, 1000;
                       800, -500, 10, 50, 50, 10, -500, 800;
                       800, -500, 10, 50, 50, 10, -500, 800;
                       1000, -450, 30, 10, 10, 30, -450, 1000;
                       -3000, -5000, -450, -500, -500, -450, -5000, -3000;
                        10000, 3000, 1000, 800, 800, 1000, -3000, 10000;];
    
    BOARD_MAT=rand(8,8);
    
    for i=1:8
        for j=1:8
            if BOARD_MAT(i,j)<0.33
                BOARD_MAT(i,j)=-1;
            elseif BOARD_MAT(i,j)<0.66
                BOARD_MAT(i,j)=0;
            else
                BOARD_MAT(i,j)=1;
            end
        end
    end
    
    BOARD_MAT
    
    STATIC_WEIGHT_MAT=STATIC_WEIGHT_MAT(:);
    BOARD_MAT=BOARD_MAT(:);
    
    rating=(BOARD_MAT'*STATIC_WEIGHT_MAT)*color;
    