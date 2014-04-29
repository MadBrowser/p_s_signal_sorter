function [DatosN]= normalizar(datos)

aux1=mean(datos);
aux2=range(datos);

DatosN(:,1)=(datos(:,1)-aux1(1,1))/aux2(1,1);
DatosN(:,2)=(datos(:,2)-aux1(1,2))/aux2(1,2);
DatosN(:,3)=(datos(:,3)-aux1(1,3))/aux2(1,3);


% x = -1;
% y = 1;
% range2 = y - x;
% DatosN = (DatosN*range2) ;

end