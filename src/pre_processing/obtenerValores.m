function [total, intervalos] = obtenerValores(n_estaciones, prueba, ventanas, filtro)

diary('Intervalos.txt');
diary on

% Total estaciones de entrenamiento + validación = 1590
% Total estaciones de prueba = 1580

if(prueba)
    aumento = 100000;
    stations_path = '~/Dev/p_s_signal_sorter/test_data/stations/Estacion';
else
    aumento = 0;
    stations_path = '~/Dev/p_s_signal_sorter/stations/Estacion';
end


total = 0;
intervalos = [];

ventanas = ventanas*50; % La cantidad de segundos se multiplica por la Fs.
                        % Así se pasa de segundos a cantidad de filas.
                       
for ventana = ventanas
    for i = 0 : n_estaciones - 1
        disp(strcat('Revisando archivo: Estacion', num2str(i + aumento)));
        [num, intervalos] = GeneraIntervalos(ventana, 50, i + aumento, intervalos, stations_path, filtro);
        total = num + total;
    end
end

diary off

end