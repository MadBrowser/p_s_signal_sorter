function [total, intervalos] = obtenerValores(numeroMax)

diary('Intervalos.txt');
diary on

% Total estaciones de entrenamiento + validación = 1590
% Total estaciones de prueba = 1580

% aumento = 100000;
aumento = 0;

stations_path = '~/Dev/p_s_signal_sorter/stations/Estacion';
test_stations_path = '~/Dev/p_s_signal_sorter/test_data/stations/Estacion';


total = 0;
intervalos = [];
for i = 0 : numeroMax - 1
    disp(strcat('Revisando archivo: Estacion', num2str(i + aumento)));
    [num, intervalos] = GeneraIntervalos(400, 50, i + aumento, intervalos, stations_path);
    total = num + total;
end

diary off

end