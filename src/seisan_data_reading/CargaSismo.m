function CargaSismo(Cont)
% funcion que recorre filenr.lis y obtiene los valores que tienen
% componente P Y S
%Lectura de archivos que contienen los 346 terremotos
fileToRead1='E:\U\Memoria\Datos\Seismo\WOR\filenr.lis';

%abrir archivo de eventos detectados y se almacenan en DATA

f = fopen(fileToRead1,'r');
data=textscan(f, '%s %s', 346);
fclose(f);
data=data{1,2};

Cont=Cont;
sen=[];

% titulos = [{'señal P'}, {'Señal S'}];
% xlswrite( 'senales' , titulos,'hoja1','A1') ;


%recorro cada evento y recojo sus caracteristicas

for i=1:length(data)
    
%     disp(strcat('Para el Evento: ',data(i)));
    file = strcat('E:\U\Memoria\Datos\Seismo\WOR\',data(i));
    [Cont senales]= cargarDatos(file{1,1},Cont);
    sen = vertcat(sen,senales);
    
end

% sen

assignin('base', 'senales', sen);
assignin('base','listSism', data);
end

