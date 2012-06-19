function [] = converter()
%CONVERTER Summary of this function goes here
%   Detailed explanation goes here
%   dieser Converter liest eine Matrix ein welche nur aus Zeilen mit
%   Strings besteht in denen eine Spielabfolge abgespeichert ist und
%   wandelt diese in eine nx60 Matrix um

load mlfirst2dnum.mat;
load mlsecond2dnum.mat;

mlfirstnum = zeros(length(mlfirst2dnum),65);
mlsecondnum = zeros(length(mlsecond2dnum),65);


for i=1:length(mlfirst2dnum)
    str = mlfirst2dnum{i};
    vorzeichen = '-';                                % immer da schwarz beginnt
    index = 1;
    for j=1:4:length(str)-3
        
        if( str(j) == vorzeichen)                   % überprüfen ob ein Zug ausgelassen worden ist
            mlfirstnum(i,index) = str2num(sprintf('%s%s',str(j+1),str(j+3)));
            index = index + 1; 
        else
            mlfirstnum(i,index) = 0;
            mlfirstnum(i,index+1) = str2num(sprintf('%s%s',str(j+1),str(j+3)));
            index = index + 2;
            if (vorzeichen == '-') vorzeichen = '+';
            else vorzeichen = '-'; end
        end
        if (vorzeichen == '-') vorzeichen = '+';
        else vorzeichen = '-'; end
    end
end


for i=1:length(mlsecond2dnum)
    str = mlsecond2dnum{i};
    vorzeichen = '-';                                % immer da schwarz beginnt
    index = 1;
    for j=1:4:length(str)-3
        
        if( str(j) == vorzeichen)                   % überprüfen ob ein Zug ausgelassen worden ist
            mlsecondnum(i,index) = str2num(sprintf('%s%s',str(j+1),str(j+3)));
            index = index + 1;
        else
            mlsecondnum(i,index) = 0;
            mlsecondnum(i,index+1) = str2num(sprintf('%s%s',str(j+1),str(j+3)));
            index = index + 2;
            if (vorzeichen == '-') vorzeichen = '+';
            else vorzeichen = '-'; end
        end
        if (vorzeichen == '-') vorzeichen = '+';
        else vorzeichen = '-'; end
    end
end

save('mlfirstnum.mat','mlfirstnum');
save('mlsecondnum.mat','mlsecondnum');
