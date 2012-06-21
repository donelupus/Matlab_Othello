close all;

load('mlfirstnum.mat');

new_move= struct('row', {0},'col', {0});


color=1;
static_field_rating_bool_mat=zeros(35180,  70);
Inner_Coustatic_field_rating_bool_mat=zeros(35180,  70);
counters_no_rating_bool_mat=zeros(35180,  70);
border_counters_rating_bool_mat=zeros(35180, 70);
inertia_moment_rating_bool_mat=zeros(35180,  70);
compl_lines_rating_bool_mat=zeros(35180, 70);

static_field_rating_value_mat=zeros(35180,  35);
counters_no_rating_value_mat=zeros(35180,  35);
border_counters_rating_value_mat=zeros(35180, 35);
inertia_moment_rating_value_mat=zeros(35180,  35);
compl_lines_rating_value_mat=zeros(35180, 35);nters=[0, 0];

for game_no=1:35180
    game_no
    Board=[0,0,0,0,0,0,0,0;
             0,0,0,0,0,0,0,0;
             0,0,0,0,0,0,0,0;
             0,0,0,-1,1,0,0,0;
             0,0,0,1,-1,0,0,0;
             0,0,0,0,0,0,0,0;
             0,0,0,0,0,0,0,0;
             0,0,0,0,0,0,0,0;];
    Inner_Counters=[0, 0];
    move_no=1;
    end_flag=0;
    counters_no=1;
    own_counters_no=1;
    color=1;
    %% while Schleife 
    while (end_flag ~= 2 && move_no<65) 
        new_move.col = (mlfirstnum(game_no,move_no)-mod(mlfirstnum(game_no,move_no), 10))/10;
        new_move.row = mod(mlfirstnum(game_no,move_no), 10);
        actual_move=[new_move.row,new_move.col];

         if (new_move.col>0 && new_move.row>0);
             
            %Calculate new Board
            Board=calculatenewtable(Board, new_move, color);

            %Calculate new inner counters
            Inner_Counters=get_inner_counters(new_move.row, new_move.col, abs(Board), Inner_Counters);
            rating=rating_fct(color, counters_no, Board, Inner_Counters);
            
       %Rating Werte
            if (mod(move_no, 2)==1)

                   static_field_rating_value_mat(game_no,(move_no+1)/2)=rating(1, 1);
                    counters_no_rating_value_mat(game_no,(move_no+1)/2)=rating(2, 1);
                    border_counters_rating_value_mat(game_no, (move_no+1)/2)=rating(3, 1);
                    inertia_moment_rating_value_mat(game_no,(move_no+1)/2)=rating(4, 1);
                    compl_lines_rating_value_mat(game_no,(move_no+1)/2)=rating(5, 1);  


            end
        %Boolsche Werte
            static_field_rating_bool_mat(game_no,(move_no))=rating(1, 2);
            counters_no_rating_bool_mat(game_no,(move_no))=rating(2, 2);
            border_counters_rating_bool_mat(game_no, (move_no))=rating(3, 2);
            inertia_moment_rating_bool_mat(game_no,(move_no))=rating(4, 2);
            compl_lines_rating_bool_mat(game_no,(move_no))=rating(5, 2);
               
    
         else

            %End game, when 2 zeros in a row
            end_flag =end_flag+1;
         end
         
         
       move_no=move_no+1;
       color=(-1)*color;
    
    end
    %%
    game_no_count=game_no;
    
end

%% black_vex
black_wins_static_field_rating_bool_vec=sum(static_field_rating_bool_mat);
black_wins_counters_no_rating_bool_vec=sum(counters_no_rating_bool_mat);
black_wins_border_counters_rating_bool_vec=sum(border_counters_rating_bool_mat);
black_wins_inertia_moment_rating_bool_vec=sum(inertia_moment_rating_bool_mat);
black_wins_compl_lines_rating_bool_vec=sum(compl_lines_rating_bool_mat);

%Gemittelte values
black_wins_static_field_rating_value_vec=sum(static_field_rating_value_mat)/game_no_count;
black_wins_counters_no_rating_value_vec=sum(counters_no_rating_value_mat)/game_no_count;
black_wins_border_counters_rating_value_vec=sum(border_counters_rating_value_mat)/game_no_count;
black_wins_inertia_moment_rating_value_vec=sum(inertia_moment_rating_value_mat)/game_no_count;
black_wins_compl_lines_rating_value_vec=sum(compl_lines_rating_value_mat)/game_no_count;


