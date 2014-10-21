% Función que recorre los archivos y agrega en la 13ava columna el promedio de
% los extractores.
function [] = addMeanValue(filterName)
% Variables globales

% Orden de los filtros
orders = [2, 4, 6];

% Tamaños de ventana
windows = [2, 3, 4, 5, 6, 7, 8, 9, 10];

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
        
        disp(fileName);
        
        for k = 1:length(training_ext_sr)
            training_ext_sr(k, 13) = sum(training_ext_sr(k,1:12)) / 12;
        end
        for k = 1:length(training_ext_red)
            training_ext_red(k, 13) = sum(training_ext_sr(k,1:12)) / 12;
        end
        for k = 1:length(testing_ext_sr)
            testing_ext_sr(k, 13) = sum(training_ext_sr(k,1:12)) / 12;
        end
        
        save(fileName, 'training_ext_sr', 'training_ext_red', 'testing_ext_sr');
    end
end
