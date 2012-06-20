%  Gruppe D
%  
%  

function b = PlayerD(b, color, t)

 addpath(['players' filesep 'PlayerD']);
 
 tic;
 b = openingmoves(b,color);
 time = toc;
 disp(time);
 
end
