function b = openingmoves(table,color)
%OPENINGMOVES Summary of this function goes here
%   Detailed explanation goes here

%test table
%             table =  [0  0  0  0  0  0  0  0; ...
%                       0  0  0  0  0  0  0  0; ...
%                       0  0  0  0  0  0  0  0; ...
%                       0  0  0  1 -1  0  0  0; ...
%                       0  0  0 -1  1 -1  0  0; ...
%                       0  0  0  0  0  0  0  0; ...  
%                       0  0  0  0  0  0  0  0; ...
%                       0  0  0  0  0  0  0  0;];
%              color = 1;
% 

persistent lastmovetable;               %% letztes Spielbrett  
persistent lastmove;                    %% letzer Spielzug vom Gegner
persistent lastmovestr;                 %% letzen Spielzüge als String
persistent startindex;                  %% Startindex in der Suchliste am Anfang 1
persistent stopindex;                   %% Stopindex in der Suchliste am Anfang Ende der Liste
%persistent finishflag;                  %% Zeigt das Ende der Eröffnungszüge an
if color == -1
    persistent mlfirst;
else
    persistent mlsecond;
end
% if isempty(finishflag)
%     finishflag = 0;
% end

   %if finishflag == 0                  %% solange 0 dann werden Eröffnungszüge gesucht
        
        %%Initialisierung
        if color == -1
            [lastmove mlfirst startindex stopindex lastmovetable] = init_var(lastmove, mlfirst, startindex, stopindex, lastmovetable, color);
        else
            [lastmove mlsecond startindex stopindex lastmovetable] = init_var(lastmove, mlsecond, startindex, stopindex, lastmovetable, color);
        end
        %%ende Initialisierung
        
        lastmove = lastmovecal(table,lastmovetable);       %% berechne letzen Zug
        
        if color == -1
            if lastmove.row == 0 && lastmove.col == 0          %% --> ich fange an
                % zufällisum(max(difftable,[],1))g ersten Anfang wählen
                index = randi(stopindex,1,1);
                str = mlfirst{index};
                newmove.row = str(3)-48;
                newmove.col = str(2);
            else                                               %% --> Gegener hat angefangen
        %% tabelle noch mit invertieren dass -d3 gleich schwarz ist und nicht weiss 
                lmovestr = sprintf('+%s%s',lastmove.col,(lastmove.row+48));  %% in mlfirst ist schwarz +1 
                lastmovestr = [lastmovestr,lmovestr];
                [newmove startindex stopindex] = findnewmove(mlfirst, startindex, stopindex, lastmovestr);
            end
        else
            %% --> Gegner hat angefangen
                lmovestr = sprintf('-%s%s',lastmove.col,(lastmove.row+48));
                lastmovestr = [lastmovestr,lmovestr];
                [newmove startindex stopindex] = findnewmove(mlsecond, startindex, stopindex, lastmovestr);
        end
        
        if startindex == stopindex
            b = table;                   %% Ende der Anfangszüge gibt gleiche Matrix zurück
            %%finishflag = 1;
            clear mlfirst;                %% gebe Speicher frei
            clear mlsecond;
            clear lastmovetable;
            clear lastmove;
            clear lastmovestr;
            clear startindex;
            clear stopindex;
            disp('opening moves finished');
            return;
        end
        
        if color == -1
            str = sprintf('+%s%s',newmove.col,(newmove.row+48));
            lastmovestr = [lastmovestr,str];                    %% aktualisiere moveliste mit eigenen Zug
        else
            str = sprintf('-%s%s',newmove.col,(newmove.row+48));
            lastmovestr = [lastmovestr,str];                    %% aktualisiere moveliste mit eigenen Zug
        end
        
        b = calculatenewtable(table,newmove,color);
%    end
    
end




function [lastmove movelist startindex stopindex lastmovetable] = init_var(lastmove, movelist, startindex, stopindex, lastmovetable, color)

    %% initialisierung
        if isempty(lastmove)
            lastmove.row = 0;
            lastmove.col = 0;
            %%lastmove.count = 0;
        end
        
        if color == -1
            if isempty(movelist)
               load('mlfirst.mat');
               movelist = mlfirst;
            end
        else
            if isempty(movelist)
               load('mlsecond.mat');
               movelist = mlsecond;
            end
        end
        

        if isempty(startindex)
            startindex = 1;
            stopindex = length(movelist);
        end


        if isempty(lastmovetable)

            lastmovetable =  [0  0  0  0  0  0  0  0; ...
                              0  0  0  0  0  0  0  0; ...
                              0  0  0  0  0  0  0  0; ...
                              0  0  0  1 -1  0  0  0; ...
                              0  0  0 -1  1  0  0  0; ...
                              0  0  0  0  0  0  0  0; ...  
                              0  0  0  0  0  0  0  0; ...
                              0  0  0  0  0  0  0  0;]
            %%lastmove.count = 1;
        end
        %% ende Initialisierung


end




