function RealizarTest()

conjuntos = {
    'Cjto1,1', 'DATAFIN7', 'Test1';'Cjto2,1', 'DATAFIN7', 'Test2';'Cjto3,1', 'DATAFIN7', 'Test3';
    'Cjto4,1', 'DATAFIN6', 'Test4';'Cjto5,1', 'DATAFIN6', 'Test5';'Cjto6,1', 'DATAFIN6', 'Test6';
    'Cjto7,1', 'DATAFIN7', 'Test7';'Cjto8,1', 'DATAFIN8', 'Test8';'Cjto9,1', 'DATAFIN8', 'Test9';
    'Cjto9,71', 'DATAFIN8', 'Test9,71';'Cjto9,72', 'DATAFIN8', 'Test9,72';'Cjto9,81', 'DATAFIN7', 'Test9,81';
    'Cjto9,82', 'DATAFIN8', 'Test9,82';'Cjto9,91', 'DATAFIN7', 'Test9,91';'Cjto9,92', 'DATAFIN7', 'Test9,92';
    'Cjto10,1', 'DATAFIN7', 'Test10';'Cjto11,1', 'DATAFIN7', 'Test11';
    'Cjto12,1', 'DATAFIN8', 'Test12';
    'Cjto13,1', 'DATAFIN7', 'Test13';'Cjto14,1', 'DATAFIN7', 'Test14';'Cjto15,1', 'DATAFIN8', 'Test15';
    'Cjto16,1', 'DATAFIN7', 'Test16';'Cjto17,1', 'DATAFIN7', 'Test17';'Cjto18,1', 'DATAFIN7', 'Test18';
    'Cjto19,1', 'DATAFIN7', 'Test19';'Cjto20,1', 'DATAFIN7', 'Test20';'Cjto20,71', 'DATAFIN7', 'Test20,71';
    'Cjto20,72', 'DATAFIN7', 'Test20,72';'Cjto20,81', 'DATAFIN7', 'Test20,81';'Cjto20,82', 'DATAFIN7', 'Test20,82';
    'Cjto20,91', 'DATAFIN6', 'Test20,91';'Cjto20,92', 'DATAFIN6', 'Test20,92';'Cjto21,1', 'DATAFIN6', 'Test21';
    'Cjto22,1', 'DATAFIN6', 'Test22';
    'Cjto23,1', 'DATAFIN8', 'Test23';'Cjto24,1', 'DATAFIN8', 'Test24';
    'Cjto25,1', 'DATAFIN8', 'Test25';'Cjto26,1', 'DATAFIN8', 'Test26';'Cjto27,1', 'DATAFIN7', 'Test27';
    'Cjto28,1', 'DATAFIN7', 'Test28';'Cjto29,1', 'DATAFIN7', 'Test29';'Cjto30,1', 'DATAFIN7', 'Test30';
    'Cjto31,1', 'DATAFIN7', 'Test31';'Cjto31,71', 'DATAFIN7', 'Test31,71';'Cjto31,72', 'DATAFIN7', 'Test31,72';
    'Cjto31,81', 'DATAFIN7', 'Test31,81';'Cjto31,82', 'DATAFIN6', 'Test31,82';'Cjto31,91', 'DATAFIN7', 'Test31,91';
    'Cjto31,92', 'DATAFIN6', 'Test31,92';'Cjto32,1', 'DATAFIN7', 'Test32';'Cjto33,1', 'DATAFIN6', 'Test33'
    };

for i = 1:length(conjuntos)    
    TEST = [];    
    try
       load(strcat(conjuntos{i,1},'.mat'));
       disp(strcat(conjuntos{i,1},'.mat'));
       DATATOT = DATA;       
       try
          load(strcat(conjuntos{i,3},'.mat'),'DATA');
          disp(strcat(conjuntos{i,3},'.mat'));
          TEST = DATA;
       catch
            disp('Archivo de Test no existe');
       end       
    catch
        disp('Archivo no existe');
