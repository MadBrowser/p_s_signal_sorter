%% Funcion que define la multiple coincidencia de la señal P o S en P
function [DATAFIN] = cambiaDoble(DATA)
if(~isempty(DATA))
    tar = DATA(:,14:15);
    %tar = DATA(:,15:17);
    tar2 = tar(:,1) + tar(:,2) ;
    %+ tar(:,3);
    pos = find(tar2 >=2);
    DATA(pos,14) = 1;
    DATA(pos,15) = -1;
%   DATA(pos,15) = 1;
%   DATA(pos,16) = -1;
%   DATA(pos,17) = -1;

    DATAFIN = DATA;
else
    DATAFIN = [];
end

end