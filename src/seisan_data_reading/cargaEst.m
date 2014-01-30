function [tiempo] = cargaDato(nombreArch,i)
warning off;
%disp('Cargando Datos...');
% abrir un txt y cargar los datos en una variable
T = [];
tiempo=[];

%eje Norte-Sur
try
    
   [tiempo,T(:,1)]=textread(strcat('E:\U\Memoria\Datos\Seismo\WOR\',strcat(nombreArch,'N')),'%s    %f');
   
catch
    disp('Componente N no existe');
    tiempo=[];
    T=[];
    return;
end

try
%eje Este-Oeste

[tiempo,T(:,2)]=textread(strcat('E:\U\Memoria\Datos\Seismo\WOR\',strcat(nombreArch,'E')),'%s    %f');

catch
    disp('Componente E no existe');
    tiempo=[];
    T=[];
    return;
end

try
%eje altura
[tiempo,T(:,3)]=textread(strcat('E:\U\Memoria\Datos\Seismo\WOR\',strcat(nombreArch,'Z')),'%s    %f');
catch
    disp('Componente Z no existe');
    tiempo=[];
    T=[];
    return;
end
%to do .. probar esto ... por separado y empezar a preprocesar... consultar
%al profe sobre las dimensiones... etc...
%T=horzcat(num2cell(T),tiempo);
%assignin('base',strcat('t',num2str(i)),tiempo);
nombre = strcat(strcat('Estacion',num2str(i)),'.mat');
T = normalizar(T);
save( nombre ,'tiempo','T');
% assignin('base',strcat('D',num2str(i)),T);
% titulos = [{'Eje Norte-Sur'}, {'Eje Este-Oeste'}, {'Eje Z'},{'Tiempo'},{'Onda S'},{'Onda P'}];
% xlswrite( strcat('E',num2str(i)) , T , 'hoja1', 'A2');
% xlswrite( strcat('E',num2str(i)) , tiempo , 'hoja1', 'D2');
% assignin('base',strcat('T',num2str(i)),tiempo);
fclose('all');
end
