function TARGET = Postprocess()

conjuntos = {
    'Cjto1,1', 'DATAFIN7', 'Test1';%'Cjto12,1', 'DATAFIN8', 'Test12';%'Cjto23,1', 'DATAFIN8', 'Test23';
    'Cjto2,1', 'DATAFIN7', 'Test2';%'Cjto13,1', 'DATAFIN7', 'Test13';'Cjto24,1', 'DATAFIN8', 'Test24';
    'Cjto3,1', 'DATAFIN7', 'Test3';%'Cjto14,1', 'DATAFIN7', 'Test14';'Cjto25,1', 'DATAFIN8', 'Test25';
    'Cjto4,1', 'DATAFIN6', 'Test4';%'Cjto15,1', 'DATAFIN8', 'Test15';'Cjto26,1', 'DATAFIN8', 'Test26';
    'Cjto5,1', 'DATAFIN6', 'Test5';%'Cjto16,1', 'DATAFIN7', 'Test16';'Cjto27,1', 'DATAFIN7', 'Test27';
    'Cjto6,1', 'DATAFIN6', 'Test6';%'Cjto17,1', 'DATAFIN7', 'Test17';'Cjto28,1', 'DATAFIN7', 'Test28';
    'Cjto7,1', 'DATAFIN7', 'Test7';%'Cjto18,1', 'DATAFIN7', 'Test18';'Cjto29,1', 'DATAFIN7', 'Test29';
    'Cjto8,1', 'DATAFIN8', 'Test8';%'Cjto19,1', 'DATAFIN7', 'Test19';'Cjto30,1', 'DATAFIN7', 'Test30';
    'Cjto9,1', 'DATAFIN8', 'Test9';%'Cjto20,1', 'DATAFIN7', 'Test20';'Cjto31,1', 'DATAFIN7', 'Test31';
    'Cjto9,71', 'DATAFIN8', 'Test9,71';%'Cjto20,71', 'DATAFIN7', 'Test20,71';'Cjto31,71', 'DATAFIN7', 'Test31,71';
    'Cjto9,72', 'DATAFIN8', 'Test9,72';%'Cjto20,72', 'DATAFIN7', 'Test20,72';'Cjto31,72', 'DATAFIN7', 'Test31,72';
    'Cjto9,81', 'DATAFIN7', 'Test9,81';%'Cjto20,81', 'DATAFIN7', 'Test20,81';'Cjto31,81', 'DATAFIN7', 'Test31,81';    
    'Cjto9,82', 'DATAFIN8', 'Test9,82';%'Cjto20,82', 'DATAFIN7', 'Test20,82';'Cjto31,82', 'DATAFIN6', 'Test31,82';
    'Cjto9,91', 'DATAFIN7', 'Test9,91';%'Cjto20,91', 'DATAFIN6', 'Test20,91';'Cjto31,91', 'DATAFIN7', 'Test31,91';
    'Cjto9,92', 'DATAFIN7', 'Test9,92';%'Cjto20,92', 'DATAFIN6', 'Test20,92';'Cjto31,92', 'DATAFIN6', 'Test31,92';
    'Cjto10,1', 'DATAFIN7', 'Test10';%'Cjto21,1', 'DATAFIN6', 'Test21';'Cjto32,1', 'DATAFIN7', 'Test32';
    'Cjto11,1', 'DATAFIN7', 'Test11';%'Cjto22,1', 'DATAFIN6', 'Test22';'Cjto33,1', 'DATAFIN6', 'Test33'
    };
i = 1;

for ventana = 100:50:500;
    for traslape = 50:50:100
        for filtro = 1:1
            if(ventana ~= traslape)
                segundos = strcat('DataTest',strcat(num2str(ventana/50),'seg'));
                tras = strcat(num2str(traslape/50),'trasF');
                filter = strcat(num2str(filtro),'.mat');
                file = strcat(segundos,strcat(tras,filter))
                TARGET = ExtraeTiempo(file);
                CalculaTiempo(strcat(conjuntos{i,1},'.mat'),strcat(conjuntos{i,3},'.mat'), TARGET,i);
                i = i + 1;
%                 return ;
            end
        end
    end    
end

end

%% funcion cuyo fin es extraer el tiempo original
function Target = ExtraeTiempo(file)

load(file,'Int');

emptyCells = cellfun(@isempty,Int);
Int(emptyCells) = {0};

Target = Int;

end

%% funcion que calcula el tiempo del archivo de test
function CalculaTiempo(nombre, test, TARGET,i)

TEST = [];    
try
    load(nombre);
    disp(nombre);
    DATATOT = DATA;       
    try
        load(test);
        disp(test);
        TEST = DATA;
    catch
        disp('Archivo de Test no existe');
    end
