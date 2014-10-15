% Funci�n que recorre las carpetas con los archivos y re�ne en un s�lo archivo
% con nombre <filtro>_<orden>_<ventana> y que tiene como data el conjunto de
% entrenamiento reducido y total (sin reducir) adem�s del conjunto de
% extractores de prueba (sin reducir)
function [] = creaArchivosParaSvm(filterName)
% Variables globales

% Orden de los filtros
orders = [2, 4, 6];

% Tama�os de ventana
windows = [2, 3, 4, 5, 6, 7, 8, 9, 10];

% Ruta donde se encuentran los archivos
generalDataPath = '~/Dev/p_s_signal_sorter/Data/';

% Ruta donde est�n los archivos correspondientes a un tipo de filtro
dataPath = strcat(generalDataPath, filterName, '/');

for i = orders
    for j = windows  
       % Estructura principal para el nombre de los archivos, ej:
       % 'Bessel_2_3s'
       fileNameStructure = strcat(filterName, '_', num2str(i), '_', num2str(j), 's');
       
       % Entrenamiento
       trainingName = '_entrenamiento.mat';
       % Prueba
       testingName = '_prueba.mat';
       
       % Extractores sin reducir
       fileName = strcat(strcat(fileNameStructure, '_extractores'), trainingName);
       fullPath = strcat(dataPath, fileName);
       load(fullPath, 'extractores');
       training_ext_sr = extractores;
       
       % Extractores reducido
       fileName = strcat(strcat(fileNameStructure, '_reducido'), trainingName);
       fullPath = strcat(dataPath, fileName);
       load(fullPath, 'reducido');
       training_ext_red = reducido;
       
       % Extractores prueba
       fileName = strcat(strcat(fileNameStructure, '_extractores'), testingName);
       fullPath = strcat(dataPath, fileName);
       load(fullPath, 'extractores');
       testingext_red = extractores;
       
       fileName = strcat(dataPath, fileNameStructure, '.mat');
       save(fileName, 'training_ext_sr', 'training_ext_red', 'testingext_red');
    end
end
    
