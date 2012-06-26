function  [rating]=rating_simple_table(BOARD_MAT, color)
    STATIC_WEIGHT_MAT=[10000, 3000, 1000, 800, 800, 1000, -3000, 10000;
                       -3000, -5000, -450, -500, -500, -450, -5000, -3000;
                       1000, -450, 30, 10, 10, 30, -450, 1000;
                       800, -500, 10, 50, 50, 10, -500, 800;
                       800, -500, 10, 50, 50, 10, -500, 800;
                       1000, -450, 30, 10, 10, 30, -450, 1000;
                       -3000, -5000, -450, -500, -500, -450, -5000, -3000;
                        10000, 3000, 1000, 800, 800, 1000, -3000, 10000;];
    
    
    STATIC_WEIGHT_MAT=STATIC_WEIGHT_MAT(:);
    BOARD_MAT=BOARD_MAT(:);
    
    rating=(BOARD_MAT'*STATIC_WEIGHT_MAT)*color;
    