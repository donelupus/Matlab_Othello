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

    for index = 1:6
             
         if ~(((posrow+h*index) > 8) || ((poscol+v*index) > 8) ||...
              ((posrow+h*index) < 1) || ((poscol+v*index) < 1))
          
            if(oldtable(posrow+h*index,poscol+v*index) == (-1)*color )
                  
               if ~(((posrow+h*(index + 1)) > 8) || ((poscol+v*(index + 1)) > 8) ||...
                    ((posrow+h*(index + 1)) < 1) || ((poscol+v*(index + 1)) < 1))
                    
                    if(oldtable(posrow+h*(index+1),poscol+v*(index+1)) == color) 
                        for k = 1:index
                            oldtable(posrow+h*k,poscol+v*k) = color;
                        end
                    end
               end
            else 
               break;
            end
         end
    end
        newtable = oldtable;
end