catch
    disp('Archivo no existe');
%         disp(strcat(conjuntos(i,1),'.mat'));
end
           
Cfinal = 0;
Sfinal = 0;
media = 0;
maximo = 0;
    
    if(exist('DATAFIN8'))
        Escribe(svmFinal, Cfinal, Sfinal, cambiaDoble(DATATOT), cambiaDoble(DATAFIN8), cambiaDoble(TEST),i,'SVM',TARGET);
        escribeErrRNJ(redSgc,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN8),cambiaDoble(DATATOT),i,'Entrenamiento SCG',TARGET);
        escribeErrRNJ(redLM,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN8),cambiaDoble(DATATOT),i,'Entrenamiento LM',TARGET);
        escribeErrRNJ(redBr,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN8),cambiaDoble(DATATOT),i,'Entrenamiento BR',TARGET);
        escribeErrRNJ(redGDM,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN8),cambiaDoble(DATATOT),i,'EntrenamientoGDM',TARGET);
        escribeErrRNJ(redGDA,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN8),cambiaDoble(DATATOT),i,'Entrenamiento GDA',TARGET);
        clearvars DATAFIN8 DATAFIN7 DATAFIN6;
    elseif(exist('DATAFIN7'))
        Escribe(svmFinal, Cfinal, Sfinal, cambiaDoble(DATATOT), cambiaDoble(DATAFIN7), cambiaDoble(TEST),i,'SVM',TARGET)
        escribeErrRNJ(redSgc,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN7),cambiaDoble(DATATOT),i,'Entrenamiento SCG',TARGET);
        escribeErrRNJ(redLM,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN7),cambiaDoble(DATATOT),i,'Entrenamiento LM',TARGET);
        escribeErrRNJ(redBr,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN7),cambiaDoble(DATATOT),i,'Entrenamiento BR',TARGET);
        escribeErrRNJ(redGDM,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN7),cambiaDoble(DATATOT),i,'EntrenamientoGDM',TARGET);
        escribeErrRNJ(redGDA,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN7),cambiaDoble(DATATOT),i,'Entrenamiento GDA',TARGET);
        clearvars DATAFIN7 DATAFIN6;
    elseif(exist('DATAFIN6'))
        Escribe(svmFinal, Cfinal, Sfinal, cambiaDoble(DATATOT), cambiaDoble(DATAFIN6), cambiaDoble(TEST),i,'SVM',TARGET)
        escribeErrRNJ(redSgc,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN6),cambiaDoble(DATATOT),i,'Entrenamiento SCG',TARGET);
        escribeErrRNJ(redLM,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN6),cambiaDoble(DATATOT),i,'Entrenamiento LM',TARGET);
        escribeErrRNJ(redBr,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN6),cambiaDoble(DATATOT),i,'Entrenamiento BR',TARGET);
        escribeErrRNJ(redGDM,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN6),cambiaDoble(DATATOT),i,'EntrenamientoGDM',TARGET);
        escribeErrRNJ(redGDA,media,maximo,cambiaDoble(TEST),cambiaDoble(DATAFIN6),cambiaDoble(DATATOT),i,'Entrenamiento GDA',TARGET);
        clearvars DATAFIN6;
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

function escribeErrRNJ(red, media, maximo,TEST,DATAFIN,DATA,i,hoja,TARGET)

nombre = 'Datos Finales2.xlsx';

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

escribe4 = Compara(outputs,TARGET,0);

xlswrite(nombre, [escribe, escribe2, escribe3, escribe4, 'P y S'],hoja,strcat('U',int2str(i + inicial)));

end


%% funcion que escribe el los errores obtenidos con las maquinas vector de
%% soporteya sea de entrenamiento, validacion y test. y termina
%% escribiendolo todo en prueba.xslx en la hoja 1
function Escribe(svmFinal, Cfinal, Sfinal, DATA, DATAFIN, TEST, i,hoja,TARGET)

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

nombre = 'Datos Finales2.xlsx';

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

post = test(svmFinal,d3);
outputs = post.X;
escribe4 = Compara(outputs,TARGET,1);

xlswrite(nombre, [ escribe, escribe2, escribe3, escribe4, 'O Vs A'],hoja,strcat('P',int2str(i + inicial)));

end

%% Funcion cuyo objetivo es comparar los dos targets y obtener los
%% indicadores medios para la P y la S
function datos = Compara(TEST,TARGET,tipo)

datos = '';
if(tipo == 0)
    TEST = TEST';
end

RED = cellfun(@length,TARGET(:,1)) < 100 ;
TARGET(RED,:) = []; 

% assignin('base', 'tests', TEST);
% assignin('base', 'target', TARGET);

