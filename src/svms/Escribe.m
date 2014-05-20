%% funcion que escribe el los errores obtenidos con las maquinas vector de
%% soporteya sea de entrenamiento, validacion y test. y termina
%% escribiendolo todo en prueba.xslx en la hoja 1
function [inicio, Cfinal, Sfinal, escribe, escribe2, escribe3] = Escribe(svmFinal, Cfinal, Sfinal, DATA, DATAFIN, TEST, i)

tam = length(DATA);
inicial = 4;

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

nombre = 'pruebaF3.xlsx';
hoja = 'hoja1';

tam = length(DATA);
inicial = 2;


inicio = {i,'SVM',length(DATAFIN),'','','','','',length(DATAFIN), length(DATAFIN(DATAFIN(:,14)==1)), length(DATAFIN(DATAFIN(:,15)==1)), length(DATA)};
    %, length(DATAFIN(DATAFIN(:,17)==1))
%csvwrite(nombre,inicio,hoja,strcat('A',int2str(i + inicial)));


tst=test(svmFinal,d2,'confusion_matrix');
matriz = tst.Y';
escribe = calculaError(matriz,1);

tst1=test(svmFinal,d,'confusion_matrix');
matriz2 = tst1.Y';
escribe2 = calculaError(matriz2,1);

if(~isempty(TEST))
    tst2=test(svmFinal,d3,'confusion_matrix');
    matriz3 = tst2.Y';
    escribe3 = calculaError(matriz3,3);
else
    escribe3 = ['','','','','','','','',''];
end


%csvwrite(nombre, [ Cfinal, Sfinal, escribe, escribe2, escribe3, 'O Vs A'],'hoja1',strcat('N',int2str(i + inicial)));



end