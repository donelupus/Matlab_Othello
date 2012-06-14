function  [RANDOM_BOARD]=get_random_board
    
    BOARD_MAT=rand(8,8);
    
    for i=1:8
        for j=1:8
            %if BOARD_MAT(i,j)<0.33
            %    BOARD_MAT(i,j)=-1;
            %elseif BOARD_MAT(i,j)<0.66
            %    BOARD_MAT(i,j)=0;
            %else
            %    BOARD_MAT(i,j)=1;
            %end
            BOARD_MAT(i,j)=0;
        end
    end
    
    RANDOM_BOARD=BOARD_MAT
end

