function [] = corta( numero, corte, cont)
T = [];
TF = [];
tiempo = [];
original = strcat(strcat('Estacion',num2str(numero)));

load(strcat(strcat('Estacion',num2str(numero)),'.mat'),'TF','T','tiempo');

originalT = T;
originalTF = TF;
originalTiempo = tiempo;

restoT2(:,1) = originalT(1:corte,1);
restoT2(:,2) = originalT(1:corte,2);
restoT2(:,3) = originalT(1:corte,3);
restoTF2(:,1) = originalTF(1:corte,1);
restoTF2(:,2) = originalTF(1:corte,2);
restoTF2(:,3) = originalTF(1:corte,3);
restoTiempo2(:,1) = originalTiempo(1:corte,1);

T = restoT2;
TF = restoTF2;
tiempo = restoTiempo2;

save (strcat(strcat('Estacion',num2str(cont)),'NO.mat'), 'TF','T','tiempo','original');


restoT(:,1) = originalT(corte-1:end,1);
restoT(:,2) = originalT(corte-1:end,2);
restoT(:,3) = originalT(corte-1:end,3);
restoTF(:,1) = originalTF(corte-1:end,1);
restoTF(:,2) = originalTF(corte-1:end,2);
restoTF(:,3) = originalTF(corte-1:end,3);
restoTiempo(:,1) = originalTiempo(corte-1:end,1);

T = restoT;
TF = restoTF;
tiempo = restoTiempo;

save (strcat(strcat('Estacion',num2str(numero)),'.mat'),'-append', 'TF','T','tiempo');



end