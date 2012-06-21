%  Gruppe D
%  
%  

function b = PlayerD(b, color, t)
if 180.0 - t == 0.0
 addpath(['players' filesep 'PlayerD']);
 load('static_field_rating_bool_vec.mat');
 load('counters_no_rating_bool_vec.mat');
 load('border_counters_rating_bool_vec.mat');
 load('inertia_moment_rating_bool_vec.mat');
 load('compl_lines_rating_bool_vec.mat');

 load('static_field_rating_value_vec.mat');
 load('counters_no_rating_value_vec.mat');
 load('border_counters_rating_value_vec.mat');
 load('inertia_moment_rating_value_vec.mat');
 load('compl_lines_rating_value_vec.mat');
end
 tic;
 table = b;
 b = openingmoves(b,color);
 time = toc;
 disp(time);
 if b == 0 % size(b,1) == 1
    b = table;
    Move_No = length(find(Brett~=0))-4;
    [ BestWert, BestBewegung, b ] = BaumFunktion(b,Farbe, Move_No);
 end
 
 
     
 
end
