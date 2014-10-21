%% funcion que escribe el los errores obtenidos con las maquinas vector de
%% soporteya sea de entrenamiento, validacion y test. y termina
%% escribiendolo todo en prueba.xslx en la hoja 1
function [Cfinal, Sfinal, exactitud_ent_red, exactitud_ent_sr, precision_clase_e_indice_kappa] = Escribe(svmFinal, Cfinal, Sfinal, DATA, DATAFIN, TEST)

tar = DATA(:,14:15);
ext = DATA(:,1:13);

tartst = DATAFIN(:,14:15);
exttst = DATAFIN(:,1:13);

if(~isempty(TEST))
    tartest = TEST(:,14:15);
    exttest = TEST(:,1:13);
else
    tartest = [];
    exttest = [];
end
tar( tar == 0 ) = -1;
tartst( tartst == 0 ) = -1;
tartest( tartest == 0 ) = -1;


d = data(ext,tar);
d2 = data(exttst,tartst);
d3 = data(exttest,tartest);

% indicadores de exactitud por clase y general cjto entrenamiento reducido
tst = test(svmFinal,d2,'confusion_matrix');
matriz = tst.Y';
exactitud_ent_red = calculaError(matriz,1);

% indicadores de exactitud por clase y general cjto entrenamiento s/reducir
tst1 = test(svmFinal,d,'confusion_matrix');
matriz2 = tst1.Y';
exactitud_ent_sr = calculaError(matriz2,1);

if(~isempty(TEST))
    % Precision por clase e indice kappa
    tst2=test(svmFinal,d3,'confusion_matrix');
    matriz3 = tst2.Y';
    precision_clase_e_indice_kappa = calculaError(matriz3,3);
else
    precision_clase_e_indice_kappa = ['','','','','','','','',''];
end

end