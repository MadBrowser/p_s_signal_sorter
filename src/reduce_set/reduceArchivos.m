function [] = reduceArchivos(filterName)

% Orden de los filtros
orders = [2, 4, 6];

% Tamaños de ventana
windows = [2,3,4,5,6,7,8,9,10];

% Ruta donde se encuentran los archivos
generalDataPath = '~/Dev/p_s_signal_sorter/Data/';

% Ruta donde están los archivos correspondientes a un tipo de filtro
dataPath = strcat(generalDataPath, filterName, '/');

for i = orders
    for j = windows
        % Estructura principal para el nombre de los archivos, ej:
        % 'Bessel_2_3s'
        fileNameStructure = strcat(filterName, '_', num2str(i), '_', num2str(j), 's');
        fileName = strcat(dataPath, fileNameStructure, '.mat');
        load(fileName);
        disp('Revisando archivo: ');
        disp(fileName);
        
        training_ext_red = Reduce(training_ext_sr);
        
        save(fileName, 'training_ext_sr', 'training_ext_red', 'testing_ext_sr');
    end
end
end

