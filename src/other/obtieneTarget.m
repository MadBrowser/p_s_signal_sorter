function [target] = obtieneTarget(tiempo,hora)
% funcion cuyo objetivo es generar la salida target deseada 

%extraigo unica y exclusivamente el tiempo asociado
[~,targetT] = strtok(tiempo,'T');
targetT = strrep(targetT, 'T', '');

% comparo y obtengo una lista logica y luego se pasa a tipo entero
target = ismember(targetT, hora);
target=double(target);

end