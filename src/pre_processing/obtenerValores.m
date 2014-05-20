function [total, intervalos] = obtenerValores(numeroMax)

diary('Intervalos.txt');
diary on

% Total estaciones de entrenamiento + validación = 1590
% Total estaciones de prueba = 1580

total = 0;
intervalos = [];
for i = 0 : numeroMax - 1
    disp(strcat('Revisando archivo: Estacion', num2str(i)));
    [num, intervalos] = GeneraIntervalos(400, 50, i, intervalos);
    total = num + total;
end

diary off

end