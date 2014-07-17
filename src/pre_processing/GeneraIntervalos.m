function [num, Int2] = GeneraIntervalos(ventana, traslape, numArch, Int, stations_path, filtro)

% Variables globales
horaP = '';
horaS = '';
tiempo = [];
T = [];
num = 0;
Int2 = Int;
filter_path = '~/Dev/p_s_signal_sorter/Butterworth_Filters.mat';

% cargo los datos que necesito
f = load(filter_path, filtro);
try
    load(strcat(strcat(stations_path, num2str(numArch)),'.mat'),'horaP','horaS','T','tiempo');
    Int1 = [];
    max = size(T);
    j = 1;
    
    % Revisa que la información de la estación contenga los datos de HoraP y HoraS
    [tiempo, T, estado] = revisaTarget(tiempo, T, horaP, horaS);
    
    % Filtra la señal
    disp(strcat('filtro la señal ', num2str(numArch)));
    TF = filter(f.(filtro), T);
    
    % Guarda la información de la señal filtrada y su intervalo en la estación.
    if(estado == 1)
        save (strcat(strcat(stations_path,num2str(numArch)),'.mat'),'-append', 'Int1');
        save (strcat(strcat(stations_path,num2str(numArch)),'.mat'),'-append', 'TF');
    else % Descarta estaciones inválidas
        % Se renombra el archivo como inválido
        movefile(strcat(strcat(stations_path,num2str(numArch)),'.mat'), strcat(strcat(stations_path,num2str(numArch)),'NO.mat'));
        % Se guarda su información
        save (strcat(strcat(stations_path,num2str(numArch)),'NO.mat'),'-append', 'Int1');
        save (strcat(strcat(stations_path,num2str(numArch)),'NO.mat'),'-append', 'TF');
        disp(strcat('Estación no considerada: ', num2str(numArch)));
        return;
    end
    
    % Grafica la señal pre y pos filtrada.
    % subplot(3,2,1);
    % plot(T(:,1),'r');
    % title(strcat('Se?al original eje N: ',num2str(numArch)));
    % ylabel('Amplitud');
    % xlabel('Tiempo')
    % subplot(3,2,3);
    % plot(T(:,2),'k');
    % title(strcat('Se?al original eje E: ',num2str(numArch)))
    % ylabel('Amplitud');
    % xlabel('Tiempo')
    % subplot(3,2,5);
    % plot(T(:,3),'b');
    % title(strcat('Se?al original eje Z: ',num2str(numArch)))
    % ylabel('Amplitud');
    % xlabel('Tiempo')
    % subplot(3,2,2);
    % plot(TF(:,1),'r');
    % title(strcat('Se?al filtrada eje N: ',num2str(numArch)))
    % ylabel('Amplitud');
    % xlabel('Tiempo')
    % subplot(3,2,4);
    % plot(TF(:,2),'k');
    % title(strcat('Se?al filtrada eje E: ',num2str(numArch)))
    % ylabel('Amplitud');
    % xlabel('Tiempo')
    % subplot(3,2,6);
    % plot(TF(:,3),'b');
    % title(strcat('Se?al filtrada eje Z: ',num2str(numArch)))
    % ylabel('Amplitud');
    % xlabel('Tiempo');
    % pause(1);
    
    %obtengo el Target de la señal P
    [~, targetT] = strtok(tiempo,'T');
    targetT = strrep(targetT, 'T', '');
    target = ismember(targetT, horaP);
    target = double(target);
    
    [~,targetT2] = strtok(tiempo,'T');
    targetT2 = strrep(targetT2, 'T', '');
    target2 = ismember(targetT2, horaS);
    target2 = double(target2);
    
    % los separo por intervalo
    for i = 1:(ventana - traslape):max(1,1)
        final = ventana + i - 1;
        
        if(ventana + i - 1 > max(1,1))
            final = max(1,1);
        end
        
        if(final == i )
            break;
        end
        
        Int1{j,1} = TF(i:final,1);
        Int1{j,2} = TF(i:final,2);
        Int1{j,3} = TF(i:final,3);
        
        if (any(target(i:final,1)))
            disp(' LLeno  para P');
            Int1{j,4} = find(target(i:final,1));
        else
            Int1{j,4} = find(target(i:final,1));
        end
        if (any(target2(i:final,1)))
            disp(' LLeno  para S');
            Int1{j,5} = find(target2(i:final,1));
        else
            Int1{j,5} = find(target2(i:final,1));
        end
        j = j + 1;
    end
    
    Int2 = vertcat(Int,Int1);
    
    num = j - 1;
    
catch
    disp('Archivo no existe')
    return
end

end