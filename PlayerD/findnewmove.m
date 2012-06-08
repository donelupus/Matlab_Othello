function [ newmove startindex stopindex] = findnewmove(mlist, startindex, stopindex, lastmovestr)
%FINDNEWMOVE Summary of this function goes here
%   Detailed explanation goes here

    startflag = 0;
        for index = startindex:stopindex-1
               
            [trash pindex] = regexp(mlist{index},['(\<)',lastmovestr], 'match');
            if pindex                            %%strfind(movelist{index},lastmovestr)
                   
                    [trash pindex] = regexp(mlist{index},['(\<)',lastmovestr,'(\>)'],'match');
                    [trash pindex2] = regexp(mlist{index+1},['(\<)',lastmovestr],'match');
                    
                if pindex
                    if pindex2 
                    startindex = index + 1;
                    startflag = 1;
                    end
                elseif startflag == 0;
                    startindex = index;
                    startflag = 1;
                end

            elseif startflag == 1;
                    stopindex = index-1;
                    break;
            end
        end
        
        if startflag == 0
            startindex = stopindex;
        end
        
        
        if startindex == stopindex
            newmove.row = 0;
            newmove.col = 0;
        else
            [match posend] = regexp(mlist{startindex},['(\<)',lastmovestr],'match','end');
            str = mlist{startindex};
            newmove.row = str(posend+3)-48;
            newmove.col = str(posend+2);
        end
end