save('black_wins_static_field_rating_value_vec.mat', 'black_wins_static_field_rating_value_vec');
save('black_wins_counters_no_rating_value_vec.mat', 'black_wins_counters_no_rating_value_vec');
save('black_wins_border_counters_rating_value_vec.mat', 'black_wins_border_counters_rating_value_vec');
save('black_wins_inertia_moment_rating_value_vec.mat', 'black_wins_inertia_moment_rating_value_vec');
save('black_wins_compl_lines_rating_value_vec.mat', 'black_wins_compl_lines_rating_value_vec');

 load('mlsecondnum.mat')
%% For Schleife weiße gewinnt
for game_no=1:35180
    game_no
    Board=[0,0,0,0,0,0,0,0;
             0,0,0,0,0,0,0,0;
             0,0,0,0,0,0,0,0;
             0,0,0,-1,1,0,0,0;
             0,0,0,1,-1,0,0,0;
             0,0,0,0,0,0,0,0;
             0,0,0,0,0,0,0,0;
             0,0,0,0,0,0,0,0;];
    Inner_Counters=[0, 0];
    move_no=1;
    end_flag=0;
    counters_no=1;
    own_counters_no=1;
    color=1;
    %% while Schleife 
    while (end_flag ~= 2 && move_no<65) 
        new_move.col = (mlsecondnum(game_no,move_no)-mod(mlsecondnum(game_no,move_no), 10))/10;
        new_move.row = mod(mlsecondnum(game_no,move_no), 10);
        actual_move=[new_move.row,new_move.col];

         if (new_move.col>0 && new_move.row>0);
             
            %Calculate new Board
            Board=calculatenewtable(Board, new_move, color);

            %Calculate new inner counters
            Inner_Counters=get_inner_counters(new_move.row, new_move.col, abs(Board), Inner_Counters);
            rating=rating_fct(color, counters_no, Board, Inner_Counters);
            
       %Rating Werte
                    if (mod(move_no, 2)==0)

                           static_field_rating_value_mat(game_no,(move_no)/2)=rating(1, 1);
                            counters_no_rating_value_mat(game_no,(move_no)/2)=rating(2, 1);
                            border_counters_rating_value_mat(game_no, (move_no)/2)=rating(3, 1);
                            inertia_moment_rating_value_mat(game_no,(move_no)/2)=rating(4, 1);
                            compl_lines_rating_value_mat(game_no,(move_no)/2)=rating(5, 1);  


                    end
        %Boolsche Werte
                static_field_rating_bool_mat(game_no,(move_no))=rating(1, 2);
                counters_no_rating_bool_mat(game_no,(move_no))=rating(2, 2);
                border_counters_rating_bool_mat(game_no, (move_no))=rating(3, 2);
                inertia_moment_rating_bool_mat(game_no,(move_no))=rating(4, 2);
                compl_lines_rating_bool_mat(game_no,(move_no))=rating(5, 2);
               
    
         else

            %End game, when 2 zeros in a row
            end_flag =end_flag+1;
         end
         
         
       move_no=move_no+1;
       color=(-1)*color;
    
    end
    %%
    game_no_count=game_no;
    
end
%% white_vec
white_wins_static_field_rating_bool_vec=sum(static_field_rating_bool_mat);
white_wins_counters_no_rating_bool_vec=sum(counters_no_rating_bool_mat);
white_wins_border_counters_rating_bool_vec=sum(border_counters_rating_bool_mat);
white_wins_inertia_moment_rating_bool_vec=sum(inertia_moment_rating_bool_mat);
white_wins_compl_lines_rating_bool_vec=sum(compl_lines_rating_bool_mat);

%Gemittelte values
white_wins_static_field_rating_value_vec=sum(static_field_rating_value_mat)/game_no_count;
white_wins_counters_no_rating_value_vec=sum(counters_no_rating_value_mat)/game_no_count;
white_wins_border_counters_rating_value_vec=sum(border_counters_rating_value_mat)/game_no_count;
white_wins_inertia_moment_rating_value_vec=sum(inertia_moment_rating_value_mat)/game_no_count;
white_wins_compl_lines_rating_value_vec=sum(compl_lines_rating_value_mat)/game_no_count;

