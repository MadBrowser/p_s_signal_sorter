function valores = valCruz()

load('Cjto52.mat','svmFinal')
load('Cjto9,81.mat','DATA')

DATA = cambiaDoble(DATA);
tar = DATA(:,15:17);
ext = DATA(:,1:14);
tar( tar == 0 ) = -1;
d = data(ext,tar);


tst2=test(svmFinal,d,'confusion_matrix');
matriz3 = tst2.Y';
escribe3 = calculaError(matriz3,3);

valores = escribe3;


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