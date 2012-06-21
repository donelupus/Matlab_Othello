function [ ] = Baum_Speicherung...
        ( Brett, Zug, ValidPos, Store_ValidPos, Bewertung, ID, Ex_ID, Tiefe )
%BAUM_SPEICHERUNG Summary of this function goes here
%   Detailed explanation goes here

persistent  Case_No History1 History2 History3 History4; % Baum_History
Case_No = 4;
History1 = {};
History2 = {};
History3 = {};
History4 = {};
Temp_Cell = {Brett,Zug,ValidPos,Store_ValidPos, Bewertung,ID,Ex_ID};
switch (Case_No - Tiefe)
    case 1
        History1 = {History1,Temp_Cell};
    case 2
        History2 = {History2,Temp_Cell};
    case 3
        History3 = {History3,Temp_Cell};
    case 4
        History4 = {History4,Temp_Cell};
end
% Baum_History = {History1, History2, History3, History4};
end