save('white_wins_static_field_rating_value_vec.mat', 'white_wins_static_field_rating_value_vec');
save('white_wins_counters_no_rating_value_vec.mat', 'white_wins_counters_no_rating_value_vec');
save('white_wins_border_counters_rating_value_vec.mat', 'white_wins_border_counters_rating_value_vec');
save('white_wins_inertia_moment_rating_value_vec.mat', 'white_wins_inertia_moment_rating_value_vec');
save('white_wins_compl_lines_rating_value_vec.mat', 'white_wins_compl_lines_rating_value_vec');
%X für schwarz
x=1:2:70;

Diff_black_vec_static_field_rating_bool_vec=black_wins_static_field_rating_bool_vec(x)-white_wins_static_field_rating_bool_vec(x);
Diff_black_vec_counters_no_rating_bool_vec=black_wins_counters_no_rating_bool_vec(x)-white_wins_counters_no_rating_bool_vec(x);
Diff_black_vec_border_counters_rating_bool_vec=black_wins_border_counters_rating_bool_vec(x)-white_wins_border_counters_rating_bool_vec(x);
Diff_black_vec_inertia_moment_rating_bool_vec=black_wins_inertia_moment_rating_bool_vec(x)-white_wins_inertia_moment_rating_bool_vec(x);
Diff_black_vec_compl_lines_rating_bool_vec=black_wins_compl_lines_rating_bool_vec(x)-white_wins_compl_lines_rating_bool_vec(x);


save('Diff_black_vec_static_field_rating_bool_vec.mat', 'Diff_black_vec_static_field_rating_bool_vec');
save('Diff_black_vec_counters_no_rating_bool_vec.mat', 'Diff_black_vec_counters_no_rating_bool_vec');
save('Diff_black_vec_border_counters_rating_bool_vec.mat', 'Diff_black_vec_border_counters_rating_bool_vec');
save('Diff_black_vec_inertia_moment_rating_bool_vec.mat', 'Diff_black_vec_inertia_moment_rating_bool_vec');
save('Diff_black_vec_compl_lines_rating_bool_vec.mat', 'Diff_black_vec_compl_lines_rating_bool_vec');

%Y für Weiß
y=2:2:70;

Diff_white_vec_static_field_rating_bool_vec=-black_wins_static_field_rating_bool_vec(y)+white_wins_static_field_rating_bool_vec(y);
Diff_white_vec_counters_no_rating_bool_vec=-black_wins_counters_no_rating_bool_vec(y)+white_wins_counters_no_rating_bool_vec(y);
Diff_white_vec_border_counters_rating_bool_vec=-black_wins_border_counters_rating_bool_vec(y)+white_wins_border_counters_rating_bool_vec(y);
Diff_white_vec_inertia_moment_rating_bool_vec=-black_wins_inertia_moment_rating_bool_vec(y)+white_wins_inertia_moment_rating_bool_vec(y);
Diff_white_vec_compl_lines_rating_bool_vec=-black_wins_compl_lines_rating_bool_vec(y)+white_wins_compl_lines_rating_bool_vec(y);

save('Diff_white_vec_static_field_rating_bool_vec.mat', 'Diff_white_vec_static_field_rating_bool_vec');
save('Diff_white_vec_counters_no_rating_bool_vec.mat', 'Diff_white_vec_counters_no_rating_bool_vec');
save('Diff_white_vec_border_counters_rating_bool_vec.mat', 'Diff_white_vec_border_counters_rating_bool_vec');
save('Diff_white_vec_inertia_moment_rating_bool_vec.mat', 'Diff_white_vec_inertia_moment_rating_bool_vec');
save('Diff_white_vec_compl_lines_rating_bool_vec.mat', 'Diff_white_vec_compl_lines_rating_bool_vec');



%%PLOT
x=1:35;
figure('Name', 'Diff_black_vec_static_field_rating_vec');
plot(x, Diff_black_vec_static_field_rating_bool_vec(x));
figure('Name', 'Diff_black_vec_counters_no_rating_bool_vec');
plot(x, Diff_black_vec_counters_no_rating_bool_vec(x));
figure('Name', 'Diff_black_vec_border_counters_rating_bool_vec');
plot(x, Diff_black_vec_border_counters_rating_bool_vec(x));
figure('Name', 'Diff_black_vec_inertia_moment_rating_bool_vec');
plot(x, Diff_black_vec_inertia_moment_rating_bool_vec(x));
figure('Name', 'Diff_black_vec_compl_lines_rating_bool_vec');
plot(x, Diff_black_vec_compl_lines_rating_bool_vec(x));