%         disp(strcat(conjuntos(i,1),'.mat'));
        continue;
    end
           
    Cfinal = 0;
    Sfinal = 0;
    media = 0;
    maximo = 0;
    
    if(exist('DATAFIN8'))
        Escribe(svmFinal, Cfinal, Sfinal, cambiaDoble(DATATOT), cambiaDoble(DATAFIN8), cambiaDoble(TEST),i,'SVM')
        escribeErrRNJ(redSgc,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN8),cambiaDoble(DATATOT),i,'Entrenamiento SCG');
        escribeErrRNJ(redLM,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN8),cambiaDoble(DATATOT),i,'Entrenamiento LM');
        escribeErrRNJ(redBr,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN8),cambiaDoble(DATATOT),i,'Entrenamiento BR');
        escribeErrRNJ(redGDM,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN8),cambiaDoble(DATATOT),i,'EntrenamientoGDM');
        escribeErrRNJ(redGDA,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN8),cambiaDoble(DATATOT),i,'Entrenamiento GDA');
        clearvars DATAFIN8 DATAFIN7 DATAFIN6;
    elseif(exist('DATAFIN7'))
        Escribe(svmFinal, Cfinal, Sfinal, cambiaDoble(DATATOT), cambiaDoble(DATAFIN7), cambiaDoble(TEST),i,'SVM')
        escribeErrRNJ(redSgc,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN7),cambiaDoble(DATATOT),i,'Entrenamiento SCG');
        escribeErrRNJ(redLM,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN7),cambiaDoble(DATATOT),i,'Entrenamiento LM');
        escribeErrRNJ(redBr,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN7),cambiaDoble(DATATOT),i,'Entrenamiento BR');
        escribeErrRNJ(redGDM,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN7),cambiaDoble(DATATOT),i,'EntrenamientoGDM');
        escribeErrRNJ(redGDA,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN7),cambiaDoble(DATATOT),i,'Entrenamiento GDA');
        clearvars DATAFIN7 DATAFIN6;
    elseif(exist('DATAFIN6'))
        Escribe(svmFinal, Cfinal, Sfinal, cambiaDoble(DATATOT), cambiaDoble(DATAFIN6), cambiaDoble(TEST),i,'SVM')
        escribeErrRNJ(redSgc,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN6),cambiaDoble(DATATOT),i,'Entrenamiento SCG');
        escribeErrRNJ(redLM,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN6),cambiaDoble(DATATOT),i,'Entrenamiento LM');
        escribeErrRNJ(redBr,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN6),cambiaDoble(DATATOT),i,'Entrenamiento BR');
        escribeErrRNJ(redGDM,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN6),cambiaDoble(DATATOT),i,'EntrenamientoGDM');
        escribeErrRNJ(redGDA,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN6),cambiaDoble(DATATOT),i,'Entrenamiento GDA');
        clearvars DATAFIN6;
    end
end
end

%% Funcion que define la multiple coincidencia de la señal P o S en P
function [DATAFIN] = cambiaDoble(DATA)
if(~isempty(DATA))
    tar = DATA(:,15:17);
    tar2 = tar(:,1) + tar(:,2) + tar(:,3);
    pos = find(tar2 >=2);
    DATA(pos,15) = 1;
    DATA(pos,16) = -1;
    DATA(pos,17) = -1;

    DATAFIN = DATA;
else
    DATAFIN = [];
end
end


%% funcion que escribe el error de las redes neuonales

function escribeErrRNJ(red, media, maximo,TEST,DATAFIN,DATA,i,hoja)

nombre = 'Datos Finales.xlsx';

tam = length(DATA);
inicial = 2;

outputs = sim(red,DATAFIN(:,1:14)');
[~,cm,~,~] = confusion(DATAFIN(:,15:17)',outputs);

escribe = calculaError(cm',1);

outputs = sim(red,DATA(:,1:14)');
[~,matriz,~,~] = confusion(DATA(:,15:17)',outputs);
escribe2 = calculaError(matriz',1);

if(~isempty(TEST))
    outputs = sim(red,TEST(:,1:14)');
    [~,mat,~,~] = confusion(TEST(:,15:17)',outputs);
    escribe3 = calculaError(mat',3);
else
    escribe3 = ['','','','','','','','',''];
end

xlswrite(nombre, [escribe, escribe2, escribe3, 'P y S'],hoja,strcat('U',int2str(i + inicial)));

end


%% funcion que escribe el los errores obtenidos con las maquinas vector de
%% soporteya sea de entrenamiento, validacion y test. y termina
%% escribiendolo todo en prueba.xslx en la hoja 1
function Escribe(svmFinal, Cfinal, Sfinal, DATA, DATAFIN, TEST, i,hoja)

tam = length(DATAFIN);
inicial = 2;

tar = DATA(:,15:17);
ext = DATA(:,1:14);

tartst = DATAFIN(:,15:17);
exttst = DATAFIN(:,1:14);

if(~isempty(TEST))
    tartest = TEST(:,15:17);
    exttest = TEST(:,1:14);
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

nombre = 'Datos Finales.xlsx';

tam = length(DATA);
inicial = 2;

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

xlswrite(nombre, [ escribe, escribe2, escribe3, 'O Vs A'],hoja,strcat('P',int2str(i + inicial)));

end