valP = cell2mat(TARGET(:,4));
valS = cell2mat(TARGET(:,5));

valores = max(TEST,[],2);

aux = (valores == TEST(:,1));
aux2 = (valores == TEST(:,2));
aux3 = (valores == TEST(:,3));

aux = [(logical(aux) & logical(valP)) (logical(aux2) & logical(valS)) logical(aux3)].*1;

filasRevP = find(aux(:,1));
filasRevS = find(aux(:,2));
% assignin('base', 'filasP', filasRevP);
% assignin('base', 'filasS', filasRevS);
    
% aux(filasRevP,1) = cellfun(@obtieneValor,TARGET(filasRevP,1:3),0) - valP(filasRevP);
% aux(filasRevS,2) = cellfun(@obtieneValor,TARGET(filasRevS,1:3),1) - valP(filasRevS);

for i = 1: length(filasRevP)
    aux(filasRevP(i),1) = abs(obtieneValor(TARGET(i,1:3),0) - valP(filasRevP(i)));
end
for i = 1: length(filasRevS)
    aux(filasRevS(i),2) = abs(obtieneValor(TARGET(i,1:3),1) - valS(filasRevS(i)));
end
%     assignin('base', 'aux', aux);
%     datosP = num2str(mean(aux(filasRevP,1)));
%     datosS = num2str(mean(aux(filasRevS,2)));
datos = [mean(aux(filasRevP,1)) , mean(aux(filasRevS,2))]
    
end

function valor = obtieneValor(ejex,i)

if(i == 0)
    valor1 = AIC(ejex{1});
    valor2 = AIC(ejex{2});
    valor3 = AIC(ejex{3});
    valor = mean([valor1 valor2 valor3]);
else
    Datos(:,1) = ejex{1,1};
    Datos(:,2) = ejex{1,2};
    Datos(:,3) = ejex{1,3};
    valor = IDS(Datos);
end
end

%% funcion encargada de obtener el clsificador de señal P
function valor = AIC(datos)
tam = length(datos);
valores = [];

if(tam < 50 )
    valor = -1;
    return;
end

for i = 1: tam
 valores(i,1) = i * log( std(datos(1:i,1))^2) + (tam - i - 1)* log ( std( datos(i+1:tam,1))^2);
end
pos1 = isnan(valores);
pos2 = isinf(valores);
valores(pos1) = 0;
valores(pos2) = 0;
valores(find(valores == 0)) = mean(valores);
% valores = normalizarEje(valores(:,1));
valores = valores - max(valores);
valor = find(valores == min(min(valores))); % deberia ser la desviacion estandar ya que a mas amplia sirve

% plot(valores);pause;

end


%% funcion encargada de obtener el clsificador de señal S
function valor = IDS(datos)

k = 350;
l = 150;

% si el intervalo es mas chico se definen nuevos intervalos en proporcion
if(length(datos) < 500 )
    k = floor((350/500)*length(datos));
    l = floor((150/500)*length(datos));
end

% k es el largo del LTA + STA que en este caso es 3 = 150 muestras
% l es el largo del STA que es de 1 seg => 50 muestras

O = datos(:,1).^2 + datos(:,2).^2 + datos(:,3).^2;
% plot(O),pause(2)
E = abs(datos(:,2));
% plot(E),pause(2)
N = abs(datos(:,1));
% plot(N),pause(2)

FO = evalua(O,k,l);
% length(FO)
% plot(FO),pause(3);
FN = evalua(E,k,l);
FE = evalua(N,k,l);

C = FO.*FN.*FE;
% plot(C/100);
C( find ( isinf (C) ) )= 0;

assignin('base', 'C', C);

valor = find((C/100) == max(C/100));
% plot(C/1000000)
% pause(1)
end

%funcion auxiliar para IDS
function [valores] = evalua(datos,k,l)

tam = length(datos);
datos = abs(datos);

acum = 0;
acum2 = 0;

inicioSTA = 1;
inicioLTA  = l;
finalSTA = l;
finalLTA = l + k;

for i = 1: tam

     acum = 0;
     acum2 = 0;
     for j = inicioSTA : finalSTA
         final = j;
         if( final > tam )
              final = tam;
         end
         acum = acum + abs(datos(final,1)); 
     end

     for a = inicioLTA : finalLTA
         aux2 = a;
         if( aux2 > tam )
             aux2 = tam;
         end
         acum2 = acum2 + abs(datos(aux2,1)); 
     end
    valores(i,1) = ((1/l)*acum)/((1/k)*acum2);
    inicioSTA = i + 1;
    inicioLTA = i + l + 1;
    finalSTA = i + l + 1;
    finalLTA = i + k + l + 1;
end

% valores;
% plot(valores);
% pause(3);

end
