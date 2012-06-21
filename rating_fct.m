%Funktionsbeschreibung:
%...
%inputs:
%   @Color: Eigene Spielfarbe
%   @move_no: Spielzug, erster gelegter Stein ist der erste Spielzug =>>
%               Anzahl der Spielsteine ist move_no+4
%   @BOARD_MAT aktuelles Spielbrett 8*8 Matrix mit 1=schwarz -1=weiß null=freies Feld
%   @Inner_Counters: (n, 2) Liste mit den x- und y-Koordinaten aller n, inneren Steinen

%outputs
%   @counters_no_value: (Spieler-Gegner)/(Spieler+Gegner)


function[rating_value, rating]= rating_fct(color, move_no, BOARD_MAT, Inner_Counters)
%function[rating]= rating_fct(color, move_no, BOARD_MAT, Inner_Counters)

%%
%Laden der Eichfunktionen

addpath('Weighting_Vectors');

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


%%
%Aufrufen der einzelnen Gewichtungsfunktionen
 rating=zeros(5,2);

%  tic
 [rating(1,1),rating(1,2)]=static_field_rating(color, BOARD_MAT);
 %disp('static_field_rating')
% toc
 %tic
 [rating(2,1),rating(2,2)]=counters_no_rating(color, move_no, BOARD_MAT);
 %disp('counters_no_rating')
 
 %toc
 %tic
 [rating(3,1),rating(3,2)]=border_counters_rating(color, BOARD_MAT, Inner_Counters);
 
 %disp('border_counters_rating')
 %toc
 %tic
 [rating(4,1),rating(4,2)]=inertia_moment_rating(color, BOARD_MAT,move_no);
 %disp('inertia_moment_rating')
 %toc
 
 %tic
 [rating(5,1),rating(5,2)]=compl_lines_rating(color, BOARD_MAT);
 
 %%
 %Weighting of the ratings
%  rating_value=0;
%  rating_value=rating_value + static_field_rating_bool_vec((move_no+1)/2) * rating(1,2) / static_field_rating_value_vec((move_no+1)/2);
%  rating_value=rating_value + counters_no_rating_bool_vec((move_no+1)/2) * rating(1,2) / counters_no_rating_value_vec((move_no+1)/2);
%  rating_value=rating_value + border_counters_rating_bool_vec((move_no+1)/2) * rating(1,2) / border_counters_rating_value_vec((move_no+1)/2);
%  rating_value=rating_value + inertia_moment_rating_bool_vec((move_no+1)/2) * rating(1,2) / inertia_moment_rating_value_vec((move_no+1)/2);
%  rating_value=rating_value + compl_lines_rating_bool_vec((move_no+1)/2) * rating(1,2) / compl_lines_rating_value_vec((move_no+1)/2);
%  

%%%%%%%%%%%%%%%%Einfach selben Wert 2x abspeichern
 rating_value=0;
 rating_value=rating_value + static_field_rating_bool_vec(move_no) * rating(1,2) / static_field_rating_value_vec(move_no);
 rating_value=rating_value + counters_no_rating_bool_vec(move_no) * rating(1,2) / counters_no_rating_value_vec(move_no);
 rating_value=rating_value + border_counters_rating_bool_vec(move_no) * rating(1,2) / border_counters_rating_value_vec(move_no);
 rating_value=rating_value + inertia_moment_rating_bool_vec(move_no) * rating(1,2) / inertia_moment_rating_value_vec(move_no);
 rating_value=rating_value + compl_lines_rating_bool_vec(move_no) * rating(1,2) / compl_lines_rating_value_vec(move_no);
%%%%%%%%%%%%%%%%Einfach selben Wert 2x abspeichern
 %%
%disp('compl_lines_rating')
%toc
  %  move_no=13;
%  color=1;   
% für a
%C=zeros(8);
%C(4,4)=1;
%C(4,5)=1;
%C(5,4)=1;
%C(5,5)=1;

