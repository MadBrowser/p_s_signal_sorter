function [total, intervalos] = obtenerValores(numeroMax)

diary('Intervalos.txt');
diary on

total = 0;
intervalos = [];
for i = 0 : numeroMax
    disp(strcat('Revisando archivo: Estacion', num2str(i)));
    [num, intervalos] = GeneraIntervalos(150, 50, i, intervalos);
    total = num + total;

end

diary off

end