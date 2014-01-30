function [cont senales] = cargarDatos(file,i)
%disp(strcat('Cargando Datos...'));
% abrir un txt y cargar los datos en una variable
[~, filename] = strtok(strcat(file,'.txt'),'\');
[~,filename] = strtok(filename,'\');
[~,filename] = strtok(filename,'\');
[res,filename] = strtok(filename,'\');
numS = 1;
numP = 1;
diary(res);
diary on;

fid = fopen(file,'r');
if (fid < 0)
    error('Error:could not open file\n')
else %una vez abierto el archivo se procede a la lectura
    data = textscan(fid, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s', 1000);
    data = [ data{1,1} , data{1,2} , data{1,3} , data{1,4} , data{1,5} , data{1,6} ,data{1,7},data{1,8}];
    inicio = 0;
    final = 1;
    
    %extraccion de los titulos de los sismografos involucrados en el evento
    for j=1:length(data)
        if(strfind(data{j,1},'ACTION'))
            inicio = j;
        end
        if(strfind(data{j,1},'STAT'))
            final = j;
        end
    end
    inicio = inicio + 1;
    
    sismografos = [];%nombre de los sismografos asociados al evento
    senales = [];
    aux = []; %asignado para no leer 2 veces el mismo archivo
    cont = i;
    
%   disp( strcat(strcat( 'Se registraron: ', num2str( final - inicio ) ),' eventos'));

    horaP = '';
    horaS = '';

    %reviso cada sismografo asociado al evento
    for k=inicio:final-1
        sismografos = strvcat(sismografos,data{k,1});
%       disp(strcat('Para el sismografo: ',data{k,1}));
        %obtengo componente a revisar
        [v intn]= strtok(sscanf(data{k,1},'%*19s.%s__00%*i'),'_');
        [intn res] = strtok(intn,'0');
        int = str2double(res);
        %extraigo el tiempo de P y S
        for j=final:length(data)
            if(strfind(data{j,1},v) & (int>=3) ) %si tiene componente P y S y todas las componentes
                %TO DO: Sacar el tiempo en que se identifica la señal s y p
                % genero el nommbre necesario en cada caso
                if(length(data{j,1})==4) 
                    nomSism=strcat(data{k,1},strcat('_',strcat(data{j,1},strcat('__',strcat(data{j,2}(1)),'__'))));
                end
                
                if(length(data{j,1})==3)
                    nomSism=strcat(data{k,1},strcat('_',strcat(data{j,1},strcat('___',strcat(data{j,2}(1)),'__'))));
                end
                
                if(~strcmpi(nomSism,aux)) %si no es un archivo abierto en la anterior iteracion
                    aux=nomSism;
                    disp(cont);
                    disp(strcat('se obtuvo el siguiente sismografo: ',nomSism));
                    tiempo = cargaEst(nomSism,cont);
                    if(~isempty(tiempo))
                        %             disp(' Reviso si esta completo ');
                        if( cont-1 > 0)
                            disp(strcat('Reviso ',num2str(cont-1)));
                            horaS = '';
                            horaP = '';
                            try
                            load(strcat(strcat('Estacion',num2str(cont-1)),'.mat'),'horaP','horaS');
                            catch
                            end
                            if(isempty(horaP)&& isempty(horaS))
                                disp('archivo vacio');
                               cont = cont - 1;
            %                    save (strcat(strcat('Estacion',num2str(cont)),'.mat'), '-append','horaS','horaP');
                            end
                        end
                        cont = cont+1;
                    end
                end
                
                
                % extraigo en cada caso si es señal s y p, guardandolo
                % en una variable
                % preguntar diferencias entre EP y IP
                if(strcmp(data{j,3},'IP')| strcmp(data{j,3},'EP'))
                    
                    horaP = cargahora(data(j,4:8));
                    
                    if(~isempty(tiempo))
                        senales {numP,1} = horaP;
                        disp(horaP);
                        senales {numP,2} = [];
                        save (strcat(strcat('Estacion',num2str(cont-1)),'.mat'),'-append', 'horaP');
%                         xlswrite( 'senales', senales(numP,1) , 'hoja1', strcat('A',num2str(numP+cont-1)));
                        numP=numP+1;
                    end
                end
                
                % preguntar diferencias entre ES y IS
                if(strcmp(data{j,3},'IS')|strcmp(data{j,3},'ES'))
                    horaS= cargahora(data(j,4:8));
                    if(~isempty(tiempo))
                        senales {numS,2} = horaS;
                        disp(horaS);
                        save (strcat(strcat('Estacion',num2str(cont-1)),'.mat'), '-append','horaS');
%                         xlswrite('senales', senales(numS,2) , 'hoja1', strcat('A',num2str(numP+cont-1)));
                        numS=numS+1;
                    end
                end
            end
        end
        disp('');
    end

    %disp(sismografos);
%     disp('Se completo el analisis de los Sismografos para los eventos asociados');
    % assignin('base', strcat('sismografos',num2str(i)), sismografos);
    % assignin('base', 'data', data);
    % assignin('base', strcat('senales',num2str(i)), senales);
    % assignin('base','Tiempo',tiempo)
    % fclose(fid);
    
%     disp(' ');disp(' ');
    diary off;
    fclose('all');
    
end

% senales
end

% funcion que lee la hora de arribo de la señal S y P
function [salida] = cargahora(datos)
salida ='';
datoslim=datos;

hora='';
minutos='';
segundos='';

unidad='';
%%% to do magic

for in= 1: length(datos)
    
    % si es una letra corro todo hasta dejar la parte derecha que contiene
    % la hora
    if(isempty(str2num(datos{in})) && length(datos{in})> 0)
        datoslim = datos(in+1:end);
    end
end

datos = datoslim

for in = 1 : length(datos)
    % si se tiene que separar la hora de los minutos
    
    if( (length(datos{in})>2) && isempty(strfind(datos{in},'.')) && (in <= 3) )
        aux= datos{in};
        segundos = datos(in+1);
        minutos  = aux(end-1:end);
        hora = aux(1:end-2);
        
        datos{1}=hora;
        datos{2}=minutos;
        datos{3}=segundos{1:end};
        break;
    end
end

% for i=1:3
%     % si son numeros exclusivamentes
%     if(~isempty(str2num(datos{i})) & ~isempty(str2num(datos{i+1})) & ~isempty(str2num(datos{i+2})) )
%         %si tienenel formato de la hora que es int int float por medio de
%         %la comprobacion del punto
%         if(isempty(strfind(datos{i},'.')) & isempty(strfind(datos{i+1},'.')) & ~isempty(strfind(datos{i+2},'.'))  )
%             % si  la HHMM viende unida de la forma 012
%             salida= strcat(strcat(datos{i},':'),strcat(strcat(datos{i+1},':'),strcat(datos{i+2})))
%             break;
%         end
%
%     end
% end
 
    if(length(datos{1})<2)
        hora = strcat('0', datos{1});
    end
    if(length(datos{2})<2)
        minutos = strcat('0',datos{2});
    end
    
    largo = length(datos{3});
    switch largo
        case {1,2} %si los segundo sn excatos PE 3 seg
            decimas = '.00';
            unidad = datos{3};
            if(largo == 1)
                unidad = strcat('0',unidad);
            end
            segundos = strcat(unidad,decimas);
        case {3,4} %si los segundos son decimales pero falta para completar  PE = 3.2
            [unidad,decimas] = strtok(datos{3},'.');
            if(length(unidad)<2)
                unidad = strcat('0',unidad);
            end
            if(length(decimas)<3)
                decimas = strcat(unidad,'0');
            end
            segundos = strcat(unidad,decimas);
        case 5 % si los segundos son completos y no requiere tratamiento
            segundos = datos{3};
    end
    
    if(isempty(hora))
        hora=datos{1};
    end
    if(isempty(minutos))
        minutos=datos{2};
    end
    if(isempty(segundos))
        segundos=datos{3};
    end
    % al final la idea es tener el patron de la forma hh:mm:ss.ss
    salida= char(strcat(strcat(hora,':'),strcat(strcat(minutos,':'),strcat(segundos)))    );
    return;
end

