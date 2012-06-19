function [newtable] = calculatenewtable(oldtable,newmove,color)
%CALCULATENEWTABLE Summary of this function goes here
%   Detailed explanation goes here

posrow = newmove.row;
poscol = newmove.col;

oldtable = setrowline(oldtable, poscol, posrow, color, -1,  0); % horinzontal links       
oldtable = setrowline(oldtable, poscol, posrow, color,  1,  0); % horinzontal rechts
oldtable = setrowline(oldtable, poscol, posrow, color,  0,  1); % vertikal oben
oldtable = setrowline(oldtable, poscol, posrow, color,  0, -1); % vertikal unten
oldtable = setrowline(oldtable, poscol, posrow, color, -1, -1); % diag unten links
oldtable = setrowline(oldtable, poscol, posrow, color,  1, -1); % diag  unten rechts
oldtable = setrowline(oldtable, poscol, posrow, color, -1,  1); % diag  oben links
newtable = setrowline(oldtable, poscol, posrow, color,  1,  1); % diag  oben rechts
newtable(posrow,poscol) = color; 

end


function [newtable] = setrowline(oldtable, poscol, posrow, color, h,v)

    for index = 1:7
             
         if ~(((posrow+h*index) > 7) || ((poscol+v*index) > 7) ||...
              ((posrow+h*index) < 2) || ((poscol+v*index) < 2))
          
            if(oldtable(posrow+h*index,poscol+v*index) == (-1)*color )
                if(oldtable(posrow+h*(index+1),poscol+v*(index+1)) == color) 
                    for k = 1:index
                        oldtable(posrow+h*k,poscol+v*k) = color;
                    end
                end    
            else 
                break;
            end
         end  
    end
        newtable = oldtable;
end
