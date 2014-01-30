%% funcion que inicia con el entrenamiento de la SVM con un 0,7 para el
%% entrenamiento y el otro 0,3 para validacion
function [sist matriz] = SVM(DATA,C,sigma)

tam = length(DATA);
[trainInd,valInd,testInd] = dividerand(DATA',0.7,0.3,0);

trainInd = trainInd';
valInd = valInd';

tar = trainInd(:,15:17);
ext = trainInd(:,1:14);

tartst = valInd(:,15:17);
exttst = valInd(:,1:14);

tar( tar == 0 ) = -1;
tartst( tartst == 0 ) = -1;

% P = length(tar(tar(:,1)==1));
% S = length(tar(tar(:,2)==1));
% R = length(tar(tar(:,3)==1));

d = data(ext,tar);
d2 = data(exttst,tartst);

[rest,sist]=train(one_vs_rest(svm({kernel('rbf',2^sigma),'optimizer="andre"',strcat('C=',num2str(2^C))})),d);

tst=test(sist,d2,'confusion_matrix');
matriz = tst.Y';

% tar = DATATOT(:,15:17);tar( tar == 0 ) = -1;
% ext = DATATOT(:,1:14);
% d = data(ext,tar);
% tst=test(sist,d,'confusion_matrix');
% matriz = tst.Y';

% tst=test(sist,d,'sensitivity');
% Sencibilidad = tst.Y
% 
% tst=test(sist,d,'specificity');
% Especificidad = tst.Y
% 
% tst=test(sist,d,'class_loss');
% Error = tst.Y

end