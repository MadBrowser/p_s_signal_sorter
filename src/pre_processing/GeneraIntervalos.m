function [num Int2] = GeneraIntervalos(tamIntervalo, traslape, numArch, Int)
    num = 0;Int2 = [];
    estado = 0;
%     clear;
    %cargo los datos que necesito
    horaP = '';
    horaS = '';
    tiempo = [];
    T = [];
    load('~/Dev/p_s_signal_sorter/Filtro.mat','Hd');
    try
    load(strcat(strcat('~/Dev/p_s_signal_sorter/stations/Estacion',num2str(numArch)),'.mat'),'horaP','horaS','T','tiempo');
    
    [tiempo T]= revisaTarget(tiempo,T,horaP,horaS);
    
    catch
       num = 0;
       Int2 = Int;
       disp(strcat(strcat('Estacion',num2str(numArch)),'.mat :Archivo No existe'));
%            load(strcat(strcat('Estacion',num2str(numArch)),'NO.mat'),'horaP','horaS','T','tiempo');
%            estado = 1;
       return;
    end
%     horaP
%     horaS
    Int1 = [];
    max = size(T);
    j = 1;
    
%     T(:,1) = normalizarEje(T(:,1));
%     T(:,2) = normalizarEje(T(:,2));
%     T(:,3) = normalizarEje(T(:,3));
%
% Esta parte de ac? debe ser cambiada para matlab 2013, no reconoce la
% instrucci?n Title, cambiarla por title
    disp(strcat('filtro la se?al',num2str(numArch)));
    TF = filter(Hd,T);
%     subplot(3,2,1);
%     plot(T(:,1),'r');
%     title(strcat('Se?al original eje N: ',num2str(numArch)));
%     ylabel('Amplitud');
%     xlabel('Tiempo')
%     subplot(3,2,3);
%     plot(T(:,2),'k');
%     title(strcat('Se?al original eje E: ',num2str(numArch)))
%     ylabel('Amplitud');
%     xlabel('Tiempo')
%     subplot(3,2,5);
%     plot(T(:,3),'b');
%     title(strcat('Se?al original eje Z: ',num2str(numArch)))
%     ylabel('Amplitud');
%     xlabel('Tiempo')
%     subplot(3,2,2);
%     plot(TF(:,1),'r');
%     title(strcat('Se?al filtrada eje N: ',num2str(numArch)))
%     ylabel('Amplitud');
%     xlabel('Tiempo')
%     subplot(3,2,4);
%     plot(TF(:,2),'k');
%     title(strcat('Se?al filtrada eje E: ',num2str(numArch)))
%     ylabel('Amplitud');
%     xlabel('Tiempo')
%     subplot(3,2,6);
%     plot(TF(:,3),'b');
%     title(strcat('Se?al filtrada eje Z: ',num2str(numArch)))
%     ylabel('Amplitud');
%     xlabel('Tiempo');
%
%
%      pause;
  pause(1);
    
     
      
      %obtengo el Target de la se?al P
      [~,targetT] = strtok(tiempo,'T');
      targetT = strrep(targetT, 'T', '');
      target = ismember(targetT, horaP);
      target=double(target);
      
      [~,targetT2] = strtok(tiempo,'T');
      targetT2 = strrep(targetT2, 'T', '');
      target2 = ismember(targetT2, horaS);
      target2=double(target2);
      
 %      
 %      % los separo por intervalo
       for i = 1:(tamIntervalo-traslape):max(1,1)
           final = tamIntervalo + i - 1; 
           
            if(tamIntervalo + i - 1 > max(1,1))
               final = max(1,1);
            end
            if(final == i )
                break;
            end
           
  %           disp(strcat('Parto desde :',strcat(num2str(i),strcat(' desde :', num2str(final)))))        
           
            Int1{j,1} = T(i:final,1);
            Int1{j,2} = T(i:final,2);
            Int1{j,3} = T(i:final,3);
            if ( any(target(i:final,1)) )
               disp(' LLeno  para P');
               j
               Int1{j,4} = find(target(i:final,1));
            else
               Int1{j,4} = find(target(i:final,1));
            end
            if ( any(target2(i:final,1)) )
               disp(' LLeno  para S');
               j
               Int1{j,5} = find(target2(i:final,1));
            else
               Int1{j,5} = find(target2(i:final,1));
            end
            j = j + 1;
       end
       Int2 = vertcat(Int,Int1);
       
       
       %assignin('base','Valor',Int);
       if(estado == 0)    
           save (strcat(strcat('~/Dev/p_s_signal_sorter/stations/Estacion',num2str(numArch)),'.mat'),'-append', 'Int1');
           save (strcat(strcat('~/Dev/p_s_signal_sorter/stations/Estacion',num2str(numArch)),'.mat'),'-append', 'TF');
       end
       if(estado == 1)    
           save (strcat(strcat('~/Dev/p_s_signal_sorter/stations/Estacion',num2str(numArch)),'NO.mat'),'-append', 'Int1');
           save (strcat(strcat('~/Dev/p_s_signal_sorter/stations/Estacion',num2str(numArch)),'NO.mat'),'-append', 'TF');
       end
       if(estado == 2)
           save (strcat(strcat('~/Dev/p_s_signal_sorter/stations/Estacion',num2str(numArch)),'NOO.mat'),'-append', 'Int1');
           save (strcat(strcat('~/Dev/p_s_signal_sorter/stations/Estacion',num2str(numArch)),'NOO.mat'),'-append', 'TF');
       end
       num = j - 1;

end