% 
% A=[1,0,0,0,0,0,0,-1;
%    1,0,0,0,0,0,0,-1;
%    1,1,1,1,1,1,1,-1;
%    1,0,-1,1,1,-1,0,-1;
%    1,0,-1,-1,1,1,0,-1;
%    1,0,-1,1,1,-1,1,-1;
%    1,0,0,1,1,-1,0,-1;
%    1,0,0,0,0,0,0,-1
%     ]
% 
% Inner_Counters=[5,4;5,5];
%  actual_move=[7,5];
%  rating=compl_lines_rating(color,A );
 %rating=inertia_moment_rating(color, A,move_no)
% rating=counters_no_rating(color, move_no, A);
%rating=border_counters_rating(actual_move(1,1), actual_move(1,2), abs(A), A, Inner_Counters);
 %B
%  B=[0,0,0,0,0,0,0,0;
%    0,0,0,0,0,1,0,0;
%    0,0,-1,-1,1,0,0,0;
%    0,0,0,-1,-1,0,0,0;
%    0,0,1,-1,-1,1,0,0;
%    0,0,0,-1,-1,1,0,0;
%    0,0,0,-1,1,1,0,0;
%    0,0,0,0,1,0,0,0;
%     ]
%  Inner_Counters=[0,0];
%  actual_move=[7,6];
%  rating=inertia_moment_rating(color, B,move_no);
%rating=counters_no_rating(color, move_no, B);
%rating=border_counters_rating(actual_move(1,1), actual_move(1,2), abs(B), B, Inner_Counters);



function  [static_field_value, static_field_bool]= static_field_rating(color, BOARD_MAT)
    STATIC_WEIGHT_MAT=[10000, 3000, 1000, 800, 800, 1000, -3000, 10000;
                       -3000, -5000, -450, -500, -500, -450, -5000, -3000;
                       1000, -450, 30, 10, 10, 30, -450, 1000;
                       800, -500, 10, 50, 50, 10, -500, 800;
                       800, -500, 10, 50, 50, 10, -500, 800;
                       1000, -450, 30, 10, 10, 30, -450, 1000;
                       -3000, -5000, -450, -500, -500, -450, -5000, -3000;
                        10000, 3000, 1000, 800, 800, 1000, -3000, 10000;];
    
