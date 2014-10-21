%% Funcion automatizada que recorre cada conjunto y va generando la SVM
%% correspondiente y luego la evalua y anota los errores termina
%% guardandola en el conjunto correspondiente
function GenerarSVMs()

conjuntos = {
%     'Cjto1,1', 'DATAFIN7', 'Test1';'Cjto2,1', 'DATAFIN7', 'Test2';'Cjto3,1', 'DATAFIN7', 'Test3';
%     'Cjto4,1', 'DATAFIN6', 'Test4';'Cjto5,1', 'DATAFIN6', 'Test5';'Cjto6,1', 'DATAFIN6', 'Test6';
%     'Cjto7,1', 'DATAFIN7', 'Test7';'Cjto8,1', 'DATAFIN8', 'Test8';'Cjto9,1', 'DATAFIN8', 'Test9';
%     'Cjto9,71', 'DATAFIN8', 'Test9,71';'Cjto9,72', 'DATAFIN8', 'Test9,72';'Cjto9,81', 'DATAFIN7', 'Test9,81';
%     'Cjto9,82', 'DATAFIN8', 'Test9,82';'Cjto9,91', 'DATAFIN7', 'Test9,91';'Cjto9,92', 'DATAFIN7', 'Test9,92';
%     'Cjto10,1', 'DATAFIN7', 'Test10';'Cjto11,1', 'DATAFIN7', 'Test11';
%      'Cjto12,1', 'DATAFIN8', 'Test12';
%      'Cjto13,1', 'DATAFIN7', 'Test13';'Cjto14,1', 'DATAFIN7', 'Test14';'Cjto15,1', 'DATAFIN8', 'Test15';
%      'Cjto16,1', 'DATAFIN7', 'Test16';'Cjto17,1', 'DATAFIN7', 'Test17';'Cjto18,1', 'DATAFIN7', 'Test18';
%      'Cjto19,1', 'DATAFIN7', 'Test19';'Cjto20,1', 'DATAFIN7', 'Test20';'Cjto20,71', 'DATAFIN7', 'Test20,71';
%      'Cjto20,72', 'DATAFIN7', 'Test20,72';'Cjto20,81', 'DATAFIN7', 'Test20,81';'Cjto20,82', 'DATAFIN7', 'Test20,82';
%      'Cjto20,91', 'DATAFIN6', 'Test20,91';'Cjto20,92', 'DATAFIN6', 'Test20,92';'Cjto21,1', 'DATAFIN6', 'Test21';
%      'Cjto22,1', 'DATAFIN6', 'Test22';
%     'Cjto23,1', 'DATAFIN8', 'Test23';'Cjto24,1', 'DATAFIN8', 'Test24';
%     'Cjto25,1', 'DATAFIN8', 'Test25';'Cjto26,1', 'DATAFIN8', 'Test26';'Cjto27,1', 'DATAFIN7', 'Test27';
%     'Cjto28,1', 'DATAFIN7', 'Test28';'Cjto29,1', 'DATAFIN7', 'Test29';'Cjto30,1', 'DATAFIN7', 'Test30';
%     'Cjto31,1', 'DATAFIN7', 'Test31';'Cjto31,71', 'DATAFIN7', 'Test31,71';'Cjto31,72', 'DATAFIN7', 'Test31,72';
%     'Cjto31,81', 'DATAFIN7', 'Test31,81';'Cjto31,82', 'DATAFIN6', 'Test31,82';'Cjto31,91', 'DATAFIN7', 'Test31,91';
%     'Cjto31,92', 'DATAFIN6', 'Test31,92';'Cjto32,1', 'DATAFIN7', 'Test32';'Cjto33,1', 'DATAFIN6', 'Test33'
    };



for i = 1:length(conjuntos)    
    TEST = [];
    try
       load(strcat(conjuntos{i,1},'.mat'), conjuntos{i,2},'DATA');
       disp(strcat(conjuntos{i,1},'.mat'));
       DATATOT = DATA;
       try
           load(strcat(conjuntos{i,3},'.mat'),'DATA');
           disp(strcat(conjuntos{i,3},'.mat'));
           TEST = DATA;
       catch
            disp('Archivo de Test no existe');
%             continue;
       end
       
       
    catch
        disp('Archivo no existe');
%         disp(strcat(conjuntos{i,1},'.mat'));
        continue;
    end
    
    C = [4.8 5.2];
    S = [8.8 9.2];
    
    if(exist('DATAFIN8'))
        [svmFinal Exac Cfinal Sfinal] = iterSVM(C,S,revisaDoble(DATAFIN8));
        Escribe(svmFinal, Cfinal, Sfinal, cambiaDoble(DATATOT), cambiaDoble(DATAFIN8), cambiaDoble(TEST));
        clearvars DATAFIN8 DATAFIN7 DATAFIN6;
    elseif(exist('DATAFIN7'))
        [svmFinal Exac Cfinal Sfinal] = iterSVM(C,S,revisaDoble(DATAFIN7));
        Escribe(svmFinal, Cfinal, Sfinal, cambiaDoble(DATATOT), cambiaDoble(DATAFIN7), cambiaDoble(TEST));
        clearvars DATAFIN7 DATAFIN6;
    elseif(exist('DATAFIN6'))
        [svmFinal Exac Cfinal Sfinal] = iterSVM(C,S,revisaDoble(DATAFIN6));
        Escribe(svmFinal, Cfinal, Sfinal, cambiaDoble(DATATOT), cambiaDoble(DATAFIN6), cambiaDoble(TEST));
        clearvars DATAFIN6;
    end
  
    save(strcat(conjuntos{i,1},'.mat'),'-append','svmFinal');
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