% Función que agrega la columna de ruido en la columna 16 siguiendo esta regla:
% si la señal es P o S (col. 14 o 15 igual a 1) su valor es 0, sino su valor es
% 1.
function [matrix] = addNoiseColumn(matrix)

for i = 1:size(matrix, 1)
    if(matrix(i,14) == 1 || matrix(i,15) == 1)
        value = 0;
    else
        value = 1;
    end
    matrix(i,16) = value;
end