%     BOARD_MAT=rand(8,8);
%     
%     for i=1:8
%         for j=1:8
%             if BOARD_MAT(i,j)<0.33
%                 BOARD_MAT(i,j)=-1;
%             elseif BOARD_MAT(i,j)<0.66
%                 BOARD_MAT(i,j)=0;
%             else
%                 BOARD_MAT(i,j)=1;
%             end
%         end
%     end
%     
%     BOARD_MAT
    
    STATIC_WEIGHT_MAT=STATIC_WEIGHT_MAT(:);
    BOARD_MAT=BOARD_MAT(:);
    
    
    static_field_value=(BOARD_MAT'*STATIC_WEIGHT_MAT)*color;
    if static_field_value>=0
        static_field_bool=1;
    else
        static_field_bool=-1;
    end
%     
%     %Normierung der Differenz mit Gesamtgewicht
%     static_field_value=static_field_value/((abs(BOARD_MAT))'*STATIC_WEIGHT_MAT);
%     
    %Funktionsbeschreibung:
    %...
    %inputs:
    %   @Color: Eigene Spielfarbe
    %   @move_no: Spielzug, erster gelegter Stein ist der erste Spielzug =>>
    %               Anzahl der Spielsteine ist move_no+4
    %   @BOARD_MAT aktuelles Spielbrett 8*8 Matrix mit 1=schwarz -1=weiß null=freies Feld
    
    %outputs
    %   @counters_no_value: (Spieler-Gegner)/(Spieler+Gegner)
    
    function [counters_no_value, counters_no_bool]=counters_no_rating(color, move_no, BOARD_MAT)
    
        counters_no_value=sum(sum(BOARD_MAT))/(move_no+4)*color;
        
        
        if counters_no_value>=0
            counters_no_bool=1;
        else
            counters_no_bool=-1;
        end
        
%         %Normierung
%         if color==1
%             counters_no_value=sum(find(BOARD_MAT>0)/(move_no+4));
%         else
%             counters_no_value=sum(find(BOARD_MAT<0)/(move_no+4));
%         end
    
%     
%     %Funktionsbeschreibung:
%     %...
%     %inputs:
%     %   @x: alphabetische Reihe 
%     %   @y: Zahlenspalte
%     %   @BOARD_MAT_ABS aktuelles Spielbrett 8*8 Matrix mit 1=belegtes Feld null=freies Feld
%     
%     %outputs
%     %   @inner_stones_value: Vektor mit x,y-Positionen der inneneren Steine
%     
%     function inner_stones=get_inner_stones(x, y, BOARD_MAT_ABS)
%     
%     %Falls kein innerer Punkt
%      inner_stones=[0,0];
%      
%     %Pr�fen, ob Punkt am Rand horizontal
%         if ((x-2)<2)
%             l_r=1;
%             h_r=x+2;
%         elseif ((x+2)>7)
%             l_r=x-2;
%             h_r=8;
%         else
%             l_r=x-2;
%             h_r=x+2;
%         end 
% 
% 
%     %Pr�fen, ob Punkt am Rand vertikal
%         if ((y-2)<2)
%             l_c=1;
%             h_c=y+2;
%         elseif ((y+2)>7)
%             l_c=y-2;
%             h_c=8;
%         else
%             l_c=y-2;
%             h_c=y+2;
%         end 
% 
%         buffer_r=x;
% 
%     %Pr�fe, ob Summe der Zeilen > 3
%     while buffer_r<h_r
%         if (sum(BOARD_MAT_ABS(buffer_r, l_c:h_c))<3)
%             break;
%         end
%         buffer_r=buffer_r+1;
%     end
%     h_r=buffer_r;
%     buffer_r=x;
% 
%     while( buffer_r>l_r)
% 
%         if (sum(BOARD_MAT_ABS(buffer_r, l_c:h_c))<3)
%             break;
%         end
%         buffer_r=buffer_r-1;
%     end
% 
%     l_r=buffer_r;
% 
%     %Finden der inneren Punkte
%     if ((h_r-l_r)>2)
% 
%         k=1;
% 
%         for i=l_r:(h_r-2)
% 
%             %Ersten 3 Zeilen aufsummieren
%             if(i==l_r)
%                 test_vek=BOARD_MAT_ABS(i, l_c:h_c)+BOARD_MAT_ABS(i+1, l_c:h_c)+BOARD_MAT_ABS(i+2, l_c:h_c);
% 
%             %Folgenden 3 Zeilen aufsummieren
%             else
%                 test_vek= test_vek+BOARD_MAT_ABS(i+2, l_c:h_c)-BOARD_MAT_ABS(i-1, l_c:h_c);
%             end
% 
%             %3 aufeinander folgende Glieder aufsummieren
%             for j=(2):(h_c-l_c)
%                 if (j==2)
%                     testsum=sum(test_vek(j-1:j+1));
%                 else
%                     testsum=testsum+test_vek(j+1)-test_vek(j-2);
% 
%                 end
% 
%                 %Innerer Punkt, falls Summe=9
%                 if (testsum>8)
%                     inner_stones(k, 1)=i+1; 
%                     inner_stones(k, 2)=j+l_c-1;
%                     k=k+1;
%                 end
%             end
%         end
% 
%     end
        
        
        
        
    function [border_counters_value, border_counters_bool]=border_counters_rating(color, BOARD_MAT, Inner_Counters)
        
        
%        new_inner_stones=get_inner_stones(x, y, BOARD_MAT_ABS);
%         
%         if(max(new_inner_stones)>0)
%             if(max(Inner_Counters)>0)
%             Inner_Counters=[Inner_Counters; new_inner_stones];
%             else
%             Inner_Counters=new_inner_stones;
%             end
%         end
%         
        if(max(Inner_Counters)>0)
            [r, c]=size(Inner_Counters);
            for i=1:r
                BOARD_MAT(Inner_Counters(i,1),Inner_Counters(i,2))=0;
            end
        end
        
        border_counters_value=sum(sum(BOARD_MAT))*(color);
        
        if border_counters_value>=0
            border_counters_bool=1;
        else
            border_counters_bool=-1;
        end
%         
%         if color==1
%             borders_counters_value=sum(find(BOARD<0))/sum(abs(BOARD));
%         else
%             borders_counters_value=sum(find(BOARD<0))/sum(abs(BOARD));
%         end
%             
        
            
            
     %Funktionsbeschreibung:
    %...
    %inputs:
    
    %   @Color: Spielerfarbe
    %   @BOARD_MAT aktuelles Spielbrett 8*8 Matrix mit 1=schwarz -1=weiß null=freies Feld
    
    %outputs
    %   @inner_stones_value: Vektor mit x,y-Positionen der inneneren Steine
    
    function [inertia_moment_value,inertia_moment_bool]=inertia_moment_rating(color, BOARD_MAT,move_no)
       eigene_spielsteine_vec=zeros(move_no+4,2);
       eigene_spielsteine=0;
       gegnerische_spielsteine_vec=zeros(move_no+4,2);
       gegnerische_spielsteine=0;
       Xs=0;
       Ys=0;
       Xg=0;
       Yg=0;
       
       %Schwerpunkt ermitteln und die eigenen Steine und deren Position in
       %einem Vektor abspeichern
        for i=1:8
            for j=1:8
                if(BOARD_MAT(i,j)==color)
                   eigene_spielsteine=eigene_spielsteine+1;
                   eigene_spielsteine_vec(eigene_spielsteine,1)=i;
                   eigene_spielsteine_vec(eigene_spielsteine,1)=j;
                   Xs=Xs+i;
                   Ys=Ys+j;
                elseif(BOARD_MAT(i,j)==-color)
                   gegnerische_spielsteine=gegnerische_spielsteine+1;
                   gegnerische_spielsteine_vec(gegnerische_spielsteine,1)=i;
                   gegnerische_spielsteine_vec(gegnerische_spielsteine,1)=j;
                   Xg=Xg+i;
                   Yg=Yg+j;
                end
            end
        end
        
        %Flächenträgheitsmoment ermitteln
        if(eigene_spielsteine>0)
        Xs=Xs/eigene_spielsteine;
        Ys=Ys/eigene_spielsteine;
        end
        if(gegnerische_spielsteine>0)
        Xg=Xg/gegnerische_spielsteine;
        Yg=Yg/gegnerische_spielsteine;
        end
        A=[Xs,Ys];
        A=repmat(A,eigene_spielsteine,1);
        B=[Xg,Yg];
        B=repmat(B,gegnerische_spielsteine,1);
        
        own_inertia_moment_value=eigene_spielsteine_vec(1:eigene_spielsteine,:)-A;
        own_inertia_moment_value=own_inertia_moment_value.*own_inertia_moment_value;
        own_inertia_moment_value=sum(sum(own_inertia_moment_value));
        
        foreign_inertia_moment_value=gegnerische_spielsteine_vec(1:gegnerische_spielsteine,:)-B;
        foreign_inertia_moment_value=foreign_inertia_moment_value.*foreign_inertia_moment_value;
        foreign_inertia_moment_value=sum(sum(foreign_inertia_moment_value));
        
        inertia_moment_value=own_inertia_moment_value-foreign_inertia_moment_value;
        if inertia_moment_value>=0
            inertia_moment_bool=1;
        else
            inertia_moment_bool=-1;
        end
    
     %Funktionsbeschreibung:
    %...
    %inputs:
    
    %   @Color: Spielerfarbe
    %   @BOARD_MAT aktuelles Spielbrett 8*8 Matrix mit 1=schwarz -1=weiß null=freies Feld
    
    %outputs
    %   @inner_stones_value: Vektor mit x,y-Positionen der inneneren Steine
    
    function [compl_lines_value, compl_lines_bool]= compl_lines_rating(color, BOARD_MAT)
        rows=sum(BOARD_MAT);
        columns=sum(BOARD_MAT,2);
        
        %
        compl_lines_value=size(find(rows==color*8),2)+size(find(columns==color*8),1);
        compl_lines_value=compl_lines_value-size(find(rows==-color*8),2)-size(find(columns==-color*8),1);
        
        if compl_lines_value>0
            compl_lines_bool=1;
        elseif(compl_lines_value==0)
             compl_lines_bool=0;
        else
            compl_lines_bool=-1;
        end
      
        
