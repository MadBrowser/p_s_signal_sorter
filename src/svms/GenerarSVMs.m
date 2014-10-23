%% Funcion automatizada que recorre cada conjunto y va generando la SVM
%% correspondiente y luego la evalua y anota los errores termina
%% guardandola en el conjunto correspondiente
function GenerarSVMs(filterName)

% Orden de los filtros
orders = [2, 4, 6];

% Tamaños de ventana
windows = [2, 3, 4, 5, 6, 7, 8, 9, 10];

% Ruta donde se encuentran los archivos
generalDataPath = '~/Dev/p_s_signal_sorter/Data/';

% Ruta donde están los archivos correspondientes a un tipo de filtro
dataPath = strcat(generalDataPath, filterName, '/');

% C y S
C = [4.8 5.2];
S = [8.8 9.2];

initialVars = who;

for i = orders
    for j = windows
        % Estructura principal para el nombre de los archivos, ej:
        % 'Bessel_2_3s'
        fileNameStructure = strcat(filterName, '_', num2str(i), '_', num2str(j), 's');
        fileName = strcat(dataPath, fileNameStructure, '.mat');
        load(fileName);
        disp('Revisando archivo: ');
        disp(fileName);
        
        [svmFinal Exac Cfinal Sfinal] = iterSVM(C,S,revisaDoble(training_ext_red));
        
        [Cfinal, Sfinal, exactitud_ent_red, exactitud_ent_sr, precision_clase_e_indice_kappa] = Escribe(svmFinal, Cfinal, Sfinal, cambiaDoble(training_ext_sr), cambiaDoble(training_ext_red), cambiaDoble(testing_ext_sr));
        
        save(fileName, '-append', 'Cfinal', 'Sfinal', 'exactitud_ent_red', 'exactitud_ent_sr', 'precision_clase_e_indice_kappa');
        clearvars('svmFinal', 'Exac', 'Cfinal', 'Sfinal', 'exactitud_ent_red', 'exactitud_ent_sr', 'precision_clase_e_indice_kappa', 'training_ext_sr', 'training_ext_red', 'testing_ext_sr');
    end
end
end


%% Funcion que define la multiple coincidencia de la señal P o S en P
function [DATAFIN] = cambiaDoble(DATA)
if(~isempty(DATA))
    tar = DATA(:,14:16);
    tar2 = tar(:,1) + tar(:,2) + tar(:,3);
    pos = find(tar2 >=2);
    DATA(pos,14) = 1;
    DATA(pos,15) = 0;
    DATA(pos,16) = 0;

    DATAFIN = DATA;
else
    DATAFIN = [];
